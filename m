Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8159443
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493746; cv=none; b=ZfqLItAVPRm/Z3CLA8rBxIMEssDtbQLOM6Q/7/JRreF2Nut1riNGTJ5n90Z4xRTupQBTSKr8vhDbiWVNzbGQDCEvq21RtnkRNZJntIA0nFp3J7hh4A/lq0L8XZu7aQE1lOeaQGYkr+g/AgTjYvMfMhDccbpjcexI7so+EJUA2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493746; c=relaxed/simple;
	bh=0nOZ0+u0fOVLLm4E6Mb8BJXLs0+8JDxnbhEuR5dmCGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEwSvxj4E9v4R51uLAgR1cSnz/e2rm4b+eB4+9jjjyMOquZei6ncF8n/vrEUtHGkpTtKk4nkcGs1tvlG6I8U1RF5MxGNhEi1C/RsLhofNKfPdtfPlHh861Uy2sXCoY6RMmZ5oL+cIko8yQ+jZnXTBwlpzbpsxRFT1mVTuztJWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ZbSBNoaL; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ZbSBNoaL"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 774EF164A4D
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:22 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2DFE61260CA
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 1/2] data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
Date: Thu, 13 Feb 2025 16:42:19 -0800
Message-ID: <8346f3cb79a55cd08b45168fa6f8c16b6ee5d21f.1739493541.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739493541.git.gerickson@nuovations.com>
References: <cover.1739493541.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=GSXdaJ+FS5EK70N+SPMjZGHXBKw/JLrd0i8wDqmqR7M=; b=ZbSBNoaLkR0cIbXUZVl4xs0BUwUJ+8B97UCIx+/zFuCTooAZXvNZWDRAWClrwbUF/nmdOXnCWKytp2hWhxMoqUNdHIO737QteM03f+bIXZqzoWghnIDOCGGzp7CnNnlSCKYY7wirCgIimkBaVBSU9KQEEaHIEs8I6jQWqPOWM2ByYGlpLJ18LDdD/haOdVJvv53ChjSz+7SZE/hTIxWyDADd50HNvYg1tShsttbfsqhHtNGcVM7sI9f5qgA4QJoRkCkfNW+iWexL4ulVknfkN44gohpfkc/JTnPkHCpLdOvl1WMffBbBXfaQxrk8UZ44iKxY2wdl2CRA5WRBV3y+HA==
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

    2. A "private" APN that may or may NOT be broadly used by one
       or more MVNOs for the parent operator that issues PRIVATE IP
       addresses and DOES route through the MVNO's or parent
       operator's data center infrastructure.

    3. A "private" APN that is used only by the MVNO that issues
       static or dynamic PRIVATE IP addresses, DOES route through the
       MVNO's data center infrastructure and, from there, via a VPN to
       the customer services infrastructure. These are sometimes
       called customer private networks (CPNs).

       These are sufficiently MVNO-specific where they do not or
       should not play a role in a generic Cellular provisioning
       database.

KORE Wireless is one such IoT / M2M MVNO that uses AT&T, T-Mobile, and
Verizon as parent network operators.

This adds a MNVO-generic IoT / M2M APN of type (1) above that is used
by KORE Wireless as well as by other MVNOs for the T-Mobile parent
operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index e74d42a2758b..568055b14233 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14242,6 +14242,15 @@
           "ia"
         ],
         "tags": "iot"
+      },
+      {
+        "name": "T-Mobile LTE KORE Wireless MVNO IoT/M2M (Public)",
+        "apn": "iot.tmowholesale",
+        "type": [
+          "internet",
+          "ia"
+        ],
+        "tags": "kore-public"
       }
     ]
   },
-- 
2.45.0

