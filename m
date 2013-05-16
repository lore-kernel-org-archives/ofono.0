Content-Type: multipart/mixed; boundary="===============9046049186643436162=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 20/22] emulator: Reuse last negotiated codec
Date: Thu, 16 May 2013 14:16:40 -0300
Message-ID: <1368724602-27781-21-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9046049186643436162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a synchronous connection will be established and the last used
codec is still available, the AG will use it instead of negotiate.
---
 src/emulator.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 84b07e6..2ce1542 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -56,6 +56,7 @@ struct ofono_emulator {
 	int l_features;
 	int r_features;
 	int r_codecs;
+	int last_codec;
 	int events_mode;
 	gboolean events_ind;
 	unsigned char cmee_mode;
@@ -488,6 +489,7 @@ static void bcs_cb(GAtServer *server, GAtServerRequestT=
ype type,
 			goto fail;
 =

 		ofono_handsfree_card_set_codec(em->card, codec);
+		em->last_codec =3D codec;
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 =

@@ -510,10 +512,15 @@ static gboolean setup_codec_connection(void *user_dat=
a)
 =

 	DBG("");
 =

-	sprintf(str, "+BCS: %d", HFP_CODEC_CVSD);
-	g_at_server_send_unsolicited(em->server, str);
+	if (em->r_codecs & em->last_codec) {
+		setup_synchronous_connection(em);
+	} else {
+		sprintf(str, "+BCS: %d", HFP_CODEC_CVSD);
+		g_at_server_send_unsolicited(em->server, str);
+
+		em->bcs =3D TRUE;
+	}
 =

-	em->bcs =3D TRUE;
 	em->audiosetup_source =3D 0;
 =

 	return FALSE;
-- =

1.7.9.5


--===============9046049186643436162==--

