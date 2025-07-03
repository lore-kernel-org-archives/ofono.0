Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1B2D77F2
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543327; cv=none; b=Wve0gAChoGpC5rQg3A6SEJeahozIG2bLyt5/8xCyv7rA0r1ct0aSFRHYwyBQCwIJKDKFaIasDKouBAw5sTUy71mRtAN54mokviljtDLlzn+yZqLe0Xx15x9lzI2Vu0NLZwB/5XscJkmGo9Lm9ozMlVrlL16Vvjy0oKxuc4m4w+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543327; c=relaxed/simple;
	bh=jVLKrd4Y6Nfr+w5sAo/eygknMfHMBXuBU5idgD5cNdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=K7hK7MnNw070H+Gsr+CCl5EHgzZ4dPiDAI1BCRBpKRI3ZTURB+QaQLnzKL98yTzIyp7P/0Drr/xUYvgACTYho1dRGJ5F8TdOl13wDsfc5Bctf/RJBKRafWdYNqcRWlcJC64HI5HLW07ik/cQs1HpjRTAsCZkGEATkf972pbrt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Y8iWUUI2; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Y8iWUUI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751543318; x=1751802518;
	bh=SSK6PPJWAvPx1BzBOHiz5rcvCP8MEkIZ8yFffeVMZx4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y8iWUUI2hl2o0Qyte0ZQBIE4x8WzruNMuvydQkMUPaeJx+FcysvoLbcJxTgyAvGrQ
	 /50VMpIWnADNQgcWLM33NH0WGgRGenrbn8s9nKbojbE0f0F4xONL2NRyoxoA/Sni0J
	 V3fr2Mp2Xm87Do63n48IN9AuFuCmzRGMXUWx9IFUKcew16ayrcrj4IPFjhxkKHuilR
	 UB6FzRtxklYr8Yn/i4YR7/KOmFtiEmFSYmg+ElYvzyf091sZKlVUUkhMfGCTwCwLEP
	 VenNUtOvZm/EUpN9AWQFLHmy0WD12J/8TKJlkOQ3AZ3/U0irogQbXn5s6embcMKqi5
	 oIJwxzVWK5JLg==
X-Pm-Submission-Id: 4bXw5K0rRcz1DDWv
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 03 Jul 2025 13:48:21 +0200
Subject: [PATCH v2 3/3] doc: sim-api document
 ClearForbiddenNetworkOperators
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-fplmn-v2-3-6eb6335a7b8c@geanix.com>
References: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
In-Reply-To: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 doc/sim-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 419d8ec3ef17fc5b2876d1047249ab76bf608cce..f95e2b3a9e3562f66dde7b3c8d93bde6267071ec 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -89,6 +89,13 @@ Methods		dict GetProperties()
 					 [service].Error.InvalidArguments
 					 [service].Error.Failed
 
+		void ClearForbiddenNetworkOperators()
+
+			Clear the forbidden operator list.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given

-- 
2.49.0

