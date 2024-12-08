Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCC14A09C
	for <ofono@lists.linux.dev>; Sun,  8 Dec 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661609; cv=none; b=o3F8+exSvH0QxIikMy+NCDf2ZqJP7TCD/S7JIpw7E8Bh/4MvEfWECajh8XZthNYq93r9oynkFMzlFQmFY/mmR1Yt0gSRTzYlPJ4BgMhE0J6W6HyKS8sH4EpANjw6TnyoleaIyqRgoqmXaF2TN17ESvwT6XH5WhoxvNjg+1Kq31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661609; c=relaxed/simple;
	bh=z6NJF2gTF5wJYzVU/lJChfG7CH8KtGvl7WZCsxJl8oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0GNkMTG3YqsuS657BeqbO7OzAozhLLin5jR/n4Sn2QcTYo2D4aG7G+/qVs1N6RvkRd/x1gQMetoX4PwfqLoq/3sfvS0uc8W3LTzJk1JViZ6YLk6scN4tUE+3jeyBNk9D97hj2ftClgp9cX3bRyERO1GJ8x+jWnmOIyAcQ2MfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awDK8vzh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awDK8vzh"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so558947966b.1
        for <ofono@lists.linux.dev>; Sun, 08 Dec 2024 04:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733661606; x=1734266406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdBInLLQC/LgZws2vXoi05zQAfWxQU5J5GO+xJi4T8E=;
        b=awDK8vzhx3qN8gXWALHsEJmLXt6b4cD3NEZ/g5K/Kq2pANbIy8MNTKNTzSnbzcYnz4
         XQThz0EUWdT8qWC0wRMYyOm49aW3GOs2r6lq9CX5wgyuRH6FHR6pEJqbTKR5caoEJVKO
         cZNJsTcKa8WzoHx37Pm4eREiwfO5Mp6nCLnFl8qQaZFTktazOkZq9jWfg7CgAJ03J/Mp
         ocXDESTPnrlGimLWEN0m7Sx0JMP5gDsI/N1WhRJO2YYQMTfpZXks1+6LLMl8JU9migtI
         repbnjVni5Lc8VMHullva7C6cZeEbJX/Tv+MXp6SZsybtLvWUJSrTW6/ABQupp3hFFHb
         8SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733661606; x=1734266406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdBInLLQC/LgZws2vXoi05zQAfWxQU5J5GO+xJi4T8E=;
        b=JjGbfO4kZ69gYTG0Jybb6sxhHRVxsI2NBGIHOjCLWQ5QWDooFsk7bhKjO5mmjDMxXt
         Q051b4gL9Vjf4JONUVyUx56vIKAE875nUOYdGTdNteqrt8nGj8BjdXceMVVH58r7m1Dw
         UcZKc7Nfm1l8umTisIvjI0QY2kIVRxbHY2Z2iaE0rp7HD7FdMGw0uCdtLa7+o+U4oDsw
         q/2HEoeAMSZ/kUA6rmdICQ7ad1h426fk7olp6/S0+5i+i+80KMQ62uGuDLLQ2XFCM07L
         VULVbWpYVJVt1JchAUVQv67AnTBaMTeBkeOfkIhoPkkKJ4SNuwp9HsTg9cdmVD+eLanI
         aalA==
X-Gm-Message-State: AOJu0YxEzYw1ldATOPiQaeqmoayYBVH030eACgnIoUYgNdPrp5gS+S3o
	gaiqWiWz5E4Q1oZsRvLH9r3o8tQ9ciZKQN7Fgi8GcQTavRGdhg3YeAsyqw==
X-Gm-Gg: ASbGncshzVhO8/Yj5kyKZX59Ezbie4M0cIx2Af4g5Bl+LEXrDf4NmNYIx7iXO5+UISO
	XnH1z8Bjkp7cMEneIWyFFYidfZ1Cnh+STSL3bxRYi3WdhcKEI6ar8ejA6MxlDpQkKWxNqIgwVO6
	Nd2OxoHlovsFrlu/e2Gf1P6Acipz+W155JYwcP+/93MJtCqbNBzwKHQ1/EeWCa/1Vo8tKA+hblp
	R8SEqbFuiSwLiqxzMnh1g1ucaROWN3XuOY1U0nRHrSTO20LIvzNn1LWm4gcXNN/leLYlKs+
X-Google-Smtp-Source: AGHT+IEzvXtpmP5AlO4TQZ6xvtsJVD+X+yJp6mfQ5rQVkPkKU0LEqdWUWxn+UMNnQuueoUKpqgMJZQ==
X-Received: by 2002:a05:6402:280f:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d3be6b8145mr19481478a12.19.1733661605429;
        Sun, 08 Dec 2024 04:40:05 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67af72f6esm85782466b.148.2024.12.08.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:40:05 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] qmi: call-forwarding: fallback to basic forwarding info if no extended
Date: Sun,  8 Dec 2024 14:39:46 +0200
Message-Id: <20241208123946.255405-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
References: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
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
 drivers/qmimodem/call-forwarding.c | 81 +++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index e7ae3515..fb9bb4e1 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -21,6 +21,16 @@ struct call_forwarding_data {
 	struct qmi_service *voice;
 };
 
+struct call_forwarding_info {
+	struct {
+		int8_t active;
+		uint8_t cls;
+		uint8_t len;
+		uint8_t number[];
+	} i;
+	uint8_t time;
+} __attribute__((__packed__));
+
 struct call_forwarding_info_ext {
 	uint8_t active;
 	uint8_t cls;
@@ -31,7 +41,7 @@ struct call_forwarding_info_ext {
 	uint8_t plan;
 	uint8_t len;
 	uint8_t number[];
-};
+} __attribute__((__packed__));
 
 static int forw_type_to_reason(int type)
 {
@@ -78,55 +88,68 @@ static void query_cb(struct qmi_result *result, void *user_data)
 	ofono_call_forwarding_query_cb_t cb = cbd->cb;
 	const uint8_t *p;
 	uint8_t num;
+	const uint8_t *end;
 	uint16_t length;
-
+	struct ofono_call_forwarding_condition *list = NULL;
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
+	num = *p++;
+	list = l_new(struct ofono_call_forwarding_condition, num);
 
-		for (i = 0; i < num; i++) {
-			struct call_forwarding_info_ext *info = (void *)p;
+	for (i = 0; i < num; i++) {
+		if (extended) {
+			struct call_forwarding_info_ext *fi = (void *)p;
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
+			struct call_forwarding_info *fi = (void *)p;
+			const uint8_t *iend = p + sizeof(*fi);
 
-		CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
-		l_free(list);
-		return;
+			if (iend > end || iend + fi->i.len > end)
+				goto error;
+
+			set_fwd_cond(&list[i], fi->i.active, fi->i.cls,
+					fi->time, OFONO_NUMBER_TYPE_UNKNOWN,
+					fi->i.number, fi->i.len);
+			p += sizeof(*fi) + fi->i.len;
+		}
 	}
 
+	CALLBACK_WITH_SUCCESS(cb, num, list, cbd->data);
+	l_free(list);
+	return;
+
 error:
+	l_free(list);
 	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
 }
 
-- 
2.25.1

