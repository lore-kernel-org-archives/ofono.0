Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CA78B5A
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649754; cv=none; b=tgcPUQC97bpGyHXMRyVnkgnw1FJtzQkorPjvwADFL/sg2syM+iHEHoSDSqvWjOmFk7u1E9FSlMzmVidn4ng/ABkzKuXtQBiViuUu3ok19P5Q/sq2EwZ2INeIm55Xuww55KCN1ZsidKnmZ6BPkJXXsCORbhUS+t7Kgz9qCzKG5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649754; c=relaxed/simple;
	bh=Ru9cnxY5z7jn1+SaaalHqbxHAuR5Dfg/n3Bmt3Es1pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWZrcltACwl2L8vhaeTvTmrT5pbp5qQ8bENxil1mLU4663bYpghRDz1NbUnv0oy03Kc2JsXbsrtB3T8osMOX14lWvBvdmNynSyO3il0U73aUKIQ7EFvJJtwFK/h+AQO2wZOZQEq6wMzMUvqNs7JZ8TqgAYtxqnr8PR2P/a4n12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2I4gmY7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2I4gmY7"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2187ec01d6bso1903839fac.1
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649752; x=1707254552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b/xiaWHOZdD9/xLRCljPPRZg717vMewN+EC/KiIntk=;
        b=Y2I4gmY7sACHBJO9eT1W8BC5gEVcIyRviCWz3AfhS+MzOW2xg746T0BV5ybdmEckFb
         aIyzFQxj+tUkdO3UZxZ0yxS096MiJKhT/Ajia3m0XIqLl7/VqVauzCZiVCFHHSy9A0KA
         jjnHvuF4nzn2vZq+iVY/1yW0oqaVNoNxwaoD5oy91mvh25i+17xVUXcM2INHH6giZm0G
         2qfxjU5YHzNksgd6GTVUHwSXxglXWedktrZi70WU/TqcaSjKiaYGDn+KSLm8s0Pw1AZe
         Psg6+LRzpCuVU1iXOku/fByYt5eldPsi+HJjZ/N9wyrPD53SCbR3c4qImWT4vdH+4gRK
         xx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649752; x=1707254552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b/xiaWHOZdD9/xLRCljPPRZg717vMewN+EC/KiIntk=;
        b=IccmFJVZPTAkbxbBv/BIBrPH0ZyMOcD7TptmgK0hI57qqfdvHBQPIucw4qf+I1XNIu
         3g/Q0ir8oeORnWficVjEpn78o0r4ldV0gJIAnSZe6gj2nuSfWsy1cBnKUGHWkk0vFQeM
         FcJFEAQJFfJ++xU7amse2I7ydnhVJGTAA2+uVDxRgmfh+Eh0dTLyfu1svlq5UmeJzNZI
         ekciQelzr+LazQQICyxlXPttneOVEVM4iX0Cd0KjmlQyYhSy2kaSYrkzimDhCB84Sn6f
         l0sgPd6pGIRnr+ykVzd9L2JaL7HJDkCxzv4yL84319qm+pIMuJ+2RCN8NurZfNa8TquE
         5ewQ==
X-Gm-Message-State: AOJu0YxwLlQfsltoC4hpHxvPRznYUIzBhEF26XWjvUSrdG9TdbXrZYOT
	oiasXI4d9YB2tA6oSr8wFo1rptDgwwOZwRvSeYwTmD24x4ctzLZ1opJG6Rfx
X-Google-Smtp-Source: AGHT+IFZfWdUvFNzpEi63mZTChQl+kC/up5fNlKtWQRHexvs2prIPBCuvb+mW2EaCQKq35Xtrxuvww==
X-Received: by 2002:a05:6871:6ac:b0:210:b5fa:4977 with SMTP id l44-20020a05687106ac00b00210b5fa4977mr9296459oao.52.1706649751792;
        Tue, 30 Jan 2024 13:22:31 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:31 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/17] storage: Remove mode argument
Date: Tue, 30 Jan 2024 15:21:16 -0600
Message-ID: <20240130212137.814082-11-denkenz@gmail.com>
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

oFono should be making all sub-directories in STORAGEDIR (typically
/var/lib/ofono) as owner readable/writable.  No other permissions make
sense.  Remove the mode argument from the function signature to make
this explicit.
---
 src/storage.c | 10 ++++++----
 src/storage.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 1c873474a927..f169195c8df7 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -37,6 +37,8 @@
 
 #include "storage.h"
 
+#define STORAGE_DIR_MODE (S_IRUSR | S_IWUSR | S_IXUSR)
+
 const char *ofono_config_dir(void)
 {
 	return CONFIGDIR;
@@ -47,7 +49,7 @@ const char *ofono_storage_dir(void)
 	return STORAGEDIR;
 }
 
-int create_dirs(const char *filename, const mode_t mode)
+int create_dirs(const char *filename)
 {
 	struct stat st;
 	char *dir;
@@ -71,7 +73,7 @@ int create_dirs(const char *filename, const mode_t mode)
 
 		strncat(dir, prev + 1, next - prev);
 
-		if (mkdir(dir, mode) == -1 && errno != EEXIST) {
+		if (mkdir(dir, STORAGE_DIR_MODE) == -1 && errno != EEXIST) {
 			l_free(dir);
 			return -1;
 		}
@@ -133,7 +135,7 @@ ssize_t write_file(const unsigned char *buffer, size_t len,
 	tmp_path = l_strdup_printf("%s.XXXXXX.tmp", path);
 
 	r = -1;
-	if (create_dirs(path, mode | S_IXUSR) != 0)
+	if (create_dirs(path) != 0)
 		goto error_create_dirs;
 
 	fd = L_TFR(g_mkstemp_full(tmp_path, O_WRONLY | O_CREAT | O_TRUNC, mode));
@@ -204,7 +206,7 @@ void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
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

