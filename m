Content-Type: multipart/mixed; boundary="===============7117096697778232756=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 1/2] modem: Support modem property "AlwaysOnline"
Date: Thu, 28 Mar 2013 17:00:32 -0400
Message-ID: <20130328210032.GA31496@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7117096697778232756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

This can be set by the modem driver to indicate that the device is
always in the online state when it is enabled.  This is useful for
modem drivers that handle both CDMA and GSM devices.
---
 src/modem.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 0f12f5a..49913a9 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -595,6 +595,17 @@ static gboolean modem_has_sim(struct ofono_modem *mode=
m)
 	return FALSE;
 }
 =

+static gboolean modem_is_always_online(struct ofono_modem *modem)
+{
+	if (modem->driver->set_online =3D=3D NULL)
+		return TRUE;
+
+	if (ofono_modem_get_boolean(modem, "AlwaysOnline") =3D=3D TRUE)
+		return TRUE;
+
+	return FALSE;
+}
+
 static void common_online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
@@ -702,11 +713,8 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *user)
 	case OFONO_SIM_STATE_READY:
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 =

-		/*
-		 * If we don't have the set_online method, also proceed
-		 * straight to the online state
-		 */
-		if (modem->driver->set_online =3D=3D NULL)
+		/* Modem is always online, proceed to online state. */
+		if (modem_is_always_online(modem) =3D=3D TRUE)
 			set_online(modem, TRUE);
 =

 		if (modem->online =3D=3D TRUE)
@@ -745,7 +753,7 @@ static DBusMessage *set_property_online(struct ofono_mo=
dem *modem,
 	if (ofono_modem_get_emergency_mode(modem) =3D=3D TRUE)
 		return __ofono_error_emergency_active(msg);
 =

-	if (driver->set_online =3D=3D NULL)
+	if (modem_is_always_online(modem) =3D=3D TRUE)
 		return __ofono_error_not_implemented(msg);
 =

 	modem->pending =3D dbus_message_ref(msg);
-- =

1.7.0.4

--===============7117096697778232756==--

