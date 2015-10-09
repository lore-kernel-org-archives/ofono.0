Content-Type: multipart/mixed; boundary="===============7677428481728821890=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 2/2] hfp_ag_bluez5: add codec negotiation support
Date: Fri, 09 Oct 2015 12:05:40 +0200
Message-ID: <1444385140-14777-2-git-send-email-simon.fels@canonical.com>
In-Reply-To: <1444385140-14777-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7677428481728821890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For devices which have support for HFP version >=3D 1.6 we need to negotiat=
e the
codec we use for audio data first before opening the SCO channel.
---
 include/emulator.h      |   6 ++
 plugins/hfp_ag_bluez5.c |  48 ++++++++++-
 src/emulator.c          | 208 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 260 insertions(+), 2 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 15dc61c..c377268 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -26,6 +26,7 @@
 extern "C" {
 #endif
 =

+#include <stdint.h>
 #include <ofono/types.h>
 =

 #define OFONO_EMULATOR_IND_BATTERY "battchg"
@@ -112,6 +113,11 @@ void ofono_emulator_set_hf_indicator_active(struct ofo=
no_emulator *em,
 void ofono_emulator_set_handsfree_card(struct ofono_emulator *em,
 					struct ofono_handsfree_card *card);
 =

+void ofono_emulator_enable_codec_negotiation(struct ofono_emulator *em);
+ofono_bool_t ofono_emulator_codec_already_negotiated(struct ofono_emulator=
 *em);
+ofono_bool_t ofono_emulator_codec_negotiation_supported(struct ofono_emula=
tor *em);
+int ofono_emulator_start_codec_negotiation(struct ofono_emulator *em, uint=
8_t codec);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index a80875f..d0430a3 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -59,22 +59,60 @@ static GHashTable *connection_hash;
 static int hfp16_card_probe(struct ofono_handsfree_card *card,
 					unsigned int vendor, void *data)
 {
+	DBG("");
+
 	return 0;
 }
 =

 static void hfp16_card_remove(struct ofono_handsfree_card *card)
 {
+	DBG("");
 }
 =

 static void hfp16_card_connect(struct ofono_handsfree_card *card,
 					ofono_handsfree_card_connect_cb_t cb,
 					void *data)
 {
+	int err;
+	struct ofono_emulator *em =3D ofono_handsfree_card_get_data(card);
+
+	DBG("");
+
+	if (ofono_emulator_codec_negotiation_supported(em) &&
+		!ofono_emulator_codec_already_negotiated(em)) {
+
+		struct ofono_error error;
+		error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		error.error =3D 0;
+
+		err =3D ofono_emulator_start_codec_negotiation(em, 0);
+		if (err < 0) {
+			error.type =3D OFONO_ERROR_TYPE_FAILURE;
+			error.error =3D err;
+			cb(&error, data);
+			return;
+		}
+
+		/* We hand over to the emulator core here to establish the
+		 * SCO connection once the codec is negotiated */
+		cb(&error, data);
+
+		return;
+	}
+
+	/*
+	 * If any side (remote or local) doesn't support codec negotiation or
+	 * if the codec was already negotiated before we can directly proceed
+	 * with establishing the SCO connection. Calling connect_sco()
+	 * hands the connection responsibility to the core, so no need
+	 * to call the callback
+	 */
 	ofono_handsfree_card_connect_sco(card);
 }
 =

 static void hfp16_sco_connected_hint(struct ofono_handsfree_card *card)
 {
+	DBG("");
 }
 =

 static struct ofono_handsfree_card_driver hfp16_ag_driver =3D {
@@ -249,12 +287,18 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 =

 	driver =3D NULL;
 =

-	if (version >=3D HFP_VERSION_1_6)
+	if (version >=3D HFP_VERSION_1_6) {
 		driver =3D HFP16_AG_DRIVER;
+		/* Codec negotiation between HF and AG is only supported
+		 * starting with HFP 1.6  */
+		ofono_emulator_enable_codec_negotiation(em);
+	}
 =

 	card =3D ofono_handsfree_card_create(0,
 					OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
-					driver, NULL);
+					driver, em);
+
+	ofono_handsfree_card_set_data(card, em);
 =

 	ofono_handsfree_card_set_local(card, local);
 	ofono_handsfree_card_set_remote(card, remote);
diff --git a/src/emulator.c b/src/emulator.c
index 626dec3..58095e9 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -27,6 +27,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <errno.h>
 =

 #include <glib.h>
 =

@@ -50,6 +51,10 @@ struct ofono_emulator {
 	guint callsetup_source;
 	int pns_id;
 	struct ofono_handsfree_card *card;
+	int r_codecs;
+	uint8_t negotiated_codec;
+	uint8_t proposed_codec;
+	guint delay_sco;
 	bool slc : 1;
 	unsigned int events_mode : 2;
 	bool events_ind : 1;
@@ -938,6 +943,140 @@ fail:
 	}
 }
 =

+static void bac_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	DBG("");
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (!ofono_emulator_codec_negotiation_supported(em)) {
+			DBG("Codec negotiation is not supported from our side");
+			goto fail;
+		}
+
+		em->r_codecs =3D 0;
+		em->negotiated_codec =3D 0;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		/* CVSD codec is mandatory and must come first.
+		 * See HFP v1.6 4.34.1 */
+		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE ||
+			val !=3D HFP_CODEC_CVSD)
+			goto fail;
+
+		em->r_codecs |=3D HFP_CODEC_CVSD;
+
+		while (g_at_result_iter_next_number(&iter, &val))
+			em->r_codecs |=3D val;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		/* If we're currently in the process of selecting a codec
+		 * we have to restart that now */
+		if (em->proposed_codec)
+			ofono_emulator_start_codec_negotiation(em, 0);
+
+		break;
+
+	default:
+fail:
+		DBG("Process AT+BAC failed");
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static gboolean connect_sco_delayed(gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	int err;
+
+	DBG("");
+
+	em->delay_sco =3D 0;
+
+	err =3D ofono_handsfree_card_connect_sco(em->card);
+	if (err =3D=3D 0)
+		return FALSE;
+
+	/* If we have another codec we can try then lets do that */
+	if (em->negotiated_codec !=3D HFP_CODEC_CVSD)
+		ofono_emulator_start_codec_negotiation(em, HFP_CODEC_CVSD);
+
+	return FALSE;
+}
+
+static void bcs_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+	GAtResultIter iter;
+	int val;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "");
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			break;
+
+		if (em->proposed_codec !=3D val) {
+			em->proposed_codec =3D 0;
+			break;
+		}
+
+		em->proposed_codec =3D 0;
+		em->negotiated_codec =3D val;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		if (!em->delay_sco)
+			em->delay_sco =3D g_idle_add(connect_sco_delayed, em);
+
+		return;
+	default:
+		break;
+	}
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void bcc_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	struct ofono_emulator *em =3D user_data;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		if (!ofono_emulator_codec_negotiation_supported(em))
+			break;
+
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+
+		if (!em->negotiated_codec) {
+			ofono_emulator_start_codec_negotiation(em, 0);
+			return;
+		}
+
+		if (!em->delay_sco)
+			em->delay_sco =3D g_idle_add(connect_sco_delayed, em);
+
+		return;
+	default:
+		break;
+	}
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+}
+
 static void emulator_add_indicator(struct ofono_emulator *em, const char* =
name,
 					int min, int max, int dflt,
 					gboolean mandatory)
@@ -1047,6 +1186,9 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
 		g_at_server_register(em->server, "+BIA", bia_cb, em, NULL);
 		g_at_server_register(em->server, "+BIND", bind_cb, em, NULL);
 		g_at_server_register(em->server, "+BIEV", biev_cb, em, NULL);
+		g_at_server_register(em->server, "+BAC", bac_cb, em, NULL);
+		g_at_server_register(em->server, "+BCC", bcc_cb, em, NULL);
+		g_at_server_register(em->server, "+BCS", bcs_cb, em, NULL);
 	}
 =

 	__ofono_atom_register(em->atom, emulator_unregister);
@@ -1476,3 +1618,69 @@ void ofono_emulator_set_handsfree_card(struct ofono_=
emulator *em,
 =

 	em->card =3D card;
 }
+
+void ofono_emulator_enable_codec_negotiation(struct ofono_emulator *em)
+{
+	em->l_features |=3D HFP_AG_FEATURE_CODEC_NEGOTIATION;
+}
+
+ofono_bool_t ofono_emulator_codec_negotiation_supported(struct ofono_emula=
tor *em)
+{
+	if (em->card =3D=3D NULL)
+		return FALSE;
+
+	return (em->l_features & HFP_AG_FEATURE_CODEC_NEGOTIATION) &&
+		(em->r_features & HFP_HF_FEATURE_CODEC_NEGOTIATION);
+}
+
+static uint8_t select_codec(struct ofono_emulator *em)
+{
+	if (em =3D=3D NULL || em->card =3D=3D NULL)
+		return 0;
+
+	if (ofono_handsfree_audio_has_wideband() &&
+		em->r_codecs & HFP_CODEC_MSBC)
+		return HFP_CODEC_MSBC;
+
+	if (!(em->r_codecs & HFP_CODEC_CVSD))
+		return 0;
+
+	/* CVSD is mandatory for both sides */
+	return HFP_CODEC_CVSD;
+}
+
+ofono_bool_t ofono_emulator_codec_already_negotiated(struct ofono_emulator=
 *em)
+{
+	if (em =3D=3D NULL)
+		return FALSE;
+
+	return em->negotiated_codec;
+}
+
+int ofono_emulator_start_codec_negotiation(struct ofono_emulator *em, uint=
8_t codec)
+{
+	char buf[64];
+	uint8_t selected_codec;
+
+	if (em =3D=3D NULL || em->card =3D=3D NULL)
+		return -EINVAL;
+
+	if (codec > 0) {
+		selected_codec =3D codec;
+		goto done;
+	}
+
+	selected_codec =3D select_codec(em);
+	if (!selected_codec) {
+		DBG("Failed to selected HFP codec");
+		return -EINVAL;
+	}
+
+done:
+	em->proposed_codec =3D selected_codec;
+
+	snprintf(buf, 64, "+BCS: %d", selected_codec);
+	g_at_server_send_unsolicited(em->server, buf);
+
+	return 0;
+}
-- =

2.5.0


--===============7677428481728821890==--

