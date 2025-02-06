Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE42AF07
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805872; cv=none; b=Oz9sziDyDDkzJjzakywSfSZ2rTWuPr6z+Ot4jSBD5w/DAog6L+klFOBqA45db+NxzKsF/AeG4gpJvCfEu4k2aFT5H13pl0aP6pNf8I+3FrlPHmkpjVjUKq9LRnJE8QuTLS5W1RBh8GhvyxQNcIDzzG5CW0JbIUPVbWBqCgkhRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805872; c=relaxed/simple;
	bh=ajsh3a28SpaDt9TFWqzO+KFe2Oq467h9n0NxbH9XZHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItZX7+ilFUHDGaz2cfZy5101EeHnluoZ+h3kKLxAVzRZ1flEbpcGkqY2yutYAT+4ibyuyoMuD4CVMVpI7Teb+5f3XiMgyW9+Xib7amyq7pqXOTy6m6zqZWmhfvS3go5hQru0BeDJfXjsmFu/sWuzcbopHFEhscBCRC/tTWMkP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=PfRbe7Rz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="PfRbe7Rz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CA919164A83
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:47 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 81473125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 4/7] data: Add T-Mobile MVNO IoT/M2M 'Private' APN.
Date: Wed,  5 Feb 2025 17:37:41 -0800
Message-ID: <55ab4b264d85e27f47bd6f7ade8b3bd67a270e04.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=YJbbBF1e8S/RraSTvFlJIxCLu597DvGRTxl9vvYno3M=; b=PfRbe7RzT42RXHWEHElAsZTysxYoFdABEVdlLgU0k1DTEtMNRnF/wWb6ugRxg/0mtLBEGCYOHnub8x31IorEpnorc1eTvjYcr+oGEBGDlrqI6zdtBtZOcScIZR/3jes8Wvx4uC2Emy6LKFTUHYmxoDTz5L9lMeHTGzZWbZJsCrvBfRN/eOgN8KPd3x93E8LWnlEQPsOLyQ511ogeSu5ARQ15l+Hum6PBC6e108Cvu1SN0CF5f4bvJURz7ksRPUeiunzZGLfQrnK+MV9MxkovyTFV4bq6wNYlRNtFMhhsCxrnAm1qA3gy0V5l5YErcw+xxUA2becnALcnXjKpbmMQBg==
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
by KORE Wireless as well as by other MVNOs for the T-Mobile parent
operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index bd10068f6b3e..c0dcc7b37c9f 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14259,6 +14259,15 @@
           "ia"
         ],
         "tags": "kore-m2m-public"
+      },
+      {
+        "name": "T-Mobile LTE KORE Wireless MVNO IoT/M2M (Private)",
+        "apn": "c1.korem2m.com",
+        "type": [
+          "internet",
+          "ia"
+        ],
+        "tags": "kore-m2m-private"
       }
     ]
   },
-- 
2.45.0

