Content-Type: multipart/mixed; boundary="===============6041949905979311928=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 18/22] emulator: Resend +BCS after receive AT+BAC
Date: Thu, 16 May 2013 14:16:38 -0300
Message-ID: <1368724602-27781-19-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6041949905979311928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the AG receives AT+BAC as a response to an unsolicited +BCS, it
will resend +BCS based on new list of available codecs.
---
 src/emulator.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index a228df4..7f6604a 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -541,6 +541,7 @@ static void bac_cb(GAtServer *server, GAtServerRequestT=
ype type,
 	struct ofono_emulator *em =3D user_data;
 	GAtResultIter iter;
 	int codec, codecs =3D 0;
+	gboolean bcs =3D em->bcs;
 =

 	em->bcs =3D FALSE;
 =

@@ -558,6 +559,11 @@ static void bac_cb(GAtServer *server, GAtServerRequest=
Type type,
 		em->r_codecs =3D codecs;
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		if (bcs)
+			em->audiosetup_source =3D g_timeout_add_seconds(0,
+						setup_codec_connection, em);
+
 		break;
 =

 	default:
-- =

1.7.9.5


--===============6041949905979311928==--

