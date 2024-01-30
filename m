Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7278B53
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649754; cv=none; b=ToBrd/3UNAh9SoC3Ny/bFGA1ltCSktsiwu3Q0gafrnLo5h60KMnzWR0DWLSrFMCszW4uTed3ZHsUHq/S4Tfx6x38hu09/RNWif5EMNNmyo+X265UVxS9ktZyGXsbVVmzqXEe6jck24HLfPX8rPBg6hEwbgEqsTb17OGV3EFcx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649754; c=relaxed/simple;
	bh=4dXw3NOJT0RmekpMipDN8TKAXS2MVeQcyWoZJFtLx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdQuW2yylFGdvVNo7tOZNtf5PerRUM3jksyxS8yD7QonGXDxjRxXX8i6475gp1N8ZJjgGLUgwK/6XmYVCp8jXrOll1CvFIOzDa16XzLsOlmn9mMMGNCPUeVTaD/i9LSemQw2XLLdJ5W4kAYqbwO+bwGPsAbHlFcQz1pHQcOyq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucp3Em61; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucp3Em61"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3be4c0b0e47so1638358b6e.2
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649750; x=1707254550; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWYM4X5sXvwfqLz2R8FSWT/EI8XJuj1mOlHl5FkpNMI=;
        b=Ucp3Em61FQsCh7HncCPDL2bX/GdierkkKOEf/BufPT5G7o+jAwOXC8KOsNX3LPd551
         QY2ibZQqvkbn7lkaqDZPD471uFFbM7euy6iepNz9pa55jydUng5vSt0HDyjO/bwiaUEB
         7e2WCvDm2GB5H9oYFHN+OKwrMGe996LNXCx70QaJDfmxpZRAf+IdeAv24jT5SHp48WiZ
         LzWxfdQB1Xe2OAAY072YRDTkeTl8Z7InLsTwl4zvqFyXC2kUIX+HgS9zl2HUYYbF+yaB
         7yYZ+9X2wqmSN61J2p/vtlggxMozPN0Y/neE50OzczGmeoog7f6o7yn/G5BIK/klhxnZ
         Co2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649750; x=1707254550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWYM4X5sXvwfqLz2R8FSWT/EI8XJuj1mOlHl5FkpNMI=;
        b=FALEDEly8Xj83i9RsZtBAA67j943wmirBCfya8FNFkFb31KSO//djTMRr1SuZC9a0W
         8rV1KLe6sW4NNqvmdzGbUS6YUDTwqQly+/qV7v2V/JF1cjZ0VFz14lK4YHh8kzVv9LiJ
         dxyrmHd7Np+QYWY8YEAZPPGOvxPFG97CRnWQqIyD5Tyt57VMJhDOMTxasTJurOE+BmYS
         TM/bkpqPGs0liXflao5IsCxKCS+tJInpRKRbCzkJCQad0QTkaIZHFe3wCgVcwBuBadNg
         Ao5W522Bn9f/+JAQ4ahtazBiLAkJFI5vBr5L+8HbQ7YL7JAOQrICovNTwqynOsNfJUbE
         yzog==
X-Gm-Message-State: AOJu0YyNXlGASZ3ls5IowhfbkMDofWcoBbTf71rU2iAIiJUgNGF2Ew7P
	/Xc+VY2wSj5Y1dNHlZARqQi1cdsFtQrukhhbNthW3gIOORD4Gzl1stVZsZVR
X-Google-Smtp-Source: AGHT+IEVJQbQ6q5Mm0wzsLT0qJ/yZwDeqnFQnVHWTFpK7+GZLjNJrHK6bsVvNmK8WE66MzTa3V8u/g==
X-Received: by 2002:a05:6871:4609:b0:214:dbd9:b8e0 with SMTP id nf9-20020a056871460900b00214dbd9b8e0mr9264090oab.21.1706649750219;
        Tue, 30 Jan 2024 13:22:30 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:29 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/17] storage: Remove mode parameter
Date: Tue, 30 Jan 2024 15:21:14 -0600
Message-ID: <20240130212137.814082-9-denkenz@gmail.com>
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
index 2313835a49ce..89c11cac4452 100644
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
+	mode_t mode = S_IRUSR | S_IWUSR;
 
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

