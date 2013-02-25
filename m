Content-Type: multipart/mixed; boundary="===============5561401169904071003=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] audio-settings: Fix unneeded async for GetProperties
Date: Mon, 25 Feb 2013 10:48:39 -0300
Message-ID: <1361800119-10775-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5561401169904071003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GetProperties method call for Audio settings returns the reply in the
same iteraction, it doesn't need to be asynchronous.
---
 src/audio-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/audio-settings.c b/src/audio-settings.c
index aae7423..ee933d0 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -118,7 +118,7 @@ static DBusMessage *audio_get_properties(DBusConnection=
 *conn,
 }
 =

 static const GDBusMethodTable audio_methods[] =3D {
-	{ GDBUS_ASYNC_METHOD("GetProperties",
+	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 				audio_get_properties) },
 	{ }
-- =

1.7.11.7


--===============5561401169904071003==--

