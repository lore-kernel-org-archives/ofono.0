Content-Type: multipart/mixed; boundary="===============5960622715393876622=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 17/22] emulator: Add AT+BCS support
Date: Thu, 16 May 2013 14:16:37 -0300
Message-ID: <1368724602-27781-18-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5960622715393876622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit verifies if the codec id sent by HF is the same as
previous sent by AG.

It also verifies if the emulator is expecting a AT+BCS command. If not,
returns an ERROR.

We also need to unset the bcs flag in AT+BAC handler because it is a
valid +BCS response.
---
 src/emulator.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 96e6ad1..a228df4 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -64,6 +64,7 @@ struct ofono_emulator {
 	guint audiosetup_source;
 	gboolean clip;
 	gboolean ccwa;
+	gboolean bcs;
 	int pns_id;
 	struct ofono_handsfree_card *card;
 };
@@ -450,6 +451,41 @@ static gboolean notify_ring(void *user_data)
 	return TRUE;
 }
 =

+static void bcs_cb(GAtServer *server, GAtServerRequestType type,
+				GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int codec;
+
+	if (!em->bcs)
+		goto fail;
+
+	em->bcs =3D FALSE;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (g_at_result_iter_next_number(&iter, &codec) =3D=3D FALSE)
+			goto fail;
+
+		if (codec !=3D HFP_CODEC_CVSD)
+			goto fail;
+
+		ofono_handsfree_card_set_codec(em->card, codec);
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
 static gboolean setup_codec_connection(void *user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -460,6 +496,7 @@ static gboolean setup_codec_connection(void *user_data)
 	sprintf(str, "+BCS: %d", HFP_CODEC_CVSD);
 	g_at_server_send_unsolicited(em->server, str);
 =

+	em->bcs =3D TRUE;
 	em->audiosetup_source =3D 0;
 =

 	return FALSE;
@@ -505,6 +542,8 @@ static void bac_cb(GAtServer *server, GAtServerRequestT=
ype type,
 	GAtResultIter iter;
 	int codec, codecs =3D 0;
 =

+	em->bcs =3D FALSE;
+
 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_SET:
 		g_at_result_iter_init(&iter, result);
@@ -1028,6 +1067,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 		g_at_server_register(em->server, "+CCWA", ccwa_cb, em, NULL);
 		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
+		g_at_server_register(em->server, "+BCS", bcs_cb, em, NULL);
 		g_at_server_register(em->server, "+BCC", bcc_cb, em, NULL);
 	}
 =

-- =

1.7.9.5


--===============5960622715393876622==--

