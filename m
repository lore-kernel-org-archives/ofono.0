Content-Type: multipart/mixed; boundary="===============4119905643097856539=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] modem: add support to restore state when resetting the modem
Date: Tue, 07 Dec 2010 16:31:34 -0200
Message-ID: <1291746694-8014-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <4CFDAEA0.6000408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4119905643097856539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   60 +++++++++++++++++++++++++++++++++++--------------------=
---
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 2f9387c..816443e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -70,6 +70,7 @@ struct ofono_modem {
 	guint			interface_update;
 	ofono_bool_t		powered;
 	ofono_bool_t		powered_pending;
+	ofono_bool_t		get_online;
 	guint			timeout;
 	ofono_bool_t		online;
 	struct ofono_watchlist	*online_watches;
@@ -434,30 +435,6 @@ static void modem_change_state(struct ofono_modem *mod=
em,
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
-		break;
-	}
-}
-
 unsigned int __ofono_modem_add_online_watch(struct ofono_modem *modem,
 					ofono_modem_online_notify_func notify,
 					void *data, ofono_destroy_func destroy)
@@ -487,6 +464,9 @@ static void online_cb(const struct ofono_error *error, =
void *data)
 	struct ofono_modem *modem =3D data;
 	DBusMessage *reply;
 =

+	if (!modem->pending)
+		goto out;
+
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
 			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
 		reply =3D dbus_message_new_method_return(modem->pending);
@@ -495,6 +475,7 @@ static void online_cb(const struct ofono_error *error, =
void *data)
 =

 	__ofono_dbus_pending_reply(&modem->pending, reply);
 =

+out:
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
 			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
 		modem_change_state(modem, MODEM_STATE_ONLINE);
@@ -517,6 +498,34 @@ static void offline_cb(const struct ofono_error *error=
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
+		else if (modem->get_online)
+			modem->driver->set_online(modem, 1, online_cb, modem);
+
+		modem->get_online =3D FALSE;
+
+		break;
+	}
+}
+
 static DBusMessage *set_property_online(struct ofono_modem *modem,
 					DBusMessage *msg,
 					DBusMessageIter *var)
@@ -1627,6 +1636,9 @@ void ofono_modem_reset(struct ofono_modem *modem)
 		__ofono_dbus_pending_reply(&modem->pending, reply);
 	}
 =

+	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+		modem->get_online =3D TRUE;
+
 	ofono_modem_set_powered(modem, FALSE);
 =

 	err =3D set_powered(modem, TRUE);
-- =

1.7.3.2


--===============4119905643097856539==--

