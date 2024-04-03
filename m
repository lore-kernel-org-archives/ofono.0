Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63014D2BE
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160368; cv=none; b=BrZ+sSAphV2s7Mucbj7Lwq3JtkXHXxI1DlFZtdbDhTT8hVAb2eTbKGPPPuCiTnxBgo/g+TrVXAn0mej68jf/Jtb8UWHh5/7uMdf4WzuPC6CBnBMXt88zxLyIks62xcoyar0QGykiwg/c3Zu2OrHOOFgHlXiKaVaRM1V51ryXrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160368; c=relaxed/simple;
	bh=s0Bv3UA2qC7Y73LHPGb39vKsBvBr50BYguKrJo3XPNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZma0RgFQ1lAcZtN0brTwpoGtoQhEXSQVkTTPBkQlbEvYH1QDgbLf08D9m0ClKceB1CdQhQTJwuOaBwnMrjaXc290qgaPo+eWhLBvXKH8qHSiUKPwvQJ5KGjd93WC4pClcjiPkdg66Q+MrDc+bf52o8U1oLT+8j2kz6CAhyrhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYMKQkvn; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYMKQkvn"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e89b6daa1fso12972a34.0
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160366; x=1712765166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt4wRsDcMGIHHM1uJUmPeebowvVE+1VhfzJeay2c9Qo=;
        b=QYMKQkvnXCQ6hWi9gssxFhi+NVPeEc0V5vYfcFhw6esMGu1lNBe83WVNEMA9sONC1n
         GUPHh00ueyXB5agPx9fviMUlnW7us89qbNfqPF/6X1Nqx8IcBbyWDcxd8BJaHXSIG4DN
         o19v7ddWPep+hXHm8i32EYXSfT637g+Bz5CZSxptx8JJ3PpfLeEaTny/pu8TmE388fvU
         wXA3k6gPsSVJHTkLNUOKbCEYV7HaGVH/MmS2HypNHXI+zb/5YR5xRfLjwH4t4asronq6
         oy5iHlo5kfT+Tt9lwhEqH7eh5bLagGEkxq1EWwAdlwBW0Wylhnmj17Rlkd8rPxYTzt92
         Pe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160366; x=1712765166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt4wRsDcMGIHHM1uJUmPeebowvVE+1VhfzJeay2c9Qo=;
        b=aRTCCdD94rSPsmyrIw70Hrzfcl0FtYH0sE7jBphAo6iZgLRKApcU1dBDFisicwj0cJ
         4agQJLOZOdyGi6SFPLVOt4/1zT2k0YqVyhUj3deS3MmSuaWqu3RmmpnlhxwKRoqonEdA
         ThdXL34dZh0P9eEBIZM/PeRDqWa+Z7IYbZyMALa/Hu8kSwh4pLqm9pTNF5TI3eK8aURF
         JPYYHULJDkggLmwE1eixgbj+dVahyjLkkBYiVq4AYZgXKLaEdj9GXv3yCYbxh+M+eiyn
         qXei2OvxTiBTR/p+6Lo9FA5VY/Gmydv6av8TJZJSlPfxr+pfxPC/B2Iqmr9siYgnYZa1
         E3uw==
X-Gm-Message-State: AOJu0Yz2F/NZMbfE/OmVE0rkw29+WCw29gvcGGvvli1ArMx921OXZ3zI
	RTQQcSi6/2PHiFTTfsB9TI92KVtm0vXz9d1DuS9KmQhUw6QG2hTeq5L9Ftty
X-Google-Smtp-Source: AGHT+IEdSqkhuwP6M3/9Rfw/tkdq2BB3+lx+Dca0sEi0FLy7FtNq/A5rbyEXDjBjDKoSFlmLT+iL3w==
X-Received: by 2002:a9d:5e88:0:b0:6e6:a1c8:d035 with SMTP id f8-20020a9d5e88000000b006e6a1c8d035mr16925395otl.0.1712160366209;
        Wed, 03 Apr 2024 09:06:06 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/14] data: Add tags for AT&T and T-Mobile contexts
Date: Wed,  3 Apr 2024 11:05:33 -0500
Message-ID: <20240403160557.2828145-10-denkenz@gmail.com>
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

AT&T uses several APNs, one for lte/4g devices, one for 5G capable
devices and one for M2M.  Use the newly introduced tags field to tag
them appropriately.

Similarly, for T-mobile, add "iot" tag to the iot specific APN
configuration.
---
 data/provision.json | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index cef6e34e1ae3..434bfd8d8f7b 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14169,7 +14169,8 @@
           "mms"
         ],
         "mmsc": "http://mmsc.mobile.att.net",
-        "mmsproxy": "proxy.mobile.att.net:80"
+        "mmsproxy": "proxy.mobile.att.net:80",
+        "tags": "lte"
       },
       {
         "name": "ENHANCEDPHONE",
@@ -14179,7 +14180,8 @@
           "mms"
         ],
         "mmsc": "http://mmsc.mobile.att.net",
-        "mmsproxy": "proxy.mobile.att.net:80"
+        "mmsproxy": "proxy.mobile.att.net:80",
+        "tags": "5g"
       },
       {
         "name": "AT&T M2M",
@@ -14187,7 +14189,8 @@
         "type": [
           "internet",
           "ia"
-        ]
+        ],
+        "tags": "m2m"
       }
     ]
   },
@@ -14216,8 +14219,10 @@
         "name": "T-Mobile LTE",
         "apn": "fast.t-mobile.com",
         "type": [
-          "internet"
-        ]
+          "internet",
+          "ia"
+        ],
+        "tags": "lte,5g"
       },
       {
         "name": "IoT",
@@ -14225,7 +14230,8 @@
         "type": [
           "internet",
           "ia"
-        ]
+        ],
+        "tags": "iot"
       }
     ]
   },
-- 
2.43.0

