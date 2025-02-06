Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F630B672
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802480; cv=none; b=Lw2Al4YcnsZTJ8l6khdemFiq24phy42BNRszQecoWcgtBcRE88bwrAVDlhZ0227z0fo7SXfJSHxtCtbwRdTvCfyEdnhL9ifcbFfFfdCLmXapehS90ZvV34+5xl5T1TdiREC2Dq4DxYe6XBR6UA5BZsPTCDmfGnwkVL2EGd281ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802480; c=relaxed/simple;
	bh=d335SvY3+hTRfi5tYIoX41gsAp35lpN7sOuAEUWvpFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mes4ayybFBhM0cpyLBU9Ie+MzINHyrVbLqlEY526DQarZLcyakRYM1FL6fTJ95mPpW7cYWe2TRmkYyPXgpjTuiZA/9IjrdvUk3fGLApAIOq+V1C0CSidcB4v9iHeWr3TOjCsyNkRwg9dvpoINRHdZesA3MZVhb5eREXK7hZSZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QhP6YTkm; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QhP6YTkm"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 5BE2A164A92
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:50 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 129BF126377
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 4/5] provisiondb: Document 'tags_match'.
Date: Wed,  5 Feb 2025 16:34:45 -0800
Message-ID: <4815b6ef97f75f94685ea30c5d859f2e85422fbd.1738800116.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=D+m6lEBzeuyfbK/jzgOAwmq9xYSYXqkKniZWM5nV8gY=; b=QhP6YTkmPP6T78C8J8kjZxhkh8yvuLeYnDnS77Xirg7xviJeNrrV2IBskDgQ7PKkTyhZT1qWVIo9CDfVQOQzvrnl5ERN4pihKe+pMPg34paOwZolXyWLALRLaWKGgcok46C9BElzqabmyaehSLIEtMc5yE5FNX8zlwT0azVnxZC1SmYqYkkWWr1e+6QQgG6Qb8I5AHxTQKnasjyM3H0xUx72/Fobuz1DbPe22t4csdrVuIKrqGfYqs533r2KyOUxBHl2Uo9MvDjjmYObJuZF9XRhLyKsmc/l/1N5yUpFmWz+kOos8JxmDe491y8Y6zHpMd+xYQxND9OUocyyloDLBA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Adds documentation to the 'tags_match' function.
---
 src/provisiondb.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/provisiondb.c b/src/provisiondb.c
index 753d7725103a..c7d35e4ada8f 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -219,6 +219,26 @@ static int __get_string(struct provision_db const *pdb, uint64_t offset,
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Return whether one of the tags in the specified tags array
+ *    matches one of the tags in the specified comma-separated tags
+ *    list.
+ *
+ *  @param[in]  tags_filter  An optional pointer to a string array of
+ *                           tags to match.
+ *  @param[in]  tags         An optional pointer to an immutable C
+ *                           string containing a comma-separated
+ *                           list of tags for @a tags_filter to
+ *                           match against.
+ *
+ *  @returns
+ *    True if @a tags_filter is non-null and one of its tags matches a
+ *    tag in @a tags; otherwise, false.
+ *
+ *  @private
+ *
+ */
 static bool tags_match(char **tags_filter, const char *tags)
 {
 	_auto_(l_strv_free) char **split_tags = 0;
-- 
2.45.0

