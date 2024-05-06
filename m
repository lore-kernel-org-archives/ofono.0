Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D115B547
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028000; cv=none; b=lSz7YQZKDd9upGKSE2PlqRN8D0UAJWYlN8OtsB/xBTQajHbJA4lMAKZqBuayZBwSJCpO8U4olAm/gdf9pXUFznNNdbOCWLLaN+ynoH+k7gfR94U52xs2RljSF+knnsAVpgj9+aFPjAmAdsRPwSjgwusWVnU3wefcHAilnmXi0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028000; c=relaxed/simple;
	bh=OaeFjocujl7in4tYx4myFtQ/NKp5Uw6nPMofcNLZ7zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoV9tv4fKwvgnlgPK6SscSo4hkdCMwyokmOgZ8hzmMHav2H86lI/FXokkJnlln5SCS/IeOZpcRtRJfTh8OhHeZAYFhWVUaIKZd6Cpz/54+rxAES1mfMQCGlMCuL0OcEzLsqJ4ADzjGZYhpWYpal34K7bYC1nYq8usoHoZQT39MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W23jXvzw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W23jXvzw"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23bd61fbd64so1687382fac.0
        for <ofono@lists.linux.dev>; Mon, 06 May 2024 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715027998; x=1715632798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzoQTka9ikZkJsgGRty2DPEw6KSUgOn234UT0oIM600=;
        b=W23jXvzwALxpXAEV2PbAcFHIdcMdK1hZEQhVnN/HtHAGo35xjO8d3wiHfHn7SL7lwo
         T69krBJoygxBjEAEKTbJozEksFFE6ZSitvNlCG20h9ZyEpk7f9K4Q29nVjBithLQ+Ouq
         CpywxjAjQS/to43TP/XY6ysRUxvFTPGV7itWUivJTuek+RpmijEzKPUeT2dqiGq2kPsa
         GnGRKDSJ/T/aVV9/woIWZMkwhhgpo/BIJu9jwitezJC2TkyRoX00JcWPeUSZMCODkL92
         pZdZY7PzZGt1YDqG6oVzTZKdofPKnldJRJ7K8MXhxs0W9uc+2zMCqFTykLl2w2+Zr86i
         enfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027998; x=1715632798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzoQTka9ikZkJsgGRty2DPEw6KSUgOn234UT0oIM600=;
        b=iDFty85I4Zy97wcc6paKuNYD3ud/htygrZYlKh5OladKV6AXAXlC00Iw7s3kWEGhk+
         uOx0a/91+am4lXi18QwDpV42gkW6K6d09I2WgopG7iHIeb4yPi98D0kddUb9btBHzjUQ
         D2BfUdXxWPiqfcx8nBVDtmxNoQEcOA/Oy9zEOYRdhwIEExhuGA9XVujymvWg9D/9Avyp
         bZ7kze/9u0OjxBYh0nvWg96vUm2tZsAqHwS7VCOYY07Bick5OGFlH3Wgmn2Z/I7ULMZY
         LvcmzKdJgKt7UzffM18km2LzmWngx/cTaM4DLz6b5i+l5yLPxb5tCAhocg6nQl3v/P+D
         teHQ==
X-Gm-Message-State: AOJu0YyNS0Z5Vog2gvefAJ1Hpshn38FBrmqUYE6KXoJJWii0XR20mX4b
	GBcnh30R/Oqy1cXU5FYL8ZMufBm04QYNoQVPH9KOxiPfIWohx+r/KyywKw==
X-Google-Smtp-Source: AGHT+IEs+XI4GdPkja9vDqeUdm95/LFgoM0WrRb7XU5f+2MRTUtcBpIc5UFDF22l0GOvi6JHVULWLQ==
X-Received: by 2002:a05:6870:1703:b0:229:e689:7c1b with SMTP id h3-20020a056870170300b00229e6897c1bmr13689198oae.7.1715027997837;
        Mon, 06 May 2024 13:39:57 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gk12-20020a0568703c0c00b0023bcaacf426sm2107715oab.9.2024.05.06.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:39:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/8] qmi: gprs: Remove magic number use
Date: Mon,  6 May 2024 15:39:27 -0500
Message-ID: <20240506203952.55806-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506203952.55806-1-denkenz@gmail.com>
References: <20240506203952.55806-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/gprs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index fce975def9c2..2a0d52317cbb 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -70,6 +70,7 @@ static bool extract_ss_info(struct qmi_result *result, int *status, int *tech)
 
 static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 {
+	static const uint8_t PARAM_APN = 0x10;
 	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	char *apn = NULL;
@@ -83,7 +84,7 @@ static void get_lte_attach_param_cb(struct qmi_result *result, void *user_data)
 	}
 
 	/* APN */
-	apn = qmi_result_get_string(result, 0x10);
+	apn = qmi_result_get_string(result, PARAM_APN);
 	if (!apn) {
 		DBG("Default profile has no APN setting");
 		goto noapn;
-- 
2.45.0

