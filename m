Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF8188CCA
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300599; cv=none; b=Xb5neUFBx4Xtl61BQ5b6D46KshoNoYI88NrV26RJO4O7s3Gi4wFN8giZwDENjpWV2dgOtzbEP6MfHHM9D0/LDtWKbktKctrQxxSQgeRKRtwBRNWBioM8nXTa1ZdIAiPjlY04Br0qiP9L+QTdztqgfoVRedsN++4KcPhS5/c+rYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300599; c=relaxed/simple;
	bh=Ix4PFsG7MEDvltRoyFJo1+R6Xt2fe4dNuvotNHI1Dro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK201cpM3xU3KhDWxJbFxHoaHeO7TQYDn463VXoJZ6xQsW5WT2h2BimICkmdGWZBYJaLhuLdp6K8pSTJxGWfBf7Fw0AHD3j5ijNE/1Wjul1gaRljapu+RNcooMqVuP63keg8JwIWYOJxrsKswJu20E1j/YiguoemV13WbsEPMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm4JwbAN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm4JwbAN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1833367so3331095e9.1
        for <ofono@lists.linux.dev>; Wed, 04 Dec 2024 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733300596; x=1733905396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C85Pvq7mm0P11YRdRjJj2wn1RMQOvjILO4IREs7Ez0c=;
        b=bm4JwbANSrhBjfsYJR+L4CWSJFek0Lgn6qmPkt4jfUKvDZcZohi4/rVrF8v2Uz97KM
         QaXoQBkMyvfubg5gdIAY8J6YkPl8/WaeqePEVN55+atgEjiGVZVn/9qouM54XhkNNLDz
         vipXLHedaOHHpREQBuNA9xoO/54YbTmf46PHCuKvTgGhl9zdDtvy2fItD0U+8RmFiPcX
         Z5cIkO7T5gDQTvvsGDO03jWlsKC+YKGBPjd1az1HG/bletxI7iEiSByq27sJtY4aGtpf
         NWTXS4L1KMq2Qco2X8xB85lXbhfQyFYPCL68Unm+01Pufp52Rq6n3BzrBbhOv7zvQAII
         +o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300596; x=1733905396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C85Pvq7mm0P11YRdRjJj2wn1RMQOvjILO4IREs7Ez0c=;
        b=Wcr+sTpE7AP1NIJ1Cnx7jqbup3wPrNHMUxUDdFP7VC5pk2X4uuLTA80PHrS7PdOxpT
         R9nQ/3/DK1BfpXqPHoKAWEErVL2VJAbjjwdgyQHlEdA/SllC35oWQPeVJRTfC7wj/24C
         QceZi9stbakiPylkRHNtxgT00VYWpLem/+fVvlg4ZUx4Gsj4+HJZQ9sW+9pIhe3ub8Hh
         AEkxePbA34lFrBuOZTAFIrFZ9SRDG91f7kiP+EE+EHeQeABOWIMjUYXJcWZTz/lIPmtf
         5fXqbhFKsSGx17jq74Esi91zt0JEurJYOpwVhAP3fhdPRU8Q1xW8y90V5GPwbNKqeS8o
         THog==
X-Gm-Message-State: AOJu0YyKHDbjIsRql3z2i/WsyRqP1Lq1y28dtvI4eOSqrKuKn6SE7AXA
	ll7jaTtbm3W92qbmfbM4t+vuJ3ltOjDDOzyVb1p/zMYeOMm30yehpiSpuA==
X-Gm-Gg: ASbGnctWrTDQGF5D7SLDKnPrFGp+r27kaUB6LM7fwmiKPbdF1olzVl3CaZZq+jWsAZV
	DAhx4s1r7QVZxBLpT/1MjmqrThb6T19QGoNY1j3o5MyF9ZqlUxNV795O+Ppn7e8nWaFD3EM3775
	mjKm6D7ND3aLNV64pW4wiUHgNNBED+8Jzq6nyfnpVlEtWN+SZ5E0cDzbvuUJSLcZK8ll8yHGAow
	1Dl++sel5WaNJR0vfP5hqQEPLsokc9+XMD1P9wc5/dHuAyjog==
X-Google-Smtp-Source: AGHT+IFlSR9xlJVD4oWS2bJKPNBHHPWFB8Ve0j87hPvR5Hws62mipvt0RHg22gf52PeB70OCgFXdOQ==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr218818985e9.8.1733300595891;
        Wed, 04 Dec 2024 00:23:15 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3cbe250sm12112703f8f.94.2024.12.04.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:23:15 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 2/2] smsutil: check status report fits in buffer
Date: Wed,  4 Dec 2024 10:18:52 +0200
Message-ID: <20241204082207.24692-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204082207.24692-1-absicsz@gmail.com>
References: <20241204082207.24692-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes CVE-2023-4232
---
 src/smsutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index bdb1d04f..8c1aaad3 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1077,6 +1077,9 @@ static gboolean decode_status_report(const unsigned char *pdu, int len,
 		if ((len - offset) < expected)
 			return FALSE;
 
+		if (expected > (int)sizeof(out->status_report.ud))
+			return FALSE;
+
 		memcpy(out->status_report.ud, pdu + offset, expected);
 	}
 
-- 
2.45.2

