Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9166AAD
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493746; cv=none; b=SO1wNav11SYw/QYVABFWgbNMBbwnL217Ank2FdSNbgDqXLd7AfdKviLlXvIIw2p0uUPiNU+P0AuHMZrTzKVe2l2em4yhX6+SpyF0ZsHjP1Q85xO4E1PDKRe2ykhj+A6BOZCDF2J5hu/aKrfqA/hcVI9rxqL91tpYXkHOG/gaN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493746; c=relaxed/simple;
	bh=8ayDTWoYV2R6BhlowtlnPs99x01noqG9PkhFuvaPML4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCl4GlRB9aCC4tfq2OeTPvX01YdOj22jBLRd84jsM6GKZbxU72GSw/SfeNO0GB96qbDyz/eW+6gn0GmuCUjDnUfM4hpQNMf9vlEEIu+ZmT1O9LaY4h+2qseIATYDDljQCrOClH+e/4nclQ4Mmm+t7SsnJFPs6sbohQ4Nffwb5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QOXClBb+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QOXClBb+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E4C0A164A79
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:22 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 9B6EC124B2B
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 19:42:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 2/2] data: Add T-Mobile MVNO IoT/M2M 'Private' APN.
Date: Thu, 13 Feb 2025 16:42:20 -0800
Message-ID: <1b1a091686b60589ef6832bddec58e62419b3658.1739493541.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=bDm4BqhA/wk98J6iheMgga57/+Vd75mlWScr8nKtGVo=; b=QOXClBb+bh5qPnjxPUEVbBxd3IeIpYvF/cqjFSwogvY9m90YNiewfvXvGqmKADkc4ktcbegOiQeVQV22/vfB907NYjOswTtdHkFgkZ0NPCCqWDjfTH6YlDwaoGnfSv3fKSZkxvjd7kwZepqagbYV6xUh5o0VsTqPC5Rl+s2uzISTdcY8wP0lJBrc8yKNAI/6ugXQS1emncOoqhi6nBSIVF8oNh6DIXHqjS/sDjqWuDzCxBoevAfzcPqUrP2yVenDYUlTiQW3pjlnHPQ66vnuLFtFVAoQoyGSHtCTxXeAGhrYnIH5mhCBRQf3ly780PcivXsNXW8couoe31Pdzr3BmQ==
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

This adds a MNVO-specific IoT / M2M APN of type (2) above that is used
by KORE Wireless for the T-Mobile parent network operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 568055b14233..85e29790c736 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14251,6 +14251,15 @@
           "ia"
         ],
         "tags": "kore-public"
+      },
+      {
+        "name": "T-Mobile LTE KORE Wireless MVNO IoT/M2M (Private)",
+        "apn": "c1.korem2m.com",
+        "type": [
+          "internet",
+          "ia"
+        ],
+        "tags": "kore-private"
       }
     ]
   },
-- 
2.45.0

