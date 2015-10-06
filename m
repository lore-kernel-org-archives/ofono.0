Content-Type: multipart/mixed; boundary="===============4655190326531314065=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 2/3] emulator: Add ofono_emulator_set_handsfree_card
Date: Tue, 06 Oct 2015 12:48:13 +0200
Message-ID: <1444128494-31742-3-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444128494-31742-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4655190326531314065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Denis Kenzior <denkenz@gmail.com>

---
 src/emulator.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 1c43e21..5be7b63 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -48,6 +48,7 @@ struct ofono_emulator {
 	GSList *indicators;
 	guint callsetup_source;
 	int pns_id;
+	struct ofono_handsfree_card *card;
 	bool slc : 1;
 	unsigned int events_mode : 2;
 	bool events_ind : 1;
@@ -990,6 +991,9 @@ static void emulator_unregister(struct ofono_atom *atom)
 =

 	g_at_server_unref(em->server);
 	em->server =3D NULL;
+
+	ofono_handsfree_card_remove(em->card);
+	em->card =3D NULL;
 }
 =

 void ofono_emulator_register(struct ofono_emulator *em, int fd)
@@ -1435,6 +1439,8 @@ void __ofono_emulator_slc_condition(struct ofono_emul=
ator *em,
 		ofono_info("SLC reached");
 		em->slc =3D TRUE;
 =

+		ofono_handsfree_card_register(em->card);
+
 	default:
 		break;
 	}
@@ -1460,3 +1466,12 @@ void ofono_emulator_set_hf_indicator_active(struct o=
fono_emulator *em,
 	sprintf(buf, "+BIND: %d,%d", HFP_HF_INDICATOR_ENHANCED_SAFETY, active);
 	g_at_server_send_unsolicited(em->server, buf);
 }
+
+void ofono_emulator_set_handsfree_card(struct ofono_emulator *em,
+					struct ofono_handsfree_card *card)
+{
+	if (em =3D=3D NULL)
+		return;
+
+	em->card =3D card;
+}
-- =

2.5.0


--===============4655190326531314065==--

