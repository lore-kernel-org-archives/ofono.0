Content-Type: multipart/mixed; boundary="===============0875336905003442629=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 09:50:39 +0200
Message-ID: <20181023075039.13587-2-gciofono@gmail.com>
In-Reply-To: <20181023075039.13587-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0875336905003442629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed the connection timeout to 60 seconds (from 20 seconds),
to accomodate for chipset that take time to boot-up.
---
 src/modem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 124a5192..e7978bb0 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1060,7 +1060,7 @@ static DBusMessage *set_property_lockdown(struct ofon=
o_modem *modem,
 		}
 =

 		modem->pending =3D dbus_message_ref(msg);
-		modem->timeout =3D g_timeout_add_seconds(20,
+		modem->timeout =3D g_timeout_add_seconds(60,
 						set_powered_timeout, modem);
 		return NULL;
 	}
@@ -1138,7 +1138,7 @@ static DBusMessage *modem_set_property(DBusConnection=
 *conn,
 				return __ofono_error_failed(msg);
 =

 			modem->pending =3D dbus_message_ref(msg);
-			modem->timeout =3D g_timeout_add_seconds(20,
+			modem->timeout =3D g_timeout_add_seconds(60,
 						set_powered_timeout, modem);
 			return NULL;
 		}
-- =

2.17.1


--===============0875336905003442629==--

