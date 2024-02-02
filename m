Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16912C80B
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914505; cv=none; b=MMNa6amXThk/sDnTiNibKt9bsC4Aw8WaTtMpfUsJcAGOWN5BxcZVNV7kJeQ2+7wXDrLdHn45uMgwdBfe5bC2b2VjHxl1n91Ev4EK1/46lRSPheUeKMjqRonYHEjppUupRoXUiwqm0vlJCG0F21Hoqwfd8YPoZHf+iDAvy1jLc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914505; c=relaxed/simple;
	bh=gMqc4dy0hjylmgsbxIg2lYpH5Re5rsD2z2eWAoVbBTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyh1raIwLhdnAS1SOC5L7TmhcCu3tfHmj1LrcxeD3tZdec99xfR7nKiPU7U5h3pa0DJqzgD7jINefAIn6ctS1mpOPbmjiqnnlAl3r1Jwb9Wa85BRTEBjZagFxluCbdxEhotkL4DOUUOhBBlL5EDKaLPohFd0Ui1+ztAscjMFdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ/FVqeW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ/FVqeW"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e117e0fee8so1373189a34.2
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914503; x=1707519303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YEJXClJXndANP0ft48gNZnomKIqyKfHWvhmCOVS8MM=;
        b=TJ/FVqeWKO3ckzezBY/VXQTsYxJxTNyQizIzYpK1Gl814zk8M1Wi4EMuWPcRjwWnPh
         coSkED7JWtSTvGeReb9mx6U5pTYP96mkVaXBQoI7S4w+QqPGDuhP5pWZjXclbNkBj993
         dMycsFjoE/dMGIntYfPMPxd6OnhpPlXP2s7GdSWUt1juDdY+PvsuLPGlot/dv8r3n9Wn
         5/h/1/d6c+HJaqgcZb+7YeUaAgn9wkllVXm+cZq5z3zYbHroE6R53lvlT6mSxD6Hd+HN
         2zHz50u6EXKEMIyYHvD9EW6UggEBWIWXlPHden7sRWPBGGN/beWFp/EQb3JPo6KZoEKA
         NVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914503; x=1707519303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YEJXClJXndANP0ft48gNZnomKIqyKfHWvhmCOVS8MM=;
        b=KFpo5VabTurCqNOzPHAiTn8i2RkBO0lfwVAJxg7/X2sPJv1vSYvEiKJgN6peRk0jp1
         NwWqPjjB8WC1H5LCMM4SsLHSRCY6Th0muK/YRsnvS3fJUsNPlis1sb20UhgZsrqQk5FZ
         Zp4XsSTtoTCIudzAf2YgH/xuOrvbJrjrGbwfEKh8aWmm3nFJnblX8VaEDSk0LsQlEEEW
         VDfBnbN54nbuXswET8Im0sgE52yDeqYHlWfq1fvJtDZALZUNzCJ938j/C+JZAc+SEOlG
         pGqmbIU+jCb924oZx+DMBbvE+EmH9pdqOiAPaz5dcRMOZtfOBoZZoXFTHX30DbnxwmLH
         Vktg==
X-Gm-Message-State: AOJu0YzWzAgJFehw9dKiu641ID9FvmGjZC0dR/EDx9AsYgbYJGmOqubQ
	ZjIK7JuezcVu5C1OuqytZmGLugmKK0ZbhYD+/7L5rfbD9bj1gmk3dSQs6/hG
X-Google-Smtp-Source: AGHT+IELINjMmbEYr8O1rfYHCnb6VaID9JqnFOIBO3qP72pneXjbBAFb3yqNNqZTlbPa3gHoRK8/Qg==
X-Received: by 2002:a9d:7302:0:b0:6dd:ecaa:3aea with SMTP id e2-20020a9d7302000000b006ddecaa3aeamr10773211otk.1.1706914502941;
        Fri, 02 Feb 2024 14:55:02 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:02 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/18] storage: Remove mode argument
Date: Fri,  2 Feb 2024 16:53:44 -0600
Message-ID: <20240202225405.993792-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

oFono should be making all sub-directories in STORAGEDIR (typically
/var/lib/ofono) as owner readable/writable.  No other permissions make
sense.  Remove the mode argument from the function signature to make
this explicit.
---
 src/storage.c | 7 ++++---
 src/storage.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 47429c22d1bc..1b761c4ce57a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -47,12 +47,13 @@ const char *ofono_storage_dir(void)
 	return STORAGEDIR;
 }
 
-int create_dirs(const char *filename, const mode_t mode)
+int create_dirs(const char *filename)
 {
 	struct stat st;
 	char *dir;
 	const char *prev, *next;
 	int err;
+	static const mode_t mode = 0700;
 
 	if (filename[0] != '/')
 		return -1;
@@ -133,7 +134,7 @@ ssize_t write_file(const unsigned char *buffer, size_t len,
 	tmp_path = l_strdup_printf("%s.XXXXXX.tmp", path);
 
 	r = -1;
-	if (create_dirs(path, mode | S_IXUSR) != 0)
+	if (create_dirs(path) != 0)
 		goto error_create_dirs;
 
 	fd = L_TFR(g_mkstemp_full(tmp_path, O_WRONLY | O_CREAT | O_TRUNC, mode));
@@ -204,7 +205,7 @@ void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
 	if (path == NULL)
 		return;
 
-	if (create_dirs(path, S_IRUSR | S_IWUSR | S_IXUSR) != 0) {
+	if (create_dirs(path) != 0) {
 		l_free(path);
 		return;
 	}
diff --git a/src/storage.h b/src/storage.h
index 76069949e747..46efd2d1a208 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -22,7 +22,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 
-int create_dirs(const char *filename, const mode_t mode);
+int create_dirs(const char *filename);
 
 ssize_t read_file(unsigned char *buffer, size_t len,
 			const char *path_fmt, ...)
-- 
2.43.0

