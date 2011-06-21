Content-Type: multipart/mixed; boundary="===============6985289453760503889=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 3/4] hfpmodem: remove previous HFP defines
Date: Tue, 21 Jun 2011 14:49:48 +0200
Message-ID: <1308660589-2187-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1308660589-2187-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6985289453760503889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/hfpmodem.h |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index fca1a9b..37c9c02 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -22,25 +22,6 @@
 #include <drivers/atmodem/atutil.h>
 #include <ofono/dbus.h>
 =

-/* AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
-#define AG_FEATURE_3WAY 0x1
-#define AG_FEATURE_ECNR 0x2
-#define AG_FEATURE_VOICE_RECOG 0x4
-#define AG_FEATURE_IN_BAND_RING_TONE 0x8
-#define AG_FEATURE_ATTACH_VOICE_TAG 0x10
-#define AG_FEATURE_REJECT_CALL 0x20
-#define AG_FEATURE_ENHANCED_CALL_STATUS 0x40
-#define AG_FEATURE_ENHANCED_CALL_CONTROL 0x80
-#define AG_FEATURE_EXTENDED_RES_CODE 0x100
-
-#define HF_FEATURE_ECNR 0x1
-#define HF_FEATURE_3WAY 0x2
-#define HF_FEATURE_CLIP 0x4
-#define HF_FEATURE_VOICE_RECOGNITION 0x8
-#define HF_FEATURE_REMOTE_VOLUME_CONTROL 0x10
-#define HF_FEATURE_ENHANCED_CALL_STATUS 0x20
-#define HF_FEATURE_ENHANCED_CALL_CONTROL 0x40
-
 #define AG_CHLD_0 0x01
 #define AG_CHLD_1 0x02
 #define AG_CHLD_1x 0x04
-- =

1.7.1


--===============6985289453760503889==--

