Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18B126F2C
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914499; cv=none; b=a+V85LI5O74QUK7UFCbgHTGkvF+tUKyOvrEQXkL3RI9P1fkm5l4191A0Gv+UKjwzRB0kWUHjQ5LGaHRegJE0og4txxYy3RDUAMqEiRZCx+uYCJFWnJS5IEBygQxpjtgVLS71R5o5HLjAdTvtRE/mnO11bEzJQfyWhX/Wpa0Sk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914499; c=relaxed/simple;
	bh=ocOP2ENWgfeKcfkofb/GowR+z0pPyYIU9FELfhLwGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bse52WduMI0kNkSJJJW8IYn5Oq/BoBkLlqLV53WqFiqK0qVFe29kGjY5ASEMtEXsKiB0/q14zJjQWrycZboACPOXn+YAvsnyr757Z6CFheuB/UZVp7Z7cC41s1Bxmh9o11SbVJs5MPUPYBRH5zB4YwfX9rg12yM3u9g3ZqWzT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF+4G6ll; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF+4G6ll"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e114e247a2so1319080a34.0
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914497; x=1707519297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ/Hif7k39MhIpB+VGwN9tPfBsV5uUV3MaA8EewrxfE=;
        b=nF+4G6lliKOy/VFT4YYGjTKGLQhSejEXJBdPGn6CCHdDX/EbIQ1ttyUeSX/APVh9e2
         FcHxpHOz1CDHhPDFyOnfQzOmIMwC/z/R/PUZbE1fDmjUKOeDvh38nstcxkj8OGRGY4zl
         X7iL9Olvq+1TJlPDKf6638g/E3GFnE7ad9TZyk5gJpLRjcPlOD73Y67wkLKKHBoXy3Dc
         9Y5ogLDZnZ/Y85ph0trDR4KICo1oplQLKYqifKeNCAu2jzIG1k+1YZFmOn13pVtB5OKz
         DNkB3I8r52peZleLjhdpLh5H5pjrBHZDdqIjKvfuCBDlII0vPy7i0TfPRyJqV1NR3SUJ
         yH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914497; x=1707519297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJ/Hif7k39MhIpB+VGwN9tPfBsV5uUV3MaA8EewrxfE=;
        b=b3u8Q3OtPPyHwgE+HZEl2ydDu43QjQQwmvSqKaU4xVZ+AHuTaBVBVXePAoCBpZi31S
         Y1gddLlIVs8hlAz9G+ny8QTifApCYcvjlR3uO6qa5UtFiJddfVf0znegwsxhnz1BENsC
         g+TS9HFOoXezST0VkHlTGRBGR0HMV5iu4AUDggQkbBvRxQmqgXwIRyTgZXXAP9LZryrB
         gtncvahb87/wEmkAx8ghSOy+D0LK+9w7SVMe40Fg/hXZ0uOqJ9dAWheh8LR/tDqCZD7Z
         AQEBS35rvBbzBPJnrCvTF4b+qJwnxcbK1hEc9Ewaoc1dAeI+7smY+FfXKe0Vwdd58doG
         kVDQ==
X-Gm-Message-State: AOJu0YwCZtnRma2kZbfmTXSe/kQHUHE1EoN8pWkq9SHbkrD8PNNchpqa
	e+wQvfQTK93yox3StFHKGKvxM0UutWnS9KVXRIr0Df9yokhroDRNzFy6US8w
X-Google-Smtp-Source: AGHT+IHvLf+D0lKe/Kb7eT9/rS3Yj45W4xJGlPDzWHDJo8hccsZVpQ7a+ieM4Pv8l1WVhVqu4iiqTA==
X-Received: by 2002:a05:6830:1d92:b0:6e1:4dc4:cda3 with SMTP id y18-20020a0568301d9200b006e14dc4cda3mr8984069oti.29.1706914497387;
        Fri, 02 Feb 2024 14:54:57 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:56 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/18] storage: Introduce storage_get_file_path()
Date: Fri,  2 Feb 2024 16:53:38 -0600
Message-ID: <20240202225405.993792-6-denkenz@gmail.com>
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

There are multiple locations where the same steps are followed to
produce a file path for a given storage location.  Pull this logic into
a single function and expose it for potential use by other modules.
While here, convert use of GLib functions to ell.
---
 src/storage.c | 36 +++++++++++++++++-------------------
 src/storage.h |  1 +
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 05d9b88a0237..c7bbb1c6142a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -171,45 +171,43 @@ error_create_dirs:
 	return r;
 }
 
-GKeyFile *storage_open(const char *imsi, const char *store)
+char *storage_get_file_path(const char *imsi, const char *store)
 {
-	GKeyFile *keyfile;
-	char *path;
-
 	if (store == NULL)
 		return NULL;
 
 	if (imsi)
-		path = g_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
+		return l_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
 	else
-		path = g_strdup_printf(STORAGEDIR "/%s", store);
+		return l_strdup_printf(STORAGEDIR "/%s", store);
+}
 
-	keyfile = g_key_file_new();
+GKeyFile *storage_open(const char *imsi, const char *store)
+{
+	GKeyFile *keyfile;
+	char *path = storage_get_file_path(imsi, store);
 
-	if (path) {
-		g_key_file_load_from_file(keyfile, path, 0, NULL);
-		g_free(path);
-	}
+	if (!path)
+		return NULL;
+
+	keyfile = g_key_file_new();
+	g_key_file_load_from_file(keyfile, path, 0, NULL);
+	l_free(path);
 
 	return keyfile;
 }
 
 void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
 {
-	char *path;
+	char *path = storage_get_file_path(imsi, store);
 	char *data;
 	gsize length = 0;
 
-	if (imsi)
-		path = g_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
-	else
-		path = g_strdup_printf(STORAGEDIR "/%s", store);
-
 	if (path == NULL)
 		return;
 
 	if (create_dirs(path, S_IRUSR | S_IWUSR | S_IXUSR) != 0) {
-		g_free(path);
+		l_free(path);
 		return;
 	}
 
@@ -218,7 +216,7 @@ void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
 	g_file_set_contents(path, data, length, NULL);
 
 	g_free(data);
-	g_free(path);
+	l_free(path);
 }
 
 void storage_close(const char *imsi, const char *store, GKeyFile *keyfile,
diff --git a/src/storage.h b/src/storage.h
index 4dc792ccf7f9..3a1e64493546 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -32,6 +32,7 @@ ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
 			const char *path_fmt, ...)
 	__attribute__((format(printf, 4, 5)));
 
+char *storage_get_file_path(const char *imsi, const char *store);
 GKeyFile *storage_open(const char *imsi, const char *store);
 void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile);
 void storage_close(const char *imsi, const char *store, GKeyFile *keyfile,
-- 
2.43.0

