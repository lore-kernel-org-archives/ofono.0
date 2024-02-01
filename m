Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C32B9C2
	for <ofono@lists.linux.dev>; Thu,  1 Feb 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820302; cv=none; b=EiVFQKQy8+C+y5vM3XEpnH/5McB7l8LLbOYyYZLIqYZnbyMfhLXaW36zxgE2lK+SAAmpZQyWZmMoLIs7MA2j9dDyZw6QVQr5ybgz1aa7ZEgQntX2mEHmPQGw3FDxC3LGzPb+/LWqXCmTt2pUYrgwP45FcNgEWN/QRNChWN/+4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820302; c=relaxed/simple;
	bh=kgJdM6fKyuuW6fQ8vFUKAruTlkxCnfUQCQ3PgLIUYRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnuHuy2Bi6SjeJD8sIpa4ZHkIfaCZllE7Zo6lAn7w64KLF+zXF6xAUnlooQnQjmxoOTmJH1vv0qatIeMUAB1Srz1N9a5jFBnwyubHEAkgbAVKWP/77p7Jm+tfpQOAxx/alO1MpdAW4lfIN2vtK501HJyf8hme3KpmgexkWFnrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw8/EMs2; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw8/EMs2"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3be6b977516so944253b6e.2
        for <ofono@lists.linux.dev>; Thu, 01 Feb 2024 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706820300; x=1707425100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jF9LbRiHbtrnhos8mhQ+mcn+AJtqtZlJDXxvP+hFowY=;
        b=Yw8/EMs2zwlr761xBOMixLSVDktvC3FDSbff3ZcLAwF+rvWjqlsNkCUoYLGhkLlPxm
         g/R7PvpLcccZAgoPj7dj8Ked+wAExahnledJN/YKCtJa/Yg39lyHAi+fKIDy5YsM+3cs
         RtUZC8dh9eeGejJl/3e4hn+NOJqW256diNH1lxwc9ZPtOqalwzsC0+CmJZMjlu+bw8mM
         T63POgW9c3yfkjZcQP4dXoQLck1wqL7QSUc8pYl1MJDZFUbeokZfcu7ILQnvbI3Jc9sd
         C8uRLBSR8CJrsrMwR7tgAYCCFtPiYfk8Y90B3B1pA1tF1d522EKAyNwg8dtOoNjmEDfn
         xd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820300; x=1707425100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF9LbRiHbtrnhos8mhQ+mcn+AJtqtZlJDXxvP+hFowY=;
        b=gBV+R/TOBRhQwmPVdKqEDDFuDBGgyP5NsZtupO7S10xuHTGz6OArvNtCciBFpg9mfN
         lpZ5Uuto4222QfhVUwrrFqQjtucAgGkVPeSzW3nnaLT6mgu0mGo5W7ek+NteyP7R1lgv
         fCQbuA2yFjp0jZL7tH8k/heZJfkPdm70XYqn0z6gLdFtEz1uErY61Gz+vuZOg/nOcNDg
         ojEGdzFtSawyd9ehdPOhs98v0L18wSTC/NSpWkLW5Xx0aep8h8SsUYlw1+x4GqjBAWHG
         UF/1YgYIDsbx4VNTO1aXS4I9IajLSvwY7hboZIm1bBiEVk3Zbzrjjmcv/QlUI/BY2G0C
         D6lA==
X-Gm-Message-State: AOJu0YzIuYNET8LQ/+14st787pKTpQU7eaYXt2/KCpjdpXEjVf/vTjxV
	7dEx3J2l7yUVbwAOwXcmLrBpyYNT8xfzbZqJVmdDnuDlzZNIaU9Ej8KLyo1q
X-Google-Smtp-Source: AGHT+IHlaiS2z9yy7Xpbhk21E3nldwxIJNICl2seUMezOcpbwBnqQtIKZTr/GscvVjdPM4QHSpLN1g==
X-Received: by 2002:a05:6870:c0a:b0:210:b77a:c3cf with SMTP id le10-20020a0568700c0a00b00210b77ac3cfmr3774774oab.41.1706820299659;
        Thu, 01 Feb 2024 12:44:59 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id os11-20020a0568707d0b00b00218e3695b3asm115907oab.51.2024.02.01.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:44:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] doc: Prefer l_new instead of g_try*
Date: Thu,  1 Feb 2024 14:43:59 -0600
Message-ID: <20240201204412.951617-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using l_new and g_new* variants for small allocations has been the
preferred approach for quite some time.  Update the coding style
document to reflect that.
---
 doc/coding-style.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index c27a2f275565..0ec1cd97e8ca 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -155,15 +155,12 @@ for (i = 0; i < 3; i++) {
 }
 
 
-M8: Use g_try_malloc instead of g_malloc
-========================================
-When g_malloc fails, the whole program would exit. Most of time, this is not
-the expected behavior, and you may want to use g_try_malloc instead.
-
-Example:
-additional = g_try_malloc(len - 1);  // correct
-if (additional == NULL)
-	return FALSE;
+M8: Prefer l_new when allocating small structures
+=================================================
+Small allocations (less than a page) in userspace Linux applications typically
+do not fail, and often there's nothing meaningful a program can do to recover.
+For small allocations, prefer using l_new (or the GLib equivalent g_new0)
+instead of g_try* functions.
 
 
 M9: Follow the order of include header elements
-- 
2.43.0

