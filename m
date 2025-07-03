Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33B2561D1
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543327; cv=none; b=hPH6nOeKT+wyc+uuOa38CfH9oCWrrThcZmMH6HlogOTtw7g8eYPH4BNF08HXVFJvqCOUlFNYE10UXMBNb49fNeMCSV8a+G5Qr8xYnc/zoUA7jYZ3gTZemxDwBimIDC01YR7fB7tedT3D8uW/XYglyW3ruH2VIpDzNPkSUL0RK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543327; c=relaxed/simple;
	bh=+zFHzT/Ap7rrffMOVzJhQdC711cvBamtpW1TnBbD33c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=SI/qxLYPiqZV3VzM4CN3QtqOdSyBRYtiwDlj8fcaVayJ20yd8tgIyH57wEo9E9Eb/KrjU0iypvAeS4o55IP7txf0U9yj+A3LB3/QyX2ZDyA3n6B+MHQvwGdN3MtIBjbksy2GTDjax5OCJUB0thpw0OZZi149juLkge/T+qXibVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BxxUPy02; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BxxUPy02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751543316; x=1751802516;
	bh=9cp71Voa/MPHHkemVul8kHtcjFMfzJmajQBV8uh782A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BxxUPy02bmsu1cmtxcpDEOgKDMOpP9K7Z9bs27osyKVYy2MDgPiIvFpKc7ZlDhHuA
	 XI4DgQ3iJkXtQYCV+PnSEZ0QEEXs6TXlEo/wh+N8KSj3wmZ2GksIiGvuETF/gWu4OK
	 PZwczZ5UEe02gXkXe2ZvIqvnY35EYsiKVVSEkn8KagoYaBzboTepQDHjEcJwF4HgK1
	 6+kyhpOCSy+rQ9OkrnrYx/8d0S1wnDgmM9jIJpmPtkUAEkGyTBrfajXBzRp8ScqrL6
	 CTibbeTidneApCyukZNwRx0v8mUsp9X2hg5wXlRoetCw5mfo/SNlmu886mSM4mAjQO
	 l1T/sWtt4bipw==
X-Pm-Submission-Id: 4bXw5G662Qz1DDWx
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 03 Jul 2025 13:48:19 +0200
Subject: [PATCH v2 1/3] simutil: Add forbidden operator list fileid
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-fplmn-v2-1-6eb6335a7b8c@geanix.com>
References: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
In-Reply-To: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
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
index 91be5e2345d39bfe4f4f25f5f4c6b8dfd4e8c3ea..556412c4eaa089789092caa72fc3d8dd7ad5b00f 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -40,6 +40,7 @@ enum sim_fileid {
 	SIM_EFBDN_FILEID =			0x6F4D,
 	SIM_EFCBMIR_FILEID =			0x6F50,
 	SIM_EFEST_FILEID =			0x6F56,
+	SIM_EF_PLMN_FILEID =			0x6F7B,
 	SIM_EFAD_FILEID =			0x6FAD,
 	SIM_EFPHASE_FILEID =			0x6FAE,
 	SIM_EFECC_FILEID =			0x6FB7,

-- 
2.49.0

