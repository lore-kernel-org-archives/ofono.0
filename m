Content-Type: multipart/mixed; boundary="===============4791380429376497092=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v2] atmodem/lte: proto and authentication handling
Date: Thu, 25 Oct 2018 07:49:21 +0200
Message-ID: <20181025054921.4803-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4791380429376497092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono_lte_default_attach_info now handles also the protocol and the
authentication method, username and password.

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
---
 drivers/atmodem/lte.c | 70 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index c4866623..f4ac10be 100644
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
@@ -42,43 +43,84 @@
 =

 struct lte_driver_data {
 	GAtChat *chat;
+	struct ofono_lte_default_attach_info pending_info;
 };
 =

-static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_lte_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

-	DBG("ok %d", ok);
-
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
 =

+static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
+	struct lte_driver_data *ldd =3D cbd->user;
+	struct ofono_error error;
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1];
+	size_t buflen =3D sizeof(buf);
+	size_t len;
+	enum ofono_gprs_auth_method auth_method;
+
+	if (!ok) {
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, data);
+		return;
+	}
+
+	auth_method =3D ldd->pending_info.auth_method;
+
+	/* change the authentication method if the  parameters are invalid */
+	if (!*ldd->pending_info.username || !*ldd->pending_info.password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	len =3D snprintf(buf, buflen, "AT+CGAUTH=3D0,%d",
+			at_util_gprs_auth_method_to_auth_prot(auth_method));
+	buflen -=3D len;
+
+	if (auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE)
+		snprintf(buf + len, buflen, ",\"%s\",\"%s\"",
+				ldd->pending_info.username,
+				ldd->pending_info.password);
+
+	cbd =3D cb_data_ref(cbd);
+	if (g_at_chat_send(ldd->chat, buf, NULL,
+			at_lte_set_auth_cb, cbd, cb_data_unref) > 0)
+		return;
+
+	cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
 {
 	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
-	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *buf =3D at_util_get_cgdcont_command(0, info->proto, info->apn);
 =

-	DBG("LTE config with APN: %s", info->apn);
+	cbd->user =3D ldd;
+	memcpy(&ldd->pending_info, info, sizeof(ldd->pending_info));
 =

-	if (strlen(info->apn) > 0)
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
-				info->apn);
-	else
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
-
-	/* We can't do much in case of failure so don't check response. */
 	if (g_at_chat_send(ldd->chat, buf, NULL,
-			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
-		return;
+					at_lte_set_default_attach_info_cb,
+					cbd, cb_data_unref) > 0)
+		goto end;
 =

+	cb_data_unref(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
+end:
+	g_free(buf);
 }
 =

 static gboolean lte_delayed_register(gpointer user_data)
-- =

2.17.1


--===============4791380429376497092==--

