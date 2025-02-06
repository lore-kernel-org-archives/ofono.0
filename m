Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD9381C4
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805872; cv=none; b=iBYzPb7H5xEMBnQm9LK0n2YiDAdH+zbTg+jcBtsOf+8WMFaQrn4K6ZqvBo4WNlF5Ke3/LnulW69iEmJwSJID3zI/lB1Oue25tunPe1XapPrZm/yW2iXt72A7VAoz9U6UrsGwDKTRKBCOVRT4wQOVYjEaAlTYglFy3RVzNdKBiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805872; c=relaxed/simple;
	bh=qLTJg/CedxxiurkKdjZezqhhGN9ResJtsE0yI65YuJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSErnQXky19ZVo8CzHqHMG22uKuOkSPNNNekfb/FO7EyRg6RmLnAQAnJ3gGU0RyOiBYyzadmtLhM9Q1erttnxWy1la37tx9Lt86dD4lK5k+GJpr0p83mMbY0VdVkYe446DyTzMvelf58jvykZ7rPSjxiEjd1ZzRMtrWx2aKdO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=OFb4MrYm; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="OFb4MrYm"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 43683164A92
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:48 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id EE33F125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 5/7] data: Add Verizon MVNO IoT/M2M 'Private' APN.
Date: Wed,  5 Feb 2025 17:37:42 -0800
Message-ID: <2cc87b5e7855dcf0926c83804958b1555f515315.1738805694.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738805694.git.gerickson@nuovations.com>
References: <cover.1738805694.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=nCKTcKbnitNCbBKztq+9G2sskBhi2V7IHoJViJHuZHI=; b=OFb4MrYmPktBqVSGi/nN+yb/xuLm+tmr5Q7QNQKSWCgYghaVieWlGPJSQmTxgxjvImdAivvoSYQmuOgTdzjBHlD2YpP9QPQibDEZT69+thR/SDSifY21r/JY9llXWMtgWf5Yr4SfH6AeJJs8peZu99b4/SbhOtPrIoHA26S4EaQZQivTAKkC0yJqo6lr7yRlSJUiG5JsyaI4BpEk36jmV2RMg/sMXGxDOBGXs/PV67TKx8ciG6Cp3H7gZoBzHDHzwu/UBPrWmq6H69pU2LFb1o2IA26/frOyuTGj+EaJpDhpqskn8VrNi8h5wQNCC5LkBPOfDlnIj0Gl3CrU2BZA8w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

At least in North America / United States, there exist Cellular MVNOs
(particularly in the IoT / M2M veritical) that neither use mobile
virtual network operator (MVNO) service provider names (SPNs) nor use
unique home network identifiers (HNIs) (that is, mobile country code
(MCC) + mobile network code (MNC) pairs). Instead, they simply use the
HNI of the parent operator.

In addition, those MVNOs typically have two or three APN schemes:

    1. A "public" APN that is broadly used by one or more MVNOs for
       the parent operator that issues PUBLIC IP addresses and does
       NOT route through the MVNOs or parent operator data center
       infrastructure.

    2. A "private" APN that may or may NOT be broadly used by one
       or more MVNOs for the parent operator that issues PRIVATE IP
       addresses and does route through the MVNOs or parent operator
       data center infrastructure.

    3. A "private" APN that is used only by the MVNO that issues
       static or dynamic PRIVATE IP addresses, does route through the
       MVNO data center infrastructure and, from there, via a VPN to
       the customer services infrastructure.

       These are sufficiently MVNO-specific where they do not or
       should not play a role in a generic provisioning database.

KORE Wireless is one such IoT / M2M MVNO that uses AT&T, T-Mobile, and
Verizon as parent operators.

This adds a MNVO-generic IoT / M2M APN of type (2) above that is used
by KORE Wireless as well as by other MVNOs for the Verizon parent
operator.
---
 data/provision.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index c0dcc7b37c9f..cda4b6e532f4 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14336,6 +14336,14 @@
         "type": [
           "wap"
         ]
+      },
+      {
+        "name": "4G LTE Contract (Private)",
+        "apn": "wyleslte.gw7.vzwentp",
+        "type": [
+          "internet"
+        ],
+        "tags": "kore-m2m-private"
       }
     ]
   },
-- 
2.45.0

