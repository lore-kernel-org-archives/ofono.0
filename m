Content-Type: multipart/mixed; boundary="===============3438723786017520334=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/3] call-barring: removed +CSSI type SS notifications
Date: Wed, 09 Feb 2011 12:33:58 +0200
Message-ID: <7f7cc862a685786b014377e6e97c789d8d65666b.1297244230.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1297244229.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3438723786017520334==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c |   74 ------------------------------------------------=
----
 1 files changed, 0 insertions(+), 74 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 649826e..84ed277 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -58,9 +58,6 @@ struct ofono_call_barring {
 	int ss_req_lock;
 	struct ofono_ssn *ssn;
 	struct ofono_ussd *ussd;
-	unsigned int incoming_bar_watch;
-	unsigned int outgoing_bar_watch;
-	unsigned int ssn_watch;
 	unsigned int ussd_watch;
 	const struct ofono_call_barring_driver *driver;
 	void *driver_data;
@@ -987,41 +984,10 @@ static GDBusMethodTable cb_methods[] =3D {
 };
 =

 static GDBusSignalTable cb_signals[] =3D {
-	{ "IncomingBarringInEffect",	"" },
-	{ "OutgoingBarringInEffect",	"" },
 	{ "PropertyChanged",		"sv" },
 	{ }
 };
 =

-static void call_barring_incoming_enabled_notify(int idx, void *userdata)
-{
-	struct ofono_call_barring *cb =3D userdata;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(cb->atom);
-
-	g_dbus_emit_signal(conn, path, OFONO_CALL_BARRING_INTERFACE,
-			"IncomingBarringInEffect", DBUS_TYPE_INVALID);
-}
-
-static void call_barring_outgoing_enabled_notify(int idx, void *userdata)
-{
-	struct ofono_call_barring *cb =3D userdata;
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	const char *path =3D __ofono_atom_get_path(cb->atom);
-	DBusMessage *signal;
-
-	signal =3D dbus_message_new_signal(path, OFONO_CALL_BARRING_INTERFACE,
-						"OutgoingBarringInEffect");
-
-	if (signal =3D=3D NULL) {
-		ofono_error("Unable to allocate new %s.OutgoingBarringInEffect"
-				" signal", OFONO_CALL_BARRING_INTERFACE);
-		return;
-	}
-
-	g_dbus_send_message(conn, signal);
-}
-
 int ofono_call_barring_driver_register(const struct ofono_call_barring_dri=
ver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -1054,14 +1020,6 @@ static void call_barring_unregister(struct ofono_ato=
m *atom)
 	if (cb->ussd)
 		cb_unregister_ss_controls(cb);
 =

-	if (cb->incoming_bar_watch)
-		__ofono_ssn_mo_watch_remove(cb->ssn, cb->incoming_bar_watch);
-	if (cb->outgoing_bar_watch)
-		__ofono_ssn_mt_watch_remove(cb->ssn, cb->outgoing_bar_watch);
-
-	if (cb->ssn_watch)
-		__ofono_modem_remove_atom_watch(modem, cb->ssn_watch);
-
 	if (cb->ussd_watch)
 		__ofono_modem_remove_atom_watch(modem, cb->ussd_watch);
 }
@@ -1116,29 +1074,6 @@ struct ofono_call_barring *ofono_call_barring_create=
(struct ofono_modem *modem,
 	return cb;
 }
 =

-static void ssn_watch(struct ofono_atom *atom,
-			enum ofono_atom_watch_condition cond, void *data)
-{
-	struct ofono_call_barring *cb =3D data;
-
-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		cb->ssn =3D NULL;
-		cb->incoming_bar_watch =3D 0;
-		cb->outgoing_bar_watch =3D 0;
-		return;
-	}
-
-	cb->ssn =3D __ofono_atom_get_data(atom);
-
-	cb->incoming_bar_watch =3D
-		__ofono_ssn_mo_watch_add(cb->ssn, SS_MO_INCOMING_BARRING,
-				call_barring_incoming_enabled_notify, cb, NULL);
-
-	cb->outgoing_bar_watch =3D
-		__ofono_ssn_mo_watch_add(cb->ssn, SS_MO_OUTGOING_BARRING,
-				call_barring_outgoing_enabled_notify, cb, NULL);
-}
-
 static void ussd_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
@@ -1158,7 +1093,6 @@ void ofono_call_barring_register(struct ofono_call_ba=
rring *cb)
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(cb->atom);
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cb->atom);
-	struct ofono_atom *ssn_atom;
 	struct ofono_atom *ussd_atom;
 =

 	if (!g_dbus_register_interface(conn, path,
@@ -1173,14 +1107,6 @@ void ofono_call_barring_register(struct ofono_call_b=
arring *cb)
 =

 	ofono_modem_add_interface(modem, OFONO_CALL_BARRING_INTERFACE);
 =

-	cb->ssn_watch =3D __ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SSN,
-					ssn_watch, cb, NULL);
-
-	ssn_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SSN);
-
-	if (ssn_atom && __ofono_atom_get_registered(ssn_atom))
-		ssn_watch(ssn_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, cb);
-
 	cb->ussd_watch =3D __ofono_modem_add_atom_watch(modem,
 					OFONO_ATOM_TYPE_USSD,
 					ussd_watch, cb, NULL);
-- =

1.7.0.4


--===============3438723786017520334==--

