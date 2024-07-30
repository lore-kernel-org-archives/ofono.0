Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4E198E6D
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331785; cv=none; b=ES4TUIhXwnClLaIPxwLdWC/zBnDvo+NMmo7WLnE1aiII8vnUhCn2Ba8ctYV2RV3sH+i8L5pSQ2KOOwafZlyxdYsMzrGmMIqLhARlb0M4N98u4q4R6B3pvif7QBVJTMsPBx+9ye/HHr5PYsdmdn5bAf+clWSE2rnnjpGqWmA5QpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331785; c=relaxed/simple;
	bh=TqERaDbCD6LiVxIvFwE72eEtywio8N+uKqc5OQUA2dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp6eSRC9IQmroxHu899uiS79XwTHLzorEPxBD+c8055dVOiizSvfWp/AjiR1LXalwa32eomesRROq3BeoJGaqPRujpwRzgHfL+rGnH70lyN6E5dNNoxjIMnMgHQ5l6V9VIL4eGvBw7qCdVxEJaqTSjnzrND6/ydN6ec4Dii2HjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst017.omp.ru (109.73.39.18) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 30 Jul
 2024 12:14:15 +0300
From: Denis Grigorev <d.grigorev@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, Denis Grigorev <d.grigorev@omp.ru>
Subject: [PATCH 1/1] Revert "cbs: Fix possible NULL dereference"
Date: Tue, 30 Jul 2024 12:13:32 +0300
Message-ID: <20240730091332.20031-2-d.grigorev@omp.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730091332.20031-1-d.grigorev@omp.ru>
References: <20240730091332.20031-1-d.grigorev@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/30/2024 08:52:44
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186785 [Jul 30 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: d.grigorev@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;spb1wst017.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 109.73.39.18
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/30/2024 08:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/30/2024 7:19:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

At the time cbs_unregister() is called, cbs->netreg has already been
cleared in netreg_watch(), so __ofono_modem_remove_atom_watch() is
not called, resulting in a use-after-free later.

This reverts commit 5b528ee0fa699f598995772060e28653897e748f.
---
 src/cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cbs.c b/src/cbs.c
index 246157b1..760fd860 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -593,7 +593,7 @@ static void cbs_unregister(struct ofono_atom *atom)
 		cbs->settings = NULL;
 	}
 
-	if (cbs->netreg_watch && cbs->netreg) {
+	if (cbs->netreg_watch) {
 		if (cbs->location_watch) {
 			__ofono_netreg_remove_status_watch(cbs->netreg,
 							cbs->location_watch);
-- 
2.17.1

