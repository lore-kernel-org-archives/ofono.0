Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93968F65
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314101; cv=none; b=jw6GN32qie8dhFXL/TC49vPLtW39TLbRGZ1g4nuoSga2Ne4T0KHjIwWslenjhbGySbn/KBjTcUtkdvNm3gDaQWNiRDf6aazuGYeVuWFJnbhHXl/nUOQnGfS84Nx9XnarhFgL6ObTI5rbIiHphK3mjnouS3Oll2pSiVPfWGicZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314101; c=relaxed/simple;
	bh=jjbsn6dWQ8Xr8AeA29DrnipeTNYmIgZDgloHLjT7fT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBKAEhjPQJLbFD0AEcfvLLGrsSozjTx0XRA6DHSXg/vTw6DzPTjdiAbwable4UOmXewyxEJBecyEA1N9xMT6RXjshVdjeGxeFdlypQ8qBTPvk2T0GxhCgPX7aNgP7Cz3D0mik51tdUQjH9cNeFw2isYMKdWI+s+KlCL2eNHSpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEEBk06z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEEBk06z"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a109a03276so263647eaf.1
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709314098; x=1709918898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMhIZz/2u20eiDboMKDtd5tiktaCNH0FczveoGzeBE4=;
        b=gEEBk06zp0+amT5wefSAt0jnNtpDy/yIvjnb7FZY9T1RLzUys4XNQlJ6XH3IYYpJmr
         +IzzNWu7JhpciugTsoFVzJXx6h4u89PKnuGr5USUHWwhn9a8n85zJOEdNIFH70cQ/Vur
         K6rYXzELOywkDgFZL3ku4IxnLTggZVLHOL1i0Zbj3cma42dJFQF48sByJF7uFaVMtAeW
         LdE8DyNAC8IQ21RhJMhXanCwqkClEVj7psNLwFlfPQgMDwBJT/BWCxGXJi7zhwJA3dLD
         H/KSt82mtIq7KJsNn69rve7QaLaZUWWpAIkK5jvf0VZ4x49BmnbISVYnhfFBeRKReOIi
         nFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314098; x=1709918898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMhIZz/2u20eiDboMKDtd5tiktaCNH0FczveoGzeBE4=;
        b=KConywk1BXQ47IQv74oQYdMQevkaSMhek6CNRM0j7nADBaPtnIxXUpVVerE+PobQ1z
         dCvJJ7I6ksYpkysBcw8rndta4WPn8EUvKCpXEJcO0k+l4mjLMqNK8MK4zl+MECeFiiHj
         q2Ebb5wM1rEdKqr2edKrMwMsEaOJD++zisNLzlksrc5c4Msl0VgA9LKgz9NMVFWa/gD+
         3ZXsKU0ejfh7bywP75C6QmW60NC3o9q4whdIdt5mcSAGz4NzKuioKQ+ickeDWVKRSgSV
         n5jHGy90N8upKt9tpKdq5yTIvuKI68slMWdH9BxmXF8pf5U1lxEMEwxt9TzZNSZwT80I
         qg+w==
X-Gm-Message-State: AOJu0Yz2zXZeWVdVxrzywHfHP3u0yJVqNGbKJMSSLT5FmCK5MLNGdZrG
	UKePausx7SXLtUfp4CAIgk7dliEKlM/28BKtYOSSIXj5AzyhAaDfVnQrQ76y
X-Google-Smtp-Source: AGHT+IFajvtWQWRlXV2UptanzMeSKzZBdImGCGAz0Q3P+hIjIfO+gToSsQGPM117ZlHMWPcc+gTICw==
X-Received: by 2002:a4a:6201:0:b0:5a0:b781:fddd with SMTP id x1-20020a4a6201000000b005a0b781fdddmr2171425ooc.8.1709314098719;
        Fri, 01 Mar 2024 09:28:18 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id m15-20020a4a240f000000b005a0131f0315sm302999oof.2.2024.03.01.09.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:28:18 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmimodem: Add support for "embedded" endpoints
Date: Fri,  1 Mar 2024 11:27:57 -0600
Message-ID: <20240301172816.1703961-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/gprs-context.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 46ba46c95139..f575c5e2e1be 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -403,6 +403,8 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 		endpoint_info.endpoint_type = QMI_DATA_ENDPOINT_TYPE_PCIE;
 	else if (!strcmp(bus, "usb"))
 		endpoint_info.endpoint_type = QMI_DATA_ENDPOINT_TYPE_HSUSB;
+	else if (!strcmp(bus, "embedded"))
+		endpoint_info.endpoint_type = QMI_DATA_ENDPOINT_TYPE_EMBEDDED;
 	else {
 		ofono_error("%s: Invalid 'Bus' value",
 				ofono_modem_get_path(modem));
-- 
2.43.0

