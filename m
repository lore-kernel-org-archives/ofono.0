Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C712C812
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914506; cv=none; b=tNXTsaSWvSpcacNUnDgAfQuNg2v6kwv91mbqGMvD53gWgWjQbN1y+H13HrnJMqvmnzclYdaZ83+oIXfDvkbhn3go29ipPMnumiov/2XMFexTdX1JnEx9Q6TeSth3xwhFpjeh2btSKH/9LLptmpnitfAzfVCc8IvWm93umLV6ats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914506; c=relaxed/simple;
	bh=+IAj5/cYSSgOLSMK7pV3pIOZ6oTbviP6AB9sjLMys4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvA5ZZccppbJlSBHWyWK51HwQ183raP+yVxdm9vmuHOaBR/PL3IyxT5/xCMj3REdz85eHVkRE830MZ2kI54Yh0YxRrI0OYFb9up9dq7c1zWDhcV59WeCQAoF+VjvlMS8QMeZA17rZNHIyu3nnir2a9UrhCWgng8txvhFehwfL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDW261qn; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDW261qn"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e11faeb125so1252177a34.2
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914504; x=1707519304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVRCuVGPEoLGVvSyzuBR5NWdqYsZ6rUc159zqiqyK28=;
        b=HDW261qnpE3bdYofQsYUxuAEHn9jqDO83NjHLFS59O2IVOUYoCV93ya60uYaWhiP6+
         Q1Rlxy9XWHAISpAElNtzGuyLGTbNJ8+WCOnsKyo6/zn0JTuVUTwBggO62MQ9Ka34adfC
         RG16+Rfg5SWXoHhVaUqSoRFSfVwFO3lBB13XEpNPfG0HmC9YbsbQsIWeEjAabPNbHhIw
         XsHJscvu5Lkeb6lQ88UMB5zu9T0Ln7jSwj0y6rd/YI84qYVlj8O+c4gE1VsZiySDFl7B
         op5uQoK38/dECUSJEZsB/pKLGM33vQeRNS2JFogavmu3RYyUEJ6kUnM1e9nExxyTi516
         aoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914504; x=1707519304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVRCuVGPEoLGVvSyzuBR5NWdqYsZ6rUc159zqiqyK28=;
        b=tTwkJZ0aQkq31ClKNB6IDN7phFo2AWsKQqMl9fsy1bt5FNEuxliU28+tDt28wgOW8e
         MUFunwNj+hoQYvFQlhYj4hpwz/MPif2yfaOatVdbTh76PWJcfBk0bno1rXgR8SAxTKYQ
         0bqDnhOwd0WvmqC13EhmwwBrmCcenHQ09dqWimcj4R9AwZgYqwlHf8LTccFe7aZ40ugj
         PEJiSw876kT9lDTBZB0kjnCWXMnc+DxMeftp+0z0WawrdjWOFE4lPspBJ65m6ZvwpuPv
         3jA0iCDRfg7D9ldziiupnOoMN8M22M3yaf2Xb5a+xX6EmkIYN4Q+UhJFffYoKk3SNAnw
         rMkg==
X-Gm-Message-State: AOJu0Ywvgm/Hi4UAOD7E9ajYqdeNqya1Se9DaFEMf/9IA1pgfYVvRgzc
	5DufcJezjIbVJJsDHQCZc7u1YviEqDgUjWgOOsQLcTwOMnAYIgAnCpcJU3j2
X-Google-Smtp-Source: AGHT+IHoMUl9KlNBGs/oKkz+jUkVgNTurgeSKGLzaifAJg60c07lI3AfBH9Qqro2kQsfEijxvPAnpQ==
X-Received: by 2002:a9d:66d6:0:b0:6dd:636b:c95c with SMTP id t22-20020a9d66d6000000b006dd636bc95cmr7224237otm.25.1706914504388;
        Fri, 02 Feb 2024 14:55:04 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/18] storage: use l_file_set_contents
Date: Fri,  2 Feb 2024 16:53:46 -0600
Message-ID: <20240202225405.993792-14-denkenz@gmail.com>
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

Use ell convenience function to set the file contents.
---
 src/storage.c | 41 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 5b12c69ba6dd..00469f48510c 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2024  Cruise, LLC
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -120,50 +121,20 @@ ssize_t read_file(void *buffer, size_t len, const char *path_fmt, ...)
 ssize_t write_file(const void *buffer, size_t len, const char *path_fmt, ...)
 {
 	va_list ap;
-	char *tmp_path, *path;
-	ssize_t r;
-	int fd;
-	static const mode_t mode = 0600;
+	char *path;
+	int r;
 
 	va_start(ap, path_fmt);
 	path = l_strdup_vprintf(path_fmt, ap);
 	va_end(ap);
 
-	tmp_path = l_strdup_printf("%s.XXXXXX.tmp", path);
-
-	r = -1;
-	if (create_dirs(path) != 0)
+	r = create_dirs(path);
+	if (r < 0)
 		goto error_create_dirs;
 
-	fd = L_TFR(g_mkstemp_full(tmp_path, O_WRONLY | O_CREAT | O_TRUNC, mode));
-	if (fd == -1)
-		goto error_mkstemp_full;
-
-	r = L_TFR(write(fd, buffer, len));
-
-	L_TFR(close(fd));
-
-	if (r != (ssize_t) len) {
-		r = -1;
-		goto error_write;
-	}
-
-	/*
-	 * Now that the file contents are written, rename to the real
-	 * file name; this way we are uniquely sure that the whole
-	 * thing is there.
-	 */
-	unlink(path);
-
-	/* conserve @r's value from 'write' */
-	if (link(tmp_path, path) == -1)
-		r = -1;
+	r = l_file_set_contents(path, buffer, len);
 
-error_write:
-	unlink(tmp_path);
-error_mkstemp_full:
 error_create_dirs:
-	l_free(tmp_path);
 	l_free(path);
 	return r;
 }
-- 
2.43.0

