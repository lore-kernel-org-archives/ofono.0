Content-Type: multipart/mixed; boundary="===============0893885665668844256=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v8 5/5] atmodem/lte: proto and authentication handling
Date: Fri, 19 Oct 2018 13:31:41 +0200
Message-ID: <20181019113141.20734-6-gciofono@gmail.com>
In-Reply-To: <20181019113141.20734-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0893885665668844256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono_lte_default_attach_info now handles also the protocol and the
authentication method, username and password.

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
---
 drivers/atmodem/lte.c | 118 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 17 deletions(-)

diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index c4866623..54c8de54 100644
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
@@ -44,41 +45,124 @@ struct lte_driver_data {
 	GAtChat *chat;
 };
 =

-static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+struct lte_cbd {
+	gint ref_count; /* Ref count */
+	ofono_lte_cb_t cb;
+	void *data;
+	GAtChat *chat;
+	const struct ofono_lte_default_attach_info *info;
+	struct ofono_modem *modem;
+};
+
+static struct lte_cbd *lte_cb_data_new0(void *cb, void *data,
+		GAtChat *chat, const struct ofono_lte_default_attach_info *info)
+{
+	struct lte_cbd *cbd =3D g_new0(struct lte_cbd, 1);
+
+	cbd->ref_count =3D 1;
+	cbd->cb =3D cb;
+	cbd->data =3D data;
+	cbd->chat =3D chat;
+	cbd->info =3D info;
+
+	return cbd;
+}
+
+static inline struct lte_cbd *lte_cb_data_ref(struct lte_cbd *cbd)
+{
+	if (cbd =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&cbd->ref_count);
+
+	return cbd;
+}
+
+static void lte_cb_data_unref(gpointer user_data)
+{
+	gboolean is_zero;
+	struct lte_cbd *cbd =3D user_data;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
+
+	if (is_zero =3D=3D TRUE)
+		g_free(cbd);
+}
+
+static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
 							gpointer user_data)
 {
-	struct cb_data *cbd =3D user_data;
+	struct lte_cbd *cbd =3D user_data;
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
+	struct lte_cbd *cbd =3D user_data;
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
+		lte_cb_data_unref(cbd);
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, data);
+		return;
+	}
+
+	auth_method =3D cbd->info->auth_method;
+
+	/* change the authentication method if the  parameters are invalid */
+	if (!*cbd->info->username || !*cbd->info->password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	len =3D snprintf(buf, buflen, "AT+CGAUTH=3D0,%d",
+					at_auth_type_from_method(auth_method));
+	buflen -=3D len;
+
+	if (auth_method !=3D OFONO_GPRS_AUTH_METHOD_NONE)
+		snprintf(buf + len, buflen, ",\"%s\",\"%s\"",
+				cbd->info->username, cbd->info->password);
+
+	cbd =3D lte_cb_data_ref(cbd);
+	if (g_at_chat_send(cbd->chat, buf, NULL,
+			at_lte_set_auth_cb, cbd, lte_cb_data_unref) > 0)
+		return;
+
+	lte_cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
 {
 	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
-	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-
-	DBG("LTE config with APN: %s", info->apn);
+	struct lte_cbd *cbd =3D lte_cb_data_new0(cb, data, ldd->chat, info);
+	char *buf =3D at_get_cgdcont_command(0, info->proto, info->apn);
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
+					cbd, lte_cb_data_unref) > 0)
+		goto end;
 =

+	lte_cb_data_unref(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
+end:
+	g_free(buf);
 }
 =

 static gboolean lte_delayed_register(gpointer user_data)
-- =

2.17.1


--===============0893885665668844256==--

