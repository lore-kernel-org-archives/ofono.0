Content-Type: multipart/mixed; boundary="===============3783672237739770113=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] gprs: pri_set_apn not exclusively a DBus method
Date: Tue, 09 May 2017 16:52:37 +0200
Message-ID: <1494341557-3118-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1494341557-3118-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3783672237739770113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pri_set_apn is called by ofono_gprs_cid_activated() when attached
using LTE technology.
This patch avoid calling DBUS functions in this case. Without
this patch we have a crash in ofono process in this case.

diff --git a/src/gprs.c b/src/gprs.c
index c5e7709..9c6d282 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1027,14 +1027,28 @@ static DBusMessage *pri_set_apn(struct pri_context =
*ctx, DBusConnection *conn,
 {
 	GKeyFile *settings =3D ctx->gprs->settings;
 =

-	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
-		return __ofono_error_invalid_format(msg);
+	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH) {
+		if (msg)
+			return __ofono_error_invalid_format(msg);
 =

-	if (g_str_equal(apn, ctx->context.apn))
-		return dbus_message_new_method_return(msg);
+		DBG("APN %s too long", apn);
+		return NULL;
+	}
 =

-	if (is_valid_apn(apn) =3D=3D FALSE)
-		return __ofono_error_invalid_format(msg);
+	if (g_str_equal(apn, ctx->context.apn)) {
+		if (msg)
+			return dbus_message_new_method_return(msg);
+
+		return NULL;
+	}
+
+	if (is_valid_apn(apn) =3D=3D FALSE) {
+		if (msg)
+			return __ofono_error_invalid_format(msg);
+
+		DBG("APN %s invalid", apn);
+		return NULL;
+	}
 =

 	strcpy(ctx->context.apn, apn);
 =

-- =

2.7.4


--===============3783672237739770113==--

