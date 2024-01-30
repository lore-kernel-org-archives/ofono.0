Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50571B48
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649749; cv=none; b=mjhBLLIPcxrYKwDU23FtZ5wgzILJ2bQlDPstYnlS0NjueXb4+NZ1E03EWKkz3DhrOoxNGfzxtDI8VUGqWProkuogMLTLmg3NIBOZkSAB5JwKW3H25PAKKpdB69tqmwCfkeaTRH/7F6PaP4h8DA1VZSXk3I0gEk4Mv0uz/XMf//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649749; c=relaxed/simple;
	bh=hyPteJ2jqQQhUP5+JZGTuesBhi4L5h/BiDZrMdVQw7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8z8Ca6iOKRm3I1qTRyCsinL16egojaxe7O+pY3dvHcUF7w0BmFCYJgWABeia8pgg7ZEqAtAXEie0eYOdhmIOIRJxHKUMrKuA7LU0ZgSo6FPB35wIr5yv9P3l3v/vp3BQSHyUwoIyc6aP9Y4aw1IArZi3XGy4LpMqk1gF3+QhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiWV9q0+; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiWV9q0+"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-214d1139620so1286044fac.3
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649747; x=1707254547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td95VSf+KXU7eik86JTqU2W3lIsWJfE2VRdq1kJg8nc=;
        b=JiWV9q0+SBU7sYGlKYo51Uxrc7ugWy9RcJoMtf7WJm94oidfsOJc2hsmcG4rQ1aN2D
         gjm333+hH8GI95/0Z0OBh1geRnpbEQvClNJmjdkKV0Gv33Y3XMuxoth7SHYlxDXYGRwC
         nl33J+McoW1KoTjHHJMQPDgFOdAOYLpbDi4UbsN1QLAbq8pn4aLIIzJmKaStcgRtMVUD
         dORVF2LGOfOJdQ2pwUlAz5bmfBAwhkfP5/zd6hyCwsYZKJU7q5nnTWHyGSvBQ1YQk/dI
         UEuSIDkG4UYG9CrSLAZOtboqpPVtnKp0E8cP/JmFIEPKkJTi+Wi84eVsJOuUX1YSXOiY
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649747; x=1707254547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td95VSf+KXU7eik86JTqU2W3lIsWJfE2VRdq1kJg8nc=;
        b=PJ2wr86ko4clpbVRa9+LdXgpxVcAVu5LHhKIzGx48pigDK6d6B9INy6WnPZyognZuB
         LHY+Dc2vEkDTpks/ou65kz5UJ+NF6hEYZbVoRMhfBffTsTt+UiyXdDzTg7SwSVwI6xJm
         mXD1WrsyoLnejvjTvshOKO/9EVy9I7r3qlAFLgjOSb62ElXmJ+dDte1NfumzLiZxQjc2
         4Q+84PezI9A4J5qkzzs0Y88MnSipz+N9uiUawEd6gIykrtJB1wq7KV+2mpYmuHUzxyh4
         xZ8+czrXJkrYTCoi8T4+of+lbuDFtd81M7AKpIoNKLQAEWjBBXSiHN6G05qmEexPrITY
         JJKA==
X-Gm-Message-State: AOJu0Yyh0ZZnB+KjRwTnuV+KvX1Wh+eHagTHGmIqPNF2JD4wKBZ9WctL
	kGh6codoP0NBAx7J12VdPI30+3iM+/Bzg5WvF4Z71K1U+mspGL7xjttcS0tG
X-Google-Smtp-Source: AGHT+IFncILvXeARyNTNVEV2ThSUA179G4pEMezH/lMMiKWaMNHLSLt6hLp5ZKd7l1j3TGqvh+JJQg==
X-Received: by 2002:a05:6870:65a2:b0:210:ad69:e985 with SMTP id fp34-20020a05687065a200b00210ad69e985mr6735628oab.51.1706649747090;
        Tue, 30 Jan 2024 13:22:27 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/17] provisiondb: Remove some duplicate MCCMNC entries
Date: Tue, 30 Jan 2024 15:21:09 -0600
Message-ID: <20240130212137.814082-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 provision.json | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/provision.json b/provision.json
index ae9a08482254..77d5bb977254 100644
--- a/provision.json
+++ b/provision.json
@@ -14145,7 +14145,6 @@
       "310070",
       "310080",
       "310090",
-      "310090",
       "310150",
       "310170",
       "310280",
@@ -14153,8 +14152,6 @@
       "310410",
       "310560",
       "310670",
-      "310670",
-      "310680",
       "310680",
       "310950",
       "311070",
@@ -14309,7 +14306,6 @@
       "310011",
       "310012",
       "311480",
-      "311480",
       "311481",
       "311482",
       "311483",
@@ -15038,4 +15034,4 @@
       }
     ]
   }
-]
\ No newline at end of file
+]
-- 
2.43.0

