Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74444369
	for <ofono@lists.linux.dev>; Tue, 16 Jul 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124741; cv=none; b=Vmkaubc7A4VtrX+ndLUxjAsrk16c37xpnkK8v4TxOyAF8AGsjQfUgOrrdeThafr2T3XhlDLgS5BvBnPpdTFDtrkwdNRTh5Ex4WrgjJ9J/TsvQ/oGNeGeTwh0ncM79sXp1cVBosMmpfEvDlgFVaziCWeYSBI42kT2m2F8syBevCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124741; c=relaxed/simple;
	bh=gfRIMN7WpYySLkOZrlIWIrCRfeZToL713glRK0W8Bqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc9jdnDJOOinC4pfxcdJlD8eIOiwME7mAKeuOEk+ls3teUpOijyvkpNjD4llki9Lapaz1hESyqRcEEvluoBzCwdPIwJTOGCB5hjfCKs0QBRV5KravKUJEG6DFMgQR254Dm2xydHRodEwcBO0rROnpzcrJd5OwIpMwzZlKapBbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (90.154.15.122) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jul
 2024 13:12:04 +0300
From: Max Rudik <m.rudik@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, Max Rudik <m.rudik@omp.ru>
Subject: [PATCH 2/4] cbs: Fix possible NULL dereference
Date: Tue, 16 Jul 2024 13:11:34 +0300
Message-ID: <20240716101136.44583-3-m.rudik@omp.ru>
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
 src/cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cbs.c b/src/cbs.c
index 760fd860..246157b1 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -593,7 +593,7 @@ static void cbs_unregister(struct ofono_atom *atom)
 		cbs->settings = NULL;
 	}
 
-	if (cbs->netreg_watch) {
+	if (cbs->netreg_watch && cbs->netreg) {
 		if (cbs->location_watch) {
 			__ofono_netreg_remove_status_watch(cbs->netreg,
 							cbs->location_watch);
-- 
2.34.1

