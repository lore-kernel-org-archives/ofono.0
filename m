Content-Type: multipart/mixed; boundary="===============2004461327053874548=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 1/2] dundee: Fix typo in Manager's signal DeviceAdded
Date: Fri, 22 Feb 2013 14:01:11 -0300
Message-ID: <1361552472-23096-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2004461327053874548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This typo was preventing dundee from sending the signal.
---
 dundee/manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dundee/manager.c b/dundee/manager.c
index d7374d6..e8a37bf 100644
--- a/dundee/manager.c
+++ b/dundee/manager.c
@@ -90,7 +90,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ GDBUS_SIGNAL("DevicesAdded",
+	{ GDBUS_SIGNAL("DeviceAdded",
 		GDBUS_ARGS({ "path", "o"},{ "properties", "a{sv}" })) },
 	{ GDBUS_SIGNAL("DeviceRemoved",
 		GDBUS_ARGS({ "path", "o"})) },
-- =

1.7.9.5


--===============2004461327053874548==--

