Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84B1AE849
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895124; cv=none; b=q9959lB5fdCrQKuM2/eYiAMv/wF1491b8onAwib1E8W8lhXMFbexrwY3aIsqU4zeP/tQvG0KyqGUIaUCHOUy2UJtn3dj2aUxPX1bZnnZu5TQyfR1UB0hLbhoCUZX30MTr1QsshHzehQNfsHM2QxPjUQphhRsSw7tJr43oT6yxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895124; c=relaxed/simple;
	bh=C1Klstakq1E/nv9QVwz6nvyMi41TJ2AxHJa13YjzJD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbGXBDl8eX/IWVQlzSh38j+rWU9zRZro3LSdz5JS0fYOUsdaUIM+Gp1QH+XTS4FbtN+r+0fuQ5Wfd0QR2mgPbkH4z3+GNFo8sEGXtFKec5gVpWDKh8lBLQ9nIXqqi86fMteyVMKnQfxGbfMnTgPoqY9IH/Zftfk+L8oGhFwvFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8F1xNEC; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8F1xNEC"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d5288e6513so509902b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895121; x=1719499921; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fByp4wLBhBBUpXWhXGrIHMho2t3mrztcWOLJTwl/2M=;
        b=X8F1xNECxgnrMe7PbHc+BZclaPKJ1VbwQLPjGhtlouTWutgjBsdvHjQrwO6Vueclwr
         rK6yRQwk3o/chCNTDSIEzNGo9sVuOruiJyXV91BSTPSN74mQ0UDZTcfOF0H0wF+68GHY
         28MGOzsdVBfXCaNX+A1AAHz7oRhj09pTuLiU7NBJ/Roq5FXwuM0N7z1kB9ad9UPTHUCf
         8NtY6zOz+6Nk0qUyxn+YSSvHgjk6s6WbjigOCyEOhvOc8qQwXX7slnFQaGuQwp77GtOh
         jkRjLjNgA3DOoDOGj4y9JWt4L9oAreKAhtHQPYRPa7zE3sG8xVwRuYdt1CPItixQE9Qf
         66ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895121; x=1719499921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fByp4wLBhBBUpXWhXGrIHMho2t3mrztcWOLJTwl/2M=;
        b=IZ5o2in61KwG2eKBX3N9Qdxn1OaOerBcvhZ4uNY/NxFPhcMsYddyOuWD0HF0bBWM+w
         AQ9pzeg/GW7FxHV3m1FtACUAa/hs5u6CApqcW8186sldKdm/OWnQJWoRTXsACPN3v7mV
         j3gPcUPursAlOD8Bc3dIF49gA20FGdUWywDuzutqOuXcLyPtcBVqOPRG3k2zZ5kHV+ez
         maRmBgiw1tYt8OGODw0kWlXul9v3uRfldrgquvP2/ZnjRLagnj+xio384pr0gqJ1PMos
         QmMHO2oJ4+SuZ1gG36+1djf33+OA9qWIkDscRkOTk/zDtlWWKu21tT2lP3oktv1iN45/
         4Dng==
X-Gm-Message-State: AOJu0Yzt1khCE2Z7vrKcE5sdHXnVfa1Px58ybRhj5PW4Qo2y7l6bh0RT
	iJ/v/juo3TZrm1CMzmLNnnNehN4WKmkvK2RLEde22vPFAZ3Uw1y41CUOcw==
X-Google-Smtp-Source: AGHT+IGBxA4ngzVghSyyKWKQbxhOTl99pPiMqriLTeukxONiFjLGaGcg1ct+cqeoYlKCXAnRHJ7oKA==
X-Received: by 2002:a05:6808:1385:b0:3d2:1f72:d6b2 with SMTP id 5614622812f47-3d51badd5cfmr6087774b6e.38.1718895118671;
        Thu, 20 Jun 2024 07:51:58 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 11/33] qmi: Rename qmi_device_new_qrtr to qmi_qrtr_node_new
Date: Thu, 20 Jun 2024 09:50:58 -0500
Message-ID: <20240620145139.1135899-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This better reflects the terminology used on the QRTR bus.  A 'node'
parameter is introduced.  It is currently unused, but in the future will
be used to specify which node is being addressed by the created object.
---
 drivers/qmimodem/qmi.c   | 2 +-
 drivers/qmimodem/qmi.h   | 2 +-
 plugins/qrtrqmi.c        | 2 +-
 unit/test-qmimodem-qmi.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c3b1f7fef64f..a845e3809090 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2310,7 +2310,7 @@ static const struct qmi_device_ops qrtr_ops = {
 	.destroy = qmi_device_qrtr_destroy,
 };
 
-struct qmi_device *qmi_device_new_qrtr(void)
+struct qmi_device *qmi_qrtr_node_new(uint32_t node)
 {
 	struct qmi_device_qrtr *qrtr;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 604e4e7e8659..10202fba6128 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -88,8 +88,8 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
 struct qmi_device *qmi_device_new_qmux(const char *device);
-struct qmi_device *qmi_device_new_qrtr(void);
 
+struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
 
diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 9d2038a9b50c..ab85db35a5ad 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -208,7 +208,7 @@ static int qrtrqmi_enable(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	data->node = qmi_device_new_qrtr();
+	data->node = qmi_qrtr_node_new(0);
 	if (!data->node)
 		return -EIO;
 
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 07560aadcc49..0fedd9803bb5 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -153,7 +153,7 @@ static struct test_info *test_setup(void)
 
 	info = l_new(struct test_info, 1);
 	setup_test_qrtr_services(info);
-	info->node = qmi_device_new_qrtr();
+	info->node = qmi_qrtr_node_new(0);
 	assert(info->node);
 
 	/* Enable ofono logging */
-- 
2.45.0

