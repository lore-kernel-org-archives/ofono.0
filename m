Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6114286
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802284; cv=none; b=Z51XrikAk7h/0KLVpVneXStoo8R7I5l0UUWsfZe9Q/dFJP6A3Ps2Q2ImezT41qSQvFHy0nGHzeyRq4ocnral46FCtjglRi35EMA5C7+jSjwIT/g5iFC/YDu4iu0grCUe5eqZedrWCCbuDcD9X5VeLSEuwXGlVxO4FbPQsq6mzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802284; c=relaxed/simple;
	bh=gpRpLgEOZ6w5LfuL9jmK1G4ipbNWBqrlBreMRKpxcWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLZmkAk6BxuFPybQo4O0vf9kGbnZi/vcJcGAHDxDDHgPLhaLaYngLNLAlTrBZiXEd8jlX0A3IRRwKzbbziOEb4r6z3OqX9LqwU322urFRVgXtT2G+rnsJSHA0zKr3Y84IxEb+LbLiybBWqvTSE11a0O3DGZl8lN7IkIxQBzJ2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=iBw7nRVR; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="iBw7nRVR"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C97C0164A96
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 75125124FD3
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:38:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 2/3] doc: Add SEE ALSO reference to ofono.conf(5).
Date: Wed,  5 Feb 2025 16:37:58 -0800
Message-ID: <88913a4e8bdb8c7566be8ae8f7068017d999f626.1738802120.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738802120.git.gerickson@nuovations.com>
References: <cover.1738802120.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=McDPogJxuyaGLxEwM8bfrX8wjpzZEWlUaWwN7/TTDpw=; b=iBw7nRVRQl9xtXFJb5AylISfeFUaq15S+kXU1ml42gdSqnvLiYYVhUKYE0fn8LJR7S2AML593/86TXO9kEeNdhiVYmSOKqqZ45POJOpdoOKnOr1bHyKZJCgvDoUI/LkhPMmJahvM3t+XAi1U/uO/2xEd1FFXZFPOzgsh9/fw/lL1y+WLH2PCtYxpGzi+wRJvFM2hMRUZ9cm+YtzNMIQdQf8o6vnJwqBqGzubNXF3S1bsD6BuXZLC04KBpAAIb/HfMsvbJ7IkJg53cqk9Xk8j4dtskzXxvA80OoOERZGVMi8RGKz2oXxNIVQRKMhUYiA0M6FuRJ6IynuXwPw9diGMog==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add a "SEE ALSO" reference to the newly-added ofono.conf manual
reference page.
---
 doc/ofonod.8 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/ofonod.8 b/doc/ofonod.8
index 7bb908cba272..d6164116200c 100644
--- a/doc/ofonod.8
+++ b/doc/ofonod.8
@@ -28,7 +28,8 @@ Don't run as daemon in background.
 .TP
 .SH SEE ALSO
 .PP
-\&\fIdbus-send\fR\|(1)
+.BR ofono.conf (5), \c
+.BR \ dbus-send (1)
 
 .SH FILES
 .BR /etc/dbus-1/system.d/ofono.conf
-- 
2.45.0

