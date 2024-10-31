Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A91CCB4D
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412408; cv=none; b=n1A4oUqnobXSJkzrJTN9DWZYTYPXOS+bZhJVQ4igQ3zT7rrUVpIdHqAuQVhLWNFX+zggqamJUI6/NUKhgi0vV9lQMg6wSWn5sQVf2MMLEFyFuAXJkvoPc113gjq8FtD55leiHy0b2AO/FaJ4DnOuQ0kaGtF6isjgXxU1OUDyIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412408; c=relaxed/simple;
	bh=boI1wG4U9fGqbhg9LryOgFjVggLT1YikhGc29SyY5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc2od3JtlZbKZJPGvjQrvBCJ3tpx/aQwoXTxCH5xujtCXdQlDNKuMSl7ImFIDLmd+rn4ytTzoWz2LYMcqvtDfaYWU4qIRtEFlC8gs1K+jWHZn4py8QdctvrGQGByawHqA41taO3G8tW43JW02+FA6Hl0ww1EQ9kJ5O5k3vauK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4eTt1fx; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4eTt1fx"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e602a73ba1so809208b6e.2
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412401; x=1731017201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI+ujphGKonkH/pnb7/SHybvYXL4ovkTfulcizxQDCE=;
        b=B4eTt1fxPPK434cVl1wDVrAG+Og5mCAkqNlLT9Non03S3Rtchwe/6y4/I++QC8ESY2
         DUa7nPX2olvwGTJvymdvpQSahcEce9D6BsPyIWcDFZjuRsqQXdDDkkfkP7s89rRiwVbi
         2pTrmZNChyVdS220N5b2PbQYbW24LwGaOW3Io2JjGTulIloHi8tfZUPWdiqyBTfcWH7a
         Goa2aEloHRK6vOTi3aCZK+ubQ6wCtvv018bMuwZmIBEgqpif28Mn8eybArTUcBVU5Uys
         vhEgkNv3i0QyfoXaPtF1LQElkWr4qbYtMxHZg1hRdLJzeJ8exgWNmy2517uEMBxBRw9F
         XIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412401; x=1731017201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI+ujphGKonkH/pnb7/SHybvYXL4ovkTfulcizxQDCE=;
        b=R//0Jt7l6bC3ki5cseAT1YVJ+XjtbUD3IuzB6+YMxcl+5TAk1Cu9+I1g1OKVSDM2uB
         6POcUhFH13huuBybn1/vmCjcQwr7YGUN3MNzG6sIdhObmy8ckTURa0Tw4WSRqz8mNud0
         aAlgMn2jXDG060QVCLI0rVMhOvVzcTHYEhBQsAhbWv9bfdMgCmoVHggqOiToKIi3DYSy
         5N0LDOakQdtcjEr3BKGyaEDh7qzdF3w7gdMP38WfytNm6u+KR1OE78BxyVM9d+9l8sb3
         Hf7fas99fsMhUSdTmxSbVjPVYWgHiFx9q8Rqinq2y2REKYeqhLP2vBH5Hr7ralb+b4Iu
         5+xg==
X-Gm-Message-State: AOJu0Yyj/a60hR0IsqetKAw3IQVIj7g+0f1Sa6iebVsAKT7gZwloI7mE
	VEpoOOe/wE8egYqW28tY6UqZ9PSL3j9jElBImonPTWQsVFrVKpWwIawb6A==
X-Google-Smtp-Source: AGHT+IHDkUxyDBHBI+dm0jFuvuXW+DZmmKzgu4gA/GzjYlRRkvgqY8MDiL02M85sYjYQLf2ZFRyJcA==
X-Received: by 2002:a05:6830:2117:b0:710:f5bf:c4df with SMTP id 46e09a7af769-7189b55edcbmr5167460a34.30.1730412401590;
        Thu, 31 Oct 2024 15:06:41 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/13] simutil: Return early if file is not found
Date: Thu, 31 Oct 2024 17:06:10 -0500
Message-ID: <20241031220638.1582166-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain Elementary Files are only present on SIM (2G) or USIMs (3G/4G).
If the file is not relevant to a given generation, its parent2g or
parent3g member will be set to 0.  Return early if the file is found to
be irrelevant for a given phase.  This also fixes a runtime sanitizer
warning:

src/simutil.c:1345:10: runtime error: null pointer passed as argument 1, which is declared to never be null
---
 src/simutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index a504e9aa8e3b..0fafcb7f77de 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1302,7 +1302,7 @@ unsigned int sim_ef_db_get_path_2g(unsigned short id, unsigned char out_path[])
 
 	info = bsearch(GUINT_TO_POINTER((unsigned int) id), ef_db, nelem,
 				sizeof(struct sim_ef_info), find_ef_by_id);
-	if (info == NULL)
+	if (info == NULL || !info->parent2g)
 		return 0;
 
 	path[i++] = info->parent2g & 0xff;
@@ -1335,7 +1335,7 @@ unsigned int sim_ef_db_get_path_3g(unsigned short id, unsigned char out_path[])
 
 	info = bsearch(GUINT_TO_POINTER((unsigned int) id), ef_db, nelem,
 				sizeof(struct sim_ef_info), find_ef_by_id);
-	if (info == NULL)
+	if (info == NULL || !info->parent3g)
 		return 0;
 
 	path[i++] = info->parent3g & 0xff;
-- 
2.45.2

