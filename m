Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFE1F9F6C
	for <ofono@lists.linux.dev>; Tue,  3 Dec 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255057; cv=none; b=sXD0Yq6JRVqzeCGAhgOImQr8L7zVPP2lJdR5B+oYOaZ9Svy1q4QV8nuwqGXuTgT/ZwiC2TqahGoWVF4HkLfpBQv0p35kIBAhzWvPwDgsd9L+aGku1bl7A1AgV4uYhgHcHsg2C4+BaohOCfFiEIOQytv1aqruFkacLeI8xz0UgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255057; c=relaxed/simple;
	bh=BTVaqKaAQB5Tu+fmCiuOsa+Ay/sLpOObPJfduIULhIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WwrV8Zc6ulWLWcdUc2p8dHdvkiYXnHvGzvZSRRn3DnNQrOWau0Ueb7LdvwSvdBM7WdJdpd2NiomfNU7RVcYX5rMNdlwoypMbP658S1PcGeoJlFid7+8U5zEJ3qIDbagIg0OW1IO/nGeaMZdTq9jO012MYL35W6fYbjfkUR91qtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQvSGS89; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQvSGS89"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso51219255e9.2
        for <ofono@lists.linux.dev>; Tue, 03 Dec 2024 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255054; x=1733859854; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMEMvB9DlDjSIlO2U8i9kdXJH8p6on7s+kWTJXfZZyQ=;
        b=KQvSGS89+6t/ALoWgDUM23goWHzBE6nCsFSf0jN62u9vjFvh4Cg2n94riJ/Prw8DGh
         Pzqe02H04B/hhzmzSI+wLOr+mw2wiaAA0sMoP88jWCfVsYrozS+KP1mGvNOHuaquQ60R
         7H75hMy9Q2nzZMqO2E3eNNvqGSrJzUXk8dUssjjXjEmrfrCkopOtCixFmGb8qLMlOLEq
         gymBiyWngEVfzRYNwNkDY2Rm5E/eHDBPUKnU+p017opE/UKTTP38OxFm3AYTbEJA40Wv
         SE+cBr/SGnE6v52GsFQsNgZl7erdz51uB8Kz/SMfc4dUUgByI+xbIexgImLXKNOsWhWr
         nFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255054; x=1733859854;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMEMvB9DlDjSIlO2U8i9kdXJH8p6on7s+kWTJXfZZyQ=;
        b=coPRJXoX/l6SALd+wbXhbbEwknK9lbCWNHvPaYXzaH7aWz+bOlgNAZTSNOG0bKL0YG
         LFAgPNch9ArHUQyleyn/SFD4XCi9J3Vb9ZcnwUWFm8qpnSQFveIrkNcuHP5mYxgZCRSP
         M+wmw8PHcPcHT3AmF2IBpROZoVTKP+tfEuDUBndP3tq+BbyiutZ7uc3f6YFbxcW+FAfO
         wn/lXctP7j4a1RtrZaBLcBu0XndswCx0X61mQXEHFaFyhZCoisISMbmrfpErEHBKHHkg
         sad/7+G+ks8EVC1mFDuNF59NkaysbsCxxIQ01p+GnNAcfY/fWtCFENGDpwZrS+ASDWxN
         yQnA==
X-Gm-Message-State: AOJu0YwLBLVnxGFXYcCYINi2OV6feXG0/sRKt9FE77DAI57SZKN39BUt
	cmUYeW3cVQpswhAJKny+eMU3QD1Sz1Gf65UXzc2olSNMXDGcgHFDE5TYCg==
X-Gm-Gg: ASbGncuqTQwu5XX1yVoBupmTxxxoqxYpB4TlxBDAHnl6pM3aUNclEfLWM5Q6ea1pXZC
	13eisOpgMXBQ2kPVV8u5SLAfFZupe+dz5LMlY/s1qO8vuLUdTH3MwtHyRvZ6Ol4fJdqlBQTJ/59
	xA6Kr1JzM5nA8LL95tHBjMrrPjQ3kSwQGfulbC+rKbDqwtIKDaD+kR15VKiDKGIAD88hpi54w8H
	GglkXNWNUK1Abl5Z6YHss2miMNgm6bwvpM9ls876tYtGRskrNOzrtahKFpLpM/LoJzzSYK2
X-Google-Smtp-Source: AGHT+IFzKu5QRJhQNR2HOmiRguQ0rz6UfY1aaff1gq+lypOtUKFfP/0F618YDhlGMXpmkaNR6YQU3w==
X-Received: by 2002:a05:600c:5799:b0:434:a202:7a0d with SMTP id 5b1f17b1804b1-434d0a03456mr32809485e9.22.1733255054026;
        Tue, 03 Dec 2024 11:44:14 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bec1sm204553455e9.5.2024.12.03.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 11:44:13 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/4] Fix CVE-2024-7547
Date: Tue,  3 Dec 2024 21:43:51 +0200
Message-Id: <20241203194352.25514-3-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
References: <20241203194352.25514-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

---
 src/smsutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index 8f578c22..484bfd0b 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1464,6 +1464,9 @@ static gboolean decode_command(const unsigned char *pdu, int len,
 	if ((len - offset) < out->command.cdl)
 		return FALSE;
 
+	if (out->command.cdl > sizeof(out->command.cd))
+		return FALSE;
+
 	memcpy(out->command.cd, pdu + offset, out->command.cdl);
 
 	return TRUE;
-- 
2.17.1

