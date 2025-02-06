Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206A101F2
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802479; cv=none; b=j8vNTqn/yKM/JMKliHizbhBOxs4zPsfHf53YsnvElT4OwgFYv6+bmNzQNZnuhGk0vXQpOeD5pOk0f4pVp7zgvNUMnZHdKKDGS3teZV7bcCsdZlwI/BIW7Vd/6PdKMbr7J0xiwLnW1dQuSSo30gdNi0+9XKDvU+Uw8GcP0uuZXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802479; c=relaxed/simple;
	bh=hUPIzLaesVuNABycQm3Zmfb73HbxNKOiuNb7q2nGx0I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXr9dJRqW/7qnITd7PI88tVPDf6Zc6yRk2dzi1WunQxbpdrKVz0b4uez//HeLla8is5Br7HPHbBfCEOgdjwpUKCvk8c55J5ytuMWOEt+AY6vsOxqTXY1wo8M3sFcvjbL5vqNOLGN2loYC1TxuPQahgDSONKdjSle2krLtO58nU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=g80aLd1J; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="g80aLd1J"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 77D46164A75
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:49 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2536212636E
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 2/5] provisiondb: Const-qualify '__get_contexts'.
Date: Wed,  5 Feb 2025 16:34:43 -0800
Message-ID: <01ee6574eb0a05aaabbe757d452e562237ee1add.1738800116.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738800116.git.gerickson@nuovations.com>
References: <cover.1738800116.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=d5Xwi+3S78CcJnGP7P7FYnX1pyjp3SaYFpy6ibXRFF4=; b=g80aLd1JnY0bkclQNbt6pgV5E5d/RrWlgJEp7tBbRNpGx3JugqiZSpFaHciJ5JKtLweW+7n/jewDhP7Azbahy6CjT0j0PwNVP6vKiRLrTeeHuB8CKi5TZp2LhzA7g5nNcy9gPs7bPS+3hYva85GVx6ELzDqIrjAlHXRIxRuRe6+0qDvOH153dBaXdBGtUhShPIKBQmJY+0RFUB+qUNqolaT0E1Q9xkemllMOuKxt2sb0v48bDRAIQsGHMDkOaGA+5cjYVPMuuBe1VQD9nyCuTvUBRn//cY5UfMfuvqfp9MbQnGu8ShvvIBtJVtlKnyn5Ea57W8HmwVnSJvFQ2VZNdw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Const-qualify the pdb argument of '__get_contexts' to make it clear to
the compiler, static analyzers, and human readers that the function
is strictly a getter with no pdb argument mutation side effects.
---
 src/provisiondb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/provisiondb.c b/src/provisiondb.c
index 8a71978b8afe..4a7f1bb6ef6e 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -236,7 +236,7 @@ static bool tags_match(char **tags_filter, const char *tags)
 	return false;
 }
 
-static int __get_contexts(struct provision_db *pdb, uint64_t offset,
+static int __get_contexts(struct provision_db const *pdb, uint64_t offset,
 				char **tags_filter,
 				struct provision_db_entry **contexts,
 				size_t *n_contexts)
-- 
2.45.0

