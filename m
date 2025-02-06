Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE1A2A8D0
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738805870; cv=none; b=efyU4lKnZGXmdqVTO5pfaaJebt0E9fkKdIlTqBgU6qOElfRzBx8Mt8eHWogbwm1bwdUnLFKUSj8vxRwH+GEetog7iW9RlA4moq9/VfsSxQlU4Yu4xa0bzzm9n61laBZD10Bs8HlpRJRGg3tioSwWLK+ULEjgoP0j+i8iMjkDU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738805870; c=relaxed/simple;
	bh=EESuhLxTjd4qwEtDQ4Whn85ONDbgZj+OJHoudKx8G/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixVhw4y8QOnuspmK0KQEvimpauVj/SoRN8lSmnB18rUU9jGRpmE7kUwlGFWucEaUoC1PIKyB8/382VEIP+N7WjnFUwZq7wASDnACrq4/D2s5dL8RWOFR4wdyFnbiohAHIRrIJRhnbQZOAVWJLXhG3LriiDzG5NhDp3sq5+tjFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=pfQIAI9e; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="pfQIAI9e"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E384E164A75
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:46 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 95D56125163
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 20:37:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 2/7] data: Add AT&T MVNO IoT/M2M 'Private' APN.
Date: Wed,  5 Feb 2025 17:37:39 -0800
Message-ID: <1b16809ae1f41402dac2350b37be8d663833f01d.1738805694.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=iGS9lnL7wlqGiQvEzksb0ufP/yeS+HASM0303Guj0QU=; b=pfQIAI9elLWTgIjluAKjAIt+rpFC1c/OSgW8FHzudl6A0FkgLDx+xISFFJCBU5BpnsbFiIQbsFlh/C+rPV+GiXRCXy+j3765kAa0iTYMuDzhDejRDBQ4PyhX6plHfK0qpuWg78X8kEokaJbG/6z/zT0Q4MStCx+vCydkPDtdy1aS3tvEpjp1WUKyVdpdzciaOS7NCBDSq3JHQ3vUcoxm123ZabBmx5nas1RXM8MRHtpRkR1a2MRK5StxsoB3yhnk+wsyXbo9YkwGOlxOWXBIwTqqIbgBWJn2vWNa7IhCw4E2P8whUUxvHWiY4QwZDLKLqrY30S/LShP0HlIP6v8HYg==
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
by KORE Wireless as well as by other MVNOs for the AT&T parent
operator.
---
 data/provision.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/data/provision.json b/data/provision.json
index fb80cd839b80..751e1ea6e1df 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14200,6 +14200,15 @@
           "ia"
         ],
         "tags": "kore-m2m-public"
+      },
+      {
+        "name": "AT&T MVNO IoT/M2M (Private)",
+        "apn": "10569.mcs",
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

