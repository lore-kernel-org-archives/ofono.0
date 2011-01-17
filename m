Content-Type: multipart/mixed; boundary="===============6383456609409624414=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [RFC PATCH 3/3] smart-messaging: Adapt to use new validation function
Date: Mon, 17 Jan 2011 11:59:28 -0300
Message-ID: <1295276368-32233-4-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1295276368-32233-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6383456609409624414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/smart-messaging.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index 40af89f..5b77263 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -200,7 +200,7 @@ static DBusMessage *smart_messaging_send_vcard(DBusConn=
ection *conn,
 					&bytes, &len, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	if (valid_phone_number_format(to) =3D=3D FALSE)
+	if (valid_short_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

 	ref =3D __ofono_sms_get_next_ref(sm->sms);
@@ -243,7 +243,7 @@ static DBusMessage *smart_messaging_send_vcal(DBusConne=
ction *conn,
 					&bytes, &len, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	if (valid_phone_number_format(to) =3D=3D FALSE)
+	if (valid_short_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

 	ref =3D __ofono_sms_get_next_ref(sm->sms);
-- =

1.7.2.3


--===============6383456609409624414==--

