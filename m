Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1829405
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596707; cv=none; b=t8XLZ8AAi6gjCGVLfYAqb6poPLR1hZCKauJZ00/HqOJLMy3vR8n748WdKYbovq6OgIGz6bicaPoTzzI1mPro5M0OjB3IOD5rGBTDWTm4nw+sC6bqHElg6c8GUINUXoHVNwU1cYhuLZilhL6gGiP5auGFoPFnPQ1mL++UlsFi+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596707; c=relaxed/simple;
	bh=3s7eg/2w/9QwkI7eZ4wLM+/CycYV6qWhRpz/taZIxbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYmQVwTPxD+e2kLAHRj1FHXkhfkepjQxakDFPyDAGmNTnSMVyVQqGG7/j2gb8Z6+whSMUFTBsJ7ZBNPxKGH5Dcc/8bhxAGMWbDmEv31tEpFd1a6u18O1PqL6VeyGj4SOIxGBOxodlbp+0PoSqzDLUFl1K5I9s+A334dJbDHh+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjBLwOl9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjBLwOl9"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2343ae31a9bso3499034fac.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596705; x=1715201505; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhSTyREFXvRkGlEPxmtGbcAOQ39xmpQcQUpoaHOFwEg=;
        b=MjBLwOl9Y9VQByGnBCBgSXCt8HSOhOGYvngIAFCM9wY5Y2nwY2jLgLH1VhHESMI7F5
         C5hFTd4hPaU7wqsP6BnhmQXQQCY6KIm7z2b4AZ23kHHnZTE7EJyUL8AHP12lo6VYVgLf
         8Luus22TSv6kxBuW8UdmsAxPrkWq54I5JEQoLVUQBOaAjlB2ZaaaHsiyCcht9AMlJV0M
         CbXbK4EyJ9KWaagMePcFFnQiOJJcr6ECm+/7gaDwlxzaKufKLW/r6jSKOxenKnvD0Kcu
         Bkz8wEEUA+Ss3wRxRrWHZyiSVsz4IAuA1lVl9PyhlmW7f1RISOqoFbRBSQY0abceKilE
         s3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596705; x=1715201505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhSTyREFXvRkGlEPxmtGbcAOQ39xmpQcQUpoaHOFwEg=;
        b=wfUnF2iwXzGGvaACtGLyDUR1xnasiAmkUABBkCxaseLErcZWgXw0S5IdT6H+wyKMQr
         lHejrW48ClDbXUGSiDXSKxiZjg6FirjgmApMkJdASn0mwwxRNnOe+QWqAqPDTxFerQL2
         ixaoCG9vVkbyl1F+JuY5n3wP8HPL4/NQge/YXrHhR9ouBqDr0ZcUA5Y2pEaEKFvlnKRY
         elsNf87u1RjXN8+ZEK7WX1HDaSpCvY/mpAomaRwerfvME1ncr9bR4fv0/f2MZCV1e0lR
         odEqndd+NAKXPMXTjev8whSf93P27w10SWmt466/xzq5p4G9wy92nbvcRBlmvYuA1DiM
         e8aA==
X-Gm-Message-State: AOJu0YwtKsPU/D3lKRN60sHb20F51MwJY/j/dhG+Hw6tMzJ9Lj5Qylvi
	X7Nq98GZF3kpKmPZzzLpY4AYK3yZ3IUeo50+5A1B3fZtx1PS/eXkPN7n+Q==
X-Google-Smtp-Source: AGHT+IF+O1FyTi7K8KxaeBLVBUXIP/eU7Hepzq6VK8ofgKAMWO1MzOjSpOy56EioDcG3Z0vfgERkSA==
X-Received: by 2002:a05:6870:420d:b0:239:8e67:6f10 with SMTP id u13-20020a056870420d00b002398e676f10mr142076oac.30.1714596705276;
        Wed, 01 May 2024 13:51:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] qmi: gprs: register to NAS indications earlier
Date: Wed,  1 May 2024 15:51:22 -0500
Message-ID: <20240501205142.12777-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can register to NAS indications much earlier, as soon as the NAS
service handle is created.  Since the handle is now a 'lightweight'
handle, all service registrations are automatically unregistered when
the handle is destroyed.  There's no need to track the registered
indication id and to remove it separately.
---
 drivers/qmimodem/gprs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 738271905848..bca1897ea02f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -39,7 +39,6 @@ struct gprs_data {
 	struct qmi_service *nas;
 	struct qmi_service *wds;
 	unsigned int default_profile;
-	uint16_t serving_system_indication_id;
 };
 
 static bool extract_ss_info(struct qmi_result *result, int *status, int *tech)
@@ -306,10 +305,6 @@ static void get_default_profile_cb(struct qmi_result *result, void *user_data)
 	 */
 	qmi_service_send(data->nas, QMI_NAS_GET_SERVING_SYSTEM, NULL,
 					ss_info_notify, gprs, NULL);
-	data->serving_system_indication_id =
-		qmi_service_register(data->nas,
-					QMI_NAS_SERVING_SYSTEM_INDICATION,
-					ss_info_notify, gprs, NULL);
 
 	ofono_gprs_register(gprs);
 	return;
@@ -369,6 +364,8 @@ static void create_nas_cb(struct qmi_service *service, void *user_data)
 	}
 
 	data->nas = service;
+	qmi_service_register(data->nas, QMI_NAS_SERVING_SYSTEM_INDICATION,
+					ss_info_notify, gprs, NULL);
 
 	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
 						create_wds_cb, gprs, NULL);
@@ -403,13 +400,6 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 	ofono_gprs_set_data(gprs, NULL);
 
 	qmi_service_free(data->wds);
-
-	if (data->serving_system_indication_id) {
-		qmi_service_unregister(data->nas,
-					data->serving_system_indication_id);
-		data->serving_system_indication_id = 0;
-	}
-
 	qmi_service_free(data->nas);
 
 	l_free(data);
-- 
2.44.0

