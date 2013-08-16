Content-Type: multipart/mixed; boundary="===============4395548040690163941=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 3/6] handsfree-audio: Add support for detecting Transparent
 SCO support
Date: Thu, 15 Aug 2013 23:26:06 -0300
Message-ID: <1376619969-15080-4-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4395548040690163941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree-audio.h |  2 +-
 plugins/hfp_hf_bluez5.c   |  2 +-
 src/handsfree-audio.c     | 23 +++++++++++++++++------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 846a032..03e3b38 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -53,7 +53,7 @@ ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_=
handsfree_card *card,
 =

 ofono_bool_t ofono_handsfree_audio_has_wideband(void);
 =

-ofono_bool_t ofono_handsfree_audio_has_defer_setup(void);
+ofono_bool_t ofono_handsfree_audio_has_transparent_sco(void);
 =

 void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
 					void *data);
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 40d8ce0..f08bf53 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -645,7 +645,7 @@ static void connect_handler(DBusConnection *conn, void =
*user_data)
 	 * Assuming that if defer_setup is supported, then SCO transparent
 	 * mode is also supported
 	*/
-	if (ofono_handsfree_audio_has_defer_setup())
+	if (ofono_handsfree_audio_has_transparent_sco())
 		features |=3D HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
 =

 	DBG("Registering External Profile handler ...");
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 0caa458..c83086f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -66,7 +66,7 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
-static int defer_setup =3D 1;
+static ofono_bool_t transparent_sco =3D FALSE;
 =

 static uint16_t codec2setting(uint8_t codec)
 {
@@ -178,7 +178,9 @@ static int sco_init(void)
 {
 	GIOChannel *sco_io;
 	struct sockaddr_sco saddr;
-	int sk;
+	struct bt_voice voice;
+	int defer_setup, sk;
+	socklen_t len;
 =

 	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
 								BTPROTO_SCO);
@@ -195,6 +197,8 @@ static int sco_init(void)
 		return -errno;
 	}
 =

+	defer_setup =3D 1;
+
 	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
 				&defer_setup, sizeof(defer_setup)) < 0) {
 		defer_setup =3D 0;
@@ -202,6 +206,13 @@ static int sco_init(void)
 						strerror(errno), errno);
 	}
 =

+	memset(&voice, 0, sizeof(voice));
+	len =3D sizeof(voice);
+
+	if (defer_setup && getsockopt(sk, SOL_BLUETOOTH, BT_VOICE,
+						&voice, &len) =3D=3D 0)
+		transparent_sco =3D TRUE;
+
 	if (listen(sk, 5) < 0) {
 		close(sk);
 		return -errno;
@@ -585,9 +596,9 @@ ofono_bool_t ofono_handsfree_audio_has_wideband(void)
 	return has_wideband;
 }
 =

-ofono_bool_t ofono_handsfree_audio_has_defer_setup(void)
+ofono_bool_t ofono_handsfree_audio_has_transparent_sco(void)
 {
-	return defer_setup =3D=3D 1;
+	return transparent_sco;
 }
 =

 static void agent_free(struct agent *agent)
@@ -707,12 +718,12 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
 	DBG("Agent %s registered with the CODECs:%s%s", sender,
 		has_cvsd ? " CVSD" : "", has_msbc ? " mSBC" : "");
 =

-	if (has_msbc && defer_setup =3D=3D 1)
+	if (has_msbc && transparent_sco)
 		has_wideband =3D TRUE;
 	else {
 		has_wideband =3D FALSE;
 		DBG("Wideband speech disabled: %s", has_msbc ?
-			"no SCO defer setup support" : "no mSBC support");
+			"no Transparent SCO support" : "no mSBC support");
 	}
 =

 	if (has_cvsd =3D=3D FALSE) {
-- =

1.8.3.4


--===============4395548040690163941==--

