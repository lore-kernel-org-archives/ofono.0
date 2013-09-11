Content-Type: multipart/mixed; boundary="===============2270742147445700890=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 2/7] handsfree-audio: Add support for detecting Transparent
 SCO support
Date: Tue, 10 Sep 2013 21:09:41 -0300
Message-ID: <1378858186-683-2-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2270742147445700890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/handsfree-audio.h |  2 +-
 plugins/hfp_hf_bluez5.c   |  2 +-
 src/handsfree-audio.c     | 18 ++++++++++++++----
 3 files changed, 16 insertions(+), 6 deletions(-)

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
index c311b04..52d111a 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -67,6 +67,7 @@ static guint sco_watch =3D 0;
 static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
 static int defer_setup =3D 1;
+static ofono_bool_t transparent_sco =3D FALSE;
 =

 static uint16_t codec2setting(uint8_t codec)
 {
@@ -192,7 +193,9 @@ static int sco_init(void)
 {
 	GIOChannel *sco_io;
 	struct sockaddr_sco saddr;
+	struct bt_voice voice;
 	int sk;
+	socklen_t len;
 =

 	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
 								BTPROTO_SCO);
@@ -216,6 +219,13 @@ static int sco_init(void)
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
@@ -599,9 +609,9 @@ ofono_bool_t ofono_handsfree_audio_has_wideband(void)
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
@@ -721,12 +731,12 @@ static DBusMessage *am_agent_register(DBusConnection =
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

1.8.4


--===============2270742147445700890==--

