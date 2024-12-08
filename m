Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF7130499
	for <ofono@lists.linux.dev>; Sun,  8 Dec 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733657669; cv=none; b=G6hPjPhwF7YjUA6JT7DhSwQrEsYVTPUp5mEYmWESaFffkBvu6adlkjqC+cGAN1eo7tN3kOYXCXySdGRo8mpfMZQ9+pFg8sLgkmSE3/g39JijrRlgyT6dxwaPg7oQ/HtQ7pQhOJerTfm2I4wQ1+M+PZ5+SqrvfxQllRsW/9Gy3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733657669; c=relaxed/simple;
	bh=eLjLaWbvRAu+Z1RcKjzOUcqqhaFFSHYsAg5IyfD43Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LgNekWQKnOoCx0TuB86EERk5haFK2Et/AfTji46CFv5ODrOdYIMpRbsfIuXVi+ekQJwzlTi2WbwZwdb4KB+JephAJ5+WT5Ar8Z/pzDr2Mf+ajCVn6QhIWH+rOXn8sWb0iJk4TsZuEQwxfUFsUFy2GJSuQN3XGyrJpggl3qvPQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAPlqZWi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPlqZWi"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa543c4db92so701390566b.0
        for <ofono@lists.linux.dev>; Sun, 08 Dec 2024 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733657666; x=1734262466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJFoIvdAZbBL77z38ESPnlEba5eMDYXhel2UASiXo/M=;
        b=BAPlqZWi+Swbv4jawvc4sHw0tXfdoeCGyOAgpCcLk4PV2gF/HrbAkVBSjvJ4UDn6ys
         ttK5lMvqzEdlABo51K8D9szVwFa3OeHzdQ36KwIrFBBqVBQSUtAES0qiUC6UhHJXQYj2
         0Bwyiu0Fze0E3arGrjuKUjlDFjVS1FqS4bUsngKSs91nJX8gPQs2EePor4b92XT/OeS4
         YF3dbTQWZIaISPPJF0Bb6MvSvjHUsWTZsNijjAI8NCcQzR2SGDg37mJnP9MdCRtUWuKV
         XFe25W1iF5SXHXva04OOmiY4oRUrtPrq+TfKNA9pkKUr4weX7GiMFwY8NNiwVKAZw322
         n3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733657666; x=1734262466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJFoIvdAZbBL77z38ESPnlEba5eMDYXhel2UASiXo/M=;
        b=ehXjGF1YJZo7cOqUVZDVpVeDm+Ag+fnobeBNXg/U94COx+9EkHKZ2nXRuAIcSaNEih
         ik9p7FojH6wSZu7oRT8+TNHrqnVag92Eeo4PI7uliPAIJc8mb6p7Ba9anMJqXDk/hCpd
         uB9XcD5mfB3ucAhT+vWYiw1JEE1Qi6yke362yRqRtxN9WBedZr60q3eAuifx+tgkm1Uk
         OSHuNaA1sWXe6OwqaPEjFdlJjN6pj9mTs467/llRTtsolufQFmbAUMj06/anZiLhkciP
         nYmMnJOmN8ZEi9pURmdzTSHGmRYxgq5WBxl2WQbU8R3XenKJyQUzg/PdeX7MdfokRrmE
         JFAg==
X-Gm-Message-State: AOJu0Yy8JHSDGKzyLdLo20v3hbOdfXZMntz0IJl2k4ma2aJo/ipUoocr
	IeKFaBqwc0zu/LlU7okaFXcBLQnhYM7gDyPriWvFwllL7wSF9CorxOZ7bg==
X-Gm-Gg: ASbGncv94vzisRaziKP5HTeJTi3Cnos0GxrSc8zylq/4YK69hY2FWmgLUBvjv0DDBrF
	/y60YeyidWEHt2h4VfTlK8+b7QGwwD4Xg7NIg8tTIAYssAXyE1vZRXEmG0jCl8VODN/iAlF1SJY
	2ExdFOfCG/5X+s1QtLT+C7cHfENxe4OqXZvyiwjK1RmpXr6j/rGcUr4A0YWTVCzb6Qb3Umf9DSg
	7ZZX5H/GSvE1OOx2rOqsx51t5+UkOUXk3nKmMbWcPHG0fvKV7lR8BlzDELT1l3lpfMOrrfm
X-Google-Smtp-Source: AGHT+IF+yj0oQGrVv0fuUvL1x9UDP54oxwtaVeZfF+wGtEL9j2UVI4rx+wBXRAuKvBFjeejQFNBDzA==
X-Received: by 2002:a17:906:4c1:b0:aa6:8096:2048 with SMTP id a640c23a62f3a-aa6809621d8mr73295366b.17.1733657666210;
        Sun, 08 Dec 2024 03:34:26 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa65d18510asm207266766b.122.2024.12.08.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:34:25 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: call-forwarding: fallback to basic forwarding info if no extended
Date: Sun,  8 Dec 2024 13:34:09 +0200
Message-Id: <20241208113410.251171-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/qmimodem/call-forwarding.c | 83 +++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index e7ae3515..13de4eda 100644
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
@@ -78,55 +88,70 @@ static void query_cb(struct qmi_result *result, void *user_data)
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
+	if (p && length)
+		extended = false;
+	else
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

