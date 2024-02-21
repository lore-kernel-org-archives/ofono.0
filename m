Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58281745
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532667; cv=none; b=fmVEwdPwp3N2608lfdUiOKIiZRbRcV5UQhH9x9ltP17E4w9D1doPQ/MrTM+oALL4R/s+r2KtfdMQytvFpK1qJ/iTdWyXh2DKzglKU8WFhxXyS5HUkdm2hzKgwi5eLiZMBM9dY1TwPrBcksJIGMsggNbkQ0xglXICcgdNCrcqR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532667; c=relaxed/simple;
	bh=BRq8Dj3TeIywC6HGdCK7uFM9Sy5DGi0B4tR5umyx9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWFEyN7viEof6OUxQFNNtfJC1B3iTUB4DSHiZuUjyRFHD24Og4rVPGa8+FWgaxrn6ZqHw6GaGwqZqXTYkz9xH/egBqMUVDbVEn64qiGH4CrxhOl88oxfYcnRQpBTWpcmN5m33oIOh82VAs1LtEK1xuxa9LKPwGW/Dx/RB9/LrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foMZoryd; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foMZoryd"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59fc2d22cfaso340857eaf.3
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532665; x=1709137465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3770Jeud+LnpZQqxRP6EgfT+9//ThNEG/jkxbjD2w0=;
        b=foMZorydlMtE2ja7AaSI2vTRU3ul7vzrVIfwgE2Rtmurrg0TobqBNNeR6ujA4vLiu8
         DsJVsZMWdLqhnLvoWZfI2s1d/P8NGoARrotlFGxOd5uhb1bQLcRHqb8CUzEzQhQTgLmr
         rj3DM5Bnk7iGvu4oLuSm5KoOrPKP7itm/i3WfRaRc/2/e/cwp+CWOin6QanBr9aznlYV
         lIw+ytht8jTNQ7+8/JU2XRYYxry9sQ/SIw8c1f2yWam08fk3ad35x67/g53ij3lWEozU
         oml06kT20H55hGWQ0lfh2vupxRsoHuc9HjyHJRdjuK6jlhjE3Hx6ph9Lvfd+CY6jfRhg
         6+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532665; x=1709137465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3770Jeud+LnpZQqxRP6EgfT+9//ThNEG/jkxbjD2w0=;
        b=S6aAp1hwBVMLmQ9EzsJaFmE949RmxcTvJOMO1vxt8sKvWnnaF2HeWD24uu0DtvJ/hc
         BwCdftlrqVjg0yMR04RDyng+SmQparzFhQWpHjvStnIw4WO105HTuLmr3PNhM5JyDDE0
         3Y+wrxO6z+ZgvDG8Q2U5M6bvTx19p0SvnksRLMYa2Bg+sSaQEFonlEgBZCGrUJ6kmLY/
         BAyrDFE5GTaFasxG06nlB7bvGNi3LKg8ynhifSvSvbdKgdLn19wG5f38qW06AwS+nSh3
         mx8uB56RUd1qXCDTq9cahe0bNBD/0SqMl9H2zJJkXtm5psIVj17ijJlS0jvyH2L10h27
         OSFg==
X-Gm-Message-State: AOJu0YxN9verKwqjFIoYS6MphGwLbdJR5Apn/R12Jt553B408QFj9yBg
	R3gqVHZAWNgA7VneY49sX4qPOjBL3RSCPOOxrCruWTz73wLzg86E2kmnkn8/
X-Google-Smtp-Source: AGHT+IHWIF/H6fLbnNgKzRxFQ+OaLNNjTUPCPbhkEGPoIr/iR5MNp7yUeikoDVcWW2uKpcMNjnGC4A==
X-Received: by 2002:a4a:dcc3:0:b0:5a0:1b43:2c91 with SMTP id h3-20020a4adcc3000000b005a01b432c91mr1358405oou.9.1708532665285;
        Wed, 21 Feb 2024 08:24:25 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:25 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 5/7] qmi: Move version_str to qmux subclass
Date: Wed, 21 Feb 2024 10:23:18 -0600
Message-ID: <20240221162335.1258315-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221162335.1258315-1-denkenz@gmail.com>
References: <20240221162335.1258315-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version_str member is only available on QMUX based devices, and only
on certain ones.  Move this member out to the qmux subclass and add a
debug statement to print it out if available.
---
 drivers/qmimodem/qmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 08adb0f5fe02..59a10c8b8f8a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -73,7 +73,6 @@ struct qmi_device {
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
-	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
 	struct l_hashmap *service_list;
@@ -91,6 +90,7 @@ struct qmi_device_qmux {
 	struct qmi_device super;
 	uint16_t control_major;
 	uint16_t control_minor;
+	char *version_str;
 };
 
 struct qmi_service {
@@ -999,7 +999,6 @@ void qmi_device_unref(struct qmi_device *device)
 
 	l_hashmap_destroy(device->service_list, service_destroy);
 
-	l_free(device->version_str);
 	l_free(device->version_list);
 
 	if (device->shutting_down)
@@ -1213,7 +1212,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 	if (!ptr)
 		goto done;
 
-	device->version_str = strndup(ptr + 1, *((uint8_t *) ptr));
+	qmux->version_str = l_strndup(ptr + 1, *((uint8_t *) ptr));
+	__debug_device(device, "version string: %s", qmux->version_str);
 
 done:
 	device->version_list = list;
@@ -1586,6 +1586,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	l_free(qmux->version_str);
 	l_free(qmux);
 }
 
-- 
2.43.0

