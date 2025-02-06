Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754632AD02
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805870; cv=none; b=OhQZSpYqGT4uSIYrMrXKgejMwB0Z8etY8MkPToaVlgEKDhCJcwU063np8SdgHEmea21WnFxykrZnnmPA3JvTpsK2ocyBqQV6YZ9vMIaftQ/nCsr7QI9v1Sree34MZIbvt+d08gx7Wb9B3NfIZLRJ966aYgrsK4pJ+v8TxVU5dLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805870; c=relaxed/simple;
	bh=/SBVAqkmHEvdjLsaIZmkB8hjdkaa9rXweIHxdFtzq18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdwZWTBq6eti12qyWIRj8ZJWLbkRAezSc6UdvSrDE+Wz3qQLaHHf8myM+fdLt4ZnkTxk2QsCMjcSrd6VWK3ykTrny5JIxwUOBliJiRGrrI18Pi+Uz4hWaA+GzpmH0hP61gMDVrAYGQLe7NS9kLAmpmi2gkVYu00yuVUNqfn4q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=bF9h87iv; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="bF9h87iv"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5EA45164A7D
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:47 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 11E68125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 3/7] data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
Date: Wed,  5 Feb 2025 17:37:40 -0800
Message-ID: <3e4d9e3b9ac4539601a5767a80b5ff1d48dd1fd6.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=MbU7kPf2KVmRkHuT9J9bsDe+nU+E9t6ZeShfJhwClR4=; b=bF9h87ivFyl9lLTJ3/XQwO6E4RK75nHfjnOWKq+/UZU64lZ45oo+iG1YEfC+bXf1eQvTAhf3OLk88MSTWCA3pv+CaEVLsAnw5lLGl7G3nikisDRHGMWLuhsO2CNdYsG97ihI/INsFlDxL4+JaaR5CpZvUkdmDvjZVECZMFelPULVUYgVeecoAvtoL1is7impKdZN6ULmMPeayQgIpnYojSj2LNEN6M+snW7eBb9RqlV6E/FOAHVK8YHXAratxJ76T89+5UohAZxkyRpiMBceA7gMi+usYWjDfvmqvCjcq7eIXu9lgPA35HXSvJvvysdvGrPHSemQaL+LiqrMHwXPAg==
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

This adds a MNVO-generic IoT / M2M APN of type (1) above that is used
by KORE Wireless as well as by other MVNOs for the T-Mobile parent
operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 751e1ea6e1df..bd10068f6b3e 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14250,6 +14250,15 @@
           "ia"
         ],
         "tags": "iot"
+      },
+      {
+        "name": "T-Mobile LTE MVNO IoT/M2M (Public)",
+        "apn": "iot.tmowholesale",
+        "type": [
+          "internet",
+          "ia"
+        ],
+        "tags": "kore-m2m-public"
       }
     ]
   },
-- 
2.45.0

