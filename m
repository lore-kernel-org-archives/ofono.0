Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24D2BD0D
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716421; cv=none; b=rymeqNP+NNS75J9NLkDpuBc7S63NEdJd5Ml73CO8ZAnlRHr20/sigV7XtVrtF6YLqN4prwAObI9NjhN0lheZqhgNukl1E7kLEWTvaeejnUPYEk4Jfw7FR+DPBcAASDew9FwyhV8RyJP/4ji2ligUh9RpcMEa4zJbQ93Cr49/aOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716421; c=relaxed/simple;
	bh=VBJdnq/Br6eI4igqVnMW/sTXg0Gzz2fZ4MEiET6TZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CffTd8RtIRzvLHEy3zHdgFqjB+4adKUHbkNxrfAnde3SSBypAUDdrTe0P+8Ol9WFJsjbJ2kEFVhgIqomCy04wDjXx8hC6DZJOgkbfEELgK7zcs21t6LF2RMeI9V7+Dz7vs/ImZ6fpY/BRqUJ9avV6sQ2R3DyS50OOAvYI6BZ0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFbm0Qm+; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFbm0Qm+"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f97e794f34so45361039f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716418; x=1721321218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=YFbm0Qm+oOInNJEXb+f1xDvoRAgzXPoaZeXdISD9OQE6q5rLCivqJyp5R0ftIB7F8K
         xgmhQvNsxrU+By0o15QWcS/o9HBNnF9j1MpCC2w+OfR0rIhbfCPjXFwNGgy9eIX3ZDTf
         blJ4vQyaHg8UmDLpaOa76TSyIqrITkKksPFYNLQQcMJLDbTO5wYCzUd/Rwbw6IjoU3XW
         ExtNowTF/usvUkeW4A7QANJ19WQam/H4B4CWavQ/jJOn7AmRb47cdBnAfWkT3p/z7y09
         q+6LrulOkZKqjY9oVg8r22NtNlf2WVOORn053GPgupq+5AlqkzPUnZPB96cuTfcoC0vo
         3clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716418; x=1721321218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=C6lFL7Av5tSzsy94LE38KyyWNZd93VT9K7X7l8FXvJaKyh+bJPZc/vDE1wLGUuIxAR
         WFLKar/JJrExIy6atRil/LJByA4KcvLuHxraSw8F0MkFy7LwgYTenZoDnWLiEPI2sj4V
         8x01AMVf9hjRCvhOnkCoCTsVfY4wXYzkwCAMDTjCSaXPKSXCgLofe1hdWeGRdXFkoEqB
         YtKqUgsQ6+msxgF4+yqMP7//88jCRgRWAyG3bmumhDCFj+q2DUUoWmjvwT1HZXt7Y6E6
         Fnqixex/OBYKzPELrX4AYoYaPtsgFFTzG7quX0TMHLL+SM9BLstMoll3tYs5PNmd4zV8
         nNcw==
X-Gm-Message-State: AOJu0YwHBXGyAYO6/cIsXCu1SEY1zkun3rkHXYfYMDxjv96rPi60Yuhv
	V1RgL85ZVxrl+JfylTDRmXnJBfFXlPC+n+6frF9hzEpIkkoMvT3urULwHw==
X-Google-Smtp-Source: AGHT+IF2xT/XZRglp8tjAZo+PrMLRgn5S1qS/VhWkvvRHzpywSY09kLoX9MKFu4a+DJvdgkjRFRX4A==
X-Received: by 2002:a05:6602:2819:b0:7f6:2d58:8d6a with SMTP id ca18e2360f4ac-800004e8269mr1029440239f.7.1720716418710;
        Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/11] gobi: Request dedicated WDS services for contexts
Date: Thu, 11 Jul 2024 11:46:22 -0500
Message-ID: <20240711164654.1688558-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
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

