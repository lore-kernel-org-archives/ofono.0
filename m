Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8A26E6FC
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362204; cv=none; b=rhKZZv1a7uFSbV6EffBbJBwfIzzryAYuTIzM9NpyH1NJVqi3jx+Jdo5PK4Pm1t9fqluySeGx+uB03KkBmOWKFetNPC56In5pmQy4GExMUNzhYkptPeSAKJ/kOxGJ/qFXyiB8YdGh6bmuQJuRkmLInXIq+XyP7HjrElF0z/Ft92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362204; c=relaxed/simple;
	bh=VgqR1d2ws/7vbNFAPXFE4bodfEG8cvnZymRpJf2HLaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=TKawLS2PN0AvLMIH+1S9tkJ43flwHqx9RdYgTgf46MMUco8w+vvhVVe5LAGGCd+L+7yeAEK7wnGtZ2hxzGDO03nccgKX67hZthhw5Kx9j+bEzLadndqO3UCU0tG/5jK0xrxWmiNdiTCORG4ofyeEcglBcxbVndXJSX7gWlMZdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=IEaA57sZ; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="IEaA57sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751362187; x=1751621387;
	bh=Lj2kovoagzVrqEMgLMoSUslk3x3kki+ZBroEvXRYek0=;
	h=From:Subject:Date:Message-Id:To:From:To:Cc:Date:Subject:Reply-To:
	 Feedback-ID:Message-ID:BIMI-Selector;
	b=IEaA57sZ6X8WB10xvE2KeLHOQVd9cNpURq27CGNO3HdNrjGhB/iC9oSl8R4gSowSB
	 c0A3u0j6xfiEgvMJ44hN8xi4USUFHA2zbvT9nW0Fe5LYrL3VipW3kO6qSynTA6loAq
	 doREl1xoFG9JwIdsiiEQJi2L6dq99q5rZ+nJGAP4LUaz93RzFer0JyS/LHt2+FP6Zr
	 OGsF1488kTPGL392YeO+nAqJ8xGImVOaK8sML+y9lsXogqSsJEsXNRfTa7822Sgfcq
	 iJTF1uqR1RaLU6FU18lgdCcnYD1WXgXsqYBQfA2yvE24qLzXoGkT7VuoIKlv+65rCe
	 mTTT4Y9ynx1Hw==
X-Pm-Submission-Id: 4bWd6227Thz1DDrL
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/4] Get/Set forbidden operator list via SimManager
Date: Tue, 01 Jul 2025 11:29:27 +0200
Message-Id: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHeqY2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3bSCnNw83aTkJOPUxESLpMREEyWg2oKi1LTMCrA50bG1tQDA48+
 UVwAAAA==
X-Change-ID: 20250626-fplmn-bcb3eaa8baa4
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

IoT providers allow for enabling and disabling of operators.
If the modem have detected an forbiddel operator it will block
connections to that network.
This will allow controlling software to clear that list.
(Our IoT provider recommends to clear the list everytime we power off
the modem).

Get:
$ busctl call org.ofono /sim76xx_0 org.ofono.SimManager GetProperties
[...]
"PreferredLanguages" as 4 "da" "en" "de" "fr" "PinRequired" s "none"
"Retries" a{sy} 4 "pin" 3 "pin2" 3 "puk"
 10 "puk2" 10 "CardSlotCount" u 1 "ActiveCardSlot" u 1 "ForbiddenPLMN"
 as 4 "23802" "23902" "32431" "331022"

$ busctl call org.ofono /sim76xx_0 org.ofono.SimManager SetProperty sv
ForbiddenPLMN as 1 "23802"

Todo:
I'm still missing to do continious updates of the list.
Any idea to update it periodically?

Would also really like some feedback on the dbus interface

---
Sean Nyekjaer (4):
      simutil: Add Forbidden operatator list(PLMN) fileid
      sim: Show forbidden operator list(PLMN) with GetProperties
      sim: Allow SetProperties to set forbidden operator list(PLMN)
      doc: sim-api document ForbiddenPLMN

 doc/sim-api.txt |   7 +++
 src/sim.c       | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/simutil.h   |   2 +
 3 files changed, 151 insertions(+)
---
base-commit: 8d892785e47bde9a0912a05725405bb60c140f87
change-id: 20250626-fplmn-bcb3eaa8baa4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>

