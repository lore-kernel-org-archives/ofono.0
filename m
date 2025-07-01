Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4826CE10
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362209; cv=none; b=Df7FFel5af82vJJdL2fDXu8x4Cbb/Jpoer1JfhT2Lafcc18Mi6zlzjYWqfzqYKvnzRQtofquYNwJvglsBXgxxpRbEwWSTI5DZZLWg3QEUzJhAfKjd4p1qjxyar6oyzT1uCK2xIJR8m/cH4uqOFLU5E1+y7qVtfs7yKWeqA+jvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362209; c=relaxed/simple;
	bh=i/ULxqyARRq4U380WFgus3EjS06zGSew/ptS5RJ0ht0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Wls/0wFiMbCZ41vdfMXjo17B8dVaighiBizllWVt5Aa5oeDXtKDuqAGVzpL6u+gGzs4iCSK0gRmIrQt0Scy6NX7PPjwOAHZd7KUNSrMPOcFnFpD3ON12+lonFUhc4sB3tMweeuSbQmVh/UyCe+pIec7xPwqsH8dyA6GeJlNNooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ALAqNO4Z; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ALAqNO4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751362191; x=1751621391;
	bh=mYymDq/0QHXzXJGYVLFDnO1GreDqkz1JZqfDyxUpN8A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ALAqNO4ZoL6qrxnwj0T18vVtq5wVBqcp+/a7wOhLiwngjNR54oU7sXMTV4o/K2+iH
	 9Hls5RuDj8/nhYYZ86s1QFwsKEm53MlzZfblpW70pxwDgzI5m1mMmDkAichDMDjtyC
	 kfoIPesDIjZWLFhzsSSSyY2lSMByHy89AtFLOiohR7uYqy8K2VGAqmaziyw9PX+f05
	 n5zJg1l1MPYDWQsm4KbJrZFcCu6Y8PDScQis7yWTWbnnaydDTgeXsImmZzD05Pks5M
	 9Awt59oI5Ekf52oTILuZsikS+5mFAMdvbrv6HNI4sFYm3Ks2xY7kd/yj0EPo/WZcAc
	 r2kBuZs2LQ+IQ==
X-Pm-Submission-Id: 4bWd660CDGz1DDrK
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 01 Jul 2025 11:29:31 +0200
Subject: [PATCH 4/4] doc: sim-api document ForbiddenPLMN
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-fplmn-v1-4-d7fe9c901b57@geanix.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
In-Reply-To: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 doc/sim-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 419d8ec3ef17fc5b2876d1047249ab76bf608cce..a127ad55b358c082e853e15f52eead5bbbf5fae3 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -227,3 +227,10 @@ Properties	boolean Present [readonly]
 
 			This property will range from 1 (default) to
 			CardSlotCount (max) value.
+
+		array{string} ForbiddenPLMN
+
+			The list contains a list of forbidden PLMNs
+			(Mobile Country Code (MCC) and Mobile Network Code (MNC)).
+
+			Max allowed elements in sim is 4.

-- 
2.49.0

