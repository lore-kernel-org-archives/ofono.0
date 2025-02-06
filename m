Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886427452
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805869; cv=none; b=bMP2dA5Z8iMpJH5LFEtwAsBiEz/HMh/oMf640ZF4OrYZqINwJDOAUdUukhL8JVxMvo0BVkLMKdw4JkbZI7aWQMpDHkDwycXD9TbifWb4yTbjFgkXYskN7iYnwmifY2vH456Qnwu385oErEF5fsZUuk4b1bG1vMl8sFO7eB7M3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805869; c=relaxed/simple;
	bh=21/Jh3xqSMeyPIe/7aTqQY4mAqlr0BE7ZSIq4OK+J7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVw+x5fXEKYSExAWzYppeznrWRPNdIwUPVwyI13pzE/cvpQZ4cLv0DiYY8MLRYuw6AWSy04WsFbJ0YVpNqKIopwgF0QPFCxtnHnJrA1BLgJGozykX2iyyne8tJbFVHO0CSjQPgfxMtc75fiaB6NNvIoi3GV2Ec3s2l956EXif5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=hrNEcm9S; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="hrNEcm9S"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 724D4164A45
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:46 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 29389125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 1/7] data: Add AT&T MVNO IoT/M2M 'Public' APN.
Date: Wed,  5 Feb 2025 17:37:38 -0800
Message-ID: <3087720dfcd1d0e6d361f4f732cd708b8562a1d8.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=QWqKJsOAzW5aE2EfTz8Rxnw+TjDyCt12auQH2ZJn+gk=; b=hrNEcm9Shthie2jwUiYgu1ckUx4v1LC3Y6y1I93KX6Q8b5VQqzkvUST0pyMb0ZqYU5JZAJBOoH+tDilRpCy86TM3JSE+QV7/otW0a77uukhxcxBCwcDf4YSRS+5YlKhEwrT8zUq+qL7I4a0SwmylaAdBnNgWK/rWCuyz7teZ/8YGjjqy1NHt61fjbHPXutQ2go93X54EDI+08OmMtAnGcFSfY3ecLxZ7ruzxknlweCDLJ2h3vabvz/+2lD5i945t3p304mr1HrxPW7TE0g2qwIMPqFCn81sWQ6sJiDVoPvGPpQiRsNEVje9WIuvhJiikKSOcsaTMpj6q3WoB3nmw8A==
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
by KORE Wireless as well as by other MVNOs for the AT&T parent
operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index 50319cf33a51..fb80cd839b80 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14191,6 +14191,15 @@
           "ia"
         ],
         "tags": "m2m"
+      },
+      {
+        "name": "AT&T MVNO IoT/M2M (Public)",
+        "apn": "broadband",
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

