Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50188176255
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895109; cv=none; b=oKV07nFZpVRqM65W7ped18eDqRG4HQiJvF/giR0ZcVLbjdCfM+dq9kKp4J9ahlIxkX62EGItQ8qQo4YjJ7N4WYzYmphiePf5l2JRbSyvKbS91n9a8VWQ/Y5zfWm/z4u3VvKcZge1WcAQ2URthG+ixL6PT3vWkSOc8zTBpyhjuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895109; c=relaxed/simple;
	bh=HUU3sUQwdUaQObDoIMlsAJAGfuur9LlGmMKFRvkjIlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJfRTqk+4ndEnVcXS2/PMOzFsB1YHEr8peIXNqasOHvOE+hFT4kWcQ+46rhGfhhvJGkvPggJg8JKvgoMdCU17wiqn0ifCseHU6B3auEZ/FY6IbF0B5SkCpUHXXFrs+6WXLbg7SlH/y3nrswGej1/MUAuAgw/qjooQQq+L7224bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc4E0RHm; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc4E0RHm"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d518cdb252so453082b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895107; x=1719499907; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=cc4E0RHm+YQyh1xJyulO3MQWPW56gExE71fkPdNma1Q/pb+G6PZxO4n5s+e1GPDMyM
         sgWIdnP5EcUVp+zcSinvP2ZMW5eSIO7vLXr7/hoxq3dMNOGIyYoutzHImmeetZkKXbNr
         2toxyuiZRlFtncCeIH4/ONb3Pf8ryhC11zchAoLJxSo7VXVoGY7h+imZd2W3Tgd7dgyH
         NGFYZOMFbe2ln//fdQVJhl/KmBmN3umNssg0LI806o0iTegAv4EtfilGhjj4dCO8XUxX
         A8BLEAb/vlI4Kz3fVC5skPurs6OiYbVwjLjDw4e1sklvTq1BIyMXHxB+j7mSmM4U8HqR
         LjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895107; x=1719499907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku0cRHSkqfHg1v79ZIDpC0B8jaIvjzt5KGSfHCSRpGk=;
        b=l68Fq+SCzYcD9VHYn11H6FbizntxdzdEQEs05VCR0xVQWCJRgMF+fbfvij9G9ir7ZA
         s2/7T5hG1GiPXeEQtn5sPKye8zAHd9aZO3gfExIaZ75ys8H2vMU/4sp15VyUjB5M0DBW
         BAAWr++nfQ5Aibsp3vmYtpdKaPokdPP2qYDlhH+zjQNADZO+J/fD1W/7HYJTDHSIbSDm
         k0K0dnxK0LG85mwIiPxDbQEAtK8pkyBCg68S32QksgHPzIa9dkfrcyGR33NlHq1u1zqp
         wlPx/pzVtQOCVwIqsN04zDiobndDP/5TKA0hSMGv9q4d+nypdrKN04R7Umoo2Z79L07M
         9u+Q==
X-Gm-Message-State: AOJu0YyIWuOuOiUp8/tCatz1QorXN3Qnsd8X3s3rG0geHJNT9IsAsDqf
	0ZV4B0YHVpYj85Z7eFORPHrImg6D42pGbP1Gqz8sfWowZtkoJQI7rSqkHQ==
X-Google-Smtp-Source: AGHT+IGKqWBthjwIQNpN9uMxyhFR3XzERfBi8xWgH8gc64/61PXI+sJYpSHOz2/QNNo0RzZr061uBA==
X-Received: by 2002:a05:6808:1985:b0:3d2:27cd:fe1 with SMTP id 5614622812f47-3d51bac5643mr6390748b6e.40.1718895107227;
        Thu, 20 Jun 2024 07:51:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 01/33] qmi: Remove qmi_free()
Date: Thu, 20 Jun 2024 09:50:48 -0500
Message-ID: <20240620145139.1135899-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was just a simple wrapper around l_free, get rid of it.
---
 drivers/qmimodem/devinfo.c    | 8 ++++----
 drivers/qmimodem/qmi.c        | 5 -----
 drivers/qmimodem/qmi.h        | 2 --
 drivers/qmimodem/sim-legacy.c | 6 +++---
 drivers/qmimodem/sim.c        | 2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 2e514cfa3265..fd1ca3ceb2dd 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -45,7 +45,7 @@ static void string_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_query_manufacturer(struct ofono_devinfo *devinfo,
@@ -136,9 +136,9 @@ static void get_ids_cb(struct qmi_result *result, void *user_data)
 	else
 		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 
-	qmi_free(esn);
-	qmi_free(imei);
-	qmi_free(meid);
+	l_free(esn);
+	l_free(imei);
+	l_free(meid);
 }
 
 static void qmi_query_serial(struct ofono_devinfo *devinfo,
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 91469dc2e00c..632f647e5ea7 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -181,11 +181,6 @@ struct qmi_tlv_hdr {
 } __attribute__ ((packed));
 #define QMI_TLV_HDR_SIZE 3
 
-void qmi_free(void *ptr)
-{
-	l_free(ptr);
-}
-
 static bool qmi_service_info_matches(const void *data, const void *user)
 {
 	const struct qmi_service_info *info = data;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 821e54443658..de6238f25e62 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -56,8 +56,6 @@ enum qmi_data_endpoint_type {
 	QMI_DATA_ENDPOINT_TYPE_BAM_DMUX  = 0x05,
 };
 
-void qmi_free(void *ptr);
-
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
 
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 1feaf86976c6..4c909f7f4ae4 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -71,14 +71,14 @@ static void get_iccid_cb(struct qmi_result *result, void *user_data)
 
 	len = strlen(str);
 	if (len > 20) {
-		qmi_free(str);
+		l_free(str);
 		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 		return;
 	}
 
 	sim_encode_bcd_number(str, iccid);
 	iccid_len = len / 2;
-	qmi_free(str);
+	l_free(str);
 
 	CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, cbd->data);
 }
@@ -128,7 +128,7 @@ static void get_imsi_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_read_imsi(struct ofono_sim *sim,
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 876274fa87b4..1fffae27f63e 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -427,7 +427,7 @@ static void get_imsi_cb(struct qmi_result *result, void *user_data)
 
 	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
 
-	qmi_free(str);
+	l_free(str);
 }
 
 static void qmi_read_imsi(struct ofono_sim *sim,
-- 
2.45.0

