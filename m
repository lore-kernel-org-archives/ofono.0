Content-Type: multipart/mixed; boundary="===============1778224385114019447=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 15:16:46 +0200
Message-ID: <20181012131646.25397-2-gciofono@gmail.com>
In-Reply-To: <20181012131646.25397-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1778224385114019447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono_lte_default_attach_info now handles also the protocol and the
authentication method, username and password.

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
---
 drivers/atmodem/lte.c | 94 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 10 deletions(-)

diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index efa4e5fe..e5af6cd2 100644
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
@@ -45,10 +46,17 @@ struct lte_driver_data {
 	GAtChat *chat;
 };
 =

-static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+struct lte_callbackdata {
+	ofono_lte_cb_t cb;
+	void *data;
+	struct lte_driver_data *ldd;
+	const struct ofono_lte_default_attach_info *info;
+};
+
+static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct lte_callbackdata *cbd =3D user_data;
 	ofono_lte_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

@@ -58,27 +66,93 @@ static void at_lte_set_default_attach_info_cb(gboolean =
ok, GAtResult *result,
 	cb(&error, cbd->data);
 }
 =

+static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct lte_callbackdata *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
+	struct ofono_error error;
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1];
+	size_t buflen =3D sizeof(buf);
+	size_t len;
+	enum ofono_gprs_auth_method auth_method;
+
+	if (!ok) {
+		g_free(cbd);
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, data);
+	}
+
+	len =3D snprintf(buf, buflen, "AT+CGAUTH=3D0,");
+	buflen -=3D len;
+	auth_method =3D cbd->info->auth_method;
+
+	/* change the authentication method if the  parameters are invalid */
+	if (!*cbd->info->username || !*cbd->info->password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	switch (auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		snprintf(buf + len, buflen, "1,\"%s\",\"%s\"",
+				cbd->info->username, cbd->info->password);
+		break;
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		snprintf(buf + len, buflen, "2,\"%s\",\"%s\"",
+				cbd->info->username, cbd->info->password);
+		break;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		snprintf(buf + len, buflen, "0");
+		break;
+	}
+
+	if (g_at_chat_send(cbd->ldd->chat, buf, NULL,
+			at_lte_set_auth_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
 {
 	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
 	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct lte_callbackdata *cbd =3D g_new0(struct lte_callbackdata ,1);
+	const char *proto;
+	size_t len;
 =

 	DBG("LTE config with APN: %s", info->apn);
 =

-	if (strlen(info->apn) > 0)
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
-				info->apn);
-	else
-		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
+	cbd->cb =3D cb;
+	cbd->data =3D data;
+	cbd->ldd =3D ldd;
+	cbd->info =3D info;
+
+	switch (info->proto) {
+	case OFONO_GPRS_PROTO_IPV6:
+		proto =3D "IPV6";
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		proto =3D "IPV4V6";
+		break;
+	case OFONO_GPRS_PROTO_IP:
+		proto =3D "IP";
+		break;
+	}
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"%s\"", proto);
+
+	if (*info->apn)
+		snprintf(buf+len, sizeof(buf)-len, ",\"%s\"", info->apn);
 =

-	/* We can't do much in case of failure so don't check response. */
 	if (g_at_chat_send(ldd->chat, buf, NULL,
-			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
+			at_lte_set_default_attach_info_cb, cbd, NULL) > 0)
 		return;
 =

+	g_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-- =

2.17.1


--===============1778224385114019447==--

