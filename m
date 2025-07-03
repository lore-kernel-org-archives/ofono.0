Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A182C08A8
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543326; cv=none; b=laRXKNH6IaVR1KEgq/AT5phNj/am4AFpXnLyysJDjkTlb9kdC5DZDQYgdMB9xJXu1ygm/74uLdAg+CxbvhVHcM1o0ik9wyk363SlQY0IqZgQ+uLe4BLELKriL0ZtKcYduUU0vLqYJP0spLiDpdHHo3/4ybK+/XFeAFPieRiH3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543326; c=relaxed/simple;
	bh=3x9E9MhbDI/h9NvyZA0Vf5ir70KFCEEy7tCkC/QuLks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=hY4Pn0wPb42gTSs+zTGN59Oxpdm9a0WLp6jJREVH2r+mXMjKdi/VzGQvE7yui+3XGhRPXmnTrFAjtcZGOjsfUtScj6avDAXKz3DD7NJ5WuaB7MZ9GS54HANaOGFnOSEom8rHAAeC/vDiNpbX1qvRrwynHUn+8dz+Pq8bxjFgMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NiCkaaYx; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NiCkaaYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751543314; x=1751802514;
	bh=Jtmnx8fe+lClcGNsA+FTagTlAWoocFXEr6v3A/Ygsag=;
	h=From:Subject:Date:Message-Id:To:From:To:Cc:Date:Subject:Reply-To:
	 Feedback-ID:Message-ID:BIMI-Selector;
	b=NiCkaaYxDFArdHRbsXerK/7I8dmyOtAMGNkjzPTgVt97wBA5KMBfNe86vTR/jWA5e
	 KhKTjAK7qFCAARFz/+3t1cvXXOeKTR8yzdDTBsPYeQSRpoOBklq3MYhaOTEHR2xraP
	 tDX31QPdNoWcHxFgC3dC67QwOmJUfzQGZQsxhHv0Kjzd3w5IGd4xNMOURs8jfVbRHY
	 6Yrw0UvtEu1ALSUiWrXIRuPF/8RZvOo+A2MnqC5zGG3j5PIlObKtj021bQR1u4ZKE2
	 YMaaXdO9rjF7yyaxhOX75atSoiR4pn5X+Qb46wVYYykI0fJe5958y4929RxEINPITR
	 LtdOfRcSojlKw==
X-Pm-Submission-Id: 4bXw5F5Pqzz1DDWv
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 0/3] Clear forbidden operator list via SimManager
Date: Thu, 03 Jul 2025 13:48:18 +0200
Message-Id: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJuZmgC/y3MQQ6DIBCF4auYWZcGaJXqqvdoXAAOOkkFAw2xM
 d691Hb5v7x8GySMhAm6aoOImRIFX0KeKrCT9iMyGkqD5LLmjWyYW56zZ8aaC2p9M1pfoXyXiI7
 Ww3n0pSdKrxDfB5vFd/0Jiou/kAXjbFAOW9tyYWp1H1F7Ws82zNDv+/4Bl/wvspsAAAA=
X-Change-ID: 20250626-fplmn-bcb3eaa8baa4
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

IoT providers allow for enabling and disabling of operators.
If the modem have detected an forbiddel operator it will block
connections to that network.
This will allow controlling software to clear that list.
(Our IoT provider recommends to clear the list everytime we power off
the modem).

Clear:
$ busctl call org.ofono /sim76xx_0 org.ofono.SimManager
ClearForbiddenNetworkOperators

---
Changes in v2:
- Created new method in SimManager called ClearForbiddenNetworkOperators
- Scrapped previous Get and SetProperty options. It's to complicated to
  read the list, so rely on NetworkRegistration GetOperators showing the
  "forbidden" status.
- Link to v1: https://lore.kernel.org/r/20250701-fplmn-v1-0-d7fe9c901b57@geanix.com

---
Sean Nyekjaer (3):
      simutil: Add forbidden operator list fileid
      sim: Create new dbus method to clear the forbidden network operator list
      doc: sim-api document ClearForbiddenNetworkOperators

 doc/sim-api.txt |  7 +++++++
 src/sim.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/simutil.c   |  1 +
 src/simutil.h   |  1 +
 4 files changed, 52 insertions(+)
---
base-commit: 8d892785e47bde9a0912a05725405bb60c140f87
change-id: 20250626-fplmn-bcb3eaa8baa4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>

