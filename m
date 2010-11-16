Content-Type: multipart/mixed; boundary="===============1722723803191127916=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 4/4] modem: add support to restore state when resetting the
 modem
Date: Tue, 16 Nov 2010 18:49:09 -0200
Message-ID: <1289940549-14896-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289940549-14896-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1722723803191127916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   72 ++++++++++++++++++++++++++++++++-----------------------=
---
 1 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 9ed52c1..64500f6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -61,6 +61,7 @@ enum modem_state {
 struct ofono_modem {
 	char			*path;
 	enum modem_state	modem_state;
+	enum modem_state	old_state;
 	GSList			*atoms;
 	struct ofono_watchlist	*atom_watches;
 	GSList			*interface_list;
@@ -414,48 +415,26 @@ static void modem_change_state(struct ofono_modem *mo=
dem,
 	}
 }
 =

-static void sim_state_watch(enum ofono_sim_state new_state, void *user)
-{
-	struct ofono_modem *modem =3D user;
-
-	switch (new_state) {
-	case OFONO_SIM_STATE_NOT_PRESENT:
-		modem_change_state(modem, MODEM_STATE_PRE_SIM);
-		break;
-	case OFONO_SIM_STATE_INSERTED:
-		break;
-	case OFONO_SIM_STATE_READY:
-		modem_change_state(modem, MODEM_STATE_OFFLINE);
-
-		/*
-		 * If we don't have the set_online method, also proceed
-		 * straight to the online state
-		 */
-		if (modem->driver->set_online =3D=3D NULL)
-			modem_change_state(modem, MODEM_STATE_ONLINE);
-
-		modem->reset =3D FALSE;
-
-		break;
-	}
-}
-
 static void online_cb(const struct ofono_error *error, void *data)
 {
 	struct ofono_modem *modem =3D data;
 	DBusMessage *reply;
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
+			modem->modem_state =3D=3D MODEM_STATE_OFFLINE) {
+		modem_change_state(modem, MODEM_STATE_ONLINE);
+
+		if (modem->reset) {
+			modem->reset =3D FALSE;
+			return;
+		}
+
 		reply =3D dbus_message_new_method_return(modem->pending);
-	else
+	} else {
 		reply =3D __ofono_error_failed(modem->pending);
+	}
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
-
-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
-		modem_change_state(modem, MODEM_STATE_ONLINE);
 }
 =

 static void offline_cb(const struct ofono_error *error, void *data)
@@ -475,6 +454,34 @@ static void offline_cb(const struct ofono_error *error=
, void *data)
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
 }
 =

+static void sim_state_watch(enum ofono_sim_state new_state, void *user)
+{
+	struct ofono_modem *modem =3D user;
+
+	switch (new_state) {
+	case OFONO_SIM_STATE_NOT_PRESENT:
+		modem_change_state(modem, MODEM_STATE_PRE_SIM);
+		break;
+	case OFONO_SIM_STATE_INSERTED:
+		break;
+	case OFONO_SIM_STATE_READY:
+		modem_change_state(modem, MODEM_STATE_OFFLINE);
+
+		/*
+		 * If we don't have the set_online method, also proceed
+		 * straight to the online state
+		 */
+		if (modem->driver->set_online =3D=3D NULL)
+			modem_change_state(modem, MODEM_STATE_ONLINE);
+		else if (modem->old_state > MODEM_STATE_OFFLINE)
+			modem->driver->set_online(modem, 1, online_cb, modem);
+		else
+			modem->reset =3D FALSE;
+
+		break;
+	}
+}
+
 static DBusMessage *set_property_online(struct ofono_modem *modem,
 					DBusMessage *msg,
 					DBusMessageIter *var)
@@ -1586,6 +1593,7 @@ static gboolean __reset_modem(void *data)
 	struct ofono_modem *modem =3D data;
 	int err;
 =

+	modem->old_state =3D modem->modem_state;
 	modem->reset =3D TRUE;
 =

 	err =3D set_powered(modem, FALSE);
-- =

1.7.3.1


--===============1722723803191127916==--

