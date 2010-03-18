Content-Type: multipart/mixed; boundary="===============3384081218956032211=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 4/7] Network password has exactly 4 digits.
Date: Thu, 18 Mar 2010 16:44:28 +0200
Message-ID: <1268923471-29059-4-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-3-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3384081218956032211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 src/call-barring.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index eedb41d..f3252e1 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -360,6 +360,12 @@ static const char *cb_ss_service_to_fac(const char *sv=
c)
 	return NULL;
 }
 =

+/* Network password has exactly 4 digits */
+static inline int is_valid_password(const char *pass)
+{
+	return is_valid_pin(pass) && strlen(pass) =3D=3D 4;
+}
+
 static gboolean cb_ss_control(int type, const char *sc,
 				const char *sia, const char *sib,
 				const char *sic, const char *dn,
@@ -403,7 +409,7 @@ static gboolean cb_ss_control(int type, const char *sc,
 	if (strlen(dn) > 0)
 		goto bad_format;
 =

-	if (!is_valid_pin(sia))
+	if (!is_valid_password(sia))
 		goto bad_format;
 =

 	switch (type) {
@@ -524,7 +530,7 @@ static gboolean cb_ss_passwd(const char *sc,
 	if (!fac)
 		return FALSE;
 =

-	if (!is_valid_pin(old) || !is_valid_pin(new))
+	if (!is_valid_password(old) || !is_valid_password(new))
 		goto bad_format;
 =

 	cb->pending =3D dbus_message_ref(msg);
@@ -855,7 +861,7 @@ static DBusMessage *cb_set_property(DBusConnection *con=
n, DBusMessage *msg,
 			return __ofono_error_invalid_args(msg);
 =

 		dbus_message_iter_get_basic(&iter, &passwd);
-		if (!is_valid_pin(passwd))
+		if (!is_valid_password(passwd))
 			return __ofono_error_invalid_format(msg);
 	}
 =

@@ -902,7 +908,7 @@ static DBusMessage *cb_disable_all(DBusConnection *conn=
, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(passwd))
+	if (!is_valid_password(passwd))
 		return __ofono_error_invalid_format(msg);
 =

 	cb_set_query_bounds(cb, fac, FALSE);
@@ -950,10 +956,10 @@ static DBusMessage *cb_set_passwd(DBusConnection *con=
n, DBusMessage *msg,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!is_valid_pin(old_passwd))
+	if (!is_valid_password(old_passwd))
 		return __ofono_error_invalid_format(msg);
 =

-	if (!is_valid_pin(new_passwd))
+	if (!is_valid_password(new_passwd))
 		return __ofono_error_invalid_format(msg);
 =

 	cb->pending =3D dbus_message_ref(msg);
-- =

1.6.3.3


--===============3384081218956032211==--

