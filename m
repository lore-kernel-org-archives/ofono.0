Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40516DC1B
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740967; cv=none; b=r9BSgxe7ziZTcdLBXzhRxJ/JAqT+Jr92XJcORwV9Aw7GXm7/RQXAcmElBSgcfIXU5Q+FsLpTWdmnWL3ojNgKLl1LpqEihX/T3lKjb1loH1qntcrgEmzBPVeWFJHz8GYi7cGrvpsa8wsfdAK9eXvxeAIxsBtUl52GjfpysAdF0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740967; c=relaxed/simple;
	bh=GAqRu0UuVLiqGXJEiwY1oyEPTDDwCivuH3oQ7lf4cMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+S292Po5SJjROETtc6bFFFbriZbovVq5lpcWmmzF2tq0L9Km9Z7FN1XUfdcY6fcDW8A88d3hxyzi0XkuEgOxBJYDMvo2ZZxRcf6BxaMywa0JSHCyEQaU2b/Hunw9S8b6xMX87woWHC7/T4hk3QLsTW8hpnYVGiKn8BYHupqehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9MsoHu6; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9MsoHu6"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25c4d8ae511so220503fac.2
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740965; x=1719345765; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdvBzpreMqSB4QFmQSbJhuOcwt1m+b92CFyWwcvJqak=;
        b=H9MsoHu6+NZqpttljectNhRkdfu0aqDq+Wrme5GHg/MX81FC92v/MPDqPAH903QOoP
         y6ZTKmF46N7fKB7j+nhRfeyVeqEe6ow/gDSzk2eBpN5+nPQrDUrD70M5u16ZVmbAOVvd
         tZjM9jWdJqjrrH9HaOBfAlv0kBQjIq2AYoCksZarLdC8Dp7hR06Br+WNEMtGHPy0+NH2
         MBI58Sc6qXAjKzBJXbA7Iv28gxyFZXoK6EGl/qFxQkQVNXdPJpOjh0DqhmrI6sYI9LcI
         iUfAkBhFIArTPX6+m1r+Oa6NNgtdHTrm2XWtpQ9Gx+BaStB0mrCOIAJvqI1SJaTDs4lj
         38fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740965; x=1719345765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdvBzpreMqSB4QFmQSbJhuOcwt1m+b92CFyWwcvJqak=;
        b=SIGCifUEXjvNu13CCDRPFII9J30020VvAxqUgP9ZbFcnczNDzUZCCtqjMSRJ/90XLU
         JqYfFUpFMfCuC7h+e+p0y04sYFN3pD5NnpfxyMxjHes1kZ4tL3IHXVjmbazJ+6E3lWKU
         3UcZ+S0vW4jlPPLCYfq8Kuv+6OBnI4rmOARNyXVzX9vzVprZICdnOILlQb7nKMTgkept
         8XctGRdSa3fot4k2z4ajufd+aJmcFfNM4ElQG1zaqX5Je/uAI2dtoEqBFTZhg50imthh
         cZ08pNMp2iCrTGIbhuUIJn8OZ/mqQxBUeMGMfucGlzux2PAvsmdkwbTiIu6phHwYMNyl
         VM+A==
X-Gm-Message-State: AOJu0YzPHROaVugjVnvghA5Rh4cNiczqeveOgHdoOfKAqCms7tLk3WHr
	8v/+ZXMhzLOqkbFndEOdWnFTjfZBH23fhp2UY9Aytgn0Lzu9n5h9MnwrDw==
X-Google-Smtp-Source: AGHT+IEEtn15J9j1lGPnXOI9eqmfNK6gxaGHxYgDGUOK+7gdE7nqraGQBv6Xgst7S1GNTwUJX9Fc+w==
X-Received: by 2002:a05:6870:b620:b0:259:859e:a080 with SMTP id 586e51a60fabf-25c948eda9dmr934898fac.9.1718740965528;
        Tue, 18 Jun 2024 13:02:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 15/33] qmi: Rename qmi_device_get_service_version
Date: Tue, 18 Jun 2024 15:01:57 -0500
Message-ID: <20240618200231.1129282-15-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
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
index 90e83a4dbebd..da245e50ea50 100644
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

