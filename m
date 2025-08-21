Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811B2153E7
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775471; cv=none; b=bU9ES/rnB/cVOJDgVqWZ4L+7sswaoNT9386ro+/zeten1btUC1ldfZHlhTbOeek+zqTobHgTDbHqlyP1ztVGswxSzKwSfySllFO95A3RSTa4uoVpRu30Vfy51XyZUCwLe+kfhwgSvSsHgbXs0r7sBfaYEKmfxexQLmhj2rlVOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775471; c=relaxed/simple;
	bh=KGViOIlBDoMV5UjGH707dlaPHxhyEVPQ8sKN4SOraN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=o++huWuPUvObkevxy6CN1HlaBxPRzDX9gX+cGlKrvhQimwDIIniiLi6/BFt3Sfft18rxzYpX5esD+pS2/qUi4QsUMGP3s6EwSsEM3EyzjbiNPdX0N7TMs0/PvFDv9uhxddcisUdyJ1DQd5mVCt3mo2aEIhbCJzd6AI160BhM+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qlSboikR; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qlSboikR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775460; x=1756034660;
	bh=Cqg8roag4iWjhBCJtps16FkSatnzBj8USPLeelsOs4k=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qlSboikRaPM33H7WTUTrq/2E7iXP0UmV0eGmd81McD7KzyPo46NFGgogR0u2EEvD/
	 7H5VLxr+gs5eZ1UGw4WMK4ZYR7kFaAtHTSRr2YjA3S2tFCpKcChJgKjN0/Gs7njgPr
	 i2iVKIn58fQoJ8tMhxWHGmDerAKuDbd+n/P2q4/+HbfcN8j3F9Pd6xsfbHj5whQzry
	 bzb8tOBVB3Xu0lqpks6vTklOR7Q9vOkc6Qa+mC9Ei9HSblm/keB1u2xIb3tic8bsaB
	 OxB1kyIhG/co8Lm/29LJsi+sbADsqMD9z2j+SwiyIkWDi5ZntxVbz+yYUiDaWXxGZK
	 7dCW3uvFcyl8g==
X-Pm-Submission-Id: 4c71Df5qmJz1DDs1
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 21 Aug 2025 13:24:09 +0200
Subject: [PATCH 1/5] sim7100: Update to handle broader A76XX modem series
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-simcom-v1-1-6c794c5573c3@geanix.com>
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

Update the model detection logic in cgmm_cb. Change the prefix
check from "A7672" to "A76" to support the broader A76XX series
of modems.
---
 plugins/sim7100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 02f5b537f4d2dcd68046ab6dbac37d57706e2d3f..c4fc5798f746eb1e510302b575e38ca6924cd014 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -174,7 +174,7 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
 		DBG("modem model: %s", model);
 
-		if (g_str_has_prefix(model, "A7672"))
+		if (g_str_has_prefix(model, "A76"))
 			data->model = SIMCOM_A76XX;
 
 		break;

-- 
2.50.1

