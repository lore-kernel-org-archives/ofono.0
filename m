Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301A2171E75
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333724; cv=none; b=tUUXDx+q7xcWb6DbHQoH2VyOoQLZRchej1eKEykrFklW+vQcbQCnYJnCkfztaPNDn+ZiKN11/p3XHJ+lObzmcJZLwhixdpaHUNeRnWnKpyyTJQgD0juBygCZcAIeH3t9+pD/ANpo97RFdI9P7R90AWmZ2hjZrtT9/r0CTtRjzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333724; c=relaxed/simple;
	bh=dbqjMrjUQTfCTyD3Ho8KYPphw9aERUYXc7ogkqsrMf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4qph8nnmt6hnyaWXmWp0a+U6Vw4dIFaDc7lkMFnBlZmWzhoovHjCWV9p/S42bWlBoCDmNuNKZBKyKyTHbIOCZvgG4sYYG9CZ/Au5o5JENkOu3Y8RXgzmLaPvxZEwJY9qVgeWqfgQQzwovv9x8gGvQjU8hxwrg26XxBstcsvlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU2USQjs; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU2USQjs"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b970e90ab8so3249805eaf.3
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333722; x=1719938522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INYROVZP49t7Kd5s53aJh9lmOKM9To7nJkG2blZxgp8=;
        b=BU2USQjsgPM9z0FSfq/SBE+sz2gkyy1j6WA0srNBJClHNVR8aR2pPbZQ7QgzOh0qVO
         N6OD/AjuU8f6BDyspt5LFNwMfjnKKn+RNYLniuEWc3wh1SE4u8BGOmbpSAGbG8ihuCAn
         CAimg31cO4mgzSmnZAZNB8+Kf6B9oo81gkHVLP3q/gQ4RYOnBY7i2kf/0D0DNDC07FSo
         pinr1c4jBFPw9GbosXNPNhWghreGorzKPWZiGLG968rxz096ABo2J31R2Ve1XJgqGnG6
         jdh5rNA3WM+rgeAegKQEE/qb2wsPFX6AYRKwrQzUq8N6E8hkBaAxHyUU118RhLN8ibla
         FVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333722; x=1719938522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INYROVZP49t7Kd5s53aJh9lmOKM9To7nJkG2blZxgp8=;
        b=i0cswi9FmUt1ZrQGWJLric8ZHOWZncVAZLNAi1RD2/8beGAkmp55+4doRVcx8PJRBw
         kegMiZcvxC8JRFvu52V2hqY1Ct07CAp04+hkQi50ZEqfAxCv339To88ce5HocQd2JZ4L
         XetLMwnLA1I8Qxjvkk8NApojI4G26g53yw1WAQoxHzumWffaw6haL1xQsQ3eK+ed5g9l
         D9aLqo1V4ffxst+SMFU+xgrBn6K54KNuoYnfR1qNeJNKyKkz9tddnWBz66yFWBqJJyk6
         jIGWMd1xmuFYhjXCBck58qsu/4nUcsI2idxZt4ZMtii6h+09YtxzKg3si668rmjn8TYW
         Cppg==
X-Gm-Message-State: AOJu0Yy5gqnlpNJEfnDQ6hI5GHnCG/fVzvfDO9mRbghc3LlTcLpqracs
	F9m54ekw8dN71lLte3+i/R9ZLDJYZr2DYVcTyNledSY6U4LDtliIdXjwTA==
X-Google-Smtp-Source: AGHT+IEWcHk6lbrzobrKdIvFQJ4QRCGupY7zqAMSebvCcT+AFYwv9OY62G/ndDWHdqLPw4QsI8xyrQ==
X-Received: by 2002:a4a:6811:0:b0:5ba:ec8b:44b5 with SMTP id 006d021491bc7-5c1eec2b3fdmr7907479eaf.3.1719333721951;
        Tue, 25 Jun 2024 09:42:01 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/14] qmi: Remove control_major and control_minor
Date: Tue, 25 Jun 2024 11:41:38 -0500
Message-ID: <20240625164158.1170937-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These attributes are no longer used, remove them.
---
 drivers/qmimodem/qmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5f29c4384803..238039d4add7 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -100,8 +100,6 @@ struct qmi_device {
 
 struct qmi_qmux_device {
 	struct qmi_device super;
-	uint16_t control_major;
-	uint16_t control_minor;
 	char *version_str;
 	struct debug_data debug;
 	struct {
@@ -1235,8 +1233,6 @@ static void qmux_discover_callback(struct qmi_request *req, uint16_t message,
 					type, major, minor);
 
 		if (type == QMI_SERVICE_CONTROL) {
-			qmux->control_major = major;
-			qmux->control_minor = minor;
 			control_version = SERVICE_VERSION(major, minor);
 			continue;
 		}
-- 
2.45.0

