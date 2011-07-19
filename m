Content-Type: multipart/mixed; boundary="===============4484425105901415617=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 3/3] voicecall: remove usage of em_atd_number
Date: Tue, 19 Jul 2011 18:49:11 +0200
Message-ID: <1311094151-9765-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1311094151-9765-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4484425105901415617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

as emulator atom can only run with a 'ready' SIM,
use saved number instead of em_atd_number
---
 src/voicecall.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 8815d9e..3e9b5e5 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -74,7 +74,6 @@ struct ofono_voicecall {
 	ofono_voicecall_cb_t release_queue_done_cb;
 	struct ofono_emulator *pending_em;
 	unsigned int pending_id;
-	char *em_atd_number;
 };
 =

 struct voicecall {
@@ -1506,14 +1505,14 @@ static int voicecall_dial(struct ofono_voicecall *v=
c, const char *number,
 =

 	string_to_phone_number(number, &ph);
 =

-	vc->driver->dial(vc, &ph, clir, cb, vc);
-
 	if (vc->settings) {
 		g_key_file_set_string(vc->settings, SETTINGS_GROUP,
 					"Number", number);
 		storage_sync(vc->imsi, SETTINGS_STORE, vc->settings);
 	}
 =

+	vc->driver->dial(vc, &ph, clir, cb, vc);
+
 	return 0;
 }
 =

@@ -3153,13 +3152,18 @@ static void emulator_dial_callback(const struct ofo=
no_error *error, void *data)
 	struct ofono_voicecall *vc =3D data;
 	gboolean need_to_emit;
 	struct voicecall *v;
+	const char *number;
+	GError *err =3D NULL;
+
+	number =3D g_key_file_get_string(vc->settings, SETTINGS_GROUP,
+					"Number", &err);
 =

-	v =3D dial_handle_result(vc, error, vc->em_atd_number, &need_to_emit);
+	v =3D dial_handle_result(vc, error, number, &need_to_emit);
 =

 	if (v =3D=3D NULL) {
 		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 =

-		if (is_emergency_number(vc, vc->em_atd_number) =3D=3D TRUE)
+		if (is_emergency_number(vc, number) =3D=3D TRUE)
 			__ofono_modem_dec_emergency_mode(modem);
 	}
 =

@@ -3167,8 +3171,6 @@ static void emulator_dial_callback(const struct ofono=
_error *error, void *data)
 		ofono_emulator_send_final(vc->pending_em, error);
 =

 	vc->pending_em =3D NULL;
-	g_free(vc->em_atd_number);
-	vc->em_atd_number =3D NULL;
 =

 	notify_emulator_call_status(vc);
 =

@@ -3190,7 +3192,6 @@ static void emulator_dial(struct ofono_emulator *em, =
struct ofono_voicecall *vc,
 	}
 =

 	vc->pending_em =3D em;
-	vc->em_atd_number =3D g_strdup(number);
 =

 	err =3D voicecall_dial(vc, number, OFONO_CLIR_OPTION_DEFAULT,
 					emulator_dial_callback, vc);
@@ -3199,8 +3200,6 @@ static void emulator_dial(struct ofono_emulator *em, =
struct ofono_voicecall *vc,
 		return;
 =

 	vc->pending_em =3D NULL;
-	g_free(vc->em_atd_number);
-	vc->em_atd_number =3D NULL;
 =

 	switch (err) {
 	case -ENETDOWN:
-- =

1.7.1


--===============4484425105901415617==--

