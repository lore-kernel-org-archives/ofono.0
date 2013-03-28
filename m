Content-Type: multipart/mixed; boundary="===============0029756753152559458=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [RFC PATCH 2/3] modem: Support modem property "AlwaysOnline"
Date: Thu, 28 Mar 2013 10:22:35 -0400
Message-ID: <20130328142235.GH29445@alittletooquiet.net>
In-Reply-To: <20130328142112.GF29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0029756753152559458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 src/modem.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 0f12f5a..6c6937a 100644
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
@@ -706,7 +717,7 @@ static void sim_state_watch(enum ofono_sim_state new_st=
ate, void *user)
 		 * If we don't have the set_online method, also proceed
 		 * straight to the online state
 		 */
-		if (modem->driver->set_online =3D=3D NULL)
+		if (modem_is_always_online(modem) =3D=3D TRUE)
 			set_online(modem, TRUE);
 =

 		if (modem->online =3D=3D TRUE)
@@ -745,7 +756,7 @@ static DBusMessage *set_property_online(struct ofono_mo=
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

--===============0029756753152559458==--

