Content-Type: multipart/mixed; boundary="===============8180864331714687791=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 16/22] emulator: Setup codec connection
Date: Thu, 16 May 2013 14:16:36 -0300
Message-ID: <1368724602-27781-17-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8180864331714687791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit sends an unsolicited +BCS command with the selected codec
when the AG receives with success a AT+BCC command.

Currently the codec is hardcoded to CVSD.
---
 src/emulator.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index f358a0e..96e6ad1 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -61,6 +61,7 @@ struct ofono_emulator {
 	unsigned char cmee_mode;
 	GSList *indicators;
 	guint callsetup_source;
+	guint audiosetup_source;
 	gboolean clip;
 	gboolean ccwa;
 	int pns_id;
@@ -449,6 +450,21 @@ static gboolean notify_ring(void *user_data)
 	return TRUE;
 }
 =

+static gboolean setup_codec_connection(void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	char str[16];
+
+	DBG("");
+
+	sprintf(str, "+BCS: %d", HFP_CODEC_CVSD);
+	g_at_server_send_unsolicited(em->server, str);
+
+	em->audiosetup_source =3D 0;
+
+	return FALSE;
+}
+
 static void brsf_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -886,6 +902,10 @@ static void bcc_cb(GAtServer *server, GAtServerRequest=
Type type,
 			goto fail;
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		em->audiosetup_source =3D g_timeout_add_seconds(0,
+						setup_codec_connection, em);
+
 		break;
 =

 	default:
@@ -929,6 +949,11 @@ static void emulator_unregister(struct ofono_atom *ato=
m)
 		em->callsetup_source =3D 0;
 	}
 =

+	if (em->audiosetup_source) {
+		g_source_remove(em->audiosetup_source);
+		em->audiosetup_source =3D 0;
+	}
+
 	for (l =3D em->indicators; l; l =3D l->next) {
 		struct indicator *ind =3D l->data;
 =

-- =

1.7.9.5


--===============8180864331714687791==--

