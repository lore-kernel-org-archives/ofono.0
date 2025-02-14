Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C648C11
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493745; cv=none; b=pT6XKB1pGWcB6DhjvUpwX7MqJZIkYs5cL7A715gtdiCYFphRkttHAiC7Xk+WvDMqL+oGeMB/c8SeEU3ljzhVbQ8kXcidQzHmKMuR4egWb+WaLjk1k//U/g+1CxoBodTeBLNBR1vZ4qReOGpAV2MusZpXjF67neA+3jFJAfSXtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493745; c=relaxed/simple;
	bh=28xs1B5liEDprzzUEyX23PxbDZfgM7Fdc6RTwxq67lg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iG0kvGguQMK/xv9WqXeRJx5vHXwr9cXnQZbnBPDyEV+GTvfUgSNbpC6LoyqVfuMHb/X+yxYo6lpYmMM9OTB2rx3fvl732d8j1YPi0AQRYKVueoWgDPoKbQ6r71naCMYAa2350j6IWGcyDWefygdAqhaUa0e+iIL8Zqkkxl7Z8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=eKYSMiBG; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="eKYSMiBG"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 0A206164952
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:22 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B1CA6124FD2
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 0/2] Add T-Mobile MVNO IoT/M2M 'Public/Private' APNs
Date: Thu, 13 Feb 2025 16:42:18 -0800
Message-ID: <cover.1739493541.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=nqLpQYnNehAFxICiKRlyH9LMRg2G6+lHO5qEg0Vqj80=; b=eKYSMiBGifGhjLLouWmqGxZNqY+OewPOfZwZANJ5zOhZmlib8MVTQYC6sVXrt6PF/cb5Nuuj6yxfOQMxN18QvigyFOSDWmmFKllM/98jO3tuvbFhpDsojofnRooihFtv61tbuO7Wczj6WnFyrqcnpppWmkBeD6DNKH7W22yIKU8eF4AdEFhjcc2GFi1O5V4LVNoAptPQBhVI3Fices49hF+YvFYTWcITSU+8jruXliom7SlUHQ2z3segB2lpLV2tfyiVZVoMFmX5O8kAxLhOl5xcbnZeXnmpaAedffvU3lXG1wdLCMEveAdXHQ4ehkyhC9bNg+3erO0TT+c+ytfYyw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

At least in North America / United States, there exist Cellular MVNOs
(particularly in the IoT / M2M veritical) that neither use mobile
virtual network operator (MVNO) service provider names (SPNs) nor use
unique home network identifiers (HNIs) (that is, mobile country code
(MCC) + mobile network code (MNC) pairs). Instead, they simply use the
HNI of the parent operator.

In addition, those MVNOs typically have two or three APN schemes:

    1. A "public" APN that is broadly used by one or more MVNOs for
       the parent operator that issues PUBLIC IP addresses and DOES
       NOT route through the MVNO's or parent operator's data center
       infrastructure.

    2. A "private" APN that may or may NOT be broadly used by one or
       more MVNOs for the parent operator that issues PRIVATE IP
       addresses and DOES route through the MVNO's or parent
       operator's data center infrastructure.

    3. A "private" APN that is used only by the MVNO that issues
       static or dynamic PRIVATE IP addresses, DOES route through the
       MVNO's data center infrastructure and, from there, via a VPN to
       the customer services infrastructure.

       These are sometimes called customer private networks
       (CPNs). These are sufficiently MVNO-specific where they do not
       or should not play a role in a generic Cellular provisioning
       database.

KORE Wireless is one such IoT / M2M MVNO that uses AT&T, T-Mobile, and
Verizon as parent network operators.

This adds a MNVO-generic IoT / M2M APN of type (1) and a MNVO-specific
IoT / M2M APN (2) above that is used by KORE Wireless for the
T-Mobile parent operator.

Grant Erickson (2):
  data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
  data: Add T-Mobile MVNO IoT/M2M 'Private' APN.

 data/provision.json | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.45.0

