Content-Type: multipart/mixed; boundary="===============4115176302114322947=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/3] Add isimodem radio access driver
Date: Wed, 03 Feb 2010 00:38:06 +0200
Message-ID: <1265150286-14548-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1265150286-14548-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4115176302114322947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                     |    1 +
 drivers/isimodem/isimodem.c     |    4 +
 drivers/isimodem/isimodem.h     |    3 +
 drivers/isimodem/radio-access.c |  299 +++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 307 insertions(+), 0 deletions(-)
 create mode 100644 drivers/isimodem/radio-access.c

diff --git a/Makefile.am b/Makefile.am
index 5f67878..235aa86 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -103,6 +103,7 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/call-barring.c \
 				drivers/isimodem/call-meter.c \
 				drivers/isimodem/ss.h \
+				drivers/isimodem/radio-access.c \
 				drivers/isimodem/gss.h
 endif
 =

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 48f41c3..4b65d21 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -49,6 +49,7 @@
 #include <ofono/call-settings.h>
 #include <ofono/call-barring.h>
 #include <ofono/call-meter.h>
+#include <ofono/radio-access.h>
 =

 #include "isimodem.h"
 #include "isiutil.h"
@@ -310,6 +311,7 @@ static void isi_modem_post_sim(struct ofono_modem *mode=
m)
 	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
 	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
+	ofono_radio_access_create(isi->modem, 0, "isimodem", isi->idx);
 }
 =

 static struct ofono_modem_driver driver =3D {
@@ -339,6 +341,7 @@ static int isimodem_init(void)
 	isi_call_settings_init();
 	isi_call_barring_init();
 	isi_call_meter_init();
+	isi_radio_access_init();
 =

 	ofono_modem_driver_register(&driver);
 =

@@ -379,6 +382,7 @@ static void isimodem_exit(void)
 	isi_call_settings_exit();
 	isi_call_barring_exit();
 	isi_call_meter_exit();
+	isi_radio_access_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(isimodem, "PhoNet / ISI modem driver", VERSION,
diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index 3eb2fbe..2b3d756 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -57,3 +57,6 @@ extern void isi_call_barring_exit();
 =

 extern void isi_call_meter_init();
 extern void isi_call_meter_exit();
+
+extern void isi_radio_access_init();
+extern void isi_radio_access_exit();
diff --git a/drivers/isimodem/radio-access.c b/drivers/isimodem/radio-acces=
s.c
new file mode 100644
index 0000000..8c9e0b5
--- /dev/null
+++ b/drivers/isimodem/radio-access.c
@@ -0,0 +1,299 @@
+/*
+ * This file is part of oFono - Open Source Telephony
+ *
+ * Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <gisi/client.h>
+#include <gisi/iter.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-access.h>
+
+#include "isimodem.h"
+#include "isiutil.h"
+#include "debug.h"
+#include "gss.h"
+
+struct access_data {
+	GIsiClient *client;
+};
+
+static bool rat_mode_read_resp_cb(GIsiClient *client, const void *restrict=
 data,
+					size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_radio_access_mode_query_cb_t cb =3D cbd->cb;
+	int mode =3D -1;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3) {
+		DBG("truncated message");
+		return false;
+	}
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
+		goto error;
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_RESP) {
+		GIsiSubBlockIter iter;
+
+		for (g_isi_sb_iter_init(&iter, msg, len, 3);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) {
+
+			switch (g_isi_sb_iter_get_id(&iter)) {
+
+			case GSS_RAT_INFO: {
+
+				guint8 byte;
+
+				if (!g_isi_sb_iter_get_byte(&iter, &byte, 2))
+					goto error;
+
+				mode =3D (int)byte;
+
+				break;
+			}
+			default:
+				DBG("Skipping sub-block: %s (%zu bytes)",
+					gss_subblock_name(g_isi_sb_iter_get_id(&iter)),
+					g_isi_sb_iter_get_len(&iter));
+				break;
+			}
+		}
+
+		CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
+		goto out;
+	}
+
+	return false;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+out:
+	g_free(cbd);
+	return true;
+}
+
+static void isi_query_mode(struct ofono_radio_access *ra,
+				ofono_radio_access_mode_query_cb_t cb,
+				void *data)
+{
+	struct access_data *access =3D ofono_radio_access_get_data(ra);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(access, cb, data);
+
+	const unsigned char msg[] =3D {
+		GSS_CS_SERVICE_REQ,
+		GSS_SELECTED_RAT_READ,
+		0x00 /* subblock count */
+	};
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(access->client, msg, sizeof(msg),
+				GSS_TIMEOUT, rat_mode_read_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static bool rat_mode_write_resp_cb(GIsiClient *client, const void *restric=
t data,
+					size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_radio_access_mode_set_cb_t cb =3D cbd->cb;
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		goto error;
+	}
+
+	if (len < 3) {
+		DBG("truncated message");
+		return false;
+	}
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
+		goto error;
+
+	if (msg[0] =3D=3D GSS_CS_SERVICE_RESP) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto out;
+	}
+
+	return false;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+out:
+	g_free(cbd);
+	return true;
+}
+
+static void isi_set_mode(struct ofono_radio_access *ra, int mode,
+				ofono_radio_access_mode_set_cb_t cb,
+				void *data)
+{
+	struct access_data *access =3D ofono_radio_access_get_data(ra);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(access, cb, data);
+
+	const unsigned char msg[] =3D {
+		GSS_CS_SERVICE_REQ,
+		GSS_SELECTED_RAT_WRITE,
+		0x01, /* subblock count */
+		GSS_RAT_INFO,
+		0x04, /* subblock length */
+		mode,
+		0x00 /* filler */
+	};
+
+	if (!cbd)
+		goto error;
+
+	if (g_isi_request_make(access->client, msg, sizeof(msg),
+				GSS_TIMEOUT, rat_mode_write_resp_cb, cbd))
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void rat_mode_ind_cb(GIsiClient *client, const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_radio_access *ra =3D opaque;
+
+	if (!msg || len < 3 || msg[0] !=3D GSS_SELECTED_RAT_IND)
+		return;
+
+	ofono_radio_access_mode_notify(ra, msg[1]);
+}
+
+static gboolean isi_radio_access_register(gpointer user)
+{
+	struct ofono_radio_access *ra =3D user;
+	struct access_data *access =3D ofono_radio_access_get_data(ra);
+
+	const char *debug =3D getenv("OFONO_ISI_DEBUG");
+
+	if (debug && (g_strcmp0(debug, "all") =3D=3D 0
+		|| g_strcmp0(debug, "gss") =3D=3D 0))
+		g_isi_client_set_debug(access->client, gss_debug, NULL);
+
+	g_isi_subscribe(access->client, GSS_SELECTED_RAT_IND,
+			rat_mode_ind_cb, ra);
+
+	ofono_radio_access_register(ra);
+
+	return FALSE;
+}
+
+static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+				void *opaque)
+{
+	struct ofono_radio_access *ra =3D opaque;
+
+	if (!alive) {
+		DBG("devinfo driver bootstrap failed");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+
+	g_idle_add(isi_radio_access_register, ra);
+}
+
+static int isi_radio_access_probe(struct ofono_radio_access *ra, unsigned =
int vendor,
+					void *user)
+{
+	GIsiModem *idx =3D user;
+	struct access_data *data =3D g_try_new0(struct access_data, 1);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->client =3D g_isi_client_create(idx, PN_GSS);
+	if (!data->client) {
+		g_free(data);
+		return -ENOMEM;
+	}
+
+	ofono_radio_access_set_data(ra, data);
+
+	g_isi_verify(data->client, reachable_cb, ra);
+
+	return 0;
+}
+
+static void isi_radio_access_remove(struct ofono_radio_access *ra)
+{
+	struct access_data *data =3D ofono_radio_access_get_data(ra);
+
+	if (data) {
+		g_isi_client_destroy(data->client);
+		g_free(data);
+	}
+}
+
+static struct ofono_radio_access_driver driver =3D {
+	.name			=3D "isimodem",
+	.probe			=3D isi_radio_access_probe,
+	.remove			=3D isi_radio_access_remove,
+	.query_mode		=3D isi_query_mode,
+	.set_mode		=3D isi_set_mode
+};
+
+void isi_radio_access_init()
+{
+	ofono_radio_access_driver_register(&driver);
+}
+
+void isi_radio_access_exit()
+{
+	ofono_radio_access_driver_unregister(&driver);
+}
-- =

1.6.3.3


--===============4115176302114322947==--

