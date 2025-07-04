Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5422D63E6
	for <ofono@lists.linux.dev>; Fri,  4 Jul 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631808; cv=none; b=qR7tc3ZfuEyh5XCSaNMvzBDB2rKm8aK2QvadTPAKSQ+MP/6WCjyXCdYnuLm4nCoK40k02AzjwdsfMq+/nLazSuOcINcmSDIP/9T4d/n5ph067kGijonEw8TMHAU1pAcdlVRG1OWaWxINN6gHQVa9wjc8Lh1z3iHS1eOdurTChJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631808; c=relaxed/simple;
	bh=R2KFoSosAJmCHMosRzAA24ykpQ9TVgZQQzuK4RsRi8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=KRBeRHgDQWjggsDvXXcosXWzmbJra2nv9j5kXjO56ilhmdNdPay+Hlei1Hv3I95DtYV6r67arXxa3B9nKrCPK6ZkoS5hxw8z3Swl5NuRFi/7xDcPAwRmELKejIY1na2Sy9Oo3yIkyzvZ6dgCqaMf666wgUVnd1CO14QaeWwd11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=IA3D8g3p; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="IA3D8g3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751631797; x=1751890997;
	bh=YStQNsTJOxRk/XN1rlmof1e0TekA5/hkViYyh5IADJY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IA3D8g3pcHU0jnBqdI1b0Vz537lpDslftLBPxV0YqDGK8C/eURInppQ1Wh7q3mMq1
	 wH8yTvqra2tMn5xUHWctI1euyq1NaA9MP3EKOlkXrgECy2rnjY4ueuvCsewjm9XDQl
	 xjRrgTZcARSGy9cc40C+o+mt3tGE/kKsKh1UHvB9vjhUrUqLVIv8g16Q/xBSPltMQ9
	 q+VLgYmtgrWHvzP2J+9DrJPvh3mISl3y4sX8km1RX2D/XzuT+OzWXkfqlc/JwYTzoA
	 AQ7sGwls3vn0mo3WOzjq5jAPvuqWFmYrFUf3RcV94H60q7EXG2gUBvbOJbvynMPODc
	 RWuL6unP/39XQ==
X-Pm-Submission-Id: 4bYXpr5G39zP6
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 04 Jul 2025 14:23:13 +0200
Subject: [PATCH v3 1/3] simutil: Add forbidden operator list fileid
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-fplmn-v3-1-dbba340d6cfa@geanix.com>
References: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
In-Reply-To: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

Add the FPLMN both as a define and as a entry in the struct sim_ef_info.
---
 src/simutil.c | 1 +
 src/simutil.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/simutil.c b/src/simutil.c
index 0fafcb7f77de8b7fac7318dec43fa92137356e4b..5dfc5e05e16d918b3bce5c2aae84e9b282ae77d9 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -84,6 +84,7 @@ static struct sim_ef_info ef_db[] = {
 {	0x6F50, 0x7F20, 0x7FFF, EF, BINARY, 0,		PIN,	PIN	},
 {	0x6F56, 0x0000, 0x7FFF, EF, BINARY, 0,		PIN,	PIN2	},
 {	0x6F57,	0x7F20,	0x7FFF,	EF, BINARY, 0,		PIN,	PIN2	},
+{	0x6F7B, ROOTMF, 0x7FFF, EF, BINARY, 12,		PIN,	PIN	},
 {	0x6FAD, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
 {	0x6FAE, 0x7F20, 0x0000, EF, BINARY, 1,		ALW,	ADM	},
 {	0x6FB7, 0x7F20, 0x7FFF, EF, BINARY, 0,		ALW,	ADM	},
diff --git a/src/simutil.h b/src/simutil.h
index 91be5e2345d39bfe4f4f25f5f4c6b8dfd4e8c3ea..77f7533ca30b8a9d77dbca12b3287fb233be3ba1 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -40,6 +40,7 @@ enum sim_fileid {
 	SIM_EFBDN_FILEID =			0x6F4D,
 	SIM_EFCBMIR_FILEID =			0x6F50,
 	SIM_EFEST_FILEID =			0x6F56,
+	SIM_EF_FPLMN_FILEID =			0x6F7B,
 	SIM_EFAD_FILEID =			0x6FAD,
 	SIM_EFPHASE_FILEID =			0x6FAE,
 	SIM_EFECC_FILEID =			0x6FB7,

-- 
2.49.0

