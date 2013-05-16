Content-Type: multipart/mixed; boundary="===============1371624349009198803=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 14/22] emulator: Add AT+BAC support
Date: Thu, 16 May 2013 14:16:34 -0300
Message-ID: <1368724602-27781-15-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1371624349009198803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the emulator receives a AT+BAC SET command, it stores the
available HF codecs.
---
 src/emulator.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 490ee73..24c5e48 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -55,6 +55,7 @@ struct ofono_emulator {
 	gboolean slc;
 	int l_features;
 	int r_features;
+	int r_codecs;
 	int events_mode;
 	gboolean events_ind;
 	unsigned char cmee_mode;
@@ -481,6 +482,36 @@ fail:
 	}
 }
 =

+static void bac_cb(GAtServer *server, GAtServerRequestType type,
+					GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int codec, codecs =3D 0;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		while (g_at_result_iter_next_number(&iter, &codec))
+			codecs |=3D codec;
+
+		if (!(codecs & HFP_CODEC_CVSD))
+			goto fail;
+
+		em->r_codecs =3D codecs;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+fail:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void cind_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -941,6 +972,7 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd)
 									FALSE);
 =

 		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
+		g_at_server_register(em->server, "+BAC", bac_cb, em, NULL);
 		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
 		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
 		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
-- =

1.7.9.5


--===============1371624349009198803==--

