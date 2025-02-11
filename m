Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F14204E
	for <ofono@lists.linux.dev>; Tue, 11 Feb 2025 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234165; cv=none; b=LQGl32wZHD6LfvL/KZj6rOztFRj4wXhYL3ITZsQLT7nmbD5FErxJjBedDIk3Lyg39ioDhtOkl8CJM7bJLtjRojYcuitHKyCVgOAiPjwg787F0a6+jbH12deJCR3+fWrodyg2TLdAKmvwsAXZbRtJdj2/g8YJVUn1NE/7abJgH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234165; c=relaxed/simple;
	bh=m932xtl1vVPdkAiS7VtSq5DbhwudQGD6RDlnz0sAmsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+6UFadhzaUpbUKilCerFqzaAq/L1hX6v9DtvpDytY0BkL6ax5C9BazA9qBLeg8kykeUvuX2u4dGNZuq953MVtwGPD4cJuq6lOzNRsVx/obCKpQNsbrRWIc7BXkq0dnlBvyqmDWwt5jf5Jiq7V8Wz/n8ceNN9SfBQ5P7E1kO52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=KiYtxTxX; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="KiYtxTxX"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DC3C4164A7F
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:36:00 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 93212124FE6
	for <ofono@lists.linux.dev>; Mon, 10 Feb 2025 19:36:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 2/2] data: Add tags to Verizon APN contexts.
Date: Mon, 10 Feb 2025 16:35:58 -0800
Message-ID: <544c23a03eb34f9529b5fe1efb96fa62fbeca732.1739233526.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1739233526.git.gerickson@nuovations.com>
References: <cover.1739233526.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=gOY8YB1P3yZxVh6xUwxV9NDftDmzAVViEvoWinJCW3A=; b=KiYtxTxX7OtLaKgIm2vBlf5vERh4ssggOmWKWu9/rt40un04RN9DjBX69OeFXZtu8vVwdrgrU3+n4bDoxxwHlDb533crL5qWs/EbgA6GMYZYVk5Tx748kyywht9cHipzCeQHSu2erA8pkm1XHDYDKJn1cUDwzB4riJrFOGpBfBVNYLUSUIgu/ofFKbKZR4DhfU0t7w5nEinsINr9BZSoAo/MumMxSliGp9jkoze7Yzk54+kTbodiBUU/mjg7TgjbdYHHfVlEYlvtKa8lVgbK0xPpJup3Rw5fxkwdXgyhiHpw4qJHOwHpbO6oCPGzLDR2ZaCZJgaC4Z+H1N+l138Zcg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Verizon has a number of different Cellular access point names (APNs)
and contexts, depending on the application, per their documentation
here:

    https://www.verizon.com/support/knowledge-base-72601/

One partition of those contexts are appropriate for LTE and/or Voice
over LTE (VoLTE) applications while another is appropriate for
Internet of Things (IoT) or machine-to-machine (M2M) applications.

This applies the 'iot', 'm2m', and 'volte' tags to the three current
Verizon APN contexts such that no tags or some combination of those
tags produce the desired set of APN contexts for the desired
application.
---
 data/provision.json | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index 9d65ac08b394..b7072af256cf 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14285,7 +14285,8 @@
         "type": [
           "ims",
           "ia"
-        ]
+        ],
+        "tags": "volte"
       },
       {
         "name": "4G LTE Contract",
@@ -14293,14 +14294,16 @@
         "type": [
           "internet",
           "ia"
-        ]
+        ],
+        "tags": "iot,m2m,volte"
       },
       {
         "name": "4G LTE Contract",
         "apn": "vzwapp",
         "type": [
           "wap"
-        ]
+        ],
+        "tags": "volte"
       }
     ]
   },
-- 
2.45.0

