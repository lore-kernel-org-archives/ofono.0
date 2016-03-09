Content-Type: multipart/mixed; boundary="===============7420416210345906838=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 10/19] ubloxmodem: add Toby L2 gprs context driver
Date: Wed, 09 Mar 2016 16:44:51 +0100
Message-ID: <1457538300-7183-11-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7420416210345906838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For now the driver works only with bridged mode.

Once it activates the context it reads the ip, netmask,
gw, dns and sets them in the context settings.

4G default bearer is supported as well by reading the
automatic activation cid and using it in the first context
activation.
---
 Makefile.am                       |   7 +
 drivers/ubloxmodem/gprs-context.c | 498 ++++++++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c   |  49 ++++
 drivers/ubloxmodem/ubloxmodem.h   |  25 ++
 4 files changed, 579 insertions(+)
 create mode 100644 drivers/ubloxmodem/gprs-context.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.c
 create mode 100644 drivers/ubloxmodem/ubloxmodem.h

diff --git a/Makefile.am b/Makefile.am
index cde998d..7652cfe 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -374,6 +374,13 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/speedupmodem/speedupmodem.c \
 			drivers/speedupmodem/ussd.c
 =

+builtin_modules +=3D ubloxmodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/ubloxmodem/ubloxmodem.h \
+			drivers/ubloxmodem/ubloxmodem.c \
+			drivers/ubloxmodem/gprs-context.c
+
+
 if PHONESIM
 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
new file mode 100644
index 0000000..f80e1d8
--- /dev/null
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -0,0 +1,498 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  EndoCode AG. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "ubloxmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	unsigned int gprs_cid;
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	ofono_gprs_context_cb_t cb;
+	void *cb_data;
+};
+
+#define UBLOX_MAX_DEF_CONTEXT 8
+
+struct ublox_data {
+	/* Stores default PDP context/default EPS bearer. */
+	unsigned int default_context_id;
+	struct gprs_context_data contexts[UBLOX_MAX_DEF_CONTEXT];
+	unsigned int ncontexts;
+
+	/* Save used cids on the modem. */
+	bool active[UBLOX_MAX_DEF_CONTEXT];
+	unsigned int nactive;
+};
+
+static struct ublox_data ublox_data;
+
+static int get_context_id()
+{
+	int i =3D 0;
+
+	if (!ublox_data.nactive && ublox_data.default_context_id) {
+		/* Try to assign default context first. */
+		i =3D ublox_data.default_context_id - 1;
+		goto found;
+	}
+
+	for (i =3D 0; i < UBLOX_MAX_DEF_CONTEXT; i++) {
+		if (!ublox_data.active[i])
+			goto found;
+	}
+
+	return 0;
+found:
+	ublox_data.active[i] =3D true;
+	ublox_data.nactive++;
+
+	return i+1;
+}
+
+static void release_context_id(unsigned cid)
+{
+	int i;
+
+	if (!cid || cid > UBLOX_MAX_DEF_CONTEXT)
+		return;
+
+	for (i =3D 0; i < UBLOX_MAX_DEF_CONTEXT; i++) {
+		if (ublox_data.contexts[i].active_context =3D=3D cid) {
+
+			ublox_data.active[i] =3D false;
+			ublox_data.nactive--;
+
+			ublox_data.contexts[i].active_context =3D 0;
+			ublox_data.contexts[i].gprs_cid =3D 0;
+
+			return;
+		}
+	}
+}
+
+/*
+ * CGCONTRDP returns addr + netmask in the same string in the form
+ * of "a.b.c.d.m.m.m.m" for IPv4. IPv6 is not supported so we ignore it.
+ */
+static int read_addrnetmask(struct ofono_gprs_context *gc,
+				const char *addrnetmask)
+{
+	char *dup =3D strdup(addrnetmask);
+	char *s =3D dup;
+
+	const char *addr =3D s;
+	const char *netmask =3D NULL;
+
+	int ret =3D -EINVAL;
+	int i;
+
+	/* Count 7 dots for ipv4, less or more means error. */
+	for (i =3D 0; i < 8; i++, s++) {
+		s =3D strchr(s, '.');
+		if (!s)
+			break;
+
+		if (i =3D=3D 3) {
+			/* set netmask ptr and break the string */
+			netmask =3D s+1;
+			s[0] =3D 0;
+		}
+	}
+
+	if (i =3D=3D 7) {
+		ofono_gprs_context_set_ipv4_address(gc, addr, 1);
+		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
+
+		ret =3D 0;
+	}
+
+	free(dup);
+
+	return ret;
+}
+
+static void callback_with_error(struct gprs_context_data *gcd, GAtResult *=
res)
+{
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(res));
+	gcd->cb(&error, gcd->cb_data);
+}
+
+
+static void set_gprs_context_interface(struct ofono_gprs_context *gc)
+{
+	struct ofono_modem *modem;
+	const char *interface;
+
+	/* read interface name read at detection time */
+	modem =3D ofono_gprs_context_get_modem(gc);
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	ofono_gprs_context_set_interface(gc, interface);
+}
+
+static void cgcontrdp_bridge_cb(gboolean ok, GAtResult *result, gpointer u=
ser_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	int cid =3D -1;
+
+	const char *laddrnetmask =3D NULL;
+	const char *gw =3D NULL;
+	const char *dns[2+1] =3D { NULL, NULL, NULL };
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		callback_with_error(gcd, result);
+
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
+		/* tmp vals for ignored fields */
+		int bearer_id;
+		char *apn;
+
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			break;
+
+		if (!g_at_result_iter_next_number(&iter, &bearer_id))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &apn))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &laddrnetmask))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &gw))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &dns[0]))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &dns[1]))
+			break;
+	}
+
+	set_gprs_context_interface(gc);
+
+	if (!laddrnetmask || read_addrnetmask(gc, laddrnetmask) < 0) {
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	if (gw)
+		ofono_gprs_context_set_ipv4_gateway(gc, gw);
+
+	if (dns[0])
+		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static int ublox_read_ip_config_bridge(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	/* read ip configuration info */
+	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
+	return g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
+				cgcontrdp_bridge_cb, gc, NULL);
+
+}
+
+static void ublox_post_activation(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	if (ublox_read_ip_config_bridge(gc) < 0)
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static void cgact_enable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+	if (!ok) {
+		release_context_id(gcd->active_context);
+		callback_with_error(gcd, result);
+
+		return;
+	}
+
+	ublox_post_activation(gc);
+}
+
+static void cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		release_context_id(gcd->active_context);
+		callback_with_error(gcd, result);
+
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				cgact_enable_cb, gc, NULL))
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static void ublox_activate_ctx(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
+				gcd->active_context);
+
+	if (gcd->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+					gcd->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				cgdcont_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+#define UBLOX_MAX_USER_LEN 50
+#define UBLOX_MAX_PASS_LEN 50
+
+static void ublox_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->active_context =3D get_context_id();
+	if (!gcd->active_context) {
+		ofono_error("can't activate more contexts");
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+	gcd->gprs_cid =3D ctx->cid;
+	memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
+
+	if (gcd->active_context =3D=3D ublox_data.default_context_id)
+		/* Default context already active, only read details. */
+		ublox_post_activation(gc);
+	else
+		ublox_activate_ctx(gc);
+}
+
+static void cgact_disable_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+	if (!ok) {
+		if (gcd->active_context && ublox_data.default_context_id)
+			ofono_warn("Disabling the default context is not "
+					"allowed on LTE.");
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	release_context_id(gcd->active_context);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void ublox_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix,
+			cgact_disable_cb, gc, NULL);
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	const char *event;
+	unsigned int cid;
+	char tmp[5] =3D {0};
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (g_str_has_prefix(event, "ME PDN ACT") =3D=3D TRUE) {
+		/*
+		 * We only care about the first even coming in before any user
+		 * activations happen. This is for detecting the default
+		 * context in LTE networks which doesn't require user
+		 * activation.
+		 */
+		sscanf(event, "%s %s %s %u", tmp, tmp, tmp, &cid);
+		if (!ublox_data.default_context_id && !ublox_data.nactive)
+			ublox_data.default_context_id =3D cid;
+		DBG("cid=3D%d activated", cid);
+
+		return;
+	} else if (g_str_has_prefix(event, "NW PDN DEACT") =3D=3D TRUE) {
+		sscanf(event, "%s %s %s %u", tmp, tmp, tmp, &cid);
+		DBG("cid=3D%d deactivated", cid);
+	} else
+		return;
+
+	/* Can happen if non-default context is deactivated. Ignore. */
+	if (gcd->active_context !=3D cid)
+		return;
+
+	if (ublox_data.default_context_id =3D=3D cid)
+		ublox_data.default_context_id =3D 0;
+
+	ofono_gprs_context_deactivated(gc, gcd->gprs_cid);
+
+	release_context_id(gcd->active_context);
+}
+
+
+static int ublox_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+
+	DBG("");
+
+	if (ublox_data.ncontexts >=3D UBLOX_MAX_DEF_CONTEXT) {
+		ofono_error("modem supports defining max 8 contexts");
+		return -E2BIG;
+	}
+
+	gcd =3D &ublox_data.contexts[ublox_data.ncontexts];
+	memset(gcd, 0, sizeof(*gcd));
+	ublox_data.ncontexts++;
+
+	gcd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	/* Not sure if ok to register all contexts with the callback. */
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	return 0;
+}
+
+static void ublox_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_at_chat_unref(gcd->chat);
+
+	memset(gcd, 0, sizeof(*gcd));
+	ublox_data.ncontexts--;
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "ubloxmodem",
+	.probe			=3D ublox_gprs_context_probe,
+	.remove			=3D ublox_gprs_context_remove,
+	.activate_primary	=3D ublox_gprs_activate_primary,
+	.deactivate_primary	=3D ublox_gprs_deactivate_primary,
+};
+
+
+void ublox_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void ublox_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
new file mode 100644
index 0000000..7fc671e
--- /dev/null
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -0,0 +1,49 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Endocode AG. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "ubloxmodem.h"
+
+static int ubloxmodem_init(void)
+{
+	ublox_gprs_context_init();
+
+	return 0;
+}
+
+static void ubloxmodem_exit(void)
+{
+	ublox_gprs_context_exit();
+}
+
+OFONO_PLUGIN_DEFINE(ubloxmodem, "U-Blox Toby L2 high speed modem driver",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			ubloxmodem_init, ubloxmodem_exit)
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
new file mode 100644
index 0000000..0c8a621
--- /dev/null
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Endocode AG. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <drivers/atmodem/atutil.h>
+
+extern void ublox_gprs_context_init(void);
+extern void ublox_gprs_context_exit(void);
-- =

2.5.0


--===============7420416210345906838==--

