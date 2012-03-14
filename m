Content-Type: multipart/mixed; boundary="===============4598012862254476044=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 3/3] voicecall: Force callheld update after calls swap
Date: Wed, 14 Mar 2012 17:00:53 +0100
Message-ID: <1331740853-3994-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1331740853-3994-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4598012862254476044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In HFP spec, a callheld indicator update should be sent after swapping
calls, even if it stays to 1 (AG has both active and held calls).
---
 src/voicecall.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index dc4fdf5..c8c51f1 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -119,6 +119,8 @@ static const char *default_en_list[] =3D { "911", "112"=
, NULL };
 static const char *default_en_list_no_sim[] =3D { "119", "118", "999", "11=
0",
 						"08", "000", NULL };
 =

+static void send_ciev_after_swap_callback(const struct ofono_error *error,
+								void *data);
 static void generic_callback(const struct ofono_error *error, void *data);
 static void hangup_all_active(const struct ofono_error *error, void *data);
 static void multirelease_callback(const struct ofono_error *err, void *dat=
a);
@@ -746,6 +748,17 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
 						&val);
 }
 =

+static void emulator_set_indicator_forced(struct ofono_voicecall *vc,
+						const char *name, int value)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	struct ofono_emulator *em;
+
+	em =3D __ofono_atom_find(OFONO_ATOM_TYPE_EMULATOR_HFP, modem);
+	if (em)
+		ofono_emulator_set_indicator_forced(em, name, value);
+}
+
 static void emulator_call_status_cb(struct ofono_atom *atom, void *data)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
@@ -1615,13 +1628,19 @@ static DBusMessage *manager_swap_without_accept(DBu=
sConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	ofono_voicecall_cb_t cb;
 =

 	if (vc->pending || vc->dial_req || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	vc->driver->swap_without_accept(vc, generic_callback, vc);
+	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
+		cb =3D send_ciev_after_swap_callback;
+	else
+		cb =3D generic_callback;
+
+	vc->driver->swap_without_accept(vc, cb, vc);
 =

 	return NULL;
 }
@@ -1631,6 +1650,7 @@ static DBusMessage *manager_swap_calls(DBusConnection=
 *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
+	ofono_voicecall_cb_t cb;
 =

 	if (vc->driver->swap_without_accept)
 		return manager_swap_without_accept(conn, msg, data);
@@ -1646,7 +1666,12 @@ static DBusMessage *manager_swap_calls(DBusConnectio=
n *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

-	vc->driver->hold_all_active(vc, generic_callback, vc);
+	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
+		cb =3D send_ciev_after_swap_callback;
+	else
+		cb =3D generic_callback;
+
+	vc->driver->hold_all_active(vc, cb, vc);
 =

 	return NULL;
 }
@@ -2300,6 +2325,28 @@ error:
 		g_free(v);
 }
 =

+static void send_ciev_after_swap_callback(const struct ofono_error *error,
+								void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		DBG("command failed with error: %s",
+				telephony_error_to_str(error));
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		reply =3D dbus_message_new_method_return(vc->pending);
+		emulator_set_indicator_forced(vc, OFONO_EMULATOR_IND_CALLHELD,
+					OFONO_EMULATOR_CALLHELD_MULTIPLE);
+	} else
+		reply =3D __ofono_error_failed(vc->pending);
+
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+}
+
+
+
 static void generic_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -2801,6 +2848,23 @@ static void sim_watch(struct ofono_atom *atom,
 	sim_state_watch(ofono_sim_get_state(sim), vc);
 }
 =

+static void emulator_send_ciev_after_swap_cb(const struct ofono_error *err=
or,
+								void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+
+	if (vc->pending_em =3D=3D NULL)
+		return;
+
+	ofono_emulator_send_final(vc->pending_em, error);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		emulator_set_indicator_forced(vc, OFONO_EMULATOR_IND_CALLHELD,
+					OFONO_EMULATOR_CALLHELD_MULTIPLE);
+
+	vc->pending_em =3D NULL;
+}
+
 static void emulator_generic_cb(const struct ofono_error *error, void *dat=
a)
 {
 	struct ofono_voicecall *vc =3D data;
@@ -3039,6 +3103,7 @@ static void emulator_chld_cb(struct ofono_emulator *e=
m,
 	char buf[64];
 	char *info;
 	int chld;
+	ofono_voicecall_cb_t cb;
 =

 	result.error =3D 0;
 =

@@ -3080,9 +3145,14 @@ static void emulator_chld_cb(struct ofono_emulator *=
em,
 			if (vc->driver->hold_all_active =3D=3D NULL)
 				goto fail;
 =

+			if (voicecalls_have_active(vc) &&
+					voicecalls_have_held(vc))
+				cb =3D emulator_send_ciev_after_swap_cb;
+			else
+				cb =3D emulator_generic_cb;
+
 			vc->pending_em =3D em;
-			vc->driver->hold_all_active(vc,
-					emulator_generic_cb, vc);
+			vc->driver->hold_all_active(vc, cb, vc);
 			return;
 		case 3:
 			if (vc->driver->create_multiparty =3D=3D NULL)
-- =

1.7.1


--===============4598012862254476044==--

