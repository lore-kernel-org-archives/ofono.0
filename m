Content-Type: multipart/mixed; boundary="===============2495850828363576895=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 3/7] atmodem: implemented sim-auth functionality in atmodem
Date: Thu, 21 Sep 2017 11:11:56 -0700
Message-ID: <1506017520-22482-3-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2495850828363576895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implemented the core API's needed for sim-auth:

list_apps: already implemented
open_channel: Opens a logical channel with +CCHO
close_channel: Closes logical channel with +CCHC
gsm_authenticate: Run GSM AUTHENTICATE with +CGLA
umts_authenticate: Run UMTS AUTHENTICATE with +CGLA
---
 drivers/atmodem/sim-auth.c | 232 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 232 insertions(+)

diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
index 271ceed..71e7da3 100644
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
@@ -110,6 +114,230 @@ static void at_discover_apps(struct ofono_sim_auth *s=
a,
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
 }
 =

+static void gsm_authenticate_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gsm_authenticate_cb_t cb =3D cbd->cb;
+	const char *values;
+	gint len =3D 0;
+	GAtResultIter iter;
+	guint8 sres[4];
+	guint8 kc[8];
+
+	g_at_result_iter_init(&iter, result);
+	if (!g_at_result_iter_next(&iter, "+CGLA:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &len))
+		goto error;
+
+	/* "04" + SRES(4) + "08" + KC(8) =3D 14 bytes * 2 =3D 28 characters */
+	if (len < 28)
+		goto error;
+
+	if (!g_at_result_iter_next_string(&iter, &values))
+		goto error;
+
+	if (strncmp(values, "04", 2))
+		goto error;
+
+	decode_hex_own_buf(values + 2, 8, NULL, 0, sres);
+
+	if (strncmp(values + 10, "08", 2))
+		goto error;
+
+	decode_hex_own_buf(values + 12, 16, NULL, 0, kc);
+
+	cb(cbd->data, sres, kc);
+
+	return;
+
+error:
+	cb(cbd->data, NULL, NULL);
+}
+
+static void at_gsm_authenticate(struct ofono_sim_auth *sa,
+		ofono_gsm_authenticate_cb_t cb, int session_id,
+		const void *rand, void *data)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[62];
+
+	int ret =3D sprintf(cmd, "AT+CGLA=3D%d,46,\"008800801110", session_id);
+
+	encode_hex_own_buf(rand, 16, 0, cmd + ret);
+	strcpy(cmd + ret + 32, "00\"");
+
+	if (g_at_chat_send(sad->chat, cmd, cgla_prefix, gsm_authenticate_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	cb(data, NULL, NULL);
+}
+
+static void umts_authenticate_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_umts_authenticate_cb_t cb =3D cbd->cb;
+	const char *values;
+	gint len =3D 0;
+	GAtResultIter iter;
+	guint8 res[8];
+	guint8 ck[16];
+	guint8 ik[16];
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
+	if (!g_at_result_iter_next_string(&iter, &values))
+		goto error;
+
+	if (!strncmp(values, "DB", 2)) {
+		/* 'DB' + '08' + RES(16) + '10' + CK(32) + '10' + IK(32) =3D 86 */
+		if (len < 86)
+			goto error;
+		/* success */
+		if (strncmp(values + 2, "08", 2))
+			goto error;
+
+		decode_hex_own_buf(values + 4, 16, NULL, 0, res);
+
+		if (strncmp(values + 20, "10", 2))
+			goto error;
+
+		decode_hex_own_buf(values + 22, 32, NULL, 0, ck);
+
+		if (strncmp(values + 54, "10", 2))
+			goto error;
+
+		decode_hex_own_buf(values + 56, 32, NULL, 0, ik);
+
+		cb(cbd->data, res, 8, ck, ik);
+	} else if (!strncmp(values, "DC", 2)) {
+		/* 'DB' + '10' + AUTS(16) =3D 36 */
+		if (len < 36)
+			goto error;
+		/* sync error */
+		if (strncmp(values + 2, "10", 2))
+			goto error;
+
+		decode_hex_own_buf(values + 4, 32, NULL, 0, ck);
+
+		cb(cbd->data, NULL, 0xff, ck, ck);
+	} else {
+		/* error */
+		goto error;
+	}
+
+	return;
+
+error:
+	cb(cbd->data, NULL, 0, NULL, NULL);
+}
+
+static void at_umts_authenticate(struct ofono_sim_auth *sa,
+		ofono_umts_authenticate_cb_t cb, int session_id,
+		const void *rand, const void *autn, void *data)
+{
+	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char cmd[150];
+
+	int ret =3D sprintf(cmd, "AT+CGLA=3D%d,80,\"008800812210", session_id);
+
+	encode_hex_own_buf(rand, 16, 0, cmd + ret);
+	ret +=3D 32;
+
+	strcpy(cmd + ret, "10");
+	ret +=3D 2;
+
+	encode_hex_own_buf(autn, 16, 0, cmd + ret);
+	ret +=3D 32;
+
+	strcpy(cmd + ret, "00\"");
+
+	if (g_at_chat_send(sad->chat, cmd, cgla_prefix, umts_authenticate_cb,
+			cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	cb(data, NULL, 0, NULL, NULL);
+}
+
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
 static gboolean at_sim_auth_register(gpointer user)
 {
 	struct ofono_sim_auth *sa =3D user;
@@ -151,6 +379,10 @@ static struct ofono_sim_auth_driver driver =3D {
 	.probe		=3D at_sim_auth_probe,
 	.remove		=3D at_sim_auth_remove,
 	.list_apps	=3D at_discover_apps,
+	.open_channel	=3D at_open_channel,
+	.close_channel	=3D at_close_channel,
+	.gsm_authenticate =3D at_gsm_authenticate,
+	.umts_authenticate =3D at_umts_authenticate
 };
 =

 void at_sim_auth_init(void)
-- =

2.7.4


--===============2495850828363576895==--

