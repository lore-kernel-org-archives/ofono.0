Content-Type: multipart/mixed; boundary="===============2558692659999977001=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] gemaltomodem: added Gemalto-specific gprs-context atom
 This atom name is not the same as the driver,
 because it might be necessary to add other grps-context atoms,
 according to the needs. The name is therefore referring to the main command
 used, AT^SWWAN.
Date: Thu, 20 Sep 2018 05:50:13 +0200
Message-ID: <1537415414-3859-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2558692659999977001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/gemaltomodem/gemaltomodem.c      |   2 +
 drivers/gemaltomodem/gemaltomodem.h      |   3 +
 drivers/gemaltomodem/gprs-context-wwan.c | 446 +++++++++++++++++++++++++++=
++++
 3 files changed, 451 insertions(+)
 create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c

diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 614ca81..7afd3c1 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -35,6 +35,7 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
+	gemaltowwan_gprs_context_init();
 	gemalto_voicecall_init();
 	return 0;
 }
@@ -42,6 +43,7 @@ static int gemaltomodem_init(void)
 static void gemaltomodem_exit(void)
 {
 	gemalto_location_reporting_exit();
+	gemaltowwan_gprs_context_exit();
 	gemalto_voicecall_exit();
 }
 =

diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 4e6ed16..f45aea9 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -24,5 +24,8 @@
 extern void gemalto_location_reporting_init();
 extern void gemalto_location_reporting_exit();
 =

+extern void gemaltowwan_gprs_context_init();
+extern void gemaltowwan_gprs_context_exit();
+
 extern void gemalto_voicecall_init();
 extern void gemalto_voicecall_exit();
diff --git a/drivers/gemaltomodem/gprs-context-wwan.c b/drivers/gemaltomode=
m/gprs-context-wwan.c
new file mode 100644
index 0000000..12378a3
--- /dev/null
+++ b/drivers/gemaltomodem/gprs-context-wwan.c
@@ -0,0 +1,446 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Piotr Haber. All rights reserved.
+ *  Copyright (C) 2018 Sebastian Arnd. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
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
+#include <errno.h>
+#include <sys/stat.h>
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
+#include "gemaltomodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+enum state {
+	STATE_IDLE,
+	STATE_ENABLING,
+	STATE_DISABLING,
+	STATE_ACTIVE,
+};
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_auth_method auth_method;
+	enum state state;
+	enum ofono_gprs_proto proto;
+	char address[64];
+	char netmask[64];
+	char gateway[64];
+	char dns1[64];
+	char dns2[64];
+	ofono_gprs_context_cb_t cb;
+	void *cb_data;
+	int use_wwan;
+};
+
+static gboolean gemalto_get_auth_command(struct ofono_modem *modem, int ci=
d,
+				enum ofono_gprs_auth_method auth_method,
+				const char *username, const char *password,
+				char *buf, guint buflen)
+{
+	int gto_auth =3D ofono_modem_get_integer(modem, "Gemalto_Auth");
+	int len;
+	/*
+	 * 0: use cgauth
+	 * 1: use sgauth(pwd, user)
+	 * 2: use sgauth(user, pwd)
+	 */
+
+	int auth_type;
+
+	switch (auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		auth_type =3D 1;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		auth_type =3D 2;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+	default:
+		auth_type =3D 0;
+		break;
+	}
+
+	if (auth_type !=3D 0 && (!*username || !*password))
+		return FALSE;
+
+	switch (gto_auth) {
+	case 1:
+	case 2:
+		len =3D snprintf(buf, buflen, "AT^SGAUTH=3D%d", cid);
+		break;
+	case 0:
+	default:
+		len =3D snprintf(buf, buflen, "AT+CGAUTH=3D%d", cid);
+		break;
+	}
+
+	buflen -=3D len;
+
+	switch(auth_type) {
+	case 0:
+
+		switch (gto_auth) {
+		case 2:
+			snprintf(buf+len, buflen, ",0,\"\",\"\"");
+			break;
+		case 0:
+		case 1:
+		default:
+			snprintf(buf+len, buflen, ",0");
+			break;
+		}
+		break;
+
+	case 1:
+	case 2:
+
+		switch (gto_auth) {
+		case 1:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, password, username);
+			break;
+		case 0:
+		case 2:
+		default:
+			snprintf(buf+len, buflen, ",%d,\"%s\",\"%s\"",
+					auth_type, username, password);
+		}
+		break;
+
+	default:
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void gemalto_get_cgdcont_command(struct ofono_modem *modem,
+			guint cid, enum ofono_gprs_proto proto, const char *apn,
+							char *buf, guint buflen)
+{
+	int len =3D snprintf(buf, buflen, "AT+CGDCONT=3D%u", cid);
+	buflen -=3D len;
+
+	if (!apn) /* it will remove the context */
+		return;
+
+	switch (proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		snprintf(buf+len, buflen, ",\"IPV6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		snprintf(buf+len, buflen, ",\"IPV4V6\",\"%s\"", apn);
+		break;
+	case OFONO_GPRS_PROTO_IP:
+	default:
+		snprintf(buf+len, buflen, ",\"IP\",\"%s\"", apn);
+		break;
+	}
+}
+
+static void failed_setup(struct ofono_gprs_context *gc,
+				GAtResult *result, gboolean deactivate)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+	char buf[64];
+
+	DBG("deactivate %d", deactivate);
+
+	if (deactivate =3D=3D TRUE) {
+
+		if (gcd->use_wwan)
+			sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+		else
+			sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
+
+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	}
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	if (result =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	gcd->cb(&error, gcd->cb_data);
+}
+
+static void activate_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable activate context");
+		/*
+		 * We've reported sucess already, so can't just call
+		 * failed_setup we call ofono_gprs_context_deactivated instead.
+		 * Thats not a clean solution at all, but as it seems there is
+		 * no clean way to determine whether it is possible to activate
+		 * the context before issuing AT^SWWAN. A possible workaround
+		 * might be to issue AT+CGACT=3D1 and AT+CGACT=3D0 and try if that
+		 * works, before calling CALLBACK_WITH_SUCCESS.
+		 */
+		ofono_gprs_context_deactivated(gc, gcd->active_context);
+		gcd->active_context =3D 0;
+		gcd->state =3D STATE_IDLE;
+		return;
+	}
+	/* We've reported sucess already */
+}
+
+static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+	const char *interface;
+
+	if (!ok) {
+		ofono_error("Failed to setup context");
+		failed_setup(gc, result, FALSE);
+		return;
+	}
+
+	if (gemalto_get_auth_command(modem, gcd->active_context,
+				gcd->auth_method, gcd->username, gcd->password,
+							buf, sizeof(buf))) {
+		if (!g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL,
+									NULL))
+		goto error;
+	}
+	/*
+	 * note that if the auth command is not ok we skip it and continue
+	 * but if the sending fails we do an error
+	 */
+
+	if (gcd->use_wwan)
+		sprintf(buf, "AT^SWWAN=3D1,%u", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGACT=3D%u,1", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+					activate_cb, gc, NULL) > 0){
+
+		interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+		ofono_gprs_context_set_interface(gc, interface);
+		ofono_gprs_context_set_ipv4_address(gc, NULL, FALSE);
+
+		/*
+		 * We report sucess already here because some modules need a
+		 * DHCP request to complete the AT^SWWAN command sucessfully
+		 */
+		gcd->state =3D STATE_ACTIVE;
+
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
+		return;
+	}
+
+error:
+	failed_setup(gc, NULL, FALSE);
+}
+
+static void gemaltowwan_gprs_activate_primary(struct ofono_gprs_context *g=
c,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->use_wwan =3D ofono_modem_get_integer(modem, "Gemalto_WWAN");
+	gcd->active_context =3D ctx->cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	gcd->state =3D STATE_ENABLING;
+	gcd->proto =3D ctx->proto;
+	gcd->auth_method =3D ctx->auth_method;
+
+	gemalto_get_cgdcont_command(modem, ctx->cid, ctx->proto, ctx->apn, buf,
+								sizeof(buf));
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				setup_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void deactivate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void gemaltowwan_gprs_deactivate_primary(struct ofono_gprs_context =
*gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->state =3D STATE_DISABLING;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	if (gcd->use_wwan)
+		sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+	else
+		sprintf(buf, "AT+CGACT=3D%u,0", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				deactivate_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	const char *event;
+	int cid =3D 0;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (!g_str_has_prefix(event, "ME PDN DEACT"))
+		return;
+
+	sscanf(event, "%*s %*s %*s %u", &cid);
+
+	DBG("cid %d", cid);
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		return;
+
+	ofono_gprs_context_deactivated(gc, gcd->active_context);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+}
+
+static int gemaltowwan_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int model, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	DBG("");
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	if (modem)
+		gcd->use_wwan =3D ofono_modem_get_integer(modem, "Gemalto_WWAN");
+	gcd->chat =3D g_at_chat_clone(chat);
+	ofono_gprs_context_set_data(gc, gcd);
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	return 0;
+}
+
+static void gemaltowwan_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_at_chat_unref(gcd->chat);
+	g_free(gcd);
+}
+
+static void gemaltowwan_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	DBG("cid %u", cid);
+
+	ofono_gprs_context_deactivated(gc, cid);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "gemaltowwanmodem",
+	.probe			=3D gemaltowwan_gprs_context_probe,
+	.remove			=3D gemaltowwan_gprs_context_remove,
+	.activate_primary	=3D gemaltowwan_gprs_activate_primary,
+	.deactivate_primary	=3D gemaltowwan_gprs_deactivate_primary,
+	.detach_shutdown	=3D gemaltowwan_gprs_detach_shutdown,
+};
+
+void gemaltowwan_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void gemaltowwan_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
-- =

1.9.1


--===============2558692659999977001==--

