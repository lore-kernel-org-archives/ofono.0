Content-Type: multipart/mixed; boundary="===============5158913153906017398=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 17/19] handsfree: Supported AG features exposed in D-Bus
Date: Wed, 12 Oct 2011 14:35:38 +0200
Message-ID: <1318422940-14955-18-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5158913153906017398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index bf30b9c..e19d9d3 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -41,9 +41,12 @@
 #include "ofono.h"
 #include "common.h"
 =

+#define MAX_AG_FEATURE_COUNT 32
+
 static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
+	unsigned int ag_features;
 	ofono_bool_t inband_ringing;
 	ofono_bool_t voicerec_state;
 	ofono_bool_t pending_voicerec_state;
@@ -54,6 +57,76 @@ struct ofono_handsfree {
 	DBusMessage *pending;
 };
 =

+static void append_ag_features(struct ofono_handsfree *hf, char **features)
+{
+	unsigned int bit;
+	int feature_count =3D 0;
+
+	for (bit =3D 1; bit !=3D 0; bit <<=3D 1) {
+		if (hf->ag_features & bit) {
+			char *name =3D NULL;
+
+			switch ((enum hfp_ag_feature) bit) {
+			case HFP_AG_FEATURE_3WAY:
+				name =3D "3WayCalling";
+				break;
+			case HFP_AG_FEATURE_ECNR:
+				name =3D "ECNR";
+				break;
+			case HFP_AG_FEATURE_VOICE_RECOG:
+				name =3D "VoiceRecognition";
+				break;
+			case HFP_AG_FEATURE_IN_BAND_RING_TONE:
+				name =3D "InbandRinging";
+				break;
+			case HFP_AG_FEATURE_ATTACH_VOICE_TAG:
+				name =3D "AttachVoiceTag";
+				break;
+			case HFP_AG_FEATURE_REJECT_CALL:
+				name =3D "RejectCall";
+				break;
+			case HFP_AG_FEATURE_ENHANCED_CALL_STATUS:
+				name =3D "EnhancedCallStatus";
+				break;
+			case HFP_AG_FEATURE_ENHANCED_CALL_CONTROL:
+				name =3D "EnhancedCallControl";
+				break;
+			case HFP_AG_FEATURE_EXTENDED_RES_CODE:
+				name =3D "ExtendedResultCodes";
+				break;
+			case HFP_AG_FEATURE_CODEC_NEGOTIATION:
+				name =3D "CodecNegotiation";
+				break;
+			}
+
+			features[feature_count++] =3D name;
+		}
+	}
+
+	features[feature_count] =3D NULL;
+}
+
+void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
+					unsigned int ag_features)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+	char **features;
+
+	if (hf->ag_features =3D=3D ag_features)
+		return;
+
+	hf->ag_features =3D ag_features;
+
+	features =3D g_new0(char *, MAX_AG_FEATURE_COUNT + 1);
+	append_ag_features(hf, features);
+	ofono_dbus_signal_array_property_changed(conn, path,
+						OFONO_HANDSFREE_INTERFACE,
+						"Features", DBUS_TYPE_STRING,
+						&features);
+	g_free(features);
+}
+
 void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
 						ofono_bool_t enabled)
 {
@@ -99,6 +172,7 @@ static DBusMessage *handsfree_get_properties(DBusConnect=
ion *conn,
 	DBusMessageIter dict;
 	dbus_bool_t inband_ringing;
 	dbus_bool_t voicerec_state;
+	char **features;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -118,6 +192,12 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
 	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
 				&voicerec_state);
 =

+	features =3D g_new0(char *, MAX_AG_FEATURE_COUNT + 1);
+	append_ag_features(hf, features);
+	ofono_dbus_dict_append_array(&dict, "Features", DBUS_TYPE_STRING,
+					&features);
+	g_free(features);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
-- =

1.7.6.4


--===============5158913153906017398==--

