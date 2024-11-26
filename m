Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B301DF274
	for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656428; cv=none; b=GmxcR9XgvK5tI8IkZI+H8BTp1NuRHjod011rTnyW0Y/RxXJR62SSGpTYKZhVF99gWyct2MNiJglZ3CeNkN1CqDFlYRi/GrGd2LwNaXRbwOM4e6nBq40HBdGmWqS/gV2FbBuUaB0YBeigX5lMECDLykRAXghNk2ZMDTDcNHfjufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656428; c=relaxed/simple;
	bh=ueKfNAB0UPPS79VSnZQMs81BzvVgtXsNHuPCaigc/gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaZYydbheWYPqioY4/rd6g9LHkO5y2FHric2dQAE/KsLVSWhtk8uRR96R8sWRIqnsfds5goxU6uR4N/PdgQfPUfdGDFyO1Jte4LPbBakwjqOWYYW5/LMvlC8U7KBD38RqhwALuEq/E4Iy5W/WN31tNTBNhO3OKPVJvagfWWNHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9w5Omu6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9w5Omu6"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea48624a2aso1451523b6e.2
        for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656426; x=1733261226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjoH1IgYA6E/twIawgveTEBf+PsTyraRvZNOlYoF4S0=;
        b=W9w5Omu6ft3+mexlnb5dTqA1eQs55WJmhNtQefdYZ0FZF0Fy5ZF57rGYf2KnN8GAcW
         /vrLnliy7gRw8MEG0fFl+TAkzOpR3t/NGPyG171ijvKZbstPOwmooxBTxJUaCU/Y6e3/
         NiOFNyyVle9KUR2OgHeynQQAA800JEwrDf4lWH5uh2h1eOQS5KYherJZqLIHZf6mTeon
         78Np5gKLPArMtyqioNSZYSMJ7PxxI/brMaQfdB+ugXuOSNUqWVMNm5osEQdvsKNbQN38
         l35GIYkc2Z4o3yiPp4PP0Dqx9Tr9kuPmgHO4vhpkubqqZgh3QA0WPBwkmjwKDayl1ODp
         d3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656426; x=1733261226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjoH1IgYA6E/twIawgveTEBf+PsTyraRvZNOlYoF4S0=;
        b=K/X92p4DPG7if6l7s9iFuWtmb0cu4W6HXNpcNvYp4c0MDVDQKjEDY4GsLugW98eRGc
         EMdTEoNC3oNpogVDkuXReSM/5pC9soJtR/Q/YLeWemVDyxV9xfriWQAd5CzUOR++c9wm
         JmcBapVHmNy4Oy+94T6dx1/xZqcqi6KFx+/L97FkP6uFBt4SP4Uhrp14OcnAZYUdWRZ6
         +70m5UgVAZ4b/IM8717oqElndX8dUFhtR1IyquSjVaG9Q93KHMoDLrNcU61M6v5FzkXE
         GJ5QgaY1OJStX7oWBjQ4046gcY9qIn9PHUk2iJ3CPpRkER3i+Tl4jCFL8ahUdEgLE1Yz
         VRsg==
X-Gm-Message-State: AOJu0YwUCe3VAmHxTRLKfiiuqzvId99OusJwVt7Sw7XjCVge6Qlzktip
	kwqVtuSTbRTPXymSZgCcEv+6zLdIW62IhNOA2c0siWR8pamXe590FrIH8g==
X-Gm-Gg: ASbGncuWUVHkSBSjOklwEMP/MnXda0ldPavzOWPtJ7DchQvxk7wNyKSjqAfhkyNF1Zq
	JCdbGEoQc66OSiZxSLebnn62JpR91nZApKCatmiFwC8EF9qxrelzBYIcso5gFouKam7bQlmkFlP
	uEMv4viS9m61D+muabXsJSjiokukPoDLU4fLKGfTHMcjHXIs/sTg/4wvkAcZgS/PA7fBD3eUnt0
	87/hHmrtwzoQBpuy2dZU4FQ4nAIHUj87DN6aWGnS+7rq5KWDClf1bvpuRnLdmIY9mNpPmE+RAOl
	NALuowi0xoPlQeSNsY2VlPMp
X-Google-Smtp-Source: AGHT+IEW8saouhYvX9igLeHwMr4nDWTsXEi3sIlxJC02Lup28r7zs3AAbc/nMJJvss4ArMLpLZM8Jw==
X-Received: by 2002:a05:6808:2115:b0:3e7:bcb1:f5c4 with SMTP id 5614622812f47-3ea6db63b26mr939279b6e.4.1732656425948;
        Tue, 26 Nov 2024 13:27:05 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e835e2sm3177531b6e.13.2024.11.26.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:27:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] provision: Add 311 270 MCC/MNC as Verizon
Date: Tue, 26 Nov 2024 15:26:15 -0600
Message-ID: <20241126212703.196003-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 data/provision.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/data/provision.json b/data/provision.json
index 434bfd8d8f7b..50319cf33a51 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14266,6 +14266,7 @@
       "310010",
       "310011",
       "310012",
+      "311270",
       "311480",
       "311481",
       "311482",
-- 
2.47.0

