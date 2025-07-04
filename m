Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF742D63F1
	for <ofono@lists.linux.dev>; Fri,  4 Jul 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631808; cv=none; b=rIO12rhQsUkVyCV1i8j2oEKqen1L87h/xq+6ReSZqpO1BlL50sBr5Jd2+6ai23Ju6IxUyZOBKVkFxngaGpb7Y4JgprPkPudNdLI0iVEid2VM2egvjhsnTEOesvwxpuRmCtIUewYukaQ/FtWP1hb5SBJn3SKQEGMgAHXrdaMT4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631808; c=relaxed/simple;
	bh=uS8P4oivX6obKBISXrnGbYkurqryQ0ARuHdhaUx5cz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=oD5zMimVx5aNvkWqNAmuziwT9grf0mVxUgaziDWXP4F++NnfIhQQJm1mDrGG+cKefGJq8TvBHV0+XXguozXKHFOjlVFk2kAGI/ui+98QhDxv6vIWPF4PT87zrz9t5RJ4CiPPblgx1AQQ01s8Uve8/Dq2AiS6hwMkT8dlpCE5vNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=PP2TIFSl; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="PP2TIFSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751631798; x=1751890998;
	bh=y0jij9Y15iZ7+4LIcKv/XN/atDy6B14Gxc2QcoCz1eY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PP2TIFSlZ+YI2iFTI1i32XbY8VJ2wc/lsyMAdAmzEAUZd+0Pueoxh1JGO4YopxRmW
	 1aWePv0KzGVzOWNk7ImFbcvtklswbVojDHlbHXO2Wsk04BbX4OxnGSeda0eOkln+vW
	 +e1oTdZ8LN73H7QAf5lvahhDlW4hhPoD5V/TFU5W7l8Tj8k6nVuROKjjmxke1ktSuu
	 5QU3ZlpiYSF3mQ4zU3yFKvQZQYdzCZNSWnfwO3pB2WjLAoDLlMuiT4vatyVvbqKSlC
	 99ozmjNIB9oVPkLnTVy+l/hKdfM2SprxB72O78VkVDirwMh33dIGtBX4jJ57H+PpK/
	 Ygg9Qh5bKv7MA==
X-Pm-Submission-Id: 4bYXps5mfhzP2
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 04 Jul 2025 14:23:15 +0200
Subject: [PATCH v3 3/3] doc: sim-api document
 ClearForbiddenNetworkOperators
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-fplmn-v3-3-dbba340d6cfa@geanix.com>
References: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
In-Reply-To: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 doc/sim-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 419d8ec3ef17fc5b2876d1047249ab76bf608cce..c8b7a2b0d2e720d7c50960ffa407438049b4e983 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -89,6 +89,14 @@ Methods		dict GetProperties()
 					 [service].Error.InvalidArguments
 					 [service].Error.Failed
 
+		void ClearForbiddenNetworkOperators()
+
+			Clear the forbidden operator list.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given

-- 
2.49.0

