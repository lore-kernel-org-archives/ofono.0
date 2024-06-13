Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D0145B0B
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314903; cv=none; b=EKeizbC6VAG2v4CrJlYtCvbFk/Mxdvndx/ltZGGgjTOrTsBuJ3pAl33W8bdSpvJIQSTXpWqmJuEGA9asJafZ5i3igKVjPxWVP+YhQB5J2NYRRfv/FGRe57GMCGT/BQJ5mtcFI9iUKcrKSgTNfb7pFedoPobtNoeSNURHofujHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314903; c=relaxed/simple;
	bh=2dmAhmWZ/wPkyF9FB8Oet3/n6QpWt/Q86pnqLM+OQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZFGTeNX14+a/FJ1bWM7pObJXgudKif73v2u2bLDngrXYh4WFir/OygxMr2HeQbDS+OCPnEbxL3kyeX0vGtH4ngP3AM/mgdvULNMctIWnI7yuDM9Fq6JT6sARlAgScWnpQSskxTz1/TvP60CbY4AeQwaRtfwJfwgkplVt4hgbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9zRrg0u; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9zRrg0u"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-254871388d3so789561fac.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314900; x=1718919700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nZjk+odFokyhaV+Ey+Q8l4FcCSD/HuMKdyicUc4rrA=;
        b=d9zRrg0uUl9pJJ9vMkd3uYI40OT3zTKt1z3wVtDnYhkYruTzcP2y5eLJ135QpcRsEU
         p/ioKjnCJYM7JYakVzN26V6tVW9Usqan0LbEpvNTHCB6/I1NtXjoRYhFL+m8zxAp9f3p
         iR3xpMKGlDC/of40nKDRn70YB68ZjrPXF/YYxCRPbaA2T88f89QBOikuFhJJC2WvOg44
         Xwy3Hii7GTsAFE5a0Cl/tEHHQs1Nnm9vWyvvDyLaDGqw1Jhnyaf3W7nQbpI5j+U5nwMk
         m7oaeNUWdurTSDpFnsPvu5isXFxhisggPYpxGGRNI/ocLtqclg9w0l4+AtThESuDa9AM
         Clmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314900; x=1718919700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nZjk+odFokyhaV+Ey+Q8l4FcCSD/HuMKdyicUc4rrA=;
        b=bWK2GY/Enk4imyJfooJ6tuXNEfJpU+TVyT/oTbsDCFCWwRhNEBGNiuWKkCo7vfW6Vg
         1MAQVjm9aFY4oFLhyZvIcqn9V3T693sLzBAMQwlGxNgIPaZH+zZHL034gknYTsoLkusi
         ycw0wyHD3k+Nf3wAhtl3vs0emwbfKwdnfHPJSYMM2HRVvkGlXro5XmpNHXT2m00777mQ
         z2G+ZQJBUcnWZSBn+KxYrr0Tq0ndKq3Fpcp3q2MTFpLhu+nSEbAY66zSOIz8w3SsUzTm
         5Qpc88ob+LVVdIQ5WcykBYQvzTGKSmvmz6hKCvIflKG7baetY7L5M3hREFVf8IAfX6mK
         tAKw==
X-Gm-Message-State: AOJu0YxX9Dj6wXDSHpMwe3HcoRWS0Wpc1hb7vQ74vYmtF+ppL1KdG8YJ
	QTPkPLllmAHJwecShepUNJzhhznhMWMdjjBzDyBQc8+pwWa5Tns0g1huXQ==
X-Google-Smtp-Source: AGHT+IFlq7vopFANfVPxlGgS+9YxsCRDGBoX+IdyEX0dL9vkCcPSZrL65BCXQPOnB0syf3skOR2pCw==
X-Received: by 2002:a05:6871:e020:b0:24c:afec:f1c with SMTP id 586e51a60fabf-25842b7d122mr798267fac.48.1718314900209;
        Thu, 13 Jun 2024 14:41:40 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/23] qmi: introduce qmi_service_clone
Date: Thu, 13 Jun 2024 16:41:15 -0500
Message-ID: <20240613214134.1056517-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows obtaining a new lightweight qmi_service handle from an existing
handle.  All outstanding requests (sent using qmi_service_send) and
registrations (qmi_service_register) will be automatically canceled when
the lightweight handle is freed.
---
 drivers/qmimodem/qmi.c | 8 ++++++++
 drivers/qmimodem/qmi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 1b3fa34f685c..91469dc2e00c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2918,6 +2918,14 @@ static bool qmi_service_unregister_all(struct qmi_service *service)
 	return true;
 }
 
+struct qmi_service *qmi_service_clone(struct qmi_service *service)
+{
+	if (!service)
+		return NULL;
+
+	return service_create(service->family);
+}
+
 void qmi_service_free(struct qmi_service *service)
 {
 	if (!service)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 227c498ab41d..821e54443658 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -139,6 +139,7 @@ typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 bool qmi_service_create_shared(struct qmi_device *device,
 				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
+struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
 const char *qmi_service_get_identifier(struct qmi_service *service);
-- 
2.45.0

