Content-Type: multipart/mixed; boundary="===============7575774141650676297=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 10/19] handsfree: Removed ASYNC flag from GetProperties
Date: Wed, 12 Oct 2011 14:35:31 +0200
Message-ID: <1318422940-14955-11-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7575774141650676297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 42b71ea..579434b 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -161,8 +161,7 @@ static DBusMessage *handsfree_request_phone_number(DBus=
Connection *conn,
 }
 =

 static GDBusMethodTable handsfree_methods[] =3D {
-	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties,
-		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties },
 	{ "SetProperty",      "sv",  "", handsfree_set_property,
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "RequestPhoneNumber", "", "s", handsfree_request_phone_number,
-- =

1.7.6.4


--===============7575774141650676297==--

