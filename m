Content-Type: multipart/mixed; boundary="===============3453746121205148197=="
MIME-Version: 1.0
From: Krzysztof Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 5/5] hfp: extend Features to three way calling and CHLD
Date: Mon, 17 Mar 2014 16:47:30 +0100
Message-ID: <1395071250-19440-6-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1395071250-19440-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3453746121205148197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Wilk <Krzysztofx.Wilk@intel.com>

---
 src/handsfree.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index b23cc3a..98f9770 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -50,6 +50,7 @@ struct ofono_handsfree {
 	ofono_bool_t voice_recognition;
 	ofono_bool_t voice_recognition_pending;
 	unsigned int ag_features;
+	unsigned int ag_mpty_features;
 	unsigned char battchg;
 =

 	const struct ofono_handsfree_driver *driver;
@@ -58,11 +59,14 @@ struct ofono_handsfree {
 	DBusMessage *pending;
 };
 =

-static const char **ag_features_list(unsigned int features)
+static const char **ag_features_list(unsigned int features, unsigned int m=
pty_features)
 {
-	static const char *list[33];
+	static const char *list[10];
 	unsigned int i =3D 0;
 =

+	if (features & HFP_AG_FEATURE_3WAY)
+		list[i++] =3D "three-way-calling";
+
 	if (features & HFP_AG_FEATURE_ECNR)
 		list[i++] =3D "echo-canceling-and-noise-reduction";
 =

@@ -72,6 +76,21 @@ static const char **ag_features_list(unsigned int featur=
es)
 	if (features & HFP_AG_FEATURE_ATTACH_VOICE_TAG)
 		list[i++] =3D "attach-voice-tag";
 =

+	if (mpty_features & HFP_AG_CHLD_0)
+		list[i++] =3D "release-all-held";
+
+	if (mpty_features & HFP_AG_CHLD_1x)
+		list[i++] =3D "release-specified-active-call";
+
+	if (mpty_features & HFP_AG_CHLD_2x)
+		list[i++] =3D "private-chat";
+
+	if (mpty_features & HFP_AG_CHLD_3)
+		list[i++] =3D "create-multiparty";
+
+	if (mpty_features & HFP_AG_CHLD_4)
+		list[i++] =3D "transfer";
+
 	list[i] =3D NULL;
 =

 	return list;
@@ -125,6 +144,15 @@ void ofono_handsfree_set_ag_features(struct ofono_hand=
sfree *hf,
 	hf->ag_features =3D ag_features;
 }
 =

+void ofono_handsfree_set_ag_chld_features(struct ofono_handsfree *hf,
+					unsigned int ag_mpty_features)
+{
+	if (hf =3D=3D NULL)
+		return;
+
+	hf->ag_mpty_features =3D ag_mpty_features;
+}
+
 void ofono_handsfree_battchg_notify(struct ofono_handsfree *hf,
 					unsigned char level)
 {
@@ -181,7 +209,7 @@ static DBusMessage *handsfree_get_properties(DBusConnec=
tion *conn,
 	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
 				&voice_recognition);
 =

-	features =3D ag_features_list(hf->ag_features);
+	features =3D ag_features_list(hf->ag_features, hf->ag_mpty_features);
 	ofono_dbus_dict_append_array(&dict, "Features", DBUS_TYPE_STRING,
 					&features);
 =

-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============3453746121205148197==--

