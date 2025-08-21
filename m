Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4930DD3E
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775473; cv=none; b=X0pAWDnsUyRF45HmWUOSoEaKOsxr04v86DpycjSFFXWRwc6HEFumkExI1Wqh6SZPFj4iDmBHlyPsGFcmHItvpATT1mCzyTXSMols2n1haOVzGFYZ9CjguLCfynYpYjr3sRYGqXBZi1+eC58Vvy/ebmERyb1jMgEKO8S+/iE3vjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775473; c=relaxed/simple;
	bh=HrdYC7HiotfG+FRCHfwIKvc4d9DS9Jv1Smo2DBFKdC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=cYBVSY4Gcq8UxoUNUxJiJI2EL7+ttofSSiNDYuYIhr++haNXUqvDASW6cHd4pTHotw4eE+jWCzHn/uE6lhbmaODjB5q0inqyWl9lABi0yJhmCvhnJg3nAdOn0PK7+j5i2O8D/gSBGdA+84Lf64tAVsSc/LnpHZi4/UDTMk/Vg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=XsVGpuHL; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XsVGpuHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775463; x=1756034663;
	bh=hStvQqqtaRehjABKegkHKwBetr9J7t2J6j8ujWNkpXw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XsVGpuHLBfWdQzb6ReLHJXcesKmHeqS6D6heio0F3p2OVyqDwn9wlnkqS2fEjse7I
	 Mi5cRRvo7oUjsgVOeOktAeK0KMUYyDGmQbXr6cPmG8WcVGWhXPE00iSCBsMj5h/9Dq
	 ReJLNJtQiO+EQen6hYVa6JqXW20XBCD4Wz8vqMMtFpi41Sa74vG+DFhX7YOV8F5IJd
	 O2Vmb9xdRizherZsaglZmFGXkGKxcrWXpPWJXO2MqsAP6BDTfagVNiSASH3hUz2NcM
	 02NNj15qy2zXpTgz2eUiJlFuyeTj7E6hRnxGj6wnnMkhZNdroDaoqh5fkcH1kTWK2Q
	 7YMmMKB5SYqSg==
X-Pm-Submission-Id: 4c71Dk5Xx2z1DDs7
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 21 Aug 2025 13:24:13 +0200
Subject: [PATCH 5/5] Revert "atmodem: let +COPS: report access technology
 for SIMCom"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-simcom-v1-5-6c794c5573c3@geanix.com>
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

This doesn't make sense anymore after "atmodem: report cell technology
capability for SIMCom A76XX"

This reverts commit a2adfca2cb0a5b0857ed7843fe66d21fe1fccb86.
---
 drivers/atmodem/network-registration.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 7f03759b83b3cf8c45cc885a450cdf24ac9aed92..ba5a93bb5dfa48ce591d31b5bac8e3c9dcb1d7f4 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -412,13 +412,6 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	op.status = 2;
 	op.tech = tech;
 
-	/*
-	 * SIMCom modems shows the current tech via the +COPS
-	 * not like other modems where it's shown via +CREG
-	 */
-	if (nd->vendor == OFONO_VENDOR_SIMCOM_A76XX)
-		nd->tech = tech;
-
 	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
 
 	cb(&error, &op, cbd->data);

-- 
2.50.1

