Content-Type: multipart/mixed; boundary="===============2311188564557458068=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 3/5] modem: add support to restore state when resetting the
 modem
Date: Thu, 25 Nov 2010 17:02:18 -0200
Message-ID: <1290711740-27886-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1290711740-27886-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311188564557458068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |   70 +++++++++++++++++++++++++++++++++----------------------=
---
 1 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 6233944..1828a3b 100644
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
@@ -488,16 +465,18 @@ static void online_cb(const struct ofono_error *error=
, void *data)
 	DBusMessage *reply;
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR &&
-			modem->modem_state =3D=3D MODEM_STATE_OFFLINE)
+			modem->modem_state =3D=3D MODEM_STATE_OFFLINE) {
+		modem_change_state(modem, MODEM_STATE_ONLINE);
+
+		if (!modem->pending)
+			return;
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
@@ -517,6 +496,34 @@ static void offline_cb(const struct ofono_error *error=
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
@@ -1621,6 +1628,9 @@ void ofono_modem_reset(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (modem->modem_state =3D=3D MODEM_STATE_ONLINE)
+		modem->get_online =3D TRUE;
+
 	ofono_modem_set_powered(modem, FALSE);
 =

 	err =3D set_powered(modem, TRUE);
-- =

1.7.3.2


--===============2311188564557458068==--

