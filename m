Content-Type: multipart/mixed; boundary="===============8382145638644837571=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 22/22] emulator: Implement AG card .Connect() for HFP 1.6
Date: Thu, 16 May 2013 14:16:42 -0300
Message-ID: <1368724602-27781-23-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8382145638644837571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index c468452..8b4fd80 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -90,6 +90,7 @@ struct ofono_emulator {
 	gboolean bcs;
 	int pns_id;
 	struct ofono_handsfree_card *card;
+	struct cb_data *codec_data;
 };
 =

 struct indicator {
@@ -485,6 +486,26 @@ static gboolean notify_ring(void *user_data)
 	return TRUE;
 }
 =

+static void call_card_connect_callback(struct ofono_emulator *em,
+							GAtServerResult result)
+{
+	struct cb_data *cbd =3D em->codec_data;
+	ofono_handsfree_card_connect_cb_t cb;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	cb =3D cbd->cb;
+
+	if (result =3D=3D G_AT_SERVER_RESULT_OK)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+	em->codec_data =3D NULL;
+}
+
 static gboolean setup_synchronous_connection(void *user_data)
 {
 	struct ofono_emulator *em =3D user_data;
@@ -533,14 +554,19 @@ static void bcs_cb(GAtServer *server, GAtServerReques=
tType type,
 =

 	default:
 fail:
+		call_card_connect_callback(em, G_AT_SERVER_RESULT_ERROR);
+
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+
 		break;
 	}
+
+	=

 }
 =

-static gboolean setup_codec_connection(void *user_data)
+static void setup_codec_connection(struct ofono_emulator *em,
+							struct cb_data *cbd)
 {
-	struct ofono_emulator *em =3D user_data;
 	char str[16];
 =

 	DBG("");
@@ -554,6 +580,15 @@ static gboolean setup_codec_connection(void *user_data)
 		em->bcs =3D TRUE;
 	}
 =

+	em->codec_data =3D cbd;
+}
+
+static gboolean call_setup_codec_connection(void *user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	setup_codec_connection(em, NULL);
+
 	em->audiosetup_source =3D 0;
 =

 	return FALSE;
@@ -619,13 +654,18 @@ static void bac_cb(GAtServer *server, GAtServerReques=
tType type,
 =

 		if (bcs)
 			em->audiosetup_source =3D g_timeout_add_seconds(0,
-						setup_codec_connection, em);
+					call_setup_codec_connection, em);
 =

 		break;
 =

 	default:
 fail:
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+
+		if (bcs)
+			call_card_connect_callback(em,
+						G_AT_SERVER_RESULT_ERROR);
+
 		break;
 	}
 }
@@ -1006,7 +1046,7 @@ static void bcc_cb(GAtServer *server, GAtServerReques=
tType type,
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 =

 		em->audiosetup_source =3D g_timeout_add_seconds(0,
-						setup_codec_connection, em);
+					call_setup_codec_connection, em);
 =

 		break;
 =

@@ -1207,8 +1247,17 @@ static void hfp16_card_remove(struct ofono_handsfree=
_card *card)
 static void hfp16_card_connect(struct ofono_handsfree_card *card,
 			ofono_handsfree_card_connect_cb_t cb, void *data)
 {
+	struct ofono_emulator *em =3D ofono_handsfree_card_get_data(card);
+
 	DBG("");
 =

+	if (em->r_features & HFP_HF_FEATURE_CODEC_NEGOTIATION &&
+			em->l_features & HFP_AG_FEATURE_CODEC_NEGOTIATION) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+		setup_codec_connection(em, cbd);
+		return;
+	}
+
 	ofono_handsfree_card_connect_sco(card);
 }
 =

@@ -1268,6 +1317,7 @@ int ofono_emulator_create_card(struct ofono_emulator =
*em, int version)
 		driver =3D HFP_16_AG_DRIVER;
 =

 	em->card =3D ofono_handsfree_card_create(0, driver, NULL);
+	ofono_handsfree_card_set_data(em->card, em);
 =

 	io =3D g_at_server_get_channel(em->server);
 	fd =3D g_io_channel_unix_get_fd(io);
-- =

1.7.9.5


--===============8382145638644837571==--

