Content-Type: multipart/mixed; boundary="===============7573209209442605790=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/7] core: Add ECNR in Handsfree GetProperty
Date: Fri, 19 Apr 2013 14:34:40 -0300
Message-ID: <1366392884-7116-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366392884-7116-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7573209209442605790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/handsfree.c b/src/handsfree.c
index 6d7f263..041d3f2 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -45,6 +45,7 @@
 static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
+	ofono_bool_t ecnr;
 	ofono_bool_t inband_ringing;
 	ofono_bool_t voice_recognition;
 	ofono_bool_t voice_recognition_pending;
@@ -175,6 +176,10 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
 	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
 				&inband_ringing);
 =

+	if (hf->ag_features & HFP_AG_FEATURE_ECNR)
+		ofono_dbus_dict_append(&dict, "ECNR", DBUS_TYPE_BOOLEAN,
+								&hf->ecnr);
+
 	voice_recognition =3D hf->voice_recognition;
 	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
 				&voice_recognition);
-- =

1.7.11.7


--===============7573209209442605790==--

