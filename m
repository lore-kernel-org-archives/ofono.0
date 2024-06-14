Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FB1A0B06
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391195; cv=none; b=XIxux1w8R5EfYWIwJSMrIqKK7u7ij4ZuwOJbRfNiWbexA/6tg8rfGbCLNnhelf8YPL0R7yLGysDsQ2r+LAOGDSdvFeu1W+FXcZNt3T9QourTsFfpflCLqmIspA9Nh8EX30XZtuamasBnhQEp/GOgby4ax454wXhwlkqVIRE2gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391195; c=relaxed/simple;
	bh=OAIVS8QwqGVIeKGqP7rMgVdWxTgRaJ3OdwBOvMSArrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfKT5AOqF3GLFPYBXFUchs+Sguan9Ek6ZNgO6wfvZI4gc8SwfFx+ZRrlcHcebysB1LJjHBzYQbho61nz/MUol/Wc2alqcSOmGyCR44qrowT8nBzrJtme862+jHaIRjXKB+wkDeWg+7bdWtiCS9BjrqyyoVUCBVCirPMeNTQ4ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmriTxsA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmriTxsA"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25496642859so1244391fac.0
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391193; x=1718995993; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubk5uOl+PM1LNRYmeGTECHF8NNImlpu65iiTeF6gQI0=;
        b=UmriTxsAbyWwBPhs+UA/xmzdzjLTTgGZbmidO5G0ZoDWqaaSu57B+oLlmTJHSRUzbh
         9zEeYl/vce6SRmjy3h82RBCtL6JuLOhhMnnurYHUAHzGJMq7t5cFmsVyO1Ac0p5QqpIN
         ggg8cp/iDlBZPkZ95w2/95+3gsNzSfZxEgSe0gEaZOo5ndkeyBqh0PA6yvKhhIba+FGi
         abfOfJUQc1FDDskpn1fRR/YtHk/hych8CehyvWXgZYhcUq/r7LMeKHADqnZnJB+pbeZG
         5FWGJRZsRCFi2OmZcRG64o8/mQs2DSv57ihez6xqVkdcLk6u7WRLU9SJ59AIB5/Xwk0b
         PB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391193; x=1718995993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubk5uOl+PM1LNRYmeGTECHF8NNImlpu65iiTeF6gQI0=;
        b=wYUVWAS9Hxty6XK26awBKB5XQmgUDA8g8z8URlf+vryJLt3FApBSK3ctZ20959sLyZ
         eMeWdwv0/50346/APSG2IXQC7HJXG3pjqa+0SH/N3ffTdozwgFYB7LvkjhEOOvxkF5iC
         JqF0ttCswFzsAx92f1ILw6HiPSW6DdRtYC3ePVs+lusHUb6O+XPDJmG49ffgwTBeZ7z4
         hHIaKAb6ShjBcX6NNk/PAdBcOBtcEqh9JXnXNFdow2BwbNhya22rqN6Fp6aYg0L42Jz5
         YXxUzontMVf/0Y4ilhyF7rsE01vJculAi/o2On/1m1B1jYnEZ1z0K9vqijjfzvK6WG9S
         fPZw==
X-Gm-Message-State: AOJu0Yw2Q2juD6IOPN399+kNwX11ENvo2xkLhhmb8Msg92sKlhTvFT0R
	4Pp5MU5YFFJ0ieszo5GmEPjrOzsyVydNVmntdlLWGYklK/mKt/JcgNzRjw==
X-Google-Smtp-Source: AGHT+IGkH0TM9HYkaEuZZ47R8MX/SM2Ygtij7f01Y4NPjwVe+q0mCn7kZWKigUJLMHP1Pdm9uunqLw==
X-Received: by 2002:a05:6870:891f:b0:254:8666:cded with SMTP id 586e51a60fabf-2584288e4fdmr3662553fac.11.1718391193198;
        Fri, 14 Jun 2024 11:53:13 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/27] qmi: Rename qmi_device_get_service_version
Date: Fri, 14 Jun 2024 13:52:26 -0500
Message-ID: <20240614185300.1086701-14-denkenz@gmail.com>
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

This makes it more explicit that major/minor attributes are only
supported by QMUX.
---
 drivers/qmimodem/qmi.c | 3 ++-
 drivers/qmimodem/qmi.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 89645c1d6704..a56e5588c698 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -988,7 +988,8 @@ static const struct qmi_service_info *__find_service_info_by_type(
 	return info;
 }
 
-bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
+bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+					uint16_t type,
 					uint16_t *major, uint16_t *minor)
 {
 	const struct qmi_service_info *info;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 625771d986d5..65fe0d56e4bc 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -77,6 +77,9 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
+bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+					uint16_t type,
+					uint16_t *major, uint16_t *minor);
 
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
@@ -87,8 +90,6 @@ int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
 bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
-bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
-					uint16_t *major, uint16_t *minor);
 
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
-- 
2.45.0

