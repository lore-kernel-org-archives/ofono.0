Content-Type: multipart/mixed; boundary="===============2296161386558831728=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V3 4/4] voicecall: add +BLDN support for HFP emulator
Date: Wed, 01 Jun 2011 13:24:23 +0200
Message-ID: <1306927463-10642-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1306927463-10642-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2296161386558831728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index f176e25..c4a15a2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2474,6 +2474,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"D");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+BLDN");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -3094,6 +3098,35 @@ fail:
 	};
 }
 =

+static void emulator_bldn_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	const char *number;
+	struct ofono_error result;
+	GError *error =3D NULL;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		if (vc->settings =3D=3D NULL)
+			goto fail;
+
+		number =3D g_key_file_get_string(vc->settings, SETTINGS_GROUP,
+						"Number", &error);
+		if (number =3D=3D NULL || number[0] =3D=3D '\0')
+			goto fail;
+
+		emulator_dial(em, vc, number);
+		break;
+
+	default:
+fail:
+		result.error =3D 0;
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -3111,6 +3144,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+VTS", emulator_vts_cb, data, NULL);
 	ofono_emulator_add_handler(em, "D", emulator_atd_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+BLDN", emulator_bldn_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============2296161386558831728==--

