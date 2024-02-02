Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E512C80C
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914506; cv=none; b=GNOOz+UQTgYe5nVxljOsBumizXFvjhZy93qSEkj7WZeeY3/h05eykGNBbnx5O+vnie3jCCi7yZqxIHOxIX7p5dbt5Y1jeRxkExZhrr3holJvXk+JeJ07S9P8ksfaJSQ1JoIPC3nJKxfMta9DbTAuytwuHEPsU+M4RKgMkkRYkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914506; c=relaxed/simple;
	bh=a+jxi9QixNGyk3ipZTueAhPHBscTTc0vwO0eOodccOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLqZOojo1GHywb5ntlAsrPndX+ESOKyE3CZZ/rN3/ZdekNhvLluR7idDgs32ZV0Fhov+s/MVIDUoEa3NJ/+rmRzw+LV/wUS/2BdnE+cPLJWXeBJgnkmtT8AIPzfsTEdvyfdNtyXVA+rmb2DIdj/NtFVTpr3A66pp72GFxtAvLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6hS6Gn6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6hS6Gn6"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e117e0fee8so1373195a34.2
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914503; x=1707519303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/275mKN5hiZ2GPBZ62+urJQue5a7aTrxJsi5NaMDxAA=;
        b=C6hS6Gn6lXedRkfYWvJeRO/YnboJTQfgPQsyVG/0xIvNzusrlSVI4iVKy9y/FUN9EO
         lZEQG7b1DomPIx5/prC7Vxztco8Z8horUdAlhJ+Mv4dTPGhHRA7+Jucp881sM8DB/3hn
         d2QHW39YzMSX6gKEoCavyolI8MmZHTa3tuxsOojd7xsncM8xM0DDMv8QBE5wVtDog+V1
         38bYbFDF9PLMjtuFT8nTSNbjUauYZsXZ3ljmstJp/v4SzHqpys81eat/9WBQ8otYTQGM
         9qlC2/kaGLGYpHCj8Xh2EzSGjeV9nVYhFcpV5YUr3M187AaK5bpbzCkn/k8etM5DLqvs
         RIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914503; x=1707519303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/275mKN5hiZ2GPBZ62+urJQue5a7aTrxJsi5NaMDxAA=;
        b=uzioSVqJEcDxdyaNnfo5Kz/2g1t4ujLYU+P1YYqkxoarY0GREiYacpXLYxqD7yrd07
         FoNepIUKX3W99Iseu9U/fpB5Kn02GvLCkbYHadmYXGzeq8gTY4kRD7CtcT6ttYGh68Gc
         szPTPrPp/Ddf8HqHT+BRIWN8LKD4pt7GHc7qMNoP41lEsczjPE+jJ0JCNi0EE3zTFSve
         t1b9iku9DXxm2oHjwwLwK5IV56v2mIsINUojoS9XNbOittD49Nvwi1OCrFH3n8YEZHXD
         yo9IFCcVxX43LpqLRAd1eyEVbQeyDukrzEYr/HK0oJhKVXk4pkwUGrsRUGlrCvslj5hB
         M2+A==
X-Gm-Message-State: AOJu0YyMWfXXzG8ZNILahRwj4cOBdEr7rJmlGSuN9viZxavP78yQs0va
	3VyX36rGC0FTcPwVI7dGSXvjPVmZ4Kid0AKYsYjfgxp+Rmosuejk9KnrYf0/
X-Google-Smtp-Source: AGHT+IHrhTaabzl0G1r451oVo4ocPP21IyQjq39ijJyQSU6pDFD07/pFqzh41f5ZU/iCIEyOEmA83g==
X-Received: by 2002:a9d:6411:0:b0:6e1:1570:d4a2 with SMTP id h17-20020a9d6411000000b006e11570d4a2mr8798075otl.33.1706914503629;
        Fri, 02 Feb 2024 14:55:03 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:03 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/18] storage: Use void * instead of unsigned char *
Date: Fri,  2 Feb 2024 16:53:45 -0600
Message-ID: <20240202225405.993792-13-denkenz@gmail.com>
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

This allows passing both binary and string data to write_file() and
read_file()
---
 src/storage.c | 6 ++----
 src/storage.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 1b761c4ce57a..5b12c69ba6dd 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -82,8 +82,7 @@ int create_dirs(const char *filename)
 	return 0;
 }
 
-ssize_t read_file(unsigned char *buffer, size_t len,
-			const char *path_fmt, ...)
+ssize_t read_file(void *buffer, size_t len, const char *path_fmt, ...)
 {
 	va_list ap;
 	char *path;
@@ -118,8 +117,7 @@ ssize_t read_file(unsigned char *buffer, size_t len,
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

