Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0144369
	for <ofono@lists.linux.dev>; Tue, 16 Jul 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124744; cv=none; b=rU4Vvhu3luXoR/KT89VYx77pLiJfVNfzsaHFoeemTLC+L9Uoyi04Dd7QVLV89YWnvuWKoIbB+MPOU9rOuPqtcMJ9QL8Wt26eRpjlG6e9l/cF01vIzsGuv3mPWLzSZ8ktxVNcFiuV+9CLaxnYJZ/Iav1CuYK4wnlHbco63rEt+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124744; c=relaxed/simple;
	bh=gQWxC68/VhkrFORdJagqcRz5Pmk42RPKAm7IE6TOUqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMx3eBokrdyvjfr7Hbw3omj4imBDjlCPBcGhxgx57jAg1zBVf4oXBZaYquNsOhBG6TItx0msBjyq8zlt450zpRgaKHEhjDPfcvuKAuvO5+TVKT8HvMPcbIHj3Lxgdfs0wqQZLjagRA6jFHgHrjBJuHIyfnKkppDhYTqXBs+WnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (90.154.15.122) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jul
 2024 13:12:09 +0300
From: Max Rudik <m.rudik@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, Max Rudik <m.rudik@omp.ru>
Subject: [PATCH 3/4] stk: Fix possible NULL dereference
Date: Tue, 16 Jul 2024 13:11:35 +0300
Message-ID: <20240716101136.44583-4-m.rudik@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716101136.44583-1-m.rudik@omp.ru>
References: <20240716101136.44583-1-m.rudik@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/16/2024 09:38:35
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186532 [Jul 16 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: m.rudik@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 90.154.15.122 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;90.154.15.122:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 90.154.15.122
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/16/2024 09:40:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/16/2024 9:02:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

---
 src/stk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/stk.c b/src/stk.c
index 70e8ae30..083920a3 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -121,6 +121,9 @@ static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 	if (stk->driver->terminal_response == NULL)
 		return -ENOSYS;
 
+	if (stk->pending_cmd == NULL)
+		return -EINVAL;
+
 	rsp->src = STK_DEVICE_IDENTITY_TYPE_TERMINAL;
 	rsp->dst = STK_DEVICE_IDENTITY_TYPE_UICC;
 	rsp->number = stk->pending_cmd->number;
-- 
2.34.1

