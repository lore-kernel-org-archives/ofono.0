Content-Type: multipart/mixed; boundary="===============2991706672863017171=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH] Replace Glib type with standard C type
Date: Fri, 23 Oct 2009 18:20:13 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B9246D5@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2991706672863017171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Below patch is to replace Glib type with standard C type in hfpmodem.h, lik=
e guint, guint8, etc.

Please review it.

Regards,
Zhenhua

---
 drivers/hfpmodem/hfpmodem.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 6c6ab6f..c4e2a34 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -55,10 +55,10 @@ enum hfp_indicator {
 =

 struct hfp_data {
 	GAtChat *chat;
-	guint ag_features;
-	guint hf_features;
-	guint8 cind_pos[HFP_INDICATOR_LAST];
-	gint cind_val[HFP_INDICATOR_LAST];
+	unsigned int ag_features;
+	unsigned int hf_features;
+	unsigned char cind_pos[HFP_INDICATOR_LAST];
+	unsigned int cind_val[HFP_INDICATOR_LAST];
 };
 =

 extern void hfp_voicecall_init();
-- =

1.6.1.3
=20

--===============2991706672863017171==--

