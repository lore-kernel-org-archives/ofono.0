Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE62AD02
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805872; cv=none; b=Fos4i7hq6zyUdbgKQZeIB45lmmbv65CTjsJeg/bQcz/PvlKEOVI0ZuyMStF4XDKou06IHtAlt/FGWyFjVK+GGDzWKfxTf+kkddtTW0PWzatfjuiEgjCoeeUAwrAhGG+4878Z6oOyJHRs4OBeSuDRTcsTiyhW7a2B3/yEfewi2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805872; c=relaxed/simple;
	bh=NeaTXYkFXPlU/zlgMitZCOcUpP46A2k4kq3nHEuKxI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKKXdrA2WpuKVHIyrMCdgsHK1xHGT7PYwhGyrHy7izL3vFpdVfzqaZhW6etNkJUoSNtDcw3pQui3ui1Gi6vWT1RFZ+D7qeZ5n3LcsA/acjqRE8t79KRFeCIqU48Gdw9eGbs8YSlihIv7XRRsKvEBij4C7vaC2bCSxvb6qBdj3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=TQcLYCr5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="TQcLYCr5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 27B51164A94
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:49 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D3A39125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 7/7] data: Add Verizon MVNO IoT/M2M vzwims APN tags for KORE Wireless.
Date: Wed,  5 Feb 2025 17:37:44 -0800
Message-ID: <73e145c3384df5c139461af751179d015c470a96.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=NgbGt4AmdCc7yVqtmazQyMaLpd4gt9VOb8Eg8oUrjXs=; b=TQcLYCr5+SiNAOSNqObKHiRbw7GpY8gk3I90fuf1NJWqJWzv7U1B6V4dUVlvKsexQyM0E82S7MzkdX4qrG/wAuwB6Gv16MfVHq7+AawTi8NQEakFRF6g8XBetiq+GZHwPwuEbTv4Kq5RXsYSp770KJAAqC/Bitf4fXWABo/nYS9R8P9sJThyDqaSP8COp7ndmcPhhjplCFTEnczI4HzOf/EiQzlW+6S+a1muEwC888kMvHfpNDBiZd8t1SL/Mx9Ow+60vbup1VAKryNuVaBorxV0mYnq67INHi1MLmS3p/KSAX/CJ5QdYhKrEMqer1zVzF5E3kta2p02O2dQ5luS3g==
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

Verizon appears to require that devices first attach to 'vzwims' and
then 'vzwinternet'. This adds a KORE Wireless-specific public (1) and
private (2) tags to the Verizon attach APN to ensure that happens when
either the public or private APNs are used with (or without) tags.
---
 data/provision.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/data/provision.json b/data/provision.json
index 7bd9da27aaeb..82b16ba0ea38 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14321,7 +14321,8 @@
         "type": [
           "ims",
           "ia"
-        ]
+        ],
+        "tags": "kore-m2m-public,kore-m2m-private"
       },
       {
         "name": "4G LTE Contract (Public)",
-- 
2.45.0

