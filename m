Content-Type: multipart/mixed; boundary="===============6815130422135445739=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 2/2] voicecall: manage multiparty list in AT+CHLD=2X
Date: Tue, 05 Jul 2011 07:50:37 +0200
Message-ID: <1309845037-27360-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1309845037-27360-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6815130422135445739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 14f25ab..01d7c0a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -78,6 +78,7 @@ struct ofono_voicecall {
 	GKeyFile *settings;
 	char *imsi;
 	struct ofono_emulator *pending_em;
+	unsigned int pending_id;
 	char *em_atd_number;
 };
 =

@@ -2748,6 +2749,38 @@ static void emulator_mpty_join_cb(const struct ofono=
_error *error, void *data)
 	g_slist_free(old);
 }
 =

+static void emulator_mpty_private_chat_cb(const struct ofono_error *error,
+							void *data)
+{
+	struct ofono_voicecall *vc =3D data;
+	GSList *old;
+	GSList *l;
+
+	ofono_emulator_send_final(vc->pending_em, error);
+	vc->pending_em =3D NULL;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	old =3D g_slist_copy(vc->multiparty_list);
+
+	l =3D g_slist_find_custom(vc->multiparty_list,
+			GINT_TO_POINTER(vc->pending_id), call_compare_by_id);
+
+	if (l) {
+		vc->multiparty_list =3D
+			g_slist_remove(vc->multiparty_list, l->data);
+
+		if (vc->multiparty_list->next =3D=3D NULL) {
+			g_slist_free(vc->multiparty_list);
+			vc->multiparty_list =3D 0;
+		}
+	}
+
+	voicecalls_multiparty_changed(old, vc->multiparty_list);
+	g_slist_free(old);
+}
+
 static void emulator_ata_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
@@ -2974,11 +3007,32 @@ static void emulator_chld_cb(struct ofono_emulator =
*em,
 		}
 =

 		if (chld >=3D 21 && chld <=3D 27) {
+			GSList *l;
+			unsigned int id =3D chld - 20;
+
 			if (vc->driver->private_chat =3D=3D NULL)
 				goto fail;
 =

-			vc->driver->private_chat(vc, chld - 20,
-					emulator_generic_cb, em);
+			if (vc->pending_em || vc->pending || vc->dial_req)
+				goto fail;
+
+			for (l =3D vc->multiparty_list; l; l =3D l->next) {
+				struct voicecall *v =3D l->data;
+				if (v->call->id =3D=3D id)
+					break;
+			}
+
+			if (l =3D=3D NULL)
+				goto fail;
+
+			if (voicecalls_have_held(vc))
+				goto fail;
+
+			vc->pending_em =3D em;
+			vc->pending_id =3D id;
+
+			vc->driver->private_chat(vc, id,
+					emulator_mpty_private_chat_cb, vc);
 			return;
 		}
 =

-- =

1.7.1


--===============6815130422135445739==--

