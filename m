Content-Type: multipart/mixed; boundary="===============1543591290698894438=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 5/6] atmodem/lte: proto and authentication handling
Date: Wed, 10 Oct 2018 08:54:52 +0200
Message-ID: <20181010065454.15232-4-gciofono@gmail.com>
In-Reply-To: <20181010065454.15232-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1543591290698894438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/lte.c | 79 +++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index efa4e5fe..1d097c68 100644
--- a/drivers/atmodem/lte.c
+++ b/drivers/atmodem/lte.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -45,48 +46,67 @@ struct lte_driver_data {
 	GAtChat *chat;
 };
 =

-static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
-							gpointer user_data)
+static void at_set_reg_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_lte_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	char buf_cgdcont[32 + OFONO_GPRS_MAX_APN_LENGTH  +1];
+	char buf_cgauth[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH +1];
+	guint buflen =3D sizeof(buf_cgauth);
+	enum ofono_gprs_auth_method auth_method;
 =

-	DBG("ok %d", ok);
+	if (strlen(info->apn) > 0)
+		snprintf(buf_cgdcont, sizeof(buf_cgdcont),
+				"AT+CGDCONT=3D0,\"IP\",\"%s\"", info->apn);
+	else
+		snprintf(buf_cgdcont, sizeof(buf_cgdcont),
+				"AT+CGDCONT=3D0,\"IP\"");
 =

-	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, cbd->data);
+	if (g_at_chat_send(ldd->chat, buf_cgdcont, NULL, NULL, NULL, NULL) =3D=3D=
 0)
+		return;
+
+	snprintf(buf_cgauth, buflen, "AT+CGAUTH=3D0,");
+	buflen -=3D strlen(buf_cgauth);
+
+	auth_method =3D info->auth_method;
+
+	/*
+	 * change the authentication method if the  parameters are invalid
+	 * for behavior compatibility
+	 */
+	if(!*info->username || !*info->password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	switch(auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		snprintf(buf_cgauth+strlen(buf_cgauth),
+				buflen, "1,\"%s\",\"%s\"",
+				info->username, info->password);
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		snprintf(buf_cgauth+strlen(buf_cgauth),
+				buflen, "2,\"%s\",\"%s\"",
+				info->username, info->password);
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		snprintf(buf_cgauth+strlen(buf_cgauth), buflen, "0");
+		break;
+	}
+
+	g_at_chat_send(ldd->chat, buf_cgauth, NULL, NULL, NULL, NULL);
 }
 =

 static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
 {
-	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
-	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-
-	DBG("LTE config with APN: %s", info->apn);
-
-	if (strlen(info->apn) > 0)
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
-				info->apn);
-	else
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
-
-	/* We can't do much in case of failure so don't check response. */
-	if (g_at_chat_send(ldd->chat, buf, NULL,
-			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
-		return;
-
-	CALLBACK_WITH_FAILURE(cb, data);
+	CALLBACK_WITH_SUCCESS(cb, data);
 }
 =

 static gboolean lte_delayed_register(gpointer user_data)
 {
-	struct ofono_lte *lte =3D user_data;
-
-	ofono_lte_register(lte);
+	ofono_lte_register(user_data);
 =

 	return FALSE;
 }
@@ -129,6 +149,7 @@ static struct ofono_lte_driver driver =3D {
 	.probe				=3D at_lte_probe,
 	.remove				=3D at_lte_remove,
 	.set_default_attach_info	=3D at_lte_set_default_attach_info,
+	.set_reg_info			=3D at_set_reg_info,
 };
 =

 void at_lte_init(void)
-- =

2.17.1


--===============1543591290698894438==--

