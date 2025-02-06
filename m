Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE42A8D0
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805872; cv=none; b=QjLZuzKmPaag+HwNNlt1MZ4h9q6lMK8dcLf66in3Z2kMPxKoUjuVAB+Y3q8AxvajuAhlnalEhKxLnPMrw3Rb4DB8V53/hfAFdLAs/wy0iJC8RW4yPkQXT2Q86d12512Zv6t3SAfkRXBuOX0nBKStAP2Ez3e8hxir33v0X8zZkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805872; c=relaxed/simple;
	bh=6qi+lYAJtKVwv4p++RNoejqG0LTn33OqGar094Tb8cE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkw2DePnMLfDPaUV2/fpmFOBjAPp3/YE4ZMrACV/jpwD+m+JrXDnWrQH7QSl7yKeBO5Jp4Qe3jgnOF0RxapLpsxlkzMJZrJtjFBTqHuL1okHWsFzPvLufTmV0OyUeCV6qK85KQtEwlWcxMMLXGLxM1O8ZaYpFjiqVif3Z4uEQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=pBjoPahH; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="pBjoPahH"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B0807164A93
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:48 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 66B25125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 6/7] data: Add Verizon MVNO IoT/M2M 'Public' APN tag for KORE Wireless.
Date: Wed,  5 Feb 2025 17:37:43 -0800
Message-ID: <795195b3538316437f572dc79e6cfdfd9a844f75.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=+bM13cpAnPRCvjL/o5ryEwqvb9ZL5mLDUPs0RrHpvAY=; b=pBjoPahH5BOJGGeZ2dZyrHpZIohP2Jvh0S4rEXubIOkiiflO97oqFpl0UZ3Mlk0BgOvxeuzn4j5zLWEh2VD6NamRZ9yqT9W7+h9F1gKlwx6uVAcyhzuEYQVKwWqW7WCgGVYbHIbPdjrInaKbgJpLQ8gYc3ylO/zLCVKV6HeUnRa9M63bsfyKcO/uazS13RDUsZrFe7MGIXnz5+1JVAkj7wsVE3uZW9M4K84fpTOqmIzYxF/pLZ9FM9Q7agvfvQtYQ8Lm0lphdRM1xsnYGpI7hhpcUq+n3d8CsNUWQZL2a6RjmgpYpex41+23VxTXELzLF2SULNTBLEh0gSi8kVWQOg==
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

This adds a KORE Wireless-specific tag to the Verizon APN of type (1).
---
 data/provision.json | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index cda4b6e532f4..7bd9da27aaeb 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14324,11 +14324,12 @@
         ]
       },
       {
-        "name": "4G LTE Contract",
+        "name": "4G LTE Contract (Public)",
         "apn": "vzwinternet",
         "type": [
           "internet"
-        ]
+        ],
+        "tags": "kore-m2m-public"
       },
       {
         "name": "4G LTE Contract",
-- 
2.45.0

