Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF641D69C
	for <ofono@lists.linux.dev>; Thu, 21 Dec 2023 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst017.omp.ru (109.73.39.18) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 21 Dec
 2023 17:39:09 +0300
From: Denis Grigorev <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, <d.grigorev@omp.ru>
Subject: [PATCH 1/2] smsutil: Check that address fits in memory
Date: Thu, 21 Dec 2023 17:16:37 +0300
Message-ID: <20231221141638.19774-2-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231221141638.19774-1-d.grigorev@omp.ru>
References: <20231221141638.19774-1-d.grigorev@omp.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/21/2023 14:23:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182278 [Dec 21 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: d.grigorev@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;109.73.39.18:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1;spb1wst017.omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 109.73.39.18
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/21/2023 14:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/21/2023 10:52:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

This addresses CVE-2023-4233.
---
 src/smsutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index 8e57a065..e9551b0d 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -647,6 +647,10 @@ gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 	out->numbering_plan = bit_field(addr_type, 0, 4);
 
 	if (out->number_type != SMS_NUMBER_TYPE_ALPHANUMERIC) {
+		/* BCD number consumes half as much memory */
+		if (byte_len * 2 >= (int) sizeof(out->address))
+			return FALSE;
+
 		extract_bcd_number(pdu + *offset, byte_len, out->address);
 		*offset += byte_len;
 	} else {
-- 
2.17.1

