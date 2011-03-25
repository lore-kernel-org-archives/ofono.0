Content-Type: multipart/mixed; boundary="===============2329912066035849615=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 12/18] emulator: add AT online_data_state_cb() and register it
Date: Fri, 25 Mar 2011 16:25:43 +0100
Message-ID: <1301066749-12052-13-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2329912066035849615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e1b078d..220d0b5 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -222,6 +222,51 @@ error:
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static gboolean resume_ppp(gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	g_at_server_suspend(em->server);
+	g_at_ppp_resume(em->ppp);
+
+	return FALSE;
+}
+
+static void online_data_state_cb(GAtServer *server, GAtServerRequestType t=
ype,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	DBG("");
+
+	if (em->ppp =3D=3D NULL) {
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_NO_CARRIER);
+		return;
+	}
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
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
+	g_at_server_send_intermediate(em->server, "CONNECT");
+	em->source =3D g_idle_add(resume_ppp, em);
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
@@ -514,6 +559,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	if (em->type =3D=3D OFONO_EMULATOR_TYPE_DUN) {
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
 		g_at_server_register(em->server, "H", hook_control_cb, em, NULL);
+		g_at_server_register(em->server, "O", online_data_state_cb, em, NULL);
 	} else {
 		if (em->type =3D=3D OFONO_EMULATOR_TYPE_HFP)
 			g_at_server_set_echo(em->server, FALSE);
-- =

1.7.1


--===============2329912066035849615==--

