Content-Type: multipart/mixed; boundary="===============5233179340216294800=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 08/15] handsfree: Supported AG features exposed in D-Bus
Date: Thu, 20 Oct 2011 18:38:13 +0200
Message-ID: <1319128700-15841-9-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5233179340216294800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index 7f3882f..d3acb8b 100644
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
@@ -54,6 +57,54 @@ struct ofono_handsfree {
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
+			case HFP_AG_FEATURE_VOICE_RECOG:
+				name =3D "VoiceRecognition";
+				break;
+			case HFP_AG_FEATURE_ATTACH_VOICE_TAG:
+				name =3D "AttachVoiceTag";
+				break;
+			default:
+				continue;
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
@@ -102,6 +153,7 @@ static DBusMessage *handsfree_get_properties(DBusConnec=
tion *conn,
 	DBusMessageIter dict;
 	dbus_bool_t inband_ringing;
 	dbus_bool_t voicerec_state;
+	char **features;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
@@ -121,6 +173,12 @@ static DBusMessage *handsfree_get_properties(DBusConne=
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


--===============5233179340216294800==--

