Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5D16D4C5
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716581; cv=none; b=sEH/e7DPB+tuu52SyXm2pjtgj6MM/5ZuZBbLCrrrBsJgIWiAxoXatq5CowPNC7LSsz4kuqMcO+vOyo4AQ/UWWH7l+0WhjgxkmJ18k5sciLs7fPboaLS0FtsREN7CvoLCQIgDC43ABwhYuw1ySmF3KAP+pIDR0gsQlBTAqadcrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716581; c=relaxed/simple;
	bh=VBJdnq/Br6eI4igqVnMW/sTXg0Gzz2fZ4MEiET6TZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7bq7ik8ptdKdQ7O7p3CQGR7f+fGO2U6nLuTqEI0WIe+6MudBG5ehA7XUjrt7T5GnOe1qfcnw7VViCX/wN8sGxQ65YgxwfiKCocUKN5thSKycqdVHCwZCVrK0/hQfJ6GKfOIG38mPmehMTFyST6GVSUHFJKz/EKSY/Ijl9bGgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGVAA1FJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGVAA1FJ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d6301e7279so663818b6e.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716579; x=1721321379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=bGVAA1FJLtxPCcGZn6LxYG2uma7zSEB+zaHMJqP6e6ReA9HdoUHhgO/GYMPDvWlvZv
         X80efDFhQZ6pT0ldGBShj8b6APnzHwbbGHnZH8vJCPcVBlch2ZG0BEpD+AJbYoakanYY
         IochK/HO519grJ6EUY88BSMI+brc9udYwSp+GoXd3VSdQ97YWl1Mv1UNm0S8EnSfTYh3
         uFqv3frk50/ytZMgeZ6jaxx8afolwsgjjtLmGeULs2mGbbdrk+x8pqDhdrDDTRGDwHyk
         I4a8h6jUB3S4fPzFSeTDKO1S0eNQUKtR5NmZA4fKchVR2Y6r/nr5RT0ZqM97LYwZpxpy
         isog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716579; x=1721321379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=sQMU5xmO2ytZNYnVTs1znvvfWig8L3GV+MyOuCU2AjU5c/wBbZN4AThpOLTFs6CQn4
         xExWKnGg11XHa/vp81bKFKzyh0xjRBOXtSIvzhONz1AIimilrOUA9DbgTB6KgWS9LYml
         CsIvalVaCZKVCmD8KSvWxr2CbcltOYlZ5Lw9udCidJEKVkXlME/V1FxfsukimUV1mYeR
         iaEfN5QG0laufUVWn57C5F2a7QMsmMiKHlbEuqGLYzNRkdrpfJ2yFpjik7jinar3exHG
         kPUkWIaeUV/0DClzMAcQUEPYtskSwadijYnUyNSYNGf/Sq4GwiEJ+vF7l+2imRbiPd8X
         agWQ==
X-Gm-Message-State: AOJu0Yy2Yj7UmkHWSi4/5szBua6iuPU5a8kc0tQEtlWXxpF24Ym1DFR5
	U58GmHcXlftLQXMEwYsx62hwIdFSZhH8grnoQckPxm8AukHgPnhk/f+T0Q==
X-Google-Smtp-Source: AGHT+IH9SOmj30iQS2+G1mKXRX9E2alPoyXb7JMttf32CbpdxGi63N+6R6odA/8p6lssyzwJHyF9Qg==
X-Received: by 2002:a05:6808:170a:b0:3d2:17c2:8301 with SMTP id 5614622812f47-3d93c039304mr10247140b6e.30.1720716578825;
        Thu, 11 Jul 2024 09:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70378d3adecsm1027524a34.3.2024.07.11.09.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:49:38 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/11] gobi: Request dedicated WDS services for contexts
Date: Thu, 11 Jul 2024 11:49:24 -0500
Message-ID: <20240711164936.1688973-2-denkenz@gmail.com>
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

Each context the modem supports (up to MAX_CONTEXTS) will require two
dedicated WDS services.  One will manage the IPv4 configuration, the
other will manage IPv6 configuration.
---
 plugins/gobi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index b6df849de47e..76e1e133860d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -72,7 +72,11 @@ struct gobi_data {
 	struct qmi_service *voice;
 	struct qmi_service *pds;
 	struct qmi_service *uim;
-	struct service_request service_requests[16];
+	struct {
+		struct qmi_service *wds_ipv4;
+		struct qmi_service *wds_ipv6;
+	} context_services[MAX_CONTEXTS];
+	struct service_request service_requests[8 + MAX_CONTEXTS * 2];
 	int cur_service_request;
 	int num_service_requests;
 	unsigned long features;
@@ -170,6 +174,8 @@ static int gobi_probe(struct ofono_modem *modem)
 
 static void cleanup_services(struct gobi_data *data)
 {
+	int i;
+
 	qmi_service_free(data->dms);
 	data->dms = NULL;
 
@@ -193,6 +199,13 @@ static void cleanup_services(struct gobi_data *data)
 
 	qmi_service_free(data->uim);
 	data->uim = NULL;
+
+	for (i = 0; i < MAX_CONTEXTS; i++) {
+		qmi_service_free(data->context_services[i].wds_ipv4);
+		qmi_service_free(data->context_services[i].wds_ipv6);
+	}
+
+	memset(&data->context_services, 0, sizeof(data->context_services));
 }
 
 static void gobi_remove(struct ofono_modem *modem)
@@ -489,6 +502,7 @@ static void discover_cb(void *user_data)
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	uint16_t major;
 	uint16_t minor;
+	int i;
 
 	DBG("");
 
@@ -538,6 +552,13 @@ static void discover_cb(void *user_data)
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
+	for (i = 0; i < (data->n_premux ? data->n_premux : 1); i++) {
+		add_service_request(data, &data->context_services[i].wds_ipv4,
+							QMI_SERVICE_WDS);
+		add_service_request(data, &data->context_services[i].wds_ipv6,
+							QMI_SERVICE_WDS);
+	}
+
 	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
 					request_service_cb, modem, NULL) > 0)
 		return;
-- 
2.45.2

