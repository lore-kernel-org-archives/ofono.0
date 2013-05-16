Content-Type: multipart/mixed; boundary="===============2738654368522014354=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 19/22] emulator: Setup synchronous connection
Date: Thu, 16 May 2013 14:16:39 -0300
Message-ID: <1368724602-27781-20-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2738654368522014354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After respond OK to AT+BCS, the AG should establish a synchronous
connection with HF.
---
 src/emulator.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/emulator.c b/src/emulator.c
index 7f6604a..84b07e6 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -451,6 +451,19 @@ static gboolean notify_ring(void *user_data)
 	return TRUE;
 }
 =

+static gboolean setup_synchronous_connection(void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	DBG("");
+
+	ofono_handsfree_card_connect_sco(em->card);
+
+	em->audiosetup_source =3D 0;
+
+	return FALSE;
+}
+
 static void bcs_cb(GAtServer *server, GAtServerRequestType type,
 				GAtResult *result, gpointer user_data)
 {
@@ -477,6 +490,10 @@ static void bcs_cb(GAtServer *server, GAtServerRequest=
Type type,
 		ofono_handsfree_card_set_codec(em->card, codec);
 =

 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		em->audiosetup_source =3D g_timeout_add_seconds(0,
+					setup_synchronous_connection, em);
+
 		break;
 =

 	default:
-- =

1.7.9.5


--===============2738654368522014354==--

