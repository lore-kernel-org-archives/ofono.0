Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959D10A1A
	for <ofono@lists.linux.dev>; Fri, 29 Dec 2023 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.71.215.224) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 29 Dec
 2023 13:30:34 +0300
From: Denis Grigorev <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, <d.grigorev@omp.ru>
Subject: [PATCH v3] smsutil: Validate the length of the address field
Date: Fri, 29 Dec 2023 13:30:04 +0300
Message-ID: <20231229103004.78670-1-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228095152.68478-1-d.grigorev@omp.ru>
References: <20231228095152.68478-1-d.grigorev@omp.ru>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/29/2023 10:22:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182426 [Dec 29 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: d.grigorev@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.71.215.224
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/29/2023 10:26:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/29/2023 8:08:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

This addresses CVE-2023-4233.
---
 v1 -> v2: Validate Address-Length instead of comparing with mem size.
 v2 -> v3: Remove extra space

 src/smsutil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index c25dbdbf..27c5065a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -627,6 +627,10 @@ gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 	if (!next_octet(pdu, len, offset, &addr_len))
 		return FALSE;
 
+	/* According to 23.040 9.1.2.5 Address-Length must not exceed 20 */
+	if (addr_len > 20)
+		return FALSE;
+
 	if (sc && addr_len == 0) {
 		out->address[0] = '\0';
 		return TRUE;
-- 
2.34.1

