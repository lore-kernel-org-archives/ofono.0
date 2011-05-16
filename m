Content-Type: multipart/mixed; boundary="===============0058319212871013954=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] voicecall: add +VTS support for HFP emulator
Date: Mon, 16 May 2011 12:13:49 +0200
Message-ID: <1305540829-14417-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0058319212871013954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d46f463..846c1c4 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2421,6 +2421,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"+CHLD");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+VTS");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -2866,6 +2870,44 @@ fail:
 	ofono_emulator_send_final(em, &result);
 }
 =

+static void vts_tone_cb(int error, void *data)
+{
+	struct ofono_emulator *em =3D data;
+	struct ofono_error result;
+
+	result.error =3D 0;
+	result.type =3D error ? OFONO_ERROR_TYPE_FAILURE :
+						OFONO_ERROR_TYPE_NO_ERROR;
+
+	ofono_emulator_send_final(em, &result);
+}
+
+static void emulator_vts_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_error result;
+	const char *str;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		str =3D ofono_emulator_request_get_raw(req);
+
+		if (__ofono_voicecall_tone_send(vc, str, vts_tone_cb, em) < 0)
+			break;
+
+		return;
+
+	default:
+		break;
+	}
+
+	result.error =3D 0;
+	result.type =3D OFONO_ERROR_TYPE_FAILURE;
+
+	ofono_emulator_send_final(em, &result);
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -2881,6 +2923,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+VTS", emulator_vts_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============0058319212871013954==--

