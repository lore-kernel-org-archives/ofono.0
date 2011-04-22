Content-Type: multipart/mixed; boundary="===============8394468647339808297=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2] voicecall: add +CLCC support for HFP emulator
Date: Fri, 22 Apr 2011 15:00:10 +0200
Message-ID: <1303477210-27097-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1303477210-27097-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8394468647339808297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 7aa0b7e..51b8511 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2411,6 +2411,10 @@ static void emulator_hfp_unregister(struct ofono_ato=
m *atom)
 						OFONO_ATOM_TYPE_EMULATOR_HFP,
 						emulator_remove_handler,
 						"+CHUP");
+	__ofono_modem_foreach_registered_atom(modem,
+						OFONO_ATOM_TYPE_EMULATOR_HFP,
+						emulator_remove_handler,
+						"+CLCC");
 =

 	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
 }
@@ -2678,6 +2682,59 @@ fail:
 	};
 }
 =

+static void emulator_clcc_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_voicecall *vc =3D userdata;
+	struct ofono_error result;
+	GSList *l;
+	struct voicecall *v;
+	gboolean mpty;
+	/*
+	 * '+CLCC: 123,1,1,0,1,"+",' + phone number + phone type on 3 digits
+	 * + terminating null
+	 */
+	char buf[OFONO_MAX_PHONE_NUMBER_LENGTH + 26 + 1];
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		for (l =3D vc->call_list; l; l =3D l->next) {
+			v =3D l->data;
+
+			if (g_slist_find_custom(vc->multiparty_list,
+						GINT_TO_POINTER(v->call->id),
+						call_compare_by_id))
+				mpty =3D TRUE;
+			else
+				mpty =3D FALSE;
+
+			if (v->call->clip_validity =3D=3D CLIP_VALIDITY_VALID)
+				sprintf(buf, "+CLCC: %d,%d,%d,0,%d,\"%s\",%d",
+					v->call->id, v->call->direction,
+					v->call->status, mpty,
+					v->call->phone_number.number,
+					v->call->phone_number.type);
+			else
+				sprintf(buf, "+CLCC: %d,%d,%d,0,%d,\"\",128",
+					v->call->id, v->call->direction,
+					v->call->status, mpty);
+
+			ofono_emulator_send_info(em, buf, l->next =3D=3D NULL ?
+							TRUE : FALSE);
+		}
+
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		break;
+
+	default:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+	}
+
+	ofono_emulator_send_final(em, &result);
+}
+
 static void emulator_hfp_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
@@ -2691,6 +2748,7 @@ static void emulator_hfp_watch(struct ofono_atom *ato=
m,
 =

 	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
 	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
+	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
 }
 =

 void ofono_voicecall_register(struct ofono_voicecall *vc)
-- =

1.7.1


--===============8394468647339808297==--

