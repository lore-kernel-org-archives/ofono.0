Content-Type: multipart/mixed; boundary="===============0642579737476127518=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] modem: do not allow more than one client to lock down
Date: Wed, 26 Jan 2011 09:33:57 +0200
Message-ID: <1296027237-2532-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0642579737476127518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 553549e..a92107e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -805,11 +805,14 @@ static DBusMessage *set_property_lockdown(struct ofon=
o_modem *modem,
 	if (modem->pending !=3D NULL)
 		return __ofono_error_busy(msg);
 =

+	caller =3D dbus_message_get_sender(msg);
+
+	if (modem->lockdown && g_strcmp0(caller, modem->lock_owner))
+		return __ofono_error_access_denied(msg);
+
 	if (modem->lockdown =3D=3D lockdown)
 		return dbus_message_new_method_return(msg);
 =

-	caller =3D dbus_message_get_sender(msg);
-
 	if (lockdown) {
 		dbus_bool_t powered;
 =

@@ -847,12 +850,8 @@ static DBusMessage *set_property_lockdown(struct ofono=
_modem *modem,
 					OFONO_MODEM_INTERFACE,
 					"Powered", DBUS_TYPE_BOOLEAN,
 					&powered);
-	} else {
-		if (g_strcmp0(caller, modem->lock_owner))
-			return __ofono_error_access_denied(msg);
-
+	} else
 		lockdown_remove(modem);
-	}
 =

 done:
 	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
-- =

1.7.1


--===============0642579737476127518==--

