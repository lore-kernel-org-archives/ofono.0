Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFA2F4A
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802099; cv=none; b=GpM7whWn39lOPXhjM4exuKZd9l9uSoGMOwm/riJeBV/c7Dw25ATUjBBpPy44BpGB054sdI7XYjBtWOtQFu6WatIbm5wNbcb93ZgEiIS6j5jbvfGSxpILJ3TTpcAX7T0WVZBmDiB6HuEUw0x/Ru+YTFsxSPOJ7o9CUIgilryO3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802099; c=relaxed/simple;
	bh=joaTwBn02dmmkjAKhIwkPEcrVnIZdpz5oBmf8Hono3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdvl/eojLBYHdMQ9ziOZQ1kLm67dEBI1R//eO+yfRZ1MPCOmc/ehx9uw4X8MALzvaLgxcxIkYhuFzwYradblUTqoNjyqtXgdXC48sxjjQmM/UprQJT4BYatY5xZ/gq05eGveP+wUV4juDfOzMApoHlAGLOFKNgGnpa7WTGxaPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RqMOy9Ug; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RqMOy9Ug"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CC442164A93
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:50 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 82011125168
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 5/5] provisiondb: Document '__get_contexts'.
Date: Wed,  5 Feb 2025 16:34:46 -0800
Message-ID: <d1c543a4ed39a2e8f0ae2f7ab97d008299346700.1738800116.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=+BOQAv0qxrwY1uKf1jjJrtdq2MG4ZbQ/yigaD+DVcF0=; b=RqMOy9UgSbOuOu4ndZBdOTCW/OBI0H192SxyI4Xypjo8ytg30temkqKxn0E88ZWZ1IN61/nhvSqyZL9T099iv+pfdUoEK+8br2ogc72WPFjgQPvDQq8UIcWJChDZuLXi/to33cBKliFBXjQ9ichjW6pFxw16cshtJ8n5uCpmU+5818VnfBvKupkXICNFvMf7656aGtIJOrIJYl8vxxdwazE3FHAaPPMSR1l/mGFm39rUarV4HuZCvH1hUTL8pceHm+zuTDIta9lXAOsXYd24jB49Y/3DNo0CBJicXbTkwZwM70+TtnMazfCj4fby46h0WrrZ7IqEjbmqN+Q0GgwfcA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds documentation to the '__get_contexts' function.
---
 src/provisiondb.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/provisiondb.c b/src/provisiondb.c
index c7d35e4ada8f..2d7b29fdab45 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -269,6 +269,31 @@ static bool tags_match(char **tags_filter, const char *tags)
 	return false;
 }
 
+/**
+ *  @brief
+ *    Get contexts from the provisioning database at the specified
+ *    offset, potentially matching the optionally-specified tags.
+ *
+ *  @param[in]   pdb          A pointer to the immutable
+ *                            provisioning database from which to
+ *                            return contexts.
+ *  @param[in]   offset       The offset in @a pdb from which to
+ *                            return contexts.
+ *  @param[in]   tags_filter  An optional pointer to a string array
+ *                            of tags to match against candidate
+ *                            contexts.
+ *  @param[out]  contexts     A pointer to mutable storage for a
+ *                            an array of retrieved contexts.
+ *  @param[out]  n_contexts   A pointer to mutable storage for the
+ *                            number of contexts pointed to by @a
+ *                            contexts.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EPROTO  If @a offset results in an overrun of @a pdb.
+ *
+ *  @private
+ *
+ */
 static int __get_contexts(struct provision_db const *pdb, uint64_t offset,
 				char **tags_filter,
 				struct provision_db_entry **contexts,
-- 
2.45.0

