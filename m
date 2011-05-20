Content-Type: multipart/mixed; boundary="===============9119417718128722023=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH V2 4/4] voicecall: add +BLDN support for HFP emulator
Date: Fri, 20 May 2011 11:41:01 +0200
Message-ID: <1305884461-4476-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1305884461-4476-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9119417718128722023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index e91ba42..9132fed 100644
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
@@ -3025,6 +3029,32 @@ static void emulator_atd_cb(struct ofono_emulator *e=
m,
 	};
 }
 =

+static void emulator_bldn_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	const char *str;
+	struct ofono_error result;
+	GError *error =3D NULL;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		if (vc->settings =3D=3D NULL)
+			goto fail;
+
+		str =3D g_key_file_get_string(vc->settings, LASTDIAL_GROUP,
+						"Number", &error);
+		emulator_dial(em, vc, str);
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
@@ -3041,6 +3071,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
 	ofono_emulator_add_handler(em, "D", emulator_atd_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+BLDN", emulator_bldn_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============9119417718128722023==--

