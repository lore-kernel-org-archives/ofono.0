Content-Type: multipart/mixed; boundary="===============9110140050146241323=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] hfp_hf_bluez5: Only enable wideband speech if defer_setup
 is supported
Date: Thu, 25 Apr 2013 16:05:17 -0300
Message-ID: <1366916717-30796-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366916717-30796-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9110140050146241323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When setting the SDP features, only enable wideband speech support if
the kernel has defer setup for SCO.

It is possible that even if defer setup is supported the kernel is
not able to use Transparent Mode for SCO.
---
 plugins/hfp_hf_bluez5.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 06b6fd3..0a4c702 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -638,8 +638,14 @@ static void connect_handler(DBusConnection *conn, void=
 *user_data)
 {
 	uint16_t features =3D HFP_SDP_HF_FEATURE_3WAY |
 				HFP_SDP_HF_FEATURE_CLIP |
-				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL |
-				HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
+				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
+
+	/*
+	 * Assuming that if defer_setup is supported, then SCO transparent
+	 * mode is also supported
+	*/
+	if (ofono_handsfree_audio_has_defer_setup())
+		features |=3D HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
 =

 	DBG("Registering External Profile handler ...");
 =

-- =

1.8.2.1


--===============9110140050146241323==--

