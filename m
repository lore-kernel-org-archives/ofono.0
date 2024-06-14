Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506219AA6E
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391193; cv=none; b=Rb+X5WdqYl1KMUUsLXFpku+dqvFeUMLkCzep/XBSF+nPy61I3H9mJnsFskQs5cq8qB2gUaiyQxnr2iJOMJLb1GkqipYU7xtR/yKGVNBX/Xr2KE6x9vCUpaqSDvjCwuraSuE8dh1JVXg4L3XWrmlxk4DEkmKq1c1oM89r25w4n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391193; c=relaxed/simple;
	bh=KO0TMU8GKGboG1T+32gX+hOuvWlXrIOh5uVrj3vo/yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcU+LXukMtAoE+Xyauc24QZ9iKWIacTQuWDXVqayhFkNXqC6ooSP187MxfpxzUQusKa/mjP4/iaC5H4Uf3hSsv1b6KocFa5ME20saLxR9GzGHdqkvTqgQIRKrcHig0+BIJf4mSt984QJ4KH0dDY2aFS3d7SevDqTcC0GJnD/mmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrQQuTi9; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrQQuTi9"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9a5be6668so1305878eaf.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391191; x=1718995991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwkZ84I3GxsG5ccjbIaHjk3a2DD6fG6gmqg9Dv4D9Is=;
        b=QrQQuTi9nLQfXOC2xT/jFP6CjK90VwU8gzPu+nVrAMQvxdavX7ucs/s5i1hyqJsR/B
         NxCdld4jz3n7tUkf+RPTYungaF95raPbVuugnfZA7aaMSw3uwpW9nkJFPYfy8CCzkQ4Y
         q1fjHs9GvzPlgsgpo1azkDj7g+jNjN0Gjt2UzhJG+RNecT8qBWTkbz79pk83JgMBRABt
         RMPqKD7mPVoJun0T7Y++Y8J94PWqOq25sR26zLFfjXPjStZz2fSC8hUPpglD8hGdW7Lv
         q9HiVASU2C5VAfr35jBTB/VZM5RUBlWwx+c5N6PH3F7kg2mUocKyz4+tFm/GoFPnoHA8
         FxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391191; x=1718995991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwkZ84I3GxsG5ccjbIaHjk3a2DD6fG6gmqg9Dv4D9Is=;
        b=pHi25BM8ZaVkIdWOqF3bsHJFwSkxt0cxuX2lfbeqN/8GwLDfoHw8JoUHi2njswafgk
         gCJhfqV/Jbc8sJN9wxJij3EvRr4U8PY6VwTZnoRoQVoh80PfpzuzI8+H/W5RCL5dKuFf
         MZbnuyYiKiFxSQmSBLQII8Kn1yBhasrzHIDChNYMcAj+zeN9bbPjrDKkamGGF2p/Gl5Y
         3PlJ37lHeu1lq2IF8G8SkONfOj0P3YmcH9rObpK6BEyddx0nGXdz5hxJqCAjBjCnQVU8
         n8d2KCIvmkp0BgBpuIz3zwvirX8llZ+n57jkfmVE+mNRYRnzn6vMgVJHS4NTJQtLO88S
         hqyw==
X-Gm-Message-State: AOJu0YwsngYBC8sgSJEJMh3MomdrXR1N0uRGnjm5Dl39vvYHOcARdbfl
	wPDBeHgE0y3WOnwlfChRnoriBtb24TslYu1cUJLUad0EPmiwWnVumFytGA==
X-Google-Smtp-Source: AGHT+IG8PxDH3e/Jvx+4u5F9C5yu/T4M5EIjmZPNCLKW9ddxYQosyF6SWIT2Sm1j6iYxZSKuuyo//g==
X-Received: by 2002:a05:6870:9589:b0:254:7f9f:3f21 with SMTP id 586e51a60fabf-258429989dcmr3933815fac.27.1718391191232;
        Fri, 14 Jun 2024 11:53:11 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:10 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/27] qmi: Rename qmi_device_new_qmux to qmi_qmux_device_new
Date: Fri, 14 Jun 2024 13:52:23 -0500
Message-ID: <20240614185300.1086701-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/qmi.c | 2 +-
 drivers/qmimodem/qmi.h | 3 +--
 plugins/gobi.c         | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a845e3809090..9fdc209edf7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1991,7 +1991,7 @@ static const struct qmi_device_ops qmux_ops = {
 	.destroy = qmi_device_qmux_destroy,
 };
 
-struct qmi_device *qmi_device_new_qmux(const char *device)
+struct qmi_device *qmi_qmux_device_new(const char *device)
 {
 	struct qmi_device_qmux *qmux;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 10202fba6128..966d4f354d6e 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -68,6 +68,7 @@ typedef void (*qmi_discover_func_t)(void *user_data);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
+struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_device_free(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -87,8 +88,6 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
-struct qmi_device *qmi_device_new_qmux(const char *device);
-
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index f1a7df447a89..cbdf5adb16be 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -501,7 +501,7 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	data->device = qmi_device_new_qmux(device);
+	data->device = qmi_qmux_device_new(device);
 	if (!data->device)
 		return -EIO;
 
-- 
2.45.0

