Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B3DDDC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918654; cv=none; b=WDJf5yz57O9pjxUfrkykmvjKpN6tFJJxDwt9+tw5C92W5d+Ov8yajj9xX9jkr5eXDfKkLVJ7ui6VgWJ8CYn5q35NAjIotSNr1DEJ+9DvrxexeUGRg4Iv6O+C0ufOxMtOLR4qzUB2psb0PA1N2jZsUmsKbybGbt/48Xw09bNUxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918654; c=relaxed/simple;
	bh=S+I/u2VrVVkb+ANFuNdZwp2N+X1UsFbl4R7TWkcN/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TawvgjqCIXMhCZteEHcr967jPtUj7rBo+cZldlImjrxlfyTdj21GHjmm2ah4zmBMNP88U5s6qPhu53ZC665e7g7oCLLNQQ8aCGyvLoxsE6+oQALme8xRT1Xb+mtmTrXbsUHPAWOWNi7PSS19ZNw2Is4N/MllBiDkhfkAX0mYRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIQ/OZz4; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIQ/OZz4"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c19937913fso1002870b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918651; x=1709523451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55WXvEVzqm0Mqd2SystGX3mGPtj7zQ0w/CcvB0xYPP0=;
        b=MIQ/OZz4zGbm8rzo+6gTowAwGZ5AAeOHJ/fEozQ1WPaATUksR0D7bf9ALGPi0IX7My
         yM1V2TqZXO9gA6lHNByRuKrKyZnG17q6H97NOovxQ+07CKy9JV5MwHqpzQGNj2D9wlOB
         CB8XjJkJa/u6hyxUIWLl+NqF1EKgbDJb88hMpSV1+eRyEjK3f4JDW3a2hdFZ+AOVZMXh
         3VcBAZbJMaNZXobVlC/vLlA0m2bM8S77ejVP/r9LEePiyj3vARtriypU7J+Xwt0jRrzv
         OuuXcq5cH432rJmTgd46CCtoGpP9z8g0zClu6O3cSMpLPqSFCNvIZEq4/moiVW1W7RJA
         uP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918651; x=1709523451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55WXvEVzqm0Mqd2SystGX3mGPtj7zQ0w/CcvB0xYPP0=;
        b=YbIJ8HrefduK3IJ2oCmUQk+nihF9f3welvY6PgBhvhOQJpnbS088CjyP5FP3K1JTES
         +H9g3AGP+3ar0oMAM+mLCJ1qWDFPSHpgyR6z3NfHN8pXofmQYq+ml5EoGG+nQz8Dzx5f
         n/i+3RIe/SQDosirgCt8sYJp2ic3YvBd79Sm8I4DFcZDtbfGQb3bXzfxJOADaW2qwhi9
         2sJQW/CJbH1+b8pIgtQBwr3oJ/rcFRXxbErmCMKYsQIuODL6Tk8tVb4ZgKn3SRkCJn+w
         usCqM0Gjzc7YNzESEJHKakxqaCfPDSUWYzZkhLacYsDUHzam0Q2k5E4+oEQtk94QBbl4
         4kaQ==
X-Gm-Message-State: AOJu0Yzch2z17PfhoRO5mFA2gVeKExVJVvl7lQNUbPUpiiZYzLjnFuaQ
	1ZWc0Wl9NDKksK4QFvIih7FTE2rX6+S1y+a3aQpibQ611VkF5LSU+V7V6Ikl
X-Google-Smtp-Source: AGHT+IEMTN2E1aQYU9Y1HF5L8/xPtedLiEBpgHpWQ53z9ppYqHvFFh0RffsI9pk0C6jMenUeTNsojA==
X-Received: by 2002:a05:6808:9b5:b0:3c0:a25:bb4e with SMTP id e21-20020a05680809b500b003c00a25bb4emr6079078oig.35.1708918651344;
        Sun, 25 Feb 2024 19:37:31 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:31 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/22] simfs: Remove g_strdup_printf use
Date: Sun, 25 Feb 2024 21:36:51 -0600
Message-ID: <20240226033724.1460079-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strdup_printf
---
 src/simfs.c | 48 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 38d4852b1886..4cd7f5b5c481 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -658,9 +658,9 @@ static void sim_fs_op_cache_fileinfo(struct sim_fs *fs,
 	fileinfo[5] = record_length & 0xff;
 	fileinfo[6] = file_status;
 
-	path = g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
+	path = l_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
 	fs->fd = L_TFR(open(path, O_WRONLY | O_CREAT | O_TRUNC, SIM_CACHE_MODE));
-	g_free(path);
+	l_free(path);
 
 	if (fs->fd == -1)
 		return;
@@ -755,13 +755,9 @@ static gboolean sim_fs_op_check_cached(struct sim_fs *fs)
 	if (imsi == NULL || phase == OFONO_SIM_PHASE_UNKNOWN)
 		return FALSE;
 
-	path = g_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
-
-	if (path == NULL)
-		return FALSE;
-
+	path = l_strdup_printf(SIM_CACHE_PATH, imsi, phase, op->id);
 	fd = L_TFR(open(path, O_RDWR));
-	g_free(path);
+	l_free(path);
 
 	if (fd == -1) {
 		if (errno != ENOENT)
@@ -1183,11 +1179,11 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int id)
 	if (phase == OFONO_SIM_PHASE_UNKNOWN)
 		return NULL;
 
-	path = g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+	path = l_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
 
 	L_TFR(stat(path, &st_buf));
 	fd = L_TFR(open(path, O_RDONLY));
-	g_free(path);
+	l_free(path);
 
 	if (fd < 0)
 		return NULL;
@@ -1223,9 +1219,9 @@ static void remove_cachefile(const char *imsi, enum ofono_sim_phase phase,
 	if (sscanf(file->d_name, "%4x", &id) != 1)
 		return;
 
-	path = g_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
+	path = l_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
 	remove(path);
-	g_free(path);
+	l_free(path);
 }
 
 static void remove_imagefile(const char *imsi, enum ofono_sim_phase phase,
@@ -1240,9 +1236,9 @@ static void remove_imagefile(const char *imsi, enum ofono_sim_phase phase,
 	if (sscanf(file->d_name, "%d", &id) != 1)
 		return;
 
-	path = g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+	path = l_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
 	remove(path);
-	g_free(path);
+	l_free(path);
 }
 
 void sim_fs_check_version(struct sim_fs *fs)
@@ -1268,20 +1264,20 @@ void sim_fs_cache_flush(struct sim_fs *fs)
 {
 	const char *imsi = ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase = ofono_sim_get_phase(fs->sim);
-	char *path = g_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
+	char *path = l_strdup_printf(SIM_CACHE_BASEPATH, imsi, phase);
 	struct dirent **entries;
 	int len = scandir(path, &entries, NULL, alphasort);
 
-	g_free(path);
+	l_free(path);
 
 	if (len > 0) {
 		/* Remove all file ids */
 		while (len--) {
 			remove_cachefile(imsi, phase, entries[len]);
-			g_free(entries[len]);
+			free(entries[len]);
 		}
 
-		g_free(entries);
+		free(entries);
 	}
 
 	sim_fs_image_cache_flush(fs);
@@ -1291,21 +1287,21 @@ void sim_fs_cache_flush_file(struct sim_fs *fs, int id)
 {
 	const char *imsi = ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase = ofono_sim_get_phase(fs->sim);
-	char *path = g_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
+	char *path = l_strdup_printf(SIM_CACHE_PATH, imsi, phase, id);
 
 	remove(path);
-	g_free(path);
+	l_free(path);
 }
 
 void sim_fs_image_cache_flush(struct sim_fs *fs)
 {
 	const char *imsi = ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase = ofono_sim_get_phase(fs->sim);
-	char *path = g_strdup_printf(SIM_IMAGE_CACHE_BASEPATH, imsi, phase);
+	char *path = l_strdup_printf(SIM_IMAGE_CACHE_BASEPATH, imsi, phase);
 	struct dirent **entries;
 	int len = scandir(path, &entries, NULL, alphasort);
 
-	g_free(path);
+	l_free(path);
 
 	if (len <= 0)
 		return;
@@ -1313,18 +1309,18 @@ void sim_fs_image_cache_flush(struct sim_fs *fs)
 	/* Remove everything */
 	while (len--) {
 		remove_imagefile(imsi, phase, entries[len]);
-		g_free(entries[len]);
+		free(entries[len]);
 	}
 
-	g_free(entries);
+	free(entries);
 }
 
 void sim_fs_image_cache_flush_file(struct sim_fs *fs, int id)
 {
 	const char *imsi = ofono_sim_get_imsi(fs->sim);
 	enum ofono_sim_phase phase = ofono_sim_get_phase(fs->sim);
-	char *path = g_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
+	char *path = l_strdup_printf(SIM_IMAGE_CACHE_PATH, imsi, phase, id);
 
 	remove(path);
-	g_free(path);
+	l_free(path);
 }
-- 
2.43.0

