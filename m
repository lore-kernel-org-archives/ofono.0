Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862591B95E
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097066; cv=none; b=Hszb34V3f4GatDGwqNmoWT0qmmv2FrK2Mw3CtzXlqt4XZmE1F2YGjg6362nwx22g+zGywGs8F3Xeu6GF8t0eJ+r1Auxrqsm16azdNLdT26X+vUmqiAiknWctciFrzi70c0wN+cOvSjbW7rbDvBSOIEzc/G4D1HDKf+b1SRFmhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097066; c=relaxed/simple;
	bh=s0Bv3UA2qC7Y73LHPGb39vKsBvBr50BYguKrJo3XPNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrf7WDlZZnJPnZ9O9+/Quop7/jlZdbMU04bFo+KuXNVOMZzCX9CJ9i8DVsnLh4mawljtvyumoEWu2WqNOChCBs0S/xpqyZCYlNeidUkN+HlhFVpRGRKVCwvCdWHlL+/EFJZ2PUrBig2dQHWGsvI9nztwmomKN20BcSAyASkJQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDdYcCpH; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDdYcCpH"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a496fde460so3581086eaf.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097063; x=1712701863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt4wRsDcMGIHHM1uJUmPeebowvVE+1VhfzJeay2c9Qo=;
        b=QDdYcCpHDSUhpRrUkmEg8t3Bde23VlVOlkLgwL6RCvYrOAdyhTskKGhEirAgsIACAC
         p1nhMNYYI0jIYR/j13OS3Pi2uynXIAN6qCyHLXLoUk355DzjR9v9DBWgNt1NhAltQyvQ
         iNmn02eB+wc3+77hUCe5QH+avvuKHrFQ0uWn0RwUXLEQzRdy7wcoHrQRPpRy8iUyBnmP
         zR0eQS0YCHdEobXhIZSeJbpPkJ1QG3fLBpOBX0GkQAN9kYWfdOeKeYni2/M6vZRysKd5
         DE7q8vq+1wIwLLNJS0L4xnBYwh7GqKFe2HD8w/uwG4X0aIdg3por1WuH41ZkXTypsjMF
         Qvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097063; x=1712701863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt4wRsDcMGIHHM1uJUmPeebowvVE+1VhfzJeay2c9Qo=;
        b=MtKYFjjsJuXUMJjVm1PQL6lvWTP2jiB1FyCvkhU1SMyQOaA+/sBLAOOYOseGs/kNdr
         CSYkBGpZ6XK+An/xti5hM3vyPEu4R9b8BuWPEfQXBrxdjZnX2UiqK+MpxwQd4sFB0MbL
         JVVjHKrdlmc2nvFdhYSGR6qFiK3f9fgQ1zNOfelc3S6ipoQR4mJIZ7+zYzw7+CO53WvP
         5gRDtPGLpDqlBCyHPE5dfn6aSEQ0FwKJnEHw7r/fK+VnzduM3x85HRZVv4sx0hpeWyMh
         8GT8VBhKP+Y99+uwS99kHPklswSQ7E6P6hvqN6SP1cGMN2GrNbcRn0jvDQoZwLThAT+E
         bbsw==
X-Gm-Message-State: AOJu0YzC6dsXQEon8crqQN5KXuPLp4f8fcKX92Hl2al6dTWg8zbijJnp
	qXXT5weYw3wOkUabYUmax4bESvQnCj4xmDCowYOz4Sz4m4ngQ6LLg8vX1Hlf
X-Google-Smtp-Source: AGHT+IGKLcVO+zKfWxPVxcviHnY9dYj33oaytcM5CmkGLYqwMS/Nj/J6K6NLan2Rj7Q61fdfnfue1A==
X-Received: by 2002:a05:6820:2607:b0:5a5:27ab:189d with SMTP id cy7-20020a056820260700b005a527ab189dmr11289171oob.6.1712097063494;
        Tue, 02 Apr 2024 15:31:03 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/13] data: Add tags for AT&T and T-Mobile contexts
Date: Tue,  2 Apr 2024 17:30:35 -0500
Message-ID: <20240402223054.2819526-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
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

