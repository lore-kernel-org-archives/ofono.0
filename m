Content-Type: multipart/mixed; boundary="===============6922614802222353993=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 22/26] emulator: add dun_ato_cb() and register it
Date: Fri, 01 Apr 2011 10:56:24 +0200
Message-ID: <1301648188-7208-23-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6922614802222353993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index f375c9e..7280030 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -235,6 +235,59 @@ error:
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
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -528,6 +581,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 	case OFONO_EMULATOR_TYPE_DUN:
 		g_at_server_register(em->server, "D", dial_cb, em, NULL);
 		g_at_server_register(em->server, "H", dun_ath_cb, em, NULL);
+		g_at_server_register(em->server, "O", dun_ato_cb, em, NULL);
 		break;
 =

 	case OFONO_EMULATOR_TYPE_HFP:
-- =

1.7.1


--===============6922614802222353993==--

