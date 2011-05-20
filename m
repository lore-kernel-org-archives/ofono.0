Content-Type: multipart/mixed; boundary="===============2387998669082216585=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 4/5] emulator: add dun_ato_cb() definition and register it
 in GAtServer
Date: Fri, 20 May 2011 11:38:15 +0200
Message-ID: <1305884296-2601-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2387998669082216585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c17b901..fe2132d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -241,6 +241,59 @@ error:
 	return;
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
+static void dun_ato_cb(GAtServer *server, GAtServerRequestType type,
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
+		g_at_server_send_intermediate(em->server, "CONNECT");
+		em->source =3D g_idle_add(resume_ppp, em);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		g_at_server_send_intermediate(em->server, "CONNECT");
+		em->source =3D g_idle_add(resume_ppp, em);
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
@@ -775,6 +828,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	case OFONO_EMULATOR_TYPE_DUN:
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
 		g_at_server_register(em->server, "H", dun_ath_cb, em, NULL);
+		g_at_server_register(em->server, "O", dun_ato_cb, em, NULL);
 		break;
 	case OFONO_EMULATOR_TYPE_HFP:
 		g_at_server_set_echo(em->server, FALSE);
-- =

1.7.1


--===============2387998669082216585==--

