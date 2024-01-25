Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54888135A7C
	for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213548; cv=none; b=kfi8MM5RMae+gOefVP6ecS5w7cMTMNBdhDi+9Svjh1xKRXjQ26C+M1+l6m8OlYsd1Ug59Am6flOUG53HG2GkadFqz98GQ1E2lyaF0QsHoI5k8qVqav5LTgb/kqG6QLuPAbf1XE3JEx2rsutL7/bsV3i88fW2qxofaLubtfRuziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213548; c=relaxed/simple;
	bh=jwEb6Pgb889ROa/0HtfjDYfeds0lKlnlP2e8smGCC0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8mUK3gwa+Gw4bXnxtrTA6IwxyRsgZ2Cm/hxobGTlJXc6iaAiw0tlmUoq7weHVOJuyhCtjO/O3PToClW2TSTqBs5QqqkdjwUbGh02N1E2AchM0xg8kROLc2VjVDWx/VxyFNJ/w+9+oLoPNRLFKvsNAayeU3DJUkP6JRMkvdWLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iixw8OvT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iixw8OvT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3991654a12.1
        for <ofono@lists.linux.dev>; Thu, 25 Jan 2024 12:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706213546; x=1706818346; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmSvHNFH477EEdFsBtKfq0+hUph/bHgWvuIDbIPQAJM=;
        b=iixw8OvT8EF9DUh17uAntxVf8Qvk02w/SiCJcWilC2YuMKdN44Jc6H1teGLSnl/5U8
         /ODdo2+HLZjje0oIM8nTrvzbwr0l3/7ob90P7YVQ4XdYzO2kBldDRyYQClL5cMsmv7T8
         vH7QXk6BdILlODoVqzObVkGVoNJyusWdtXfVLWP04Q128MmuSmoWNwtTMz+zKoMKfHEG
         oiHm/cUxHSCG7RmzfsvNTuZDJODglCwhEDIX5uxKBKfkJddfZ17mGkCAFHGuAJA4caNK
         6elDXXG3w2ulWmiuCcS+evoospw5hI9HESZf5dzZkMuYSRdn1uy5j1FQ3onPBTLuDofJ
         YZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706213546; x=1706818346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmSvHNFH477EEdFsBtKfq0+hUph/bHgWvuIDbIPQAJM=;
        b=ask1cFx+iuDJXQbWq8myp6y4vE9gC6OPEEukcWTz2ZhH1AjsWsxDiW2kY1OHUuk+Jf
         fBeWmRMCkiS0yQTBjfIGmCgDqeu/WOIqTA7HIw70FQBL59dXdhhN9yGaTr2QV/FGIczV
         Ev47cpMNyPUnjRdlHdGRSqT9XpydhtCoxl3MjmuwYmQ2S/NhlRh8PK/xZa5fpFhACBWS
         zklRRUy0pgh+RnlQs8Bub+ShQwo3LsVDfJdPBvnXDq7coVViOr1DJOUzCrexWYBDXxcF
         VHC2/2id9xij3Lczn79zUiILdOUcgBif15VlxTUUPG+QDyc6pm22taK7HKphPx5I4Q6C
         OR6g==
X-Gm-Message-State: AOJu0YwYQ28AtWh6d8iP2xuMqKbv11Li9cO27cZyUcFguXtTti5PcVv7
	YU9Uny1LQ5Fj7jk8ylad8jbnA4g0fXVor2A37pSySEmqWheFULh6TxlezuwTFy4=
X-Google-Smtp-Source: AGHT+IF8yTlfPiVcgA1hLqjBrYBPcSIumdgFWSLjmvQwWlWl3BzZ8PSv/y2zUm80QFjWafqyTLDJPQ==
X-Received: by 2002:a05:6a20:ba94:b0:19c:7ed2:1355 with SMTP id fb20-20020a056a20ba9400b0019c7ed21355mr165890pzb.75.1706213546253;
        Thu, 25 Jan 2024 12:12:26 -0800 (PST)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id ko9-20020a056a00460900b006dab36287bfsm16167522pfb.207.2024.01.25.12.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:12:25 -0800 (PST)
From: Brian Fukano <bfukano@gmail.com>
To: ofono@lists.linux.dev
Cc: Brian Fukano <bfukano@gmail.com>
Subject: [PATCH] provision: Add MCC/MNC combos and APNs to db
Date: Thu, 25 Jan 2024 12:11:11 -0800
Message-Id: <20240125201111.24383-1-bfukano@gmail.com>
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
 provision.json | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/provision.json b/provision.json
index c52d5752..218f0aef 100644
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
@@ -14192,6 +14193,13 @@
         ],
         "mmsc": "http://mmsc.mobile.att.net",
         "mmsproxy": "proxy.mobile.att.net:80"
+      },
+      {
+        "name": "AT&T M2M",
+        "apn": "m2m005246.attz",
+        "type": [
+          "internet"
+        ]
       }
     ]
   },
@@ -14212,7 +14220,8 @@
       "310490",
       "310580",
       "310660",
-      "310800"
+      "310800",
+      "311882"
     ],
     "apns": [
       {
@@ -14256,6 +14265,13 @@
         "type": [
           "internet"
         ]
+      },
+      {
+        "name": "IoT",
+        "apn": "iot.t-mobile.com",
+        "type": [
+          "internet"
+        ]
       }
     ]
   },
-- 
2.34.1

