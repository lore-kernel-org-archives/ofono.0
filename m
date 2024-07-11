Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1C16D4C6
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716581; cv=none; b=d9jLY0UnjCXrjAuf1h2/k7te9KyZ5KpxHiiRVtYVgH5KKZN4+7Tz99M+AzrGpd0V35ySCMNb4yZegOELBgdklic4/SMeEryt1+ftppTwKXTqxVMmLl+LqLBzbjJCnKmbutPNFwRw74yUg7WmY/eBQzDu7UXLPU8qYYTyDob4/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716581; c=relaxed/simple;
	bh=vZemnAQx6lt/5RW9tkn97Ir7UgxKrTvGJK9H4hhc7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnbRWzCCGM4kBaCWTUcri2gJ3YORT9QktrMv7D7nro4PeLeaia6vIXJ7IQU/1cL6H0/bmkFfbzrsTAw6pt//izaT1vBWlC28fSbZEAoxLtSwsR/cjwx0V2juTGzXMpflirE+2sbx87N1FZa4NiHTAEvowx38Hs3s0YVdU3CC3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPiF7IlY; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPiF7IlY"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7037a208ff5so645605a34.0
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716579; x=1721321379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=UPiF7IlYUqFz+nRbAUJIHlkEhemf90phLJ9A5uLd/C44FbNwYmR/OQ7kLT1I6wkL3G
         LXJ3y2TrRe8Sjxiua6GkhZRWWGx7Us2UVwEnenmybJDlp+fgbqUPrFACeF+Mbg1k4Wu7
         wMuDjeejGYcNTbojj+J/7PhR1JNrWlsZPugLdzZz1JvDF6u51EkPmgoXbPsjD824TAq3
         5V1lqIVLVwyoP2WXw4JfKFopFjx2GEYpXbdeSEsOFAFWcXGSKOA4NsOygxSqZxYBaK7h
         QfMF0IKe6VFMcbvO+i7KsRbjTOimg1/aexKiT//elJvTAH8sQRQV41DMpm+BPH3fyuwV
         6Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716579; x=1721321379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=ao0laEs4C5hyaysBhuA6xUtMK/IcpwGzbOvt5IghT2lJpIQ/U9AczbBS9EeXkAGcZD
         vOBxRzZecc/X8Zamqa9m0JoUkms46mZkqo5Sktjvcsc3CVGhn1t49vApNa/peaW1qaQ4
         IWE9io/46KhG2uTWdOU6crvvTc2d3eHmUIw9VQ5oDs2I2j/eMg/ySUBKPfMv0nBniOkI
         IEmaF1Qb7kxuvzyhkttkfKhfLJcLKR15QinW9DKSxYwt3vkxukEWCnOd1NTo4T8pml6B
         vbABky12NnCUS342GHSP6xRAkrYoBA0n6O2fR3Wa2py/NfSuTa6wITMP4cqj+frRspoK
         zX+w==
X-Gm-Message-State: AOJu0Yyq7igkGkwocE5UL8QdZPtr21XMljuEovbdp0WNF9Yq2c84inDi
	AdAwiIewtJzp07zmHQDUYLw6eKykejo33Y/oraVPsvA6JJJeSjfJ6F5+6Q==
X-Google-Smtp-Source: AGHT+IHxFQDeIqEPRC13tOZ66Id4O5RiFer7MZipKo6HH5S6fSdFN5lMLgscxLC4QsIco2p/Aoqrvw==
X-Received: by 2002:a05:6830:9:b0:703:6dcc:f1db with SMTP id 46e09a7af769-70375b4a2f0mr8880163a34.37.1720716579465;
        Thu, 11 Jul 2024 09:49:39 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/11] qmi: Enable _auto_ use for some classes
Date: Thu, 11 Jul 2024 11:49:25 -0500
Message-ID: <20240711164936.1688973-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
References: <20240711164936.1688973-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables ell _auto_ keyword use with qmi_service_free and
qmi_param_free.
---
 drivers/qmimodem/qmi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0e48313ebb64..69698ee049c6 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -5,6 +5,8 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+#include <ell/cleanup.h>
+
 #include <stdbool.h>
 #include <stdint.h>
 
@@ -110,6 +112,8 @@ struct qmi_param;
 struct qmi_param *qmi_param_new(void);
 void qmi_param_free(struct qmi_param *param);
 
+DEFINE_CLEANUP_FUNC(qmi_param_free)
+
 bool qmi_param_append(struct qmi_param *param, uint8_t type,
 					uint16_t length, const void *data);
 bool qmi_param_append_uint8(struct qmi_param *param, uint8_t type,
@@ -146,6 +150,8 @@ int qmi_error_to_ofono_cme(int qmi_error);
 struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
+DEFINE_CLEANUP_FUNC(qmi_service_free)
+
 const char *qmi_service_get_identifier(struct qmi_service *service);
 bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version);
 
-- 
2.45.2

