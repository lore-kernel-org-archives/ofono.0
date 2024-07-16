Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F244369
	for <ofono@lists.linux.dev>; Tue, 16 Jul 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124730; cv=none; b=G7bGiLTdMus3W0AZtqwRQA5PYGMsk1r+JQhgOaUVdnumqcMIIX1PTgMIxBoMWGcFafjFpOq1gZTtaofqo4BfmSm+j2WefFH2gUMA5DXnqTzLvKPm9eNTUMuzTWNeToSVcX93QV9973+r8qIRNtA9lEitxSZyQK3icWmA8f66J+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124730; c=relaxed/simple;
	bh=HrZL5TMJmu2yGYONPzH1c3flkZpxcJzX713oVbxjt3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1+wThN4qIf3N+NeoipM6Gyblg5oPL2JwI0yvBeeu9qVlQaJFwkZwGIk5Ahsn/GaVsYn6SRQAnxYY9HrD3lR34vJMN051VGBDN1Ll5T2TDwm5L7rTALUBf3tP4Ba3N1cdu5QzU7ha8rOBQZqI0AIBRDvDJ/k0wv0uu14C3GFl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (90.154.15.122) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 16 Jul
 2024 13:11:55 +0300
From: Max Rudik <m.rudik@omp.ru>
To: <ofono@lists.linux.dev>
CC: <denkenz@gmail.com>, Max Rudik <m.rudik@omp.ru>
Subject: [PATCH 0/4] Fix issues found with static analyzer
Date: Tue, 16 Jul 2024 13:11:32 +0300
Message-ID: <20240716101136.44583-1-m.rudik@omp.ru>
X-Mailer: git-send-email 2.34.1
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

This patch series fixes several minor issues found with SVACE
static analyzer.

Max Rudik (4):
  stemodem: Fix possible NULL dereference
  cbs: Fix possible NULL dereference
  stk: Fix possible NULL dereference
  call-settings: Fix typo

 drivers/stemodem/gprs-context.c | 4 ++++
 src/call-settings.c             | 2 +-
 src/cbs.c                       | 2 +-
 src/stk.c                       | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

