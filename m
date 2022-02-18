Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EC48AD
	for <ofono@lists.linux.dev>; Fri, 18 Feb 2022 08:59:20 +0000 (UTC)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 4D08F20C4E3C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: by spb1wst017.omp.ru (Postfix, from userid 10000)
	id CAC95BA0162; Fri, 18 Feb 2022 11:53:41 +0300 (MSK)
From: <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 3/6] sms: Fix buffer size allocated for SMS PDU
Date: Fri, 18 Feb 2022 11:52:57 +0300
Message-ID: <20220218085300.22585-4-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218085300.22585-1-d.grigorev@omp.ru>
References: <20220218085300.22585-1-d.grigorev@omp.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1909.lancloud.ru (fd00:f066::79)

From: Denis Grigorev <d.grigorev@omp.ru>

According to the comment for sms_encode() the buffer size must be
at least 164 (tpdu) + 12 (SC address).
---
 drivers/atmodem/sms.c | 2 +-
 src/stkutil.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 963c22eb..01c9afb3 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -919,7 +919,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_opts,
 static void construct_ack_pdu(struct sms_data *d)
 {
 	struct sms ackpdu;
-	unsigned char pdu[164];
+	unsigned char pdu[176];
 	int len;
 	int tpdu_len;
 
diff --git a/src/stkutil.c b/src/stkutil.c
index 4f31af45..d1743ea0 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4244,7 +4244,7 @@ static bool build_dataobj_gsm_sms_tpdu(struct stk_tlv_builder *tlv,
 	const struct sms_deliver *msg = data;
 	struct sms sms;
 	uint8_t tag = STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU;
-	uint8_t tpdu[165];
+	uint8_t tpdu[176];
 	int tpdu_len;
 
 	sms.type = SMS_TYPE_DELIVER;
-- 
2.17.1

