Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917A55E63
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698675; cv=none; b=mY1RPr4isMOj3Fdg4JCjebUKqPsraoW9o2hT+7vz3SZPU4UcxyQAtdvxcaIwC9TfKA16lV4Bw6Uz3chlwI7NspYQ9Gn64REyT2Aw4Vl20AOzCEJwhMlvcwP5mwOVF+5BGrGaLb7upC5l0mTZ/CMFykPngUy4b5JQqS40BEtZqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698675; c=relaxed/simple;
	bh=BgfhmmeUhlyiZyI+srqRUjYNciWUasraUodzXCTx8iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB55rUg9JYRZizIaDtTXL/t3ZltLhPAudYlNLbBGz1SLWcFabXPCZwC0cXqquqscLrKE7TS8SlQI3ow6u3i1JFN9kxX7y9rhHdIQ+xz5yalR7/T2NPwHoqiz7zs7NpcIwVIoLOyZHD8W2b4mfxwhEUNI2pxlW48uyn9jSIZliWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q99qHjfX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q99qHjfX"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e0a64d94d1so633799a34.3
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698673; x=1706303473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwPNF7sgLcc/huZQAVNjyX1VGDIQSQxMNNYgdAAJnAM=;
        b=Q99qHjfXMjElk+n2D3sTfWBOsd14IN6Rgdvdvslr47FAYUtowUDHHiKqn2DL1H0bzb
         u8Lh+vNTD9IBHHoPvJWK6kg/p9+KtFqSGxRgWpl4Ii+joSUp5v6YGaTI5EuUX+MBC9EN
         LeWb6F3VKN/bhYoYtluz+AvUpsDvbfkeZEpJ03UkCPIjjOiiTuYkwna9U57k1qGkmU/y
         3EbGOuDDhh1hMKCsLes0aJGLusiA6/q+Yso8J0AF/KXJZGHYZSTMhXGP3GS0pFV+GkbB
         hpmrDIYlvJX20pIhYLgIV7yLqNwDx/Qu0uYrd9N+vlMHVGbXpmMKumJZBKTclkv/ZPA+
         AX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698673; x=1706303473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwPNF7sgLcc/huZQAVNjyX1VGDIQSQxMNNYgdAAJnAM=;
        b=d8ufVDurjfMk2EG2vhljLGgTWXn05E2r+fpBG9HXxkK/v07PgAz/fJkwJG4NKtjfEv
         AsERoM0Eep1otsDw4feiUfZzsHqzw9px1xQr2DUBa0MAVgMrTZlCVq1SnPLlTHNqQotV
         rcNGXvC9j97Osa7YsbZINIaIxlUEwTBTq9nFeC9ltORl/5U4Z9edu6JDnCY3WtqT4rVo
         agFNdSL8GFCLfDxjzmxzOYoGMca+wrhNbjMoheCOIcMCviSm3SQ9BlRiwEXbAWaUV9RC
         FVU16pwKWYWd8SS5gm27/qJw+avb7w9eiDe5HJY9uVzcCd4+Gm47ZqK+zaxGz15KBGgG
         apxQ==
X-Gm-Message-State: AOJu0YyUosKzGwbBecs1gGn5RBb0hHdytP+IoK8Tq4MotONJ+0PgC6yK
	NPcZ2xUD1SsBZE3A5iNZGcmYmvrkPZuCwZnIF7xuinEfJiYGF9m78lTzGIPO
X-Google-Smtp-Source: AGHT+IH3D17Q0b4BszEG047NCJtYeRyT1pVOhtUdgvheSGHr0G+JOFYysubFeSwnEMpRC7uc1el/HA==
X-Received: by 2002:a05:6871:b1e:b0:210:9985:786d with SMTP id fq30-20020a0568710b1e00b002109985786dmr403035oab.34.1705698672856;
        Fri, 19 Jan 2024 13:11:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:12 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 09/14] gprs: Use the new provisioning module
Date: Fri, 19 Jan 2024 15:09:45 -0600
Message-ID: <20240119211017.474598-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119211017.474598-1-denkenz@gmail.com>
References: <20240119211017.474598-1-denkenz@gmail.com>
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

