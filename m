Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E315530C
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622128; cv=none; b=T4zJhRHTBCqxbEFnGPXFNmXd9BtYorDY5pV+ZhM4MpB42dj3283S/qzw1/aRvjia4fz9PAwESkTAKFj9rK6pHiAQllloeS6V/QefPqi9UMgW3+LR200FyFpQPXoweqvRdNFsb9exVA+ISe8fuwBDdg4/OY579+/IcYAa9Ivtrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622128; c=relaxed/simple;
	bh=W9EuWcdUSjtp/rcKtFlAEIt5sO0szj0lmOEQwb1jIKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4LIlpufN7Ssmx+l65e4HU3Th72qL0GOsb28SXwxgXp01N/4ZsgZXBIpU9xJ21kRR8n72ITTWxZWPnidXM80GpqdOZcACeiPlAVknuIW5B1v065Lf67R8K7MolwuGTiiGN2W81Tx2ZHywuxdLMakWOyWeNKMpa2xpceE5XQtsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch28tr0A; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch28tr0A"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1652613d3so2322858b6e.1
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622125; x=1709226925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmY0JKrnOFM1cDu9hlc3dINxP9KgHlvo9DYGsAOhKQ0=;
        b=Ch28tr0ATlfOXbbykiW6xnRyPdq39vZ7RYn7qM0MzFpar+rpQMUwm1A5QN7DySZ/2V
         pUPheUhjhUxQ4+lwqHSYvPwJbVC9rT/PEptDSWBpKm9zQn9iuncjoo3MrrKgwRSj+Lxr
         LbAJ2l8gdnmigFFRtkdtrYMJzg5jJML8IF8CgYuJjovZFS8iXIWX4xDGiaulWGEqEtvn
         Aq+6ki6UjBw06DFgEr80egTOwPfT/5XyZnncMQn6Uc/rSS5BjEhjsAxc5eVZIcmv8hVa
         BWLgEAOmw8mhfZ876XFym+NRscu//IUZ4qJ1vs8SfvAwdOQhI7bt7EKDPdNiDfM628eh
         uQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622125; x=1709226925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmY0JKrnOFM1cDu9hlc3dINxP9KgHlvo9DYGsAOhKQ0=;
        b=K8wjqzQXrjYi3X7w6lvpFiucewHYE3WwN7Qio9c29kPomSnS1KNkRSVLzbDL4kh4ND
         u9h4ABO0UUGDflb99ee60+2kDcutRHHYE+euv93VoBGxRqfbE7MzHrpCWyYbykEU4xaQ
         +Che02TnxHWNX6/NdDVVXrKa1ZbTNTvpIDJxvY1MYlRHN0Xv7Ouk6VQgqjEY9A3e16kG
         P/2Z2z3AHLOVNjLxa8KaOOM81O2VYxOpRXgzQhv49hM6PiI6ueGZ0LiMvFBR9ZA6BGLm
         yciYcDSHAVS4FPptbnLCA/xN+IdGKVOGYxaGRsUPb8V5UaBtgWuAuofPFccYs1AulTPw
         NP7A==
X-Gm-Message-State: AOJu0YzB7Qi2a/So2m21pzsWjPosk+Y9rrzVxdLdDhmn3gErVApILr+W
	5hTNQSVAb12FuvbEwFyxfLhmNGcUu+kp0F6Qhi6rWnBq06lQ+Zd1zH/tkQwL
X-Google-Smtp-Source: AGHT+IEyL8gtI54+tES1AFb4NczU2BHUel4gsja36N7pLNES3FTuwDOZS619OLQbsM1VWEG8BCuMng==
X-Received: by 2002:a05:6808:22a4:b0:3c1:8507:9fcc with SMTP id bo36-20020a05680822a400b003c185079fccmr343076oib.53.1708622125641;
        Thu, 22 Feb 2024 09:15:25 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cc7-20020a056808324700b003c178f6a504sm355898oib.14.2024.02.22.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:15:25 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] qmi: Drop qmi_device_ref
Date: Thu, 22 Feb 2024 11:14:17 -0600
Message-ID: <20240222171438.1291553-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This API isn't being used, drop it.
---
 drivers/qmimodem/qmi.c | 10 ----------
 drivers/qmimodem/qmi.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 52a8e57c23d9..2dde31b11c7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -961,16 +961,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	return 0;
 }
 
-struct qmi_device *qmi_device_ref(struct qmi_device *device)
-{
-	if (!device)
-		return NULL;
-
-	__sync_fetch_and_add(&device->ref_count, 1);
-
-	return device;
-}
-
 static void __qmi_device_shutdown_finished(struct qmi_device *device)
 {
 	if (device->destroyed)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index df4bc39644a2..14ad84e5006a 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -81,7 +81,6 @@ typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 
-struct qmi_device *qmi_device_ref(struct qmi_device *device);
 void qmi_device_unref(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
-- 
2.43.0

