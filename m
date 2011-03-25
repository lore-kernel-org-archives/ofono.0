Content-Type: multipart/mixed; boundary="===============8784747069568350726=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 07/18] emulator: add AT hook_control_cb() and register it
Date: Fri, 25 Mar 2011 16:25:38 +0100
Message-ID: <1301066749-12052-8-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8784747069568350726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c1ceb36..e1b078d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -187,6 +187,41 @@ error:
 	g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void hook_control_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	DBG("");
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
+
+	if (em->ppp =3D=3D NULL)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+	g_at_result_iter_next(&iter, "");
+
+	if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
+		goto error;
+
+	if (val !=3D 0)
+		goto error;
+
+	g_at_ppp_unref(em->ppp);
+	em->ppp =3D NULL;
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+	return;
+
+error:
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+}
+
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -476,10 +511,13 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
 =

-	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN)
+	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN) {
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
-	else if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
-		g_at_server_set_echo(em->server, FALSE);
+		g_at_server_register(em->server, "H", hook_control_cb, em, NULL);
+	} else {
+		if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
+			g_at_server_set_echo(em->server, FALSE);
+	}
 }
 =

 static void emulator_remove(struct ofono_atom *atom)
-- =

1.7.1


--===============8784747069568350726==--

