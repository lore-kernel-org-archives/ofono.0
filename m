Content-Type: multipart/mixed; boundary="===============0785261510757741220=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Always store RoamingAllowed as a boolean.
Date: Tue, 16 Apr 2019 08:09:26 +0200
Message-ID: <20190416060926.9021-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0785261510757741220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In one instance it was stored as boolean and another as int.
Since its always parsed as a boolean and it is a boolean,
always store it as boolean.
---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index d432c9fd..148cbc97 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1793,7 +1793,7 @@ static DBusMessage *gprs_set_property(DBusConnection =
*conn,
 		gprs->roaming_allowed =3D value;
 =

 		if (gprs->settings) {
-			g_key_file_set_integer(gprs->settings, SETTINGS_GROUP,
+			g_key_file_set_boolean(gprs->settings, SETTINGS_GROUP,
 						"RoamingAllowed",
 						gprs->roaming_allowed);
 			storage_sync(gprs->imsi, SETTINGS_STORE,
-- =

2.19.1


--===============0785261510757741220==--

