Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2712E1ED
	for <ofono@lists.linux.dev>; Tue,  6 Feb 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236743; cv=none; b=B6n3AR9jsmVtaFZYxiCZ9DpwteJE3hXLZOLt8pz5Z85hZmpoovz3yZcLkBXSNh6xbTEbFFHLm9/jmyQTSMqNAeMM/mbp2KXqRrz/g3jkxobnJ/ToRfL+oQhtuxuLg2MJj2BYj4+ISkcn0NtgorchaKUtYgjHCvhLuuQkLRE3y3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236743; c=relaxed/simple;
	bh=EctR38hWmVQ22lZ2ySxZxXtB7Q0TEH4VDE0n0pIeaR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiuMUxx+BYgL4W+RmDO7e0eQW1Do4rKNsqC/GhzbGQ27zJGXUSb5zOMsg4W3M1pxCCC+3zG8SVEj23iRLkgMyGfbPrXpXh3fGA1ZTBqM/YuBwt2odYU4SHJ4D1gOOjZOaBlyA8+1bANvk7cBHGqewngt2mR5JHWZ9Nb6Wm4rvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw0sQ6Tk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw0sQ6Tk"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2185a9966bcso342682fac.0
        for <ofono@lists.linux.dev>; Tue, 06 Feb 2024 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707236741; x=1707841541; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBRg0c6kDD5rNyqIQKpUwD6kwD9qM4sjcS7vm29xFks=;
        b=Rw0sQ6TkPAypelJGArndVodCn/ghfhDIZrmpm5142AL8O8ebedqyLuFNI76XD59nmJ
         WkXyFS4aTy0cUe3E+K4B2NkLmNFxANnTZKKbXJ4qOHLng02LXozKjKbk1PMsqdu6TdZR
         yCik8aFLSWpSBREaKsLqfq6oDickp2WsVuWCC0oB3POwFrd6mWm+HVVns3z/g4Y+/3ve
         OFu0os5RmG+tLs4lM/98gHTRPhgsYH5H7CNvRG9OQ2h2Vm2fYjjWG3tfBgkuiM+DfSQ9
         m/BmLm7EUCg4iunbcWvva7l8mqgkIcHUQx6+jIFJ1fjCNxBZcfYVLo+NdWs0xUPnOADf
         GL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236741; x=1707841541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBRg0c6kDD5rNyqIQKpUwD6kwD9qM4sjcS7vm29xFks=;
        b=REV7R6MvohKGpGktzCZNnI/9uQJTg9m5dADXIQQuG0ckwA301V4TtTko8Sq6V9vUQ0
         cFc1AyiCRk+EpBWIdQGhDW/A58Y7GhwET3abTYqCX6bX5ZzlkVdBAfo+SEFBbT/NNqsQ
         An2ufCoywEs4qc8VMOvaK+pvgosAuo9qIKq4V3+3sN0YNLphfaN5fe2o++ijC3bU12C0
         N1F3ZYugLz+OCWy/MMv7LTPsiOS79aWWuOB5loObY3vhWUDm3Eb2L4glJlb1vtUnLLEi
         HnbRthqT6OjpTvR1cthPWANK92msZsgRlfy26NaaWUD39BwUvZhobSiYxht/HII3pnSi
         nN/g==
X-Gm-Message-State: AOJu0Yx7e3P9di3TUEIFTWwa2Z28GitKtZaMs95jxN4sxYW8v2Kb8wUN
	59SuItFr8MByAXK/bbcMcpImc6F8qU4YUK7k6H2hMdcrk1KBHL7SUtbMtwLJ
X-Google-Smtp-Source: AGHT+IHX0dMR5gPi9GqL5DMhzxJ+Tx22HY/ivY93oasd2WFMIIPHfE1T3+QUtSQK+cT3EOXIcE3oUw==
X-Received: by 2002:a05:6871:e41b:b0:214:8734:1345 with SMTP id py27-20020a056871e41b00b0021487341345mr1564764oac.7.1707236741083;
        Tue, 06 Feb 2024 08:25:41 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id td21-20020a056871879500b002193f59fd55sm490845oab.41.2024.02.06.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:25:40 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] build: Drop GLib 2.60 requirements
Date: Tue,  6 Feb 2024 10:24:34 -0600
Message-ID: <20240206162453.1024228-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since g_utf8_validate_len is no longer used, requiring GLib 2.60 is no
longer needed.  Drop back to the original 2.32 requirement.
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index b866e5487443..237496e7e772 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,8 +131,8 @@ PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.68, [
 	AC_DEFINE_UNQUOTED(HAVE_G_MEMDUP2, 1,
 			[Define to 1 if you have the `g_memdup2' function.])
 ], [
-	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.60, dummy=yes,
-				AC_MSG_ERROR(GLib >= 2.60 is required))
+	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.32, dummy=yes,
+				AC_MSG_ERROR(GLib >= 2.32 is required))
 ])
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
-- 
2.43.0

