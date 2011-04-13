Content-Type: multipart/mixed; boundary="===============5361659769063223019=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 6/6] voicecall: add +CHUP support for HFP emulator
Date: Wed, 13 Apr 2011 18:05:34 +0200
Message-ID: <1302710734-6103-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5361659769063223019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update multirelease_callback to be used from DBus calls or HFP Emulator.
"release done" is configurable by multirelease caller.
---
 src/voicecall.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 929ecba..f5af3ac 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -44,9 +44,17 @@
 =

 GSList *g_drivers =3D NULL;
 =

+typedef void (*ofono_voicecall_release_next_t)(struct ofono_voicecall *vc);
+
+struct multirelease {
+	ofono_voicecall_cb_t release_done;
+	struct ofono_emulator *em;
+};
+
 struct ofono_voicecall {
 	GSList *call_list;
 	GSList *release_list;
+	struct multirelease multirelease;
 	GSList *multiparty_list;
 	GHashTable *en_list; /* emergency number list */
 	GSList *sim_en_list; /* Emergency numbers already read from SIM */
@@ -1234,6 +1242,15 @@ fallback:
 					multirelease_callback, vc);
 }
 =

+static void voicecalls_release_done(const struct ofono_error *error, void =
*data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusMessage *reply;
+
+	reply =3D dbus_message_new_method_return(vc->pending);
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+}
+
 static DBusMessage *manager_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -1602,7 +1619,7 @@ static DBusMessage *manager_hangup_all(DBusConnection=
 *conn,
 {
 	struct ofono_voicecall *vc =3D data;
 =

-	if (vc->pending)
+	if (vc->pending || vc->release_list)
 		return __ofono_error_busy(msg);
 =

 	if (vc->driver->hangup_all =3D=3D NULL &&
@@ -1619,6 +1636,9 @@ static DBusMessage *manager_hangup_all(DBusConnection=
 *conn,
 =

 	if (vc->driver->hangup_all =3D=3D NULL) {
 		voicecalls_release_queue(vc, vc->call_list);
+
+		vc->multirelease.release_done =3D voicecalls_release_done;
+
 		voicecalls_release_next(vc);
 	} else
 		vc->driver->hangup_all(vc, generic_callback, vc);
@@ -1828,7 +1848,7 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 {
 	struct ofono_voicecall *vc =3D data;
 =

-	if (vc->pending)
+	if (vc->pending || vc->release_list)
 		return __ofono_error_busy(msg);
 =

 	if (vc->driver->release_specific =3D=3D NULL)
@@ -1871,6 +1891,9 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 =

 	/* Fall back to the old-fashioned way */
 	voicecalls_release_queue(vc, vc->multiparty_list);
+
+	vc->multirelease.release_done =3D voicecalls_release_done;
+
 	voicecalls_release_next(vc);
 =

 out:
@@ -2175,15 +2198,13 @@ static void generic_callback(const struct ofono_err=
or *error, void *data)
 static void multirelease_callback(const struct ofono_error *error, void *d=
ata)
 {
 	struct ofono_voicecall *vc =3D data;
-	DBusMessage *reply;
 =

 	if (vc->release_list !=3D NULL) {
 		voicecalls_release_next(vc);
 		return;
 	}
 =

-	reply =3D dbus_message_new_method_return(vc->pending);
-	__ofono_dbus_pending_reply(&vc->pending, reply);
+	vc->multirelease.release_done(error, vc);
 }
 =

 static void emit_en_list_changed(struct ofono_voicecall *vc)
@@ -2389,6 +2410,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"A");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+CHUP");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -2603,6 +2628,68 @@ fail:
 	};
 }
 =

+static void emulator_release_done(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	emulator_generic_cb(error, vc->multirelease.em);
+}
+
+static void emulator_chup_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_error result;
+	GSList *l;
+	struct voicecall *call;
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		if (vc->release_list)
+			goto fail;
+
+		if (vc->driver->release_specific =3D=3D NULL &&
+				vc->driver->hangup_active =3D=3D NULL)
+			goto fail;
+
+		if (vc->driver->hangup_active) {
+			vc->driver->hangup_active(vc, emulator_generic_cb, em);
+			goto done;
+		}
+
+		for (l =3D vc->call_list; l; l =3D l->next) {
+			call =3D l->data;
+
+			if (call->call->status =3D=3D CALL_STATUS_WAITING ||
+					call->call->status =3D=3D CALL_STATUS_HELD)
+				continue;
+
+			vc->release_list =3D g_slist_prepend(vc->release_list,
+								l->data);
+		}
+
+		if (vc->release_list =3D=3D NULL)
+			goto fail;
+
+		vc->multirelease.release_done =3D emulator_release_done;
+		vc->multirelease.em =3D em;
+
+		voicecalls_release_next(vc);
+
+done:
+		dial_request_user_cancel(vc, NULL);
+		break;
+
+	default:
+fail:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -2615,6 +2702,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	notify_emulator_call_status(data);
 =

 	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============5361659769063223019==--

