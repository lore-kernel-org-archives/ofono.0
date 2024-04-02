Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B7A41
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097063; cv=none; b=fZnwRbU9KC4xChzZQNibj4/slHFtdaZhoxyU3sOaE3Xf1rWYqX6lpJ+AnH3oZhOdOmU87O/TeH68TFLuVyd+t6Fjdra4e1q3bsEkn0zTudLNrDAIuZuNJOPQ7V0awDj2kE4qrfzrLGSTdAt7WgWqW53k0GuMVY5YuRR8vidgJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097063; c=relaxed/simple;
	bh=2jtwPV/0aXzMV9GYqTuankIWt+V0Hg7TZhCy2NTuGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GStd3lKWgN/BJpIAc4QY+dOWYnjVDm1r4979kiyclkOHF+06tl8+JFASCSGgk3Uj3G/iwCjwzHKnxBv/Dua9bJ5pyJO+i4B8NraSvJV2SdiyXjaTyMaUjGk0oM+JYzWJ4ES7ZX2YLIKkGNhe++nU3LN9WQyaTbxz+bBAmE6wa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cntPhSv+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cntPhSv+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a467dae51dso2267763eaf.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097059; x=1712701859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV/NNd6hDWilRoyKQx5/fF7EB7lNZqPai76qYnei/CY=;
        b=cntPhSv+glEG/64seBSAVZ0q/VOe0xvwLsgOi/nbWsUOt5LK5/9UnqUzNXYkS4A+2r
         PKC52ClXKsBsOZnjm3BD2LPOXE367ZYcGL86211piIaRSCvWYqqvo/DmbEWL2CzzdPt0
         xWPlOdn/RKgVJp7wQ/SAtGTdig5GA14/0kGZiuS5lmLn10NYUNx8HLebNC1D+DO05Spj
         KttQytgen1wbcHSt4GmP0QWX8e9K5TyVIHtD8MWqUfUSZ98l3sJrS+ULNZKkykywyfYQ
         nQAsdL1ZMQwciScBiENiC6hid2K6b0USoms7eneq31mVa2iyHPLAOfFHxnAwcZMpdyG+
         +Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097059; x=1712701859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV/NNd6hDWilRoyKQx5/fF7EB7lNZqPai76qYnei/CY=;
        b=g1dO2oetuubDxL9U8i0B+hcQ+ckbt8RkT5doNOAzH6ZuvB+LTy49+C6vumMcZtgJ9q
         nMcPYxrfZil7JBYA03samlkiOOnSEwyCv/sLvowR+vz62t66xbyKKPY3Cr+ROtekK4DM
         a4T8LsXB9ZLigypGBYbJlg54SLkdhhhUCL7Bw1iy2UrgkkiCCeWpWh7lOAsVElJywWvf
         k262HTO1kJCq2KLaxB9vTXUKA85THNWOAlOLMpuyNOHUJdm9ETEJQEkvB55Q+RJijKIl
         JoNH7jcerynxZHmjHmwY3iZb24s95e/mGdWBV1fPbzM6bxQ+LM8bZE/5SVRwVjjBuGmz
         +2LQ==
X-Gm-Message-State: AOJu0YyGkLaGLjUXhCi04+UuJZeKa9EO3oxUWAm3hd34/1gLfAyyeLQQ
	UUMT77xyCqEGMO8vS73jaEql23etoGifg8gmqIK24SgFl2tHoCknVneCPlW/
X-Google-Smtp-Source: AGHT+IFmMLzjBLH1KnBBEb2Oug5rhxxkVLZ16F8rARyLv03XLuIQ3zk1NcjjNWdfVnt4fDP8HpBnZQ==
X-Received: by 2002:a05:6820:a05:b0:5a4:71b3:d090 with SMTP id ch5-20020a0568200a0500b005a471b3d090mr13096694oob.5.1712097058477;
        Tue, 02 Apr 2024 15:30:58 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:30:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/13] data: Remove AweSIM entry
Date: Tue,  2 Apr 2024 17:30:28 -0500
Message-ID: <20240402223054.2819526-3-denkenz@gmail.com>
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

