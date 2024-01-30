Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3B78B67
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649754; cv=none; b=TFxWHNm1AxpIccztLduqzRpWbT1+z6NA27JZWNphYnCAzP+jpukmtQ1CEhE2IYdFaIQYAWluVdkA2K6NcETb/k7bWGBDvBHHSfnlavKh0xO87XOGxDKrl7ECT5lORbmE3eCNWBpGN7V4RXSCtJC2P+sy0ATqxht/NENbSSC0IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649754; c=relaxed/simple;
	bh=/uXtfSHX87EDIJNjKQPz57XQhZZz2/lp7t+34gMs9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBwvaQcDBSffNyNc0VQjIaJAcx8Z+9Tsw63Y9tBI7wnnqKsZs5Fdov1pU3VbcqVXye1sLqxo1TLDGcicxAlJE4nKMlREBe+o5/7IZQ6fe4vZJVWnLlho+SUsMvui+SUzUn9/DTFY7tihlHLvOy/3Mh1OZ9A2yCb2jsnjb9bE5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pezqnu0n; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pezqnu0n"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc8b280155so2624722a34.0
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649752; x=1707254552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1C0XNc0vkyWjPp1kouWBIVc2BKOna9atKyAcwc+BVs=;
        b=Pezqnu0n++mrs6xE70sXHNVjmJK+UWX4uQtCewWm3d2svdVy08ZkCzc/jOeyrxViae
         IkahcPOI83rG6ox7U3QAKO4KgkUp7nCfjlm5PLL80CI/DJXsAqBf2qC8da42iJvSoqFA
         kX8/NKrLZ2yLs7/Ym6L2pbT5AGqbsDszx85h63UbDWhoX6yr/oEzxDWh0E9nYx8u9ClT
         JJRTYURAZd4R6ZqpvVU7imdfMcNpsHcONAm1pHMKq4J+xvlF5f4/b8lWDjCKKSvWSo7X
         2jMcQZfCRyXc1d+g+jQcqhuqmpu9CmXy8hhrQjkVGOgyD1c6BIBgf4cJBPbELh46e82L
         roWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649752; x=1707254552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1C0XNc0vkyWjPp1kouWBIVc2BKOna9atKyAcwc+BVs=;
        b=UBolGKLer+yH1my23/peqPHFFex5ozKUrmDb236WsnBkRqnuJRcQ1llAK2jxyxKxJo
         mmBehlZLaR8lyMW3IErV+7apzgqmx8uMEGQNrLSAi7q6rRugRe0Ftc3G90vcNiY1Yrrp
         5ysNCuKWL8uoqWXdMsD+1d4djwRXGwJNnRk1ZQGvd8UXqs32iR7LrmGbro9WCNkUpdu4
         KSj+AVHiRskJkAWYLsfsh7NoAfHUgvt2r+36vQhcEhGfFqZuqeHT8UVgOoCAj4RruB2p
         TFlzVWyDsNoCgMULgjO7DrWcy84vj18GSgxXyNXKB797mYD19opSEh3tUm5A7QVq1wDR
         vAQQ==
X-Gm-Message-State: AOJu0YylaihXtyl16x4neuJnsSGdMIiJN19dXaATq1sJ9R/folq8I+JR
	k/sQISPbDdnlUFc1FUv9L7WTjIOZ9Z9Boaa+ZmDTiJakKLdPl8M7jkRC0gf9
X-Google-Smtp-Source: AGHT+IF6oUNQqedX8g6mm9pL7sDEXP0bfH9T/Vacpuqi65hXyriwllVd/uAGd3HuaZNhF8+NblQOXQ==
X-Received: by 2002:a05:6870:eca2:b0:214:b208:ddd2 with SMTP id eo34-20020a056870eca200b00214b208ddd2mr5413044oab.46.1706649752306;
        Tue, 30 Jan 2024 13:22:32 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:32 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/17] storage: Use void * instead of unsigned char *
Date: Tue, 30 Jan 2024 15:21:17 -0600
Message-ID: <20240130212137.814082-12-denkenz@gmail.com>
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

This allows passing both binary and string data to write_file() and
read_file()
---
 src/storage.c | 6 ++----
 src/storage.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index f169195c8df7..30e004e75d91 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -83,8 +83,7 @@ int create_dirs(const char *filename)
 	return 0;
 }
 
-ssize_t read_file(unsigned char *buffer, size_t len,
-			const char *path_fmt, ...)
+ssize_t read_file(void *buffer, size_t len, const char *path_fmt, ...)
 {
 	va_list ap;
 	char *path;
@@ -119,8 +118,7 @@ ssize_t read_file(unsigned char *buffer, size_t len,
  * file with a temporary name and when closed, it is renamed to the
  * specified name (@path_fmt+args).
  */
-ssize_t write_file(const unsigned char *buffer, size_t len,
-			const char *path_fmt, ...)
+ssize_t write_file(const void *buffer, size_t len, const char *path_fmt, ...)
 {
 	va_list ap;
 	char *tmp_path, *path;
diff --git a/src/storage.h b/src/storage.h
index 46efd2d1a208..135674c6f517 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -24,12 +24,10 @@
 
 int create_dirs(const char *filename);
 
-ssize_t read_file(unsigned char *buffer, size_t len,
-			const char *path_fmt, ...)
+ssize_t read_file(void *buffer, size_t len, const char *path_fmt, ...)
 	__attribute__((format(printf, 3, 4)));
 
-ssize_t write_file(const unsigned char *buffer, size_t len,
-			const char *path_fmt, ...)
+ssize_t write_file(const void *buffer, size_t len, const char *path_fmt, ...)
 	__attribute__((format(printf, 3, 4)));
 
 char *storage_get_file_path(const char *imsi, const char *store);
-- 
2.43.0

