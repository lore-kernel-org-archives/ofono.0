Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1C12E58
	for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222948; cv=none; b=dfW2HKnUox4M8J/U+0+QpDa3zyy54umBAhl6cJ0g9+kqOJy19/CMOKGoJYGkTxV3u4VAyLYhH46Zm7bjH9dazK0MvgRTRVTqzXDq+OW5eu7RwmTec3jKajPqSoeTbGogj0EDv+x4YpvyjzTAD/TtdN+DzeQGtdTVMnyTdZJFZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222948; c=relaxed/simple;
	bh=EMY+cFvk6BdVC4CR6Ew5acr/758fhNmQbdpS0mjkFdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFm+P2CkMls/AsarOz3QBzko+4K0rGnEEFVwad9ApJcEVDsAM+7X3e6fiur4BTPVFn4HcAd2HyvTlAame1a9bmNjPR6X+TTKZzAibAktMu7L4oiK1/nFqBT2a5Kh5RiuJQGW+JLxDyzDHqwalJEmCI1iVjOgcLnVgq8yw8wL4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy64hQ2W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy64hQ2W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d70a98c189so46990315ad.1
        for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 14:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706222945; x=1706827745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjvjXv8f+W/D7bAH12S3d5+WJBAXT7N87tuRxKqwDOk=;
        b=Vy64hQ2Wvp2K05UPGGbELnPECBFswMwre3TY7xmSclQwWOxRDFzab7JLdEM6YO2VuT
         fgeHNPJaGu7T+nk9cZqyRCA1CZ5OXTaJxFRFm5RbH+ScPUwjgRrdiwl+t93sU4jdHeS6
         2AAhuZcJXlO0wEefiPmw2EsuGMmqJm7hpYZlq1KZt9DyZbl87ohA9o+3IHQArsmDUUwT
         HQAziMIpkFSKfzzsJb/Et70loeafCLNq5kfd541CkG6L+0ygBwfdJ2te+OMFaVQTWbIZ
         M+CUdXjc717U1NROhI2RmG9ddX0YzKoOmC8uch0htuHeuUUXsaBor9EvhgOgLc+D/5g1
         5otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222945; x=1706827745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjvjXv8f+W/D7bAH12S3d5+WJBAXT7N87tuRxKqwDOk=;
        b=dXYBih235stVV1WOZ/3zUs1dyhv9p7CjP4B76/RCtRSSL2BoGSKFTbOKsHG8EVjAcZ
         VAjtzZoiYII7f7u65lZ9GH8ybbDPdvnfn25uLuh8wnohaVtRwZZrBLFJ5Y02Z+j5TRDs
         HeWGO9bQYp/DJdMif2zMekCOHbY4UkaWCjtDGAp48imk/Ossu4nHw/Xt0Nwdr3M7OLxB
         BnCZ8w0DAlaOdy1CeZ5RPTfo68IqJz+L/OL0anlTx7j84LAaMBVTPX74mOvWV3K78OsN
         jq04RGkrreWgSdM2GNUvEHVDKHsLsTvY+QYUfREMgJs4YTLD2noqnJ1w4OQtyfmSi+UM
         ZSDQ==
X-Gm-Message-State: AOJu0YzlyqNeOTgNAtb8xANoUQYAmPhfXQ4ztrGPLKaBdW44ocNJxzxz
	PTChhy3UXf32rzDNJAS8kaLxQ5SiXWtdZ87SYslSaSEtfVQotCHyapNsZinF
X-Google-Smtp-Source: AGHT+IECU3HxcMXzqnlOH0SJ83slCzznaU5siMuUU4D4GdZBxosldF7/TqhJ1+mgT8FtSe4KzO4ueA==
X-Received: by 2002:a17:903:2450:b0:1d6:fcc3:c98f with SMTP id l16-20020a170903245000b001d6fcc3c98fmr446518pls.29.1706222945528;
        Thu, 25 Jan 2024 14:49:05 -0800 (PST)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b001d7393f6917sm4143pls.86.2024.01.25.14.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:49:05 -0800 (PST)
From: Brian Fukano <bfukano@gmail.com>
To: ofono@lists.linux.dev
Cc: Brian Fukano <bfukano@gmail.com>
Subject: [PATCH v2] provision: Add MCC/MNC combos and APNs to db
Date: Thu, 25 Jan 2024 14:49:03 -0800
Message-Id: <20240125224903.4731-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional MCC/MNC combos and APNs to provisioning db needed by Cruise
---
 provision.json | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/provision.json b/provision.json
index c52d5752..ae9a0848 100644
--- a/provision.json
+++ b/provision.json
@@ -14147,6 +14147,7 @@
       "310090",
       "310090",
       "310150",
+      "310170",
       "310280",
       "310380",
       "310410",
@@ -14192,6 +14193,14 @@
         ],
         "mmsc": "http://mmsc.mobile.att.net",
         "mmsproxy": "proxy.mobile.att.net:80"
+      },
+      {
+        "name": "AT&T M2M",
+        "apn": "m2m005246.attz",
+        "type": [
+          "internet",
+          "ia"
+        ]
       }
     ]
   },
@@ -14212,7 +14221,8 @@
       "310490",
       "310580",
       "310660",
-      "310800"
+      "310800",
+      "311882"
     ],
     "apns": [
       {
@@ -14256,6 +14266,14 @@
         "type": [
           "internet"
         ]
+      },
+      {
+        "name": "IoT",
+        "apn": "iot.t-mobile.com",
+        "type": [
+          "internet",
+          "ia"
+        ]
       }
     ]
   },
@@ -14307,7 +14325,8 @@
         "name": "4G LTE Contract",
         "apn": "vzwims",
         "type": [
-          "internet"
+          "ims",
+          "ia"
         ]
       },
       {
-- 
2.34.1

