Content-Type: multipart/mixed; boundary="===============4657810748818358767=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 8/9] emulator: implement audio connection API
Date: Thu, 17 Mar 2011 19:55:47 +0100
Message-ID: <1300388148-925-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4657810748818358767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 1d4fbc6..2f39599 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -49,6 +49,9 @@ struct ofono_emulator {
 	int events_mode;
 	gboolean events_ind;
 	GSList *indicators;
+	void *user_data;
+	ofono_emulator_audio_conn_cb_t conn_cb;
+	void *conn_user_data;
 };
 =

 struct indicator {
@@ -390,6 +393,8 @@ fail:
 static void ckpd_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
+	struct ofono_emulator *em =3D user_data;
+
 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_SET:
 	{
@@ -404,6 +409,9 @@ static void ckpd_cb(GAtServer *server, GAtServerRequest=
Type type,
 		if (key !=3D 200)
 			goto fail;
 =

+		if(em->conn_cb !=3D NULL)
+			em->conn_cb(em, em->conn_user_data);
+
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 		break;
 	}
@@ -734,3 +742,11 @@ void ofono_emulator_set_indicator(struct ofono_emulato=
r *em,
 		return;
 	}
 }
+
+void ofono_emulator_set_audio_connect_handler(struct ofono_emulator *em,
+					ofono_emulator_audio_conn_cb_t cb,
+					void *user_data)
+{
+	em->conn_cb =3D cb;
+	em->conn_user_data =3D user_data;
+}
-- =

1.7.1


--===============4657810748818358767==--

