Content-Type: multipart/mixed; boundary="===============0412502810614925494=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 3/7] core: Add EchoCancelingNoiseReduction to GetProperties
Date: Tue, 23 Apr 2013 09:44:41 -0300
Message-ID: <1366721085-17837-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366721085-17837-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0412502810614925494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds EchoCancelingNoiseReduction property to GetProperties
method of Handsfree interface.
---
 src/handsfree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/handsfree.c b/src/handsfree.c
index 6d7f263..9e4fc6b 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -45,6 +45,7 @@
 static GSList *g_drivers =3D NULL;
 =

 struct ofono_handsfree {
+	ofono_bool_t nrec;
 	ofono_bool_t inband_ringing;
 	ofono_bool_t voice_recognition;
 	ofono_bool_t voice_recognition_pending;
@@ -175,6 +176,10 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
 	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
 				&inband_ringing);
 =

+	if (hf->ag_features & HFP_AG_FEATURE_ECNR)
+		ofono_dbus_dict_append(&dict, "EchoCancelingNoiseReduction",
+						DBUS_TYPE_BOOLEAN, &hf->nrec);
+
 	voice_recognition =3D hf->voice_recognition;
 	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
 				&voice_recognition);
-- =

1.7.11.7


--===============0412502810614925494==--

