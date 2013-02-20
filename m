Content-Type: multipart/mixed; boundary="===============8194517219006676143=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 3/7] handsfree-audio: Add codec array validation
Date: Wed, 20 Feb 2013 18:55:47 -0300
Message-ID: <1361397351-5841-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8194517219006676143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This patch checks if the codec array included in the "Register" method
contains valid codec ID's.
---
 src/handsfree-audio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index ee67f05..499e0de 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -32,6 +32,12 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
 =

+/* Supported agent codecs */
+enum hfp_codec {
+	HFP_CODEC_CVSD =3D 0x01,
+	HFP_CODEC_MSBC =3D 0x02,
+};
+
 struct agent {
 	char *owner;
 	char *path;
@@ -53,7 +59,7 @@ static DBusMessage *am_agent_register(DBusConnection *con=
n,
 	const char *sender, *path;
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
-	int length;
+	int length, i;
 =

 	if (agent)
 		return __ofono_error_in_use(msg);
@@ -72,6 +78,12 @@ static DBusMessage *am_agent_register(DBusConnection *co=
nn,
 	if (length =3D=3D 0)
 		return __ofono_error_invalid_args(msg);
 =

+	for (i =3D 0; i < length; i++) {
+		if (codecs[i] !=3D HFP_CODEC_CVSD &&
+				codecs[i] !=3D HFP_CODEC_MSBC)
+			return __ofono_error_invalid_args(msg);
+	}
+
 	agent =3D g_new0(struct agent, 1);
 	agent->owner =3D g_strdup(sender);
 	agent->path =3D g_strdup(path);
-- =

1.7.11.7


--===============8194517219006676143==--

