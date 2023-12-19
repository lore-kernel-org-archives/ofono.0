Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0F2628B
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enO/uBAk"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35fa08df8afso19412935ab.3
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011278; x=1703616078; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwPNF7sgLcc/huZQAVNjyX1VGDIQSQxMNNYgdAAJnAM=;
        b=enO/uBAkZbrus26tJCoMYuO3RJ7Dye0YlFuca0QwQb1ctObZbV/qBHmSaC7QufRx+p
         5vDEhNcb5NiWm+KuMI+2QvBnR2z6ngdzLtJu8AHg8wp6pfn0Tae4y17noL1jHhiURvf7
         QoERhFJrDijsjE7kkU23Fr+MNHfIETe3GhtgzL6OvxZHePAMTgojUaG2+IEVcq6R2MSN
         rP/zVLwzqhfNZGXSvXn5/QQgkNeMVQ9glPPZh358d5vJh5IQnSnp2EeGC7uekcrfBMKa
         A0jqn/HBBowH2M3yumOk0QFWfnjy/k5sAf5jvlEOUqQOYV0REVAN2dZv/StDQ21OH6nE
         yTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011278; x=1703616078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwPNF7sgLcc/huZQAVNjyX1VGDIQSQxMNNYgdAAJnAM=;
        b=ufBFSzRrsLQP/p1oWhYbqi2K6pVappiQPS4p7JinWSyYp74MSHdrDNZIYGFTvHHu8I
         oBJyTjEdQak0YUs5bl+tEQSYKjPs2vInS7zkwnHgV2INiPhDZ4heqKDNdR+NHCH3hPAD
         Fi71jFYRvaDBzEvlSPwTKx8K4UpFm6eH3hy0JVqVZPTBWITPvexBObov0lhin/L6NoRv
         y30Yrmv8t0bKPJxkondA9c3pdCMdp1sJYzinrjvvO7dtd97n2KsDWTZPIQAV3bcWQNk6
         Rl/lYvpppR2NoNBM6XTxvsxgt12x8p3jAKPKv9xdiHljypGRI1BV6sY+pKdzKAq6LRLi
         AL5Q==
X-Gm-Message-State: AOJu0YxBLsQnHPodADZ7SqVCQGB/F6z/4Dh8h/R+/MsIwfVlE9UPkXI8
	t7enzWakZAIQTCqZCj8g7eAPjyP/M64=
X-Google-Smtp-Source: AGHT+IFp2xtSAJVe8xNXpcFn7gFHiWeFDvmaFYt3hM+txLWcIDDW1EGXbrC3UXl+LAJ6npaFS/AFPQ==
X-Received: by 2002:a05:6e02:214b:b0:35d:59a2:127f with SMTP id d11-20020a056e02214b00b0035d59a2127fmr27104066ilv.43.1703011278331;
        Tue, 19 Dec 2023 10:41:18 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:17 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/15] gprs: Use the new provisioning module
Date: Tue, 19 Dec 2023 12:37:07 -0600
Message-ID: <20231219184016.420116-10-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
References: <20231219184016.420116-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/gprs.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 27aeb68c..40642324 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2376,6 +2376,7 @@ static void provision_context(const struct ofono_gprs_provision_data *ap,
 {
 	unsigned int id;
 	struct pri_context *context = NULL;
+	enum ofono_gprs_context_type type;
 
 	/* Sanity check */
 	if (ap == NULL)
@@ -2408,10 +2409,19 @@ static void provision_context(const struct ofono_gprs_provision_data *ap,
 							gprs->last_context_id);
 	else
 		id = l_uintset_find_unused_min(gprs->used_pids);
+
 	if (id > l_uintset_get_max(gprs->used_pids))
 		return;
 
-	context = pri_context_create(gprs, ap->name, ap->type);
+	/*
+	 * Right now oFono is not setup to handle contexts with multiple
+	 * types due to the way the D-Bus API is structured.  This mainly
+	 * affects Internet + MMS contexts.  For now, work around this
+	 * by selecting the primary (lowest bit) context type
+	 */
+	type = 1 << (__builtin_ffs(ap->type) - 1);
+
+	context = pri_context_create(gprs, ap->name, type);
 	if (context == NULL)
 		return;
 
@@ -2429,7 +2439,7 @@ static void provision_context(const struct ofono_gprs_provision_data *ap,
 	strcpy(context->context.apn, ap->apn);
 	context->context.proto = ap->proto;
 
-	if (ap->type == OFONO_GPRS_CONTEXT_TYPE_MMS) {
+	if (type == OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		if (ap->message_proxy != NULL)
 			strcpy(context->message_proxy, ap->message_proxy);
 
@@ -2454,11 +2464,10 @@ static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
 				const char *mnc, const char *spn)
 {
 	struct ofono_gprs_provision_data *settings;
-	int count;
-	int i;
+	size_t count;
+	size_t i;
 
-	if (__ofono_gprs_provision_get_settings(mcc, mnc, spn,
-						&settings, &count) == FALSE) {
+	if (!__ofono_provision_get_settings(mcc, mnc, spn, &settings, &count)) {
 		ofono_warn("Provisioning failed");
 		return;
 	}
@@ -2466,7 +2475,7 @@ static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
 	for (i = 0; i < count; i++)
 		provision_context(&settings[i], gprs);
 
-	__ofono_gprs_provision_free_settings(settings, count);
+	l_free(settings);
 }
 
 static void remove_non_active_context(struct ofono_gprs *gprs,
-- 
2.43.0

