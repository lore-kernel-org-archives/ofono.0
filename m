Content-Type: multipart/mixed; boundary="===============8231626343457028446=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Keep modem->powered_pending up to date after set_powered.
Date: Thu, 10 Sep 2009 18:57:11 +0200
Message-ID: <1252601831-7907-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8231626343457028446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this once a request to power up the modem fails, modem.c won't
retry even when asked.
---
 src/modem.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index ed6f870..5e6e582 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -462,6 +462,11 @@ static int set_powered(struct ofono_modem *modem, ofon=
o_bool_t powered)
 			err =3D driver->disable(modem);
 	}
 =

+	if (err =3D=3D 0)
+		modem->powered =3D powered;
+	else if (err !=3D EINPROGRESS)
+		modem->powered_pending =3D modem->powered;
+
 	return err;
 }
 =

@@ -472,6 +477,7 @@ static gboolean set_powered_timeout(gpointer user)
 	DBG("modem: %p", modem);
 =

 	modem->timeout =3D 0;
+	modem->powered_pending =3D modem->powered;
 =

 	if (modem->pending !=3D NULL) {
 		DBusMessage *reply;
@@ -530,9 +536,6 @@ static DBusMessage *modem_set_property(DBusConnection *=
conn,
 			return NULL;
 		}
 =

-		modem->powered =3D powered;
-		modem->powered_pending =3D powered;
-
 		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

 		ofono_dbus_signal_property_changed(conn, modem->path,
-- =

1.6.1


--===============8231626343457028446==--

