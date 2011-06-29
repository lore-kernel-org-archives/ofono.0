Content-Type: multipart/mixed; boundary="===============3793038133352885493=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] voicecall: manage multiparty list in AT+CHLD=2X
Date: Wed, 29 Jun 2011 21:38:53 +0200
Message-ID: <1309376333-6076-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1309376333-6076-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3793038133352885493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 8e4ab58..e55f44b 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2756,6 +2756,38 @@ static void emulator_mpty_join_cb(const struct ofono=
_error *error, void *data)
 	g_free(mp);
 }
 =

+static void emulator_mpty_private_chat_cb(const struct ofono_error *error,
+							void *data)
+{
+	struct mpty_cb_info *mp =3D data;
+	GSList *old;
+	GSList *l;
+
+	ofono_emulator_send_final(mp->em, error);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		g_free(mp);
+		return;
+	}
+
+	old =3D g_slist_copy(mp->vc->multiparty_list);
+
+	l =3D g_slist_find_custom(mp->vc->multiparty_list,
+				GINT_TO_POINTER(mp->id), call_compare_by_id);
+
+	if (l) {
+		mp->vc->multiparty_list =3D
+			g_slist_remove(mp->vc->multiparty_list, l->data);
+
+		if (mp->vc->multiparty_list->next =3D=3D NULL) {
+			g_slist_free(mp->vc->multiparty_list);
+			mp->vc->multiparty_list =3D 0;
+		}
+	}
+
+	voicecalls_multiparty_changed(old, mp->vc->multiparty_list);
+	g_slist_free(old);
+	g_free(mp);
 }
 =

 static void emulator_ata_cb(struct ofono_emulator *em,
@@ -2990,11 +3022,35 @@ static void emulator_chld_cb(struct ofono_emulator =
*em,
 		}
 =

 		if (chld >=3D 21 && chld <=3D 27) {
+			GSList *l;
+			struct mpty_cb_info *mp;
+			unsigned int id =3D chld - 20;
+
 			if (vc->driver->private_chat =3D=3D NULL)
 				goto fail;
 =

-			vc->driver->private_chat(vc, chld - 20,
-					emulator_generic_cb, em);
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
+			mp =3D g_try_malloc0(sizeof(struct mpty_cb_info));
+			if (!mp)
+				goto fail;
+
+			mp->vc =3D vc;
+			mp->em =3D em;
+			mp->id =3D id;
+
+			vc->driver->private_chat(vc, id,
+					emulator_mpty_private_chat_cb, mp);
 			return;
 		}
 =

-- =

1.7.1


--===============3793038133352885493==--

