Content-Type: multipart/mixed; boundary="===============4964143288752824248=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/7] voicecall: add +CHLD support for HFP emulator
Date: Mon, 02 May 2011 17:48:03 +0200
Message-ID: <1304351288-3894-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4964143288752824248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 4564a65..3507f33 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2417,6 +2417,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"+CLCC");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+CHLD");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -2737,6 +2741,71 @@ static void emulator_clcc_cb(struct ofono_emulator *=
em,
 	ofono_emulator_send_final(em, &result);
 }
 =

+static void emulator_chld_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_error result;
+	char buf[22];
+	char *info;
+	int chld;
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		if (!ofono_emulator_request_next_number(req, &chld))
+			goto fail;
+
+		switch (chld) {
+		case 1:
+			if (vc->driver->release_all_active =3D=3D NULL)
+				goto fail;
+
+			vc->driver->release_all_active(vc,
+					emulator_generic_cb, em);
+			return;
+		case 2:
+			if (vc->driver->hold_all_active =3D=3D NULL)
+				goto fail;
+
+			vc->driver->hold_all_active(vc,
+					emulator_generic_cb, em);
+			return;
+		default:
+			goto fail;
+		}
+		break;
+
+	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
+		memcpy(buf, "+CHLD=3D", 6);
+		info =3D buf + 6;
+
+		if (vc->driver->release_all_active)
+			*info++ =3D '1';
+
+		if (vc->driver->hold_all_active) {
+			if (info - buf > 6)
+				*info++ =3D ',';
+
+			*info++ =3D '2';
+		}
+
+		*info++ =3D '\0';
+
+		ofono_emulator_send_info(em, buf, TRUE);
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		break;
+
+	case OFONO_EMULATOR_REQUEST_TYPE_QUERY:
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+fail:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+	}
+
+	ofono_emulator_send_final(em, &result);
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -2751,6 +2820,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============4964143288752824248==--

