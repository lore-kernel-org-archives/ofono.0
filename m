Content-Type: multipart/mixed; boundary="===============0063514607597678553=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 06/11] hfp_audio: Add codec array validation
Date: Tue, 19 Feb 2013 17:44:47 -0300
Message-ID: <1361306692-959-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0063514607597678553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This patch checks if the codec array included in the "Register" method
contains valid codec ID's.
---
 plugins/hfp_audio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index 7b334e2..db21a5d 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -35,6 +35,12 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
 =

+/* Supported agents codecs */
+enum hfp_codec {
+	HFP_CODEC_CVSD =3D 0x01,
+	HFP_CODEC_MSBC =3D 0x02,
+};
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -49,7 +55,7 @@ static DBusMessage *am_agent_register(DBusConnection *con=
n,
 	const char *path;
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
-	int length;
+	int length, i;
 =

 	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
 		goto invalid_args;
@@ -63,6 +69,12 @@ static DBusMessage *am_agent_register(DBusConnection *co=
nn,
 	if (length =3D=3D 0)
 		goto invalid_args;
 =

+	for (i =3D 0; i < length; i++) {
+		if (codecs[i] !=3D HFP_CODEC_CVSD &&
+				codecs[i] !=3D HFP_CODEC_MSBC)
+			goto invalid_args;
+	}
+
 	return dbus_message_new_method_return(msg);
 =

 invalid_args:
-- =

1.7.11.7


--===============0063514607597678553==--

