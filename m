Content-Type: multipart/mixed; boundary="===============4817785493626532824=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 15/26] emulator: add dun_ath_cb() and register it
Date: Fri, 01 Apr 2011 10:56:17 +0200
Message-ID: <1301648188-7208-16-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4817785493626532824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index ededf9d..f375c9e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -188,6 +188,53 @@ error:
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
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -477,10 +524,19 @@ void ofono_emulator_register(struct ofono_emulator *e=
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
+
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


--===============4817785493626532824==--

