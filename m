Content-Type: multipart/mixed; boundary="===============3709417613699272037=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 12/12] hfp_ag: Update supported features
Date: Mon, 02 Apr 2012 15:27:22 +0200
Message-ID: <1333373242-11117-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3709417613699272037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
capabilities to supported features in HFP AG SDP record
---
 plugins/hfp_ag.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index c12068a..52a8f83 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -37,7 +37,9 @@
 =

 #define AGENT_PATH "/hfp_ag"
 #define VERSION_1_5 0x0105
-#define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_REJECT_CALL | \
+#define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_ECNR | \
+			HFP_AG_FEATURE_IN_BAND_RING_TONE | \
+			HFP_AG_FEATURE_REJECT_CALL | \
 			HFP_AG_FEATURE_ENHANCED_CALL_STATUS | \
 			HFP_AG_FEATURE_ENHANCED_CALL_CONTROL | \
 			HFP_AG_FEATURE_EXTENDED_RES_CODE)
-- =

1.7.1


--===============3709417613699272037==--

