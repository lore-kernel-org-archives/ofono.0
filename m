Content-Type: multipart/mixed; boundary="===============0376103352564877630=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 4/4] voicecall: Force callheld update after calls swap
Date: Fri, 09 Mar 2012 16:26:55 +0100
Message-ID: <1331306815-13424-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1331306815-13424-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0376103352564877630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In HFP spec, a callheld indicator update should be sent after swapping
calls, even if callheld value has not changed.
---
 src/voicecall.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index dc4fdf5..c3fbc7b 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -746,6 +746,16 @@ static void voicecall_emit_multiparty(struct voicecall=
 *call, gboolean mpty)
 						&val);
 }
 =

+static void emulator_indicator_set_forced(struct ofono_voicecall *vc,
+							const char *name)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	struct ofono_emulator *em;
+
+	em =3D __ofono_atom_find(OFONO_ATOM_TYPE_EMULATOR_HFP, modem);
+	ofono_emulator_indicator_set_forced(em, name);
+}
+
 static void emulator_call_status_cb(struct ofono_atom *atom, void *data)
 {
 	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
@@ -1621,6 +1631,8 @@ static DBusMessage *manager_swap_without_accept(DBusC=
onnection *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

+	emulator_indicator_set_forced(vc, OFONO_EMULATOR_IND_CALLHELD);
+
 	vc->driver->swap_without_accept(vc, generic_callback, vc);
 =

 	return NULL;
@@ -1646,6 +1658,8 @@ static DBusMessage *manager_swap_calls(DBusConnection=
 *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

+	emulator_indicator_set_forced(vc, OFONO_EMULATOR_IND_CALLHELD);
+
 	vc->driver->hold_all_active(vc, generic_callback, vc);
 =

 	return NULL;
@@ -3080,6 +3094,9 @@ static void emulator_chld_cb(struct ofono_emulator *e=
m,
 			if (vc->driver->hold_all_active =3D=3D NULL)
 				goto fail;
 =

+			ofono_emulator_indicator_set_forced(em,
+						OFONO_EMULATOR_IND_CALLHELD);
+
 			vc->pending_em =3D em;
 			vc->driver->hold_all_active(vc,
 					emulator_generic_cb, vc);
-- =

1.7.1


--===============0376103352564877630==--

