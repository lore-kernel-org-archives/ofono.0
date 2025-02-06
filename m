Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66AF4ED
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802479; cv=none; b=lE9/kkFZ879Gr/A2nzdIdWjkkMNRvhc/G/JTNV5I60Dc5vWOcFVvHcb8gIm4fYg2FFyT1sJT6KETM5W+ok6h1VkBxUm4ph8jXtWVSyI4b1xBrAfcIdVxChZj/L3rPzbZg6ZJpL/6Q4tOSy11v79QDQefrpB2BU0Bd0UjpnxKneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802479; c=relaxed/simple;
	bh=VPUL13pmlLMuij4gvaURQQYUkMaElvTNvVR40lgp4PQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5YxOkQufxSupu3NZpzIybuiMqEPyIF3rBKV1YtS3rmSjWnaj1eXt/k8lFB9csXaf7kjcbulpwKgozxYi2G43LpFCaoqn1a9Qx0xmiQ/HqD98Gz6cRBIKXa2+MU4ike8Un8xml/dKzO+c2c3WOjis0JTWGnUfflhk1a9jzdtj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=gDp8fPcV; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="gDp8fPcV"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 021EF164A67
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:49 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id A3C90125168
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 1/5] provisiondb: Const-qualify '__get_string'.
Date: Wed,  5 Feb 2025 16:34:42 -0800
Message-ID: <3d9fa4cd278a96af3fbf47480e63ccc175868d2b.1738800116.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Yp1i/DyJLdm0irVvOCCzVjLrlwJ0+3o/O9ZknMhEwf0=; b=gDp8fPcV0aVvkRG9gH9ufL1jhZLKY4GRlSr+9+uBg9kppSPmjRh4RRBIE+eCXFfRgfaOWOqPaKYRuczJ3vc8aOAtAkBJuCW/xyxzs0a8I8Fa4zVGOOm6CsLZQGd8TNYHnlGRgJoIZq4c56MEBBdDs256sGGFcuYcWqPA5kbLblT8jiHgG3KtnVdHCBYbysxTTWFHLsOz2MSb/foKw0/Y5Osa+tupRj+oQWBxaHP0+QpsElecDdbbDpYrra4+pWUSNi+qQPbp/mKxWcfKOBdncsNNPVxwoBJ5mjFPB8BcTpBD8aEFTiV7Vbvvv38FuQd+bbTcn+4n5eBgrfRVsERddQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Const-qualify the pdb argument of '__get_string' to make it clear to
the compiler, static analyzers, and human readers that the function
is strictly a getter with no pdb argument mutation side effects.
---
 src/provisiondb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/provisiondb.c b/src/provisiondb.c
index 6a913d8d1540..8a71978b8afe 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -204,7 +204,7 @@ static struct provision_data *__get_provision_data(struct node *node)
 	return ((void *) node) + sizeof(struct node);
 }
 
-static int __get_string(struct provision_db *pdb, uint64_t offset,
+static int __get_string(struct provision_db const *pdb, uint64_t offset,
 				const char **out_str)
 {
 	if (!offset) {
-- 
2.45.0

