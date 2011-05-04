Content-Type: multipart/mixed; boundary="===============6416350394901105758=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 7/8] emulator: add dun_ath_cb() and register it
Date: Wed, 04 May 2011 17:39:05 +0200
Message-ID: <1304523546-643-8-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6416350394901105758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 5963ffb..e389387 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -193,6 +193,53 @@ error:
 	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void dun_ath_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	DBG("");
+
+	if (em->ppp =3D=3D NULL) {
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		return;
+	}
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
+			goto error;
+
+		if (val !=3D 0)
+			goto error;
+
+		g_at_ppp_unref(em->ppp);
+		em->ppp =3D NULL;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		g_at_ppp_unref(em->ppp);
+		em->ppp =3D NULL;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+error:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+
+	return;
+}
+
 static struct indicator *find_indicator(struct ofono_emulator *em,
 						const char *name, int *index)
 {
@@ -678,10 +725,18 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
 =

-	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
+	switch (em->type) {
+	case OFONO_EMULATOR_TYPE_DUN:
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
-	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
+		g_at_server_register(em->server, "H", dun_ath_cb, em, NULL);
+		break;
+	case OFONO_EMULATOR_TYPE_HFP:
 		g_at_server_set_echo(em->server, FALSE);
+		break;
+
+	default:
+		break;
+	}
 }
 =

 static void emulator_remove(struct ofono_atom *atom)
-- =

1.7.1


--===============6416350394901105758==--

