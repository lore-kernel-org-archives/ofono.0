Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95C33EB1B
	for <ofono@lists.linux.dev>; Thu, 16 Apr 2026 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345082; cv=none; b=Bb3X5OWYzTyPASH2DNrz/KsrKNeWb9Y+MSPH9CcI/e5DH8TtB+2GjLwY7ETyWUTJCp4q6CnvfLdtKvqeLdDx3pOrDgLBUwGSMO2InGjnWaHHyUSguXGlAs7NGTQl9TxB1r5Ig2okqpk3m99mAuyFbEg8P1peeXHsvRhMbNiKHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345082; c=relaxed/simple;
	bh=7tws449/XF8sD03fAYEnFL5u0UspFFmTEd/ltBQTISI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz0tfw8O7mTDapABMhSgWy0k7MT6riwAJidy/jUgTVZd86FPsR+VIF5F7auSLNWwlxNr1l80Y/ueWc6dvRnBzkSDVhhWl/SKEpGz/AOsjI3BvwQ7u/GNzblQ5qQS9+0j+mgwGi2M46pQvDD8tYPUtU+iFAh0xNm9yK1kPaVncwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bei9RshO; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bei9RshO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1776345075; x=1776604275;
	bh=ahervfWfa5frPMqcsPOztrGHSGh7NAVDQ2UnLn7S0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bei9RshODjobI6zuQBaXXifhtCGF5X44TWoHHP9aIoBLjVty/Gve0YYeN3n0k1D6u
	 XhuunS2jiLD+3Ws+L0kBKaStP531cuffnTTTpdorwL4A8pX8tfycd7mtswBP27qoA1
	 rd3tYQBMQEnAuF+sFZIqQ34X69F1cSnK0GoO3zjnx7zsWKN5Bf1G5eQw5Vjnj9X4zu
	 ir3YFczwjpKb11Xk1mxkHilTG2MuTCOG+2n3ZXzCJRyBRsFY2al0v1Ec/MrheIQS0Y
	 IJj1ihz/o6Pf5Tdmv8aj6O5jqike+EK72CF6tXxk3fU0vJX94pJ+QNIpyrISy78P+k
	 E8OCW/kyJA0rA==
X-Pm-Submission-Id: 4fxJL91S93z2ScsY
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 2/2] doc: netmon: fix indentation
Date: Thu, 16 Apr 2026 15:11:07 +0200
Message-ID: <20260416131108.2150962-2-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416131108.2150962-1-sean@geanix.com>
References: <20260416131108.2150962-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/networkmonitor-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index af56f04b..f029d96d 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -22,7 +22,7 @@ Methods		a{sv} GetServingCellInformation()
 			are available, their valid value ranges and
 			applicability to different cell types.
 
-			a{a{sv}} GetNeighbouringCellsInformation()
+		a{a{sv}} GetNeighbouringCellsInformation()
 
 			Requests the neighbouring cells information and basic
 			measurements from oFono.  The returned value is a
-- 
2.52.0

