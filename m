Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441511E531
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097064; cv=none; b=R/MkOBzCaTzcvdYnzBoKYysj9pvu/4W7iTHLf4ZNkSdhdCaoOmm77rTOhA7TvDxWmkdbbSNGSg4iaQitzA9FeUqVpFiYBefe7sgbUXmPiEzIjVc+DHUtLVHRdzWRGqkC+gD2DD6yiLXe2tqdDw7NzSnZwEKFZ6U2vI1FghNZiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097064; c=relaxed/simple;
	bh=0aAddjk+DQaTyafitGVRRtXwILGmckal0Ks7YWPDmuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOlvJHTMcCxsLOMCLbhXRyoIiG1JW91RWGtpkH971CHDPRM22jyEeexc9/zrRf16qIhBlziYfw3fssVZaBM78yEEe5h2TvPlUsh9LMrtpzSeLNNWiH4sJohJmz2w/a+lfIHe0xoTxkjH416jtrWmHO5tLdCWvWV1l2Vubqso6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9PXS9Ef; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9PXS9Ef"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c36dcb305cso158695b6e.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097062; x=1712701862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EkF06I5JL6MFmmvaFOa6KYE773pkMsKR92nX9SPalQ=;
        b=P9PXS9Ef7KJFPQnNPF57x1q6DJtZ4Fe8u4zp+Wslr9KGCA8x9wVJpOxcPvYuXXJRDI
         0chejsPwBGx7RrqzJr4fzCjkcxaTJCiYiQccuYEfpyMxVFzlXCiz4q7/OPQsmZ3DOwrQ
         RYHuNCXpuADhwGoJBc74gD1h618SO1OWUwKDE+aBtrSW7/wbDFTC7abnuTaHvYranMtE
         mMObuW8cpU9NBkpo18zHY+btEc7EK2+D2giCsOK7FNFU39NKucoO5GGxry8LEVXHl1cP
         ewaE/2Za1DVmXJudLHm+IHtNfd7XNTpVu6KksGUaQd2U0/Qr7fjdK5Qa5rMoi7DW/K0E
         0c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097062; x=1712701862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EkF06I5JL6MFmmvaFOa6KYE773pkMsKR92nX9SPalQ=;
        b=XbZ+hIu6nINb/bhOvG/Fu73iiZ8PgO9m6L2FV65G90wrRESE4nQ3cCpoA+POVteoxe
         q6Ez+WfjOfAUT3KvnBtkvujfSQC57rX/oTuwGnlbmCSDHSS7q+Rtafq4Z8tEkeThfN4T
         hZidNA5NdPRwbmTl+Ny4Iw9MjQh9gK7gXB3Wvp4tdrzjyxjvheDU/KfLsV9mw8yjsAv4
         Zg4jKljOucEtzLcA+HAkxicxBoMGwWWxfx/p4Em09OjAJ2lp+IiXnmuIySb0d8oA2y8H
         huPnuXlvRimDkGSYdwty6/hqdt3EUzR7ZTURjzB90FdkkDlOcmYm/GEegj+0MVencfT7
         DvTg==
X-Gm-Message-State: AOJu0YxqO0M6I0xQ/1qjfImYzGtf1dR5IRpr6Tl8lfnXPFPHDKZiEgPu
	RL5V6OLW4FkHslpVp+O5aHqjp3JdiUN+K3NbHYXfKCcq3Em0xjKxC+l64h1C
X-Google-Smtp-Source: AGHT+IHqwBMXqSRAp5f/DfxzNVk8gG+AOv8uy3GEoANIA/qej1nnLiMCyhdugqNG8QkjcljR4Zog+w==
X-Received: by 2002:aca:2103:0:b0:3c4:ea71:fe5f with SMTP id 3-20020aca2103000000b003c4ea71fe5fmr297537oiz.9.1712097062173;
        Tue, 02 Apr 2024 15:31:02 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/13] provisiondb: Add tags_filter support
Date: Tue,  2 Apr 2024 17:30:33 -0500
Message-ID: <20240402223054.2819526-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
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
 src/provisiondb.c     | 57 ++++++++++++++++++++++++++++++++++---------
 src/provisiondb.h     |  2 ++
 tools/lookup-apn.c    |  2 +-
 unit/test-provision.c | 15 +++++++-----
 5 files changed, 60 insertions(+), 19 deletions(-)

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
index 53305eab0594..3d5b50bd5bd3 100644
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
@@ -242,43 +262,57 @@ static int __get_contexts(struct provision_db *pdb, uint64_t offset,
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
+		r = __get_string(pdb, L_LE64_TO_CPU(context->tags_offset),
+					&ret[n_matched].tags);
+
+		n_matched += 1;
 	}
 
 	*contexts = ret;
-	*n_contexts = num;
+	*n_contexts = n_matched;
 	return 0;
 
 fail:
@@ -374,6 +408,7 @@ static int key_from_mcc_mnc(const char *mcc, const char *mnc, uint32_t *key)
 
 int provision_db_lookup(struct provision_db *pdb,
 			const char *mcc, const char *mnc, const char *match_spn,
+			char **tags_filter,
 			struct provision_db_entry **items, size_t *n_items)
 {
 	int r;
@@ -436,5 +471,5 @@ int provision_db_lookup(struct provision_db *pdb,
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

