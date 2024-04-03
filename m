Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686414D295
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160364; cv=none; b=ehxaL5SHOrlTBAJoSVokTalbwcvKXHzH3f5l3k6wAgKkkLHff+BJ6kHcEFmPZRsqCHpNiv3A4nm+2ixP9q5AvAZGQDZnEoLmEqgtTjaDKOgSE1+94/a6VMi0LEXSZ0+s3dVFScq9umStMFb8phKLKwq4mwZ/UK+t0DrdragiiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160364; c=relaxed/simple;
	bh=2jtwPV/0aXzMV9GYqTuankIWt+V0Hg7TZhCy2NTuGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S492A5sBTN6Z98tBzQ3Ds1AbaO1j+T9ecxEQ1j2xwUOuzUY//x83DWamt6y2snYaeEiPtX2Kb0Mlx5pvLEB1JLdK7ImH7DT/x2WH0obIqXCPB7YAdtadnMoIuj3+PBHp9pSC49DuRenbsAEMLs3bqJCRacJqTcD5ryfN+fgngq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdpzlRqP; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdpzlRqP"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22ea805f3edso3020fac.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160361; x=1712765161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV/NNd6hDWilRoyKQx5/fF7EB7lNZqPai76qYnei/CY=;
        b=DdpzlRqP7BXtoClW1RsE+1MWP2RvtKYPDubDsyNkBC+MOqt9ri/lGgMOYdAHhgykJY
         nn4JkYL+isb6qtyKfxlO7fO5G/ADhB6tAts/9/BkrQi3JxHAt9V56rMr/jeFugoZ0gAL
         uotSNCSR/w21CsUT9jl2PwVmmLzQKrqx8r4+WFjE4U46B8rhwp3g1GtBeukDWSgRYbhB
         ovw0/LZ8luxxgjwfJGq06jHf7BSVVbt2Ix0lCK5nl/YZEwyPVIBO9KNZjhlnV42Gi3nG
         jtDowFi6mHhv1U1dftuGQ3XwGrpWw8K1wgT6rEqEGHdzAK1zSisha0T3ihAEs94v1CRm
         y8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160361; x=1712765161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV/NNd6hDWilRoyKQx5/fF7EB7lNZqPai76qYnei/CY=;
        b=fsYCz0qAo5xbL4pPzERiRX+GZnQW1Sq/VVodp5CMkphE4YQAdjOj5nbfOTT7PcXPc/
         eWqWMxGQrQuzXHds25dAupR41MNsq9U4DhH3kRwT91+6/ap95r8s/+dTfFJsStozCEJK
         YCLRXTp/7vY0i6zVtwtbZWMv1VXMpmBmDBKAaSopjuvh1E1o2y1ESv/bgz7tAaQ/n+mo
         GqOzOFbFquKmcbBqnPoRTSLhRMOgVEcoRhNb2vgoQLxXH3mHinSfTH+Yp0M8nGasFidk
         QzF56mmShaON1GkGMHj2dWABDV/sdArG7Xp+3VbpIVGfnADYLE6+ikpREQsHFjKwIMZ3
         QY8w==
X-Gm-Message-State: AOJu0YzbWpOdzHWmmcfb39kGfFwZ1vwntdpC/4/Qep4Zd1Wa2qWLldfh
	3Mnr1dQHGvSGUkH6QRpOHGrufSH4rDSYH3XC9T5VkK8jS/M623bW50Xf9U12
X-Google-Smtp-Source: AGHT+IGg0mpTucwGNVSb/jQnoVOO9xzsW7gLhOWC1N+ehpkhDQsviEUGYK4ZAn50u6srl5R/EKmVUg==
X-Received: by 2002:a05:6870:808c:b0:22e:98df:9a2 with SMTP id q12-20020a056870808c00b0022e98df09a2mr2151687oab.8.1712160361499;
        Wed, 03 Apr 2024 09:06:01 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/14] data: Remove AweSIM entry
Date: Wed,  3 Apr 2024 11:05:26 -0500
Message-ID: <20240403160557.2828145-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has the same MCC/MNC and APN settings as AT&T
---
 data/provision.json | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index 77d5bb977254..6856ce0f0eaf 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14425,30 +14425,6 @@
       }
     ]
   },
-  {
-    "name": "AweSIM",
-    "ids": [
-      "310410"
-    ],
-    "apns": [
-      {
-        "name": "AweSIM Internet",
-        "apn": "NXTGENPHONE",
-        "type": [
-          "internet"
-        ]
-      },
-      {
-        "name": "AweSIM MMS",
-        "apn": "NXTGENPHONE",
-        "type": [
-          "mms"
-        ],
-        "mmsc": "http://mmsc.mobile.att.net",
-        "mmsproxy": "proxy.mobile.att.net:80"
-      }
-    ]
-  },
   {
     "name": "Straight Talk",
     "ids": [
-- 
2.43.0

