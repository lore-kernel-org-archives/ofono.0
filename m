Content-Type: multipart/mixed; boundary="===============1280452315505537408=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH 1/2] handsfree-audio: add type for our audio cards
Date: Mon, 05 Oct 2015 10:35:22 +0200
Message-ID: <1444034123-2653-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1280452315505537408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When registering audio cards for the handsfree and gateway roles we
need a way for our users to differentiate between both to decide which
of them they start using for their purpose.
---
 doc/handsfree-audio-api.txt |  4 ++++
 include/handsfree-audio.h   |  6 ++++++
 plugins/hfp_hf_bluez5.c     |  2 +-
 src/handsfree-audio.c       | 20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index 89b5aab..d82035c 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -89,6 +89,10 @@ Properties	string RemoteAddress [readonly]
 =

 			Bluetooth address of the local adapter.
 =

+		string Type [readonly]
+
+			Type of the card. Valid values are "gateway" or
+			"handsfree".
 =

 Handsfree Audio Agent hierarchy [experimental]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index bfb8480..29c767d 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -30,6 +30,11 @@ extern "C" {
 =

 struct ofono_handsfree_card;
 =

+enum ofono_handsfree_card_type {
+	OFONO_HANDSFREE_CARD_TYPE_HANDSFREE,
+	OFONO_HANDSFREE_CARD_TYPE_GATEWAY,
+};
+
 typedef void (*ofono_handsfree_card_connect_cb_t)(
 				const struct ofono_error *error, void *data);
 =

@@ -45,6 +50,7 @@ struct ofono_handsfree_card_driver {
 };
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(unsigned int vend=
or,
+							enum ofono_handsfree_card_type type,
 							const char *driver,
 							void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 713c789..2f01508 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -589,7 +589,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	if (version >=3D HFP_VERSION_1_6)
 		driver =3D HFP16_HF_DRIVER;
 =

-	hfp->card =3D ofono_handsfree_card_create(0, driver, hfp);
+	hfp->card =3D ofono_handsfree_card_create(0, OFONO_HANDSFREE_CARD_TYPE_HA=
NDSFREE, driver, hfp);
 	ofono_handsfree_card_set_data(hfp->card, hfp);
 =

 	ofono_handsfree_card_set_local(hfp->card, local);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c990cc3..5bf3692 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -45,6 +45,7 @@
 #define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

 struct ofono_handsfree_card {
+	enum ofono_handsfree_card_type type;
 	char *remote;
 	char *local;
 	char *path;
@@ -69,6 +70,17 @@ static ofono_bool_t has_wideband =3D FALSE;
 static int defer_setup =3D 1;
 static ofono_bool_t transparent_sco =3D FALSE;
 =

+static const char* card_type_to_string(enum ofono_handsfree_card_type type)
+{
+	switch (type) {
+	case OFONO_HANDSFREE_CARD_TYPE_HANDSFREE:
+		return "handsfree";
+	case OFONO_HANDSFREE_CARD_TYPE_GATEWAY:
+		return "gateway";
+	}
+	return "";
+}
+
 static uint16_t codec2setting(uint8_t codec)
 {
 	switch (codec) {
@@ -255,6 +267,12 @@ static int sco_init(void)
 static void card_append_properties(struct ofono_handsfree_card *card,
 					DBusMessageIter *dict)
 {
+	const char *type;
+
+	type =3D card_type_to_string(card->type);
+	ofono_dbus_dict_append(dict, "Type",
+				DBUS_TYPE_STRING, &type);
+
 	ofono_dbus_dict_append(dict, "RemoteAddress",
 				DBUS_TYPE_STRING, &card->remote);
 =

@@ -395,6 +413,7 @@ static const GDBusSignalTable card_signals[] =3D {
 };
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(unsigned int vend=
or,
+							enum ofono_handsfree_card_type type,
 							const char *driver,
 							void *data)
 {
@@ -403,6 +422,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(unsigned int vendor,
 =

 	card =3D g_new0(struct ofono_handsfree_card, 1);
 =

+	card->type =3D type;
 	card->selected_codec =3D HFP_CODEC_CVSD;
 =

 	card_list =3D g_slist_prepend(card_list, card);
-- =

2.5.0


--===============1280452315505537408==--

