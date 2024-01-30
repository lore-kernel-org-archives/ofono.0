Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAD76C87
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649755; cv=none; b=TitjPvYC2A1YPSIa1hnQ3bpQw2U+D4b24abUJkib9sATy3X3ebqEZrQKSku8XDkyrbUh7XhdFN02w/dPLaKLvXF44QZdMewRrFVLIt+IpNAc7YfAL/NonCDrLKdW+0XkI5YRBnxGZnvZ+jYwSVX4lHZLq8K1m9A3UJLGsotUlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649755; c=relaxed/simple;
	bh=mYxwPgYSG4byzJilt5DBxW9ht5h0BDDnE1RQtYELBqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHwx9/KShKPtvTTUOrJxEOkWcHILgQIY66oorVYs98TxinBCXCGjeZlayrkr4jtSGHQe9PICIwNm7DBxGTmf6WYG0ma9f9PutwDVeGeokD/FpFkRdmg1FULx4Euvlg3ILHZ1zl2JTXyGvYhi5mQfSkockXwOdxxVnskvUeSIpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRBG/Z51; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRBG/Z51"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-214ca209184so1996019fac.1
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649753; x=1707254553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9W7uBfXrrWqqZB7aYpdTIdvqR93StqblSi5KfQSWLo=;
        b=PRBG/Z51cpB/JJbe5d885izKf9ogVWrgJV1dix8pdQRRjWr99Wmx99azySB/AmN2rL
         5PYRpGGYLzizynLr9ydy3dRM3RO64uIeZZFRDmvUBXyZ1lCxkwtpFy9fltT54T0IoH/S
         GukNGJn8Ys6CMNin/RJBscQ2V7DwcjVSibl0/QfUOPNOL+dZGhOtQxL3XS+9GO+3WR6d
         dt6pQc235aPfdVBPyLC/DoRHz9Q5U2HxGrubA2UpEafEI2YsxAIlNh53QvqnQjvanQS0
         LK6Pom7GPBVd1nKe6mWZVEvYHIqEWW4AK/AmqyI7LElCstg28eTu1Hv5g8PozLmrwdR2
         9oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649753; x=1707254553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9W7uBfXrrWqqZB7aYpdTIdvqR93StqblSi5KfQSWLo=;
        b=X2eFuxH143iGVQCilLQmbzXYIz0wOu+rtWWrjQrRXxiD2NvjglwrrHfIn1YEmWw3w3
         EQD0EQMo3SI1K+Pw8GW+bxiIoboCSgAEGLuwOhWihhBt/e1arxF20kxdTBy0iOp+lw7N
         uNlGlZVbjvaxBDW0lEp/7FC6oIi18/dfKS8jD9I1mRl0rRa+RkSin5cuQ6idGpLE5LMV
         AZlnSf72kZRlhQ13RkMqH7OsA0RJcZX7DQXy7bqoxNrQX0MLignJTRtTH1h/Or/OyqmJ
         gaxTZnBH1vkBjo/MHDo61aihGJHtQgsFNvFYZdDd5dMa7vMUjKnHtIG1Ydp3zrlm+1mX
         lkBw==
X-Gm-Message-State: AOJu0YyMhWbf+ocDuaBdg1Z1h6heuXTO71Mc9Xa359r7c1NsN0CGY0I3
	QlaM3T+HuP44UmlPD092f1sqxP4Cf5PNQOdoOPjZuKUlV+8VNvjDCbZwZ9EF
X-Google-Smtp-Source: AGHT+IG9MFYeRky1APfrx5CKoVGCvkA3dNNp8t0Qmqj634JcPnCTppNWrYEAG9lixghuK3J6yNGbtQ==
X-Received: by 2002:a05:6870:3287:b0:203:ef0f:7042 with SMTP id q7-20020a056870328700b00203ef0f7042mr11423944oac.21.1706649753016;
        Tue, 30 Jan 2024 13:22:33 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:32 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/17] storage: use l_file_set_contents
Date: Tue, 30 Jan 2024 15:21:18 -0600
Message-ID: <20240130212137.814082-13-denkenz@gmail.com>
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

Use ell convenience function to set the file contents.
---
 src/storage.c | 41 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 35 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 30e004e75d91..130fcc9ce4a7 100644
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
@@ -121,50 +122,20 @@ ssize_t read_file(void *buffer, size_t len, const char *path_fmt, ...)
 ssize_t write_file(const void *buffer, size_t len, const char *path_fmt, ...)
 {
 	va_list ap;
-	char *tmp_path, *path;
-	ssize_t r;
-	int fd;
-	mode_t mode = S_IRUSR | S_IWUSR;
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

