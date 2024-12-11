Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C631DE2CA
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936106; cv=none; b=Wzxq+5DQTbi0Hzn/Xxyhp0aeHjWIa4PnADb/bCTV/I5TXJMczuige32VWPgoliBBkDCZUllTj9hWnH3Nj4C6YiQpOpZYmn73lH6Kq3UKtqsd//5KsFRoGhRuYzKfO1X6BZcQ3GrbTTFY0Lp/n4c89OSsfNz3tgfzhXlLw63ZF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936106; c=relaxed/simple;
	bh=vAk40SchT07qv8hQNYvnhzhYB5CgSZE5l2AEpFNzlhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrJ57gMZdGay4dLZkyyNTp5Z7stfm476YDw6wCu+icbRzrQBhIzPBsm9xXHC2m9HvN6p91C7gfo+G6KD4Sd4scl8c3LaJ0uqwqa0gzyrfPlnRUjjPrAaF6yCFJnoZeCiBjfhKzdjwLs7mvTvTx3eWQSCJE8BmNAq9sVAoWWgtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKC+a9js; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKC+a9js"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so6500907a12.3
        for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733936103; x=1734540903; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CletDf8BlAQl/B0Iyxx9MesBNa+ztJXwra0pb6FfUFM=;
        b=HKC+a9js2AGfS4L1wZDA4tYPn9VchS+3ALFsg5Cz6x3QWd+1hIsGA4PS360l0oB+ho
         IgWnEHoA2rMufOFr7JwoBM0NsICY77I8Bp+d2OCN8Dc2B8BRAQem7yn8k/LdgIEa/n8P
         pVBx6tyH6peYVcu5AhrKUIcEgcMBhPtsxUFc9u13MV267TD5cdwfDFw3Tc7Qk0RkFxTi
         s2wuPThrRNDewMqYwQGdaHZVGS00HUiYt9aB6NDuC7ngkjFQOXuObPKFXv5MQHFxxBaY
         F8KDmLxr0aSUtIE3qvrm1Wc6QHGZQaJvC/M+v1F6AUPzVRTGDeOvXxbfEEbXiMLSd9QY
         VF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936103; x=1734540903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CletDf8BlAQl/B0Iyxx9MesBNa+ztJXwra0pb6FfUFM=;
        b=N4z7+ewl6IJAh1UwMKWEyH3RT8LkmTmItyeLsicE88U2pFhATaVPZYyS5jcmKXD7x9
         asuPkQ3qy2aRxTfkKseeoDUVCVPJGbVZBzqgZuZ+gxdfyVLNMxD2ZRaFS/LqBkkwz5Or
         nyFlHsJQjvcTibp0Xty2KGAwNovukYDXDGoJjaEG6GIkIKZIJxIiuJqY0ncvixsUs7KP
         KecIxFLJSriN9LumqCZPbyU4ylx4rf0yL2koCTV4hGxc+pV3T6aPvvSJgZ+WWqQkAlJn
         dz02NnOLB+An+Ssi7T6g51M/AjvmjCzSb6nwmRW/Dsz9p88VYVD9pcC98M8Sj1pBKo0j
         yCaQ==
X-Gm-Message-State: AOJu0Yx/FI7jBTDInJz/g3w6iYyaf6rSCCahV3nHEvala0cr0T0gzeGy
	48d5kKxSgnDXqv+SdUzAq4zHqpT5L0w/iSbmWdIteK1K38ucKcbSyHf16Q==
X-Gm-Gg: ASbGncuVcn7z8JBHNCb4gM2BPVnw6fDQnDdGLAoZXgD6iBlJSC0II7ECTS/kwuFH8iE
	DfwuuiB1R/q2T0Zr4Np93LIHr/9XNkdNELd5IhuupJButXd1Ork9rD5sjAWr3rkq1m/OB+yTk98
	3HfH8kAF0ZbuhldwVkFHpiUWOVrTrECj7ynMAYS9JkjFnO4KPUug68U0bK05JrOP31xfkmzQyQD
	ABIqFmmSloANP05hwOynf73YXYauPFadFnwHPbIuhGSk3II1hmlctalZKCzTj0zn+O1Pl3UDV/+
X-Google-Smtp-Source: AGHT+IHyuCgu0np+JfVI91u0UCEA+wIp+dWrLZlTNS49lgdjUQYUDVCPJGOQuD48hbOmU4TL12hZTQ==
X-Received: by 2002:a05:6402:3708:b0:5cf:bcaf:98ec with SMTP id 4fb4d7f45d1cf-5d445c3c0abmr315845a12.26.1733936102989;
        Wed, 11 Dec 2024 08:55:02 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3da2c242esm6860807a12.33.2024.12.11.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:55:02 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v3] qmi: call-forwarding: fallback to basic forwarding info if no extended
Date: Wed, 11 Dec 2024 18:54:43 +0200
Message-Id: <20241211165443.500978-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c1a078e9-82dc-4908-a8d1-53954dd40b9d@gmail.com>
References: <c1a078e9-82dc-4908-a8d1-53954dd40b9d@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least Motorola Droid 4 does not support extended call forward info, so
fallback to basic
---
 drivers/qmimodem/call-forwarding.c | 80 ++++++++++++++++++------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index e7ae3515..ad42e192 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -21,6 +21,13 @@ struct call_forwarding_data {
 	struct qmi_service *voice;
 };
 
+struct call_forwarding_info {
+	int8_t active;
+	uint8_t cls;
+	uint8_t len;
+	uint8_t number[];
+} __attribute__((__packed__));
+
 struct call_forwarding_info_ext {
 	uint8_t active;
 	uint8_t cls;
@@ -31,7 +38,7 @@ struct call_forwarding_info_ext {
 	uint8_t plan;
 	uint8_t len;
 	uint8_t number[];
-};
+} __attribute__((__packed__));
 
 static int forw_type_to_reason(int type)
 {
@@ -56,7 +63,7 @@ static int forw_type_to_reason(int type)
 
 static void set_fwd_cond(struct ofono_call_forwarding_condition *cond,
 				int status, int cls, int time, int type,
-				uint8_t *number, uint8_t nlen)
+				const uint8_t *number, uint8_t nlen)
 {
 	uint8_t maxlen = OFONO_MAX_PHONE_NUMBER_LENGTH;
 
@@ -76,56 +83,67 @@ static void query_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
 	ofono_call_forwarding_query_cb_t cb = cbd->cb;
-	const uint8_t *p;
+	const void *p;
 	uint8_t num;
+	const uint8_t *end;
 	uint16_t length;
-
+	_auto_(l_free) struct ofono_call_forwarding_condition *list = NULL;
+	int i;
+	bool extended = false;
 	DBG("");
 
 	if (qmi_result_set_error(result, NULL))
 		goto error;
 
 	/*
-	 * we want extended info, because of the number type.
-	 * FIXME - shall we fallback to 0x10 if there is no extended info?
+	 * we want extended info if any, because of the number type.
 	 */
 	p = qmi_result_get(result, 0x16, &length);
-	if (p && length) {
-		struct ofono_call_forwarding_condition *list;
-		const uint8_t *end = p + length;
-		int i;
+	if (p && length)
+		extended = true;
+	else
+		p = qmi_result_get(result, 0x10, &length);
 
-		num = *p++;
+	if (!extended && (!p || !length))
+		goto error;
 
-		list = l_new(struct ofono_call_forwarding_condition, num);
+	end = p + length;
+	num = l_get_u8(p++);
+	list = l_new(struct ofono_call_forwarding_condition, num);
 
-		for (i = 0; i < num; i++) {
-			struct call_forwarding_info_ext *info = (void *)p;
+	for (i = 0; i < num; i++) {
+		if (extended) {
+			const struct call_forwarding_info_ext *fi = p;
+			const uint8_t *iend = p + sizeof(*fi);
 			int type;
 
-			/* do not try to access beyond buffer end */
-			if (p + sizeof(*info) > end ||
-					p + sizeof(*info) + info->len > end) {
-				l_free(list);
+			if (iend > end || iend + fi->len > end)
 				goto error;
-			}
 
-			if (info->type == 1)
-				type = OFONO_NUMBER_TYPE_INTERNATIONAL;
-			else
-				type = OFONO_NUMBER_TYPE_UNKNOWN;
+			type = fi->type == 1 ?
+					OFONO_NUMBER_TYPE_INTERNATIONAL :
+					OFONO_NUMBER_TYPE_UNKNOWN;
+			set_fwd_cond(&list[i], fi->active, fi->cls,
+					fi->time, type, fi->number, fi->len);
 
-			set_fwd_cond(&list[i], info->active, info->cls,
-					info->time, type, info->number,
-					info->len);
-			p += sizeof(*info) + info->len;
-		}
+			p += sizeof(*fi) + fi->len;
+		} else {
+			const struct call_forwarding_info *fi = p;
+			const uint8_t *iend = p + sizeof(*fi) + 1;
 
-		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
-		l_free(list);
-		return;
+			if (iend > end || iend + fi->len > end)
+				goto error;
+
+			p += sizeof(*fi) + fi->len;
+			set_fwd_cond(&list[i], fi->active, fi->cls,
+				l_get_u8(p++), OFONO_NUMBER_TYPE_UNKNOWN,
+				fi->number, fi->len);
+		}
 	}
 
+	CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
+	return;
+
 error:
 	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
 }
-- 
2.25.1

