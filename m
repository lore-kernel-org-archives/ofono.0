Content-Type: multipart/mixed; boundary="===============1151762633908578195=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/7] atmodem: implemented sim-auth functionality in atmodem
Date: Tue, 26 Sep 2017 09:26:05 -0700
Message-ID: <1506443169-19755-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1151762633908578195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implemented the core API's needed for sim-auth:

list_apps: already implemented
open_channel: Opens a logical channel with +CCHO
close_channel: Closes logical channel with +CCHC
logical_access: Access an opened channel with +CGLA
---
 drivers/atmodem/sim-auth.c | 129 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
index 271ceed..9a745f9 100644
--- a/drivers/atmodem/sim-auth.c
+++ b/drivers/atmodem/sim-auth.c
@@ -25,6 +25,7 @@
 =

 #define _GNU_SOURCE
 #include <string.h>
+#include <stdio.h>
 =

 #include <glib.h>
 =

@@ -35,6 +36,7 @@
 #include "gatresult.h"
 #include "simutil.h"
 #include "vendor.h"
+#include "util.h"
 =

 #include "atmodem.h"
 =

@@ -44,6 +46,8 @@ struct sim_auth_data {
 };
 =

 static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
+static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
+static const char *cgla_prefix[] =3D { "+CGLA:", NULL };
 =

 static void at_discover_apps_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
@@ -110,6 +114,128 @@ static void at_discover_apps(struct ofono_sim_auth *s=
a,
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 }
 =

+static void at_open_channel_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_open_channel_cb_t cb =3D cbd->cb;
+	int session_id =3D -1;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CCHO:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &session_id))
+		goto error;
+
+	cb(session_id, cbd->data);
+
+	return;
+
+error:
+	cb(-1, cbd->data);
+}
+
+static void at_open_channel(struct ofono_sim_auth *sa,
+		ofono_sim_open_channel_cb_t cb, const void *channel,
+		void *data)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[43];
+	int ret =3D 0;
+
+	strcpy(cmd, "AT+CCHO=3D\"");
+	ret +=3D 9;
+
+	encode_hex_own_buf(channel, 16, 0, cmd + ret);
+	ret +=3D 32;
+
+	strcpy(cmd + ret, "\"");
+
+	if (g_at_chat_send(sad->chat, cmd, ccho_prefix, at_open_channel_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	cb(-1, data);
+}
+
+static void at_close_channel(struct ofono_sim_auth *sa, int session_id)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	char cmd[15];
+
+	sprintf(cmd, "AT+CCHC=3D%d", session_id);
+
+	g_at_chat_send(sad->chat, cmd, NULL, NULL, NULL, NULL);
+}
+
+static void logical_access_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_logical_access_cb_t cb =3D cbd->cb;
+	const char *str_data;
+	uint8_t *raw;
+	gint len =3D 0;
+	GAtResultIter iter;
+
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGLA:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &len))
+		goto error;
+
+	if (!g_at_result_iter_next_string(&iter, &str_data))
+		goto error;
+
+	raw =3D alloca(len / 2);
+
+	decode_hex_own_buf(str_data, len, NULL, 0, raw);
+
+	cb(raw, len / 2, cbd->data);
+
+	return;
+
+error:
+	cb(NULL, 0, cbd->data);
+}
+
+static void at_logical_access(struct ofono_sim_auth *sa,
+		ofono_logical_access_cb_t cb, int session_id,
+		const uint8_t *pdu, uint16_t len, void *data)
+
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int ret =3D 0;
+	char cmd[(len * 2) + 19];
+
+	ret =3D sprintf(cmd, "AT+CGLA=3D%d,%d,\"", session_id, len * 2);
+
+	encode_hex_own_buf(pdu, len, 0, cmd + ret);
+	ret +=3D len * 2;
+
+	strcpy(cmd + ret, "\"");
+
+	if (g_at_chat_send(sad->chat, cmd, cgla_prefix, logical_access_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	cb(NULL, 0, data);
+}
+
 static gboolean at_sim_auth_register(gpointer user)
 {
 	struct ofono_sim_auth *sa =3D user;
@@ -151,6 +277,9 @@ static struct ofono_sim_auth_driver driver =3D {
 	.probe		=3D at_sim_auth_probe,
 	.remove		=3D at_sim_auth_remove,
 	.list_apps	=3D at_discover_apps,
+	.open_channel	=3D at_open_channel,
+	.close_channel	=3D at_close_channel,
+	.logical_access =3D at_logical_access
 };
 =

 void at_sim_auth_init(void)
-- =

2.7.4


--===============1151762633908578195==--

