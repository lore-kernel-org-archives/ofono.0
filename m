Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62875126F22
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914503; cv=none; b=mp/oMQkUW1vDBeozb0ZGTWuIQMSwc4Z26z+wQHwdPFQLvTYfViRQmajvFje3NlwyZ5PORj0LziYYKLWWNmQZ+mhcp24xW1ljZRxI/JV7FS6883GL1yHc52qx88+klFNVrTJKU2+t5mvoLK3546u60QPrf3rB4QNvLZz4+gKrJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914503; c=relaxed/simple;
	bh=61fyQzNnKHj5QARlfxXcK5nSKB1DrWReECiyghMxOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grM5FUk+K/5neUhOtHXQQZxfrl7NAuyTu1lea4aX7oqkU/QZwHGgvbH+B/wtKPvjt/UPyCX3S5GmjdMrL8cOTZ7C4gNVef3CJ7xU0T1UqBhzLJSLind89GF17hftK8ANO2AW4n4zxm9FiLr76r0vOeZvxJKUA91ZbimV9cO6srQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtcFAeJl; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtcFAeJl"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc36e501e1so1685578a34.1
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914501; x=1707519301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hYJchzeiiEi5NAPlegGc7r3+ynvJ4n/A3YMHO2SCrI=;
        b=TtcFAeJl5VfnDy3z69oEVUUimefcejBwvvSd7cdQ1ACZ0sRAcXXXYd9vKCgh9swUWM
         44Q4CgafdjJB6uu2+bJVvSeEDJpkU70h3A0zdT+ArDihvKh9jMNZP4fizN7GRDtQDtum
         6i6YQ4DE52ixMcW2TiRn9Xf7TXFq+7tvnMQBfB9NaHyFywNJ8qge3Mw6sdZAEPL/yGIY
         51Ce4NXvaDlFiUrgNeLOaM4rbDKzzqxUX1yhyhqkOudPqSo4SCEo3+dZj1SfQBxfWEjx
         iXaB2Zlt4IGxeuJ80Kvit6LOTpsHOugXsVyKmZca2wIcWCmEn9OVj0ClpQ6+pNGzlDlN
         /3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914501; x=1707519301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hYJchzeiiEi5NAPlegGc7r3+ynvJ4n/A3YMHO2SCrI=;
        b=a2e3yp3VwDxZupi2bHim/rfUOHQHyKd+p7s8euaYfTW7PM+BDXrpQesqMtguNxbYLD
         GTY5vn1f2Ebe2FDT/bzIOJXc8X44MvGyezoDAk5NxJ0DRdMQdzl9A32oOgYHGuDHUClC
         2qLZESTjiiy1Ij4awL9RyIzifXmgjUPnTmI+r8CujGR1ye9PCRS09Gy/9H04W5i37DUe
         Nu6dWP3lpj6PEdb2onwIgy4oefYbLsfpxvtiN71oPsvdWVBdP4H/gERbcayMqHMU8i5z
         +wDjIXDU106WLmX22+zCHaq7qjA0DA7r55P2S5q4vv+Ued4CjBUOv4MSYc+pP6wn/lwu
         A2QA==
X-Gm-Message-State: AOJu0Yxkw421JmcIUn0dwFSH9bdDogZeHtePs2+haAMlTRcN9Q0M6LGK
	XbrvuFJEN3lDG8XsPRyarhmPc3F4dYidj60GYDLt12SERZYhGyF6wEvnmUzA
X-Google-Smtp-Source: AGHT+IFfIGuB/bOHeKVPc8u9repHB+t7FjduDJffEjTIwH7fqnTb0aOdCQFUqHlmMCKGpRK8uY+iNQ==
X-Received: by 2002:a9d:7d97:0:b0:6dd:ec7f:f46d with SMTP id j23-20020a9d7d97000000b006ddec7ff46dmr10025905otn.11.1706914501327;
        Fri, 02 Feb 2024 14:55:01 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:00 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/18] storage: Remove mode parameter
Date: Fri,  2 Feb 2024 16:53:42 -0600
Message-ID: <20240202225405.993792-10-denkenz@gmail.com>
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

Files are always written with owner read and write permissions.  No
other permissions make sense, so remove the mode parameter to simplify
calling code.
---
 src/simfs.c   | 5 ++---
 src/smsutil.c | 8 +++-----
 src/storage.c | 3 ++-
 src/storage.h | 4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/src/simfs.c b/src/simfs.c
index 515f5c97f7a7..38d4852b1886 100644
--- a/src/simfs.c
+++ b/src/simfs.c
@@ -1158,8 +1158,7 @@ void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id)
 		return;
 
 	write_file((const unsigned char *) image, strlen(image),
-			SIM_CACHE_MODE, SIM_IMAGE_CACHE_PATH, imsi,
-			phase, id);
+			SIM_IMAGE_CACHE_PATH, imsi, phase, id);
 }
 
 char *sim_fs_get_cached_image(struct sim_fs *fs, int id)
@@ -1262,7 +1261,7 @@ void sim_fs_check_version(struct sim_fs *fs)
 	sim_fs_cache_flush(fs);
 
 	version = SIM_FS_VERSION;
-	write_file(&version, 1, SIM_CACHE_MODE, SIM_CACHE_VERSION, imsi, phase);
+	write_file(&version, 1, SIM_CACHE_VERSION, imsi, phase);
 }
 
 void sim_fs_cache_flush(struct sim_fs *fs)
diff --git a/src/smsutil.c b/src/smsutil.c
index f2b6f44c2aa9..d07960190103 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -42,7 +42,6 @@
 
 #define uninitialized_var(x) x = x
 
-#define SMS_BACKUP_MODE 0600
 #define SMS_BACKUP_PATH STORAGEDIR "/%s/sms_assembly"
 #define SMS_BACKUP_PATH_DIR SMS_BACKUP_PATH "/%s-%i-%i"
 #define SMS_BACKUP_PATH_FILE SMS_BACKUP_PATH_DIR "/%03i"
@@ -2505,8 +2504,7 @@ static gboolean sms_assembly_store(struct sms_assembly *assembly,
 
 	len = sms_serialize(buf, sms);
 
-	if (write_file(buf, len, SMS_BACKUP_MODE,
-				SMS_BACKUP_PATH_FILE, assembly->imsi, straddr,
+	if (write_file(buf, len, SMS_BACKUP_PATH_FILE, assembly->imsi, straddr,
 				node->ref, node->max_fragments, seq) != len)
 		return FALSE;
 
@@ -2889,7 +2887,7 @@ static gboolean sr_assembly_add_fragment_backup(const char *imsi,
 		return FALSE;
 
 	/* storagedir/%s/sms_sr/%s-%s */
-	if (write_file((unsigned char *) node, len, SMS_BACKUP_MODE,
+	if (write_file((unsigned char *) node, len,
 			SMS_SR_BACKUP_PATH_FILE, imsi,
 			straddr, msgid_str) != len)
 		return FALSE;
@@ -3370,7 +3368,7 @@ gboolean sms_tx_backup_store(const char *imsi, unsigned long id,
 	/*
 	 * file name is: imsi/tx_queue/order-flags-uuid/pdu
 	 */
-	if (write_file(buf, len, SMS_BACKUP_MODE, SMS_TX_BACKUP_PATH_FILE,
+	if (write_file(buf, len, SMS_TX_BACKUP_PATH_FILE,
 					imsi, id, flags, uuid, seq) != len)
 		return FALSE;
 
diff --git a/src/storage.c b/src/storage.c
index 2313835a49ce..eddb98c79598 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -120,13 +120,14 @@ ssize_t read_file(unsigned char *buffer, size_t len,
  * file with a temporary name and when closed, it is renamed to the
  * specified name (@path_fmt+args).
  */
-ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
+ssize_t write_file(const unsigned char *buffer, size_t len,
 			const char *path_fmt, ...)
 {
 	va_list ap;
 	char *tmp_path, *path;
 	ssize_t r;
 	int fd;
+	static const mode_t mode = 0600;
 
 	va_start(ap, path_fmt);
 	path = l_strdup_vprintf(path_fmt, ap);
diff --git a/src/storage.h b/src/storage.h
index 3a1e64493546..76069949e747 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -28,9 +28,9 @@ ssize_t read_file(unsigned char *buffer, size_t len,
 			const char *path_fmt, ...)
 	__attribute__((format(printf, 3, 4)));
 
-ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
+ssize_t write_file(const unsigned char *buffer, size_t len,
 			const char *path_fmt, ...)
-	__attribute__((format(printf, 4, 5)));
+	__attribute__((format(printf, 3, 4)));
 
 char *storage_get_file_path(const char *imsi, const char *store);
 GKeyFile *storage_open(const char *imsi, const char *store);
-- 
2.43.0

