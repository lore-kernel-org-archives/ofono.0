Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0414D29F
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160369; cv=none; b=GWtdbJS2ql1Bt7xi8nQCF6gjnQxwXHO7fgeBuAN+d7W52nQmYbf04oPQN1ertCsGXaax6VZ2OLkO2miI7k0Mj9+SsyhkXsWxyyVQvfxbuzsSp8Heu77W19ZOprfRjKoefkWs9gGp3hkln3s2aFyaTq1WZNCtUdhxaTS2QtpW0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160369; c=relaxed/simple;
	bh=xXGcPCH/f2i8XpsEDqM5nE3YotYEMbkoSerxoZ3CQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se+NbjxLqGYaUoG7Sn4ctzLi8wZ5yRzn8bIFFaW99VF2pUHm+r8c+6N2cfXP1JOi9iuUS5mXjE7En8g0myi0mIb6Ji04D9/7EbWe7/eHyC4zonVvWmB5w8o6tcaTieP+mw4s7uH77LWcPWttzCPQ7RBGV00wJjgRly00FfkSeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6BbZF1i; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6BbZF1i"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e6d089f603so4378a34.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160366; x=1712765166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/WrVMZ2OFN2dz7GiYX41gzqzblVTskW2G6GEXirRpg=;
        b=M6BbZF1iKBoTCOQBM29cJaTtcBswCUByJbjL7WOO9fZtOPU0lFS+GZQjJQQxXnM3kg
         fRXewe42tF37cd7ZdCGvgj2RkQqfxakK+pcIHW0EiivEJoKuf4sO7iQ/52kFBRDrU6sm
         AzlrHiG7r6jOD3S/Q0IxyikuH55bZTR/n0lbul7QQ7OCSklFPiHv0QjpONiq1uOxVpK7
         iWUXnLBv+Eff3h6S91SFC2JtU2JBzgcIVXvTQjQ4UPY8igp2sserDp6fnqj34WLaLECR
         +mJ3Lbl2z3uAN0/OPh9H321iUQ6QogupJuxmyb2RMtXGlCSsMTev5YqqdrlmoBkZpQko
         DNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160366; x=1712765166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/WrVMZ2OFN2dz7GiYX41gzqzblVTskW2G6GEXirRpg=;
        b=BwDTYD9K6hvq6D7QD6bkznn2FNJR84ofsKCqihbCx8CapNiOJ4PKvAJ4Wp0wflGc/Y
         vrQxrF6EIrUzNEtYYVCRt+gIZ1pCBIMIEdac1Wv/GmiVLcqsjFo1hPSCKPKCkKyJV7Ah
         ABTiK7HrYqHwOy69YTncPB1Q/CePyLRo9hMMbwNTaOe/MZoyFzkxuB565ORxmZeUZCXs
         E/etYf2dTgNWfVyN82nnfY3NQ7iMMjXLe0V/IuGfOhH90u6YxAfwCMvjc79ZWL4+uh+r
         TXNb6X5hUEJg3EsYoq4K1V7lZUuopYjmsUP6Vi/zO44GkSmjcWdZnbTa4/ubTVy3oKAe
         E7vA==
X-Gm-Message-State: AOJu0Yw2vOGHkCWOpAQtBxSoaKgLEbEdyvjbYC5FGLlNqmPYYG0VZXlC
	NK1e7eOYtv9tpaNUEo8x5EfAnn1DdGnLWoPlW7oTBWPeKXhGwQJZNjbnL1Mg
X-Google-Smtp-Source: AGHT+IGEZNbZPpr3cUwJK7tJv3xEz8TBtlvlSDZZHswIVFOrqPeDh7KPXT78PmfQpsGItipahArUjw==
X-Received: by 2002:a9d:6d98:0:b0:6e6:9422:d70c with SMTP id x24-20020a9d6d98000000b006e69422d70cmr16937148otp.17.1712160365014;
        Wed, 03 Apr 2024 09:06:05 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/14] provisiondb: Add tags_filter support
Date: Wed,  3 Apr 2024 11:05:31 -0500
Message-ID: <20240403160557.2828145-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also update unit tests and other users of provisiondb APIs due to the
API change.
---
 src/provision.c       |  3 ++-
 src/provisiondb.c     | 54 ++++++++++++++++++++++++++++++++++---------
 src/provisiondb.h     |  2 ++
 tools/lookup-apn.c    |  2 +-
 unit/test-provision.c | 15 +++++++-----
 5 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/src/provision.c b/src/provision.c
index a2dfcf6cde5a..22413d2ccde6 100644
--- a/src/provision.c
+++ b/src/provision.c
@@ -32,7 +32,8 @@ bool __ofono_provision_get_settings(const char *mcc,
 	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
 		return false;
 
-	r = provision_db_lookup(pdb, mcc, mnc, spn, &contexts, &n_contexts);
+	r = provision_db_lookup(pdb, mcc, mnc, spn, NULL,
+					&contexts, &n_contexts);
 	if (r < 0)
 		return false;
 
diff --git a/src/provisiondb.c b/src/provisiondb.c
index 53305eab0594..6a913d8d1540 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -69,6 +69,7 @@ struct context {
 	__le64 password_offset;
 	__le64 mmsproxy_offset;
 	__le64 mmsc_offset;
+	__le64 tags_offset;
 } __attribute__((packed));
 
 struct provision_db {
@@ -218,7 +219,25 @@ static int __get_string(struct provision_db *pdb, uint64_t offset,
 	return 0;
 }
 
+static bool tags_match(char **tags_filter, const char *tags)
+{
+	_auto_(l_strv_free) char **split_tags = 0;
+	unsigned int i;
+
+	if (!tags_filter || !tags)
+		return true;
+
+	split_tags = l_strsplit(tags, ',');
+
+	for (i = 0; tags_filter[i]; i++)
+		if (l_strv_contains(split_tags, tags_filter[i]))
+			return true;
+
+	return false;
+}
+
 static int __get_contexts(struct provision_db *pdb, uint64_t offset,
+				char **tags_filter,
 				struct provision_db_entry **contexts,
 				size_t *n_contexts)
 {
@@ -227,6 +246,7 @@ static int __get_contexts(struct provision_db *pdb, uint64_t offset,
 	uint64_t i;
 	struct provision_db_entry *ret;
 	int r;
+	uint64_t n_matched = 0;
 
 	if (offset + sizeof(__le64) >= pdb->contexts_size)
 		return -EPROTO;
@@ -242,43 +262,54 @@ static int __get_contexts(struct provision_db *pdb, uint64_t offset,
 	for (i = 0; i < num; i++, offset += sizeof(struct context)) {
 		struct context *context = start + offset;
 
-		ret[i].type = L_LE32_TO_CPU(context->type);
-		ret[i].proto = L_LE32_TO_CPU(context->protocol);
-		ret[i].auth_method = L_LE32_TO_CPU(context->authentication);
+		r = __get_string(pdb, L_LE64_TO_CPU(context->tags_offset),
+					&ret[n_matched].tags);
+		if (r < 0)
+			goto fail;
+
+		if (!tags_match(tags_filter, ret[n_matched].tags))
+			continue;
+
+		ret[n_matched].type = L_LE32_TO_CPU(context->type);
+		ret[n_matched].proto = L_LE32_TO_CPU(context->protocol);
+		ret[n_matched].auth_method =
+			L_LE32_TO_CPU(context->authentication);
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->name_offset),
-					&ret[i].name);
+					&ret[n_matched].name);
 		if (r < 0)
 			goto fail;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->apn_offset),
-					&ret[i].apn);
+					&ret[n_matched].apn);
 		if (r < 0)
 			goto fail;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->username_offset),
-					&ret[i].username);
+					&ret[n_matched].username);
 		if (r < 0)
 			goto fail;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->password_offset),
-					&ret[i].password);
+					&ret[n_matched].password);
 		if (r < 0)
 			goto fail;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->mmsproxy_offset),
-					&ret[i].message_proxy);
+					&ret[n_matched].message_proxy);
 		if (r < 0)
 			goto fail;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(context->mmsc_offset),
-					&ret[i].message_center);
+					&ret[n_matched].message_center);
 		if (r < 0)
 			goto fail;
+
+		n_matched += 1;
 	}
 
 	*contexts = ret;
-	*n_contexts = num;
+	*n_contexts = n_matched;
 	return 0;
 
 fail:
@@ -374,6 +405,7 @@ static int key_from_mcc_mnc(const char *mcc, const char *mnc, uint32_t *key)
 
 int provision_db_lookup(struct provision_db *pdb,
 			const char *mcc, const char *mnc, const char *match_spn,
+			char **tags_filter,
 			struct provision_db_entry **items, size_t *n_items)
 {
 	int r;
@@ -436,5 +468,5 @@ int provision_db_lookup(struct provision_db *pdb,
 		return -ENOENT;
 
 	return __get_contexts(pdb, L_LE64_TO_CPU(found->context_offset),
-				items, n_items);
+				tags_filter, items, n_items);
 }
diff --git a/src/provisiondb.h b/src/provisiondb.h
index ee203c6154af..2c70bc15cb26 100644
--- a/src/provisiondb.h
+++ b/src/provisiondb.h
@@ -19,6 +19,7 @@ struct provision_db_entry {
 	enum ofono_gprs_auth_method auth_method;
 	const char *message_proxy;
 	const char *message_center;
+	const char *tags;
 };
 
 struct provision_db *provision_db_new(const char *pathname);
@@ -27,5 +28,6 @@ void provision_db_free(struct provision_db *pdb);
 
 int provision_db_lookup(struct provision_db *pdb,
 			const char *mcc, const char *mnc, const char *spn,
+			char **tags_filter,
 			struct provision_db_entry **items,
 			size_t *n_items);
diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 34d689a434cf..abb95f38f470 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -50,7 +50,7 @@ static int lookup_apn(const char *match_mcc, const char *match_mnc,
 	fprintf(stdout, "Searching for info for network: %s%s, spn: %s\n",
 			match_mcc, match_mnc, match_spn ? match_spn : "<None>");
 
-	r = provision_db_lookup(pdb, match_mcc, match_mnc, match_spn,
+	r = provision_db_lookup(pdb, match_mcc, match_mnc, match_spn, NULL,
 					&contexts, &n_contexts);
 	if (r < 0) {
 		fprintf(stderr, "Unable to lookup: %s\n", strerror(-r));
diff --git a/unit/test-provision.c b/unit/test-provision.c
index 9c3dfad43a62..b80f4d80fa0e 100644
--- a/unit/test-provision.c
+++ b/unit/test-provision.c
@@ -27,7 +27,8 @@ static void null_provision_db(const void *data)
 	size_t n_items;
 	int r;
 
-	r = provision_db_lookup(NULL, "123", "345", NULL, &items, &n_items);
+	r = provision_db_lookup(NULL, "123", "345", NULL, NULL,
+				&items, &n_items);
 	assert(r == -EBADF);
 }
 
@@ -37,16 +38,18 @@ static void invalid_mcc_mnc(const void *data)
 	size_t n_items;
 	int r;
 
-	r = provision_db_lookup(pdb, "3444", "33", NULL, &items, &n_items);
+	r = provision_db_lookup(pdb, "3444", "33", NULL, NULL,
+				&items, &n_items);
 	assert(r == -EINVAL);
 
-	r = provision_db_lookup(pdb, "3ab", "33", NULL, &items, &n_items);
+	r = provision_db_lookup(pdb, "3ab", "33", NULL, NULL, &items, &n_items);
 	assert(r == -EINVAL);
 
-	r = provision_db_lookup(pdb, "333", "3", NULL, &items, &n_items);
+	r = provision_db_lookup(pdb, "333", "3", NULL, NULL, &items, &n_items);
 	assert(r == -EINVAL);
 
-	r = provision_db_lookup(pdb, "333", "3334", NULL, &items, &n_items);
+	r = provision_db_lookup(pdb, "333", "3334", NULL, NULL,
+			&items, &n_items);
 	assert(r == -EINVAL);
 }
 
@@ -225,7 +228,7 @@ static void provision_lookup(const void *data)
 	size_t i;
 	int r;
 
-	r = provision_db_lookup(pdb, test->mcc, test->mnc, test->spn,
+	r = provision_db_lookup(pdb, test->mcc, test->mnc, test->spn, NULL,
 					&items, &n_items);
 	assert(r == test->result);
 
-- 
2.43.0

