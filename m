Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D0389446
	for <ofono@lists.linux.dev>; Thu, 16 Apr 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324017; cv=none; b=Q7/SaxmVeijSlGJw/oTr5GJfB/R04HB/rMDCRW8cxyMRrf+pXVrfBozDu+b59MSDSmGUqnplnoB0Kms0j/GIZiKNPjQzm2dVdSNKxwsBy7lBhEEjvTsv2ggZMkkcM60einGO70hx4Ybi+aAHUdWd//43X/KA3Xzbth14tGPD07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324017; c=relaxed/simple;
	bh=7tws449/XF8sD03fAYEnFL5u0UspFFmTEd/ltBQTISI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4jB3jjfTmGYnBJK3wXOcEBi8L69ZzXsNqcyWQFICgbwn5tP6pH+PAmFaDZMGO6lZx4tgSGHqQeuhRoF1IAwDFo8gLx01rhbKaqchjX0tnu/9h5izK8Ibu21eKAjImIBBpRR0Yxs8YJ5ZWKbHGFVOwR+BLzGGdutacB2OEW5tTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WnoJZod+; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WnoJZod+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1776323997; x=1776583197;
	bh=ahervfWfa5frPMqcsPOztrGHSGh7NAVDQ2UnLn7S0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WnoJZod+p4EsZtOTuHCo9PO99Hw5ex9Ql4RWDad98nNkfFfcysyM/fdTgmrD1Arl8
	 g/uLDRo6cwAoy9r7larxQGDJIiyTAe/BEfD8Tci/yTq4xrhfcV2L/qZ7D8ZK803AaQ
	 ZqgdHVKV9dAqDpjDfckaxiU1Uc73hHc58IqEE8N0MRZBJQr/KjGxIrk/qilfN3VP+y
	 e5ayMfEViGk4pw4YbS1c924gxXX/WMd4Q+h6Loy83NPYaRnzBmPbpoR4wUyFu8unzA
	 bKEzReAtHkBpJVpebdTRWbsU37j9KKUHTuKicQzeAwVpXqTACovjAEojy4NGbOGNwl
	 v1A2PC469l+bw==
X-Pm-Submission-Id: 4fx8Xr3LVsz1DDs6
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 2/2] doc: netmon: fix indentation
Date: Thu, 16 Apr 2026 09:19:48 +0200
Message-ID: <20260416071949.2221937-2-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416071949.2221937-1-sean@geanix.com>
References: <20260416071949.2221937-1-sean@geanix.com>
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

