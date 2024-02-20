Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666D153BDD
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468928; cv=none; b=N8kaRTIhcKCxcMgk4K4kOlZvkYDgnw8QF3aWy/Av4BhmyGDgcsToJmKlQDDPYJeQ+AxPvdmQ3EsMmq76X33Ngh+FDRQeTo40iY5wJwU1rD64nt6AI1diEG79u5QXVPk1hydkxBrthZDiiYroknDVlnbz2MVl1fswt/XPcUosFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468928; c=relaxed/simple;
	bh=RhBSKqRpApsLQHZ6P7+QG1Mtrv6i+R3BQoONgBjCrLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIXPcpOHOJbhLtJtTMNb+iqk24NRBqo2wBy80RWYfDlW1ie25US2XIT1gJS+wyxN2cWbk6bzpFtoeeyEBeSbP8MV1Wpvkubt8XVhtqYLdWyrC3z97tCwpRm6etTM8apHInY+KgbICEK9N+6MnuLjeXZxcpcKYk7MIAvN91n6s4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixEz17hx; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixEz17hx"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204235d0913so3759479fac.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468926; x=1709073726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf1gjBRkNUxU/zigl7LWX0W3eEotXOcrDqDM7grgO0s=;
        b=ixEz17hxnHbqvYWqQ5fzy9PZQDHmjHEZklDth7/tqIr+1nZxUjkaSzSI30Krw5x4R4
         EIP9h3yW8tq+gWxG2wTNtnGxxSvITIJ+rD2i62TWlp5SflknND92a5QQBxjykBU+7oNj
         X3gPs/3GRQZkTvd8mssdggLIxW1ZO7jiYJfFAFhoHZiEcyTfq2bMh5Fcyl3SWCvWuxHg
         TIFkNa8Y1VWb8/0u9a675y0bnCDMvoAT0i/3TKbF4JsrMjgxejGoURMYolhqL8jRVNv5
         d/jIBJLeOYf7f6lvX7NOQhutNm8zNw+qps2q+XHooGCRdPl8rbFoPXp2BhiYUvo8zSNK
         8+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468926; x=1709073726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf1gjBRkNUxU/zigl7LWX0W3eEotXOcrDqDM7grgO0s=;
        b=t0RVBDwczjj1En+W2pSCvn6bOXtbh/yQu6PI7lTphHienio9tmrP8yNiLbREFKd3y0
         9maSx4LwlO89nxd6TrqTqJcbHjbF1f+TQQA+fcg7Qi5ixMtN9oSO2ks4dI35hIIVVh64
         qWwWuxB5iQadfvxC0wMy5GzIvbn308n2Dmet/sJJ2pJ/tbZsVxpb3xcjUV6TW5W0H49q
         LvVF+l8JpMm117sWB6ap/U/POgmOlKuIZWMIq1tKWAKMPi95MfnYufhA8Hdz/iH7PuKK
         6rw7EfZyVctq4dHhXgM92L5septOVIiOs8DXrqyoFj/A0Qe8AGFWBC9h/P2Py0Xm58Q9
         TMhQ==
X-Gm-Message-State: AOJu0Yyav9R93/VWlWMM8Tihd5BxnAVLLpP81KLDvIsYxkmRhk3pFjcY
	FmfNHV8RhwQHxe971dXmjH6mlXqjcS43Uxff+7PvHoMIMER/3U7Z9tq8PNen
X-Google-Smtp-Source: AGHT+IF//ByJGGZelJrAobijFObGC9W+g24LzAXAYzn4L65MxcbzG+IA5zv4nWTWO5d5ySoi8+fKZQ==
X-Received: by 2002:a05:6870:1581:b0:21e:bb30:e2b7 with SMTP id j1-20020a056870158100b0021ebb30e2b7mr9685658oab.50.1708468926122;
        Tue, 20 Feb 2024 14:42:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/7] qmi: Move version_str to qmux subclass
Date: Tue, 20 Feb 2024 16:40:58 -0600
Message-ID: <20240220224115.1254853-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220224115.1254853-1-denkenz@gmail.com>
References: <20240220224115.1254853-1-denkenz@gmail.com>
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
index dae540251118..47a9bbe2cb59 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -73,7 +73,6 @@ struct qmi_device {
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
 	void *debug_data;
-	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
 	GHashTable *service_list;
@@ -91,6 +90,7 @@ struct qmi_device_qmux {
 	struct qmi_device super;
 	uint16_t control_major;
 	uint16_t control_minor;
+	char *version_str;
 };
 
 struct qmi_service {
@@ -1052,7 +1052,6 @@ void qmi_device_unref(struct qmi_device *device)
 
 	g_hash_table_destroy(device->service_list);
 
-	g_free(device->version_str);
 	g_free(device->version_list);
 
 	if (device->shutting_down)
@@ -1269,7 +1268,8 @@ static void discover_callback(uint16_t message, uint16_t length,
 	if (!ptr)
 		goto done;
 
-	device->version_str = strndup(ptr + 1, *((uint8_t *) ptr));
+	qmux->version_str = l_strndup(ptr + 1, *((uint8_t *) ptr));
+	__debug_device(device, "version string: %s", qmux->version_str);
 
 done:
 	device->version_list = list;
@@ -1648,6 +1648,7 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	l_free(qmux->version_str);
 	l_free(qmux);
 }
 
-- 
2.43.0

