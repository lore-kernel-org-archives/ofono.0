Content-Type: multipart/mixed; boundary="===============4701274114973188887=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/3] emulator: add HFP feature defines
Date: Mon, 20 Jun 2011 17:13:46 +0200
Message-ID: <1308582828-3806-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4701274114973188887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..452c59c 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -48,6 +48,25 @@ extern "C" {
 #define OFONO_EMULATOR_CALLHELD_MULTIPLE 1
 #define OFONO_EMULATOR_CALLHELD_ON_HOLD 2
 =

+/* AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
+#define AG_FEATURE_3WAY 0x1
+#define AG_FEATURE_ECNR 0x2
+#define AG_FEATURE_VOICE_RECOG 0x4
+#define AG_FEATURE_IN_BAND_RING_TONE 0x8
+#define AG_FEATURE_ATTACH_VOICE_TAG 0x10
+#define AG_FEATURE_REJECT_CALL 0x20
+#define AG_FEATURE_ENHANCED_CALL_STATUS 0x40
+#define AG_FEATURE_ENHANCED_CALL_CONTROL 0x80
+#define AG_FEATURE_EXTENDED_RES_CODE 0x100
+
+#define HF_FEATURE_ECNR 0x1
+#define HF_FEATURE_3WAY 0x2
+#define HF_FEATURE_CLIP 0x4
+#define HF_FEATURE_VOICE_RECOGNITION 0x8
+#define HF_FEATURE_REMOTE_VOLUME_CONTROL 0x10
+#define HF_FEATURE_ENHANCED_CALL_STATUS 0x20
+#define HF_FEATURE_ENHANCED_CALL_CONTROL 0x40
+
 struct ofono_emulator;
 struct ofono_emulator_request;
 =

-- =

1.7.1


--===============4701274114973188887==--

