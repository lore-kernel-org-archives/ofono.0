Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54858200138
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346894; cv=none; b=T5CvmuDhWhIKVPvONCf1IfDstZ0GvhLAc4HWH5YiVRug194g0xuIOVgS/pHzNebjK401bQOIQ6pWxQDTquvfvKuSFJgddtFCBfkfrnV4Mxwhlv06M7hgEAFq35CoIoprK5THaxnqJkO8p4T7HqoSdayt+EPM1S4lIanl/ktfpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346894; c=relaxed/simple;
	bh=Aatm2wozbHOO3H45Ho4t+AE1nhVdaTeRSfYURuOpb/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9QPoHK7CLup9nwNfvNyp4MLcXaH3/NWBSYo3s+XlaNZLr30MuQabGiCuICIE/LgxhxYvfAwhMdLPjPaabcDuiU3Uo+ouhQ7dlVx3/gzrla6d9DHcuprldsD8K3FHLaFZSs3V79xr21MjN+dWAyb6lJ5qyCeZ4C5Y1wR5eBYOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4fBmbfx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4fBmbfx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa67f31a858so736481966b.2
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 03:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734346890; x=1734951690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn/5kpwOqqG1MTuhvXCpO8B2UonR68gMDB4krWFbmCE=;
        b=P4fBmbfxHcpp0lClwfXRZLDTrs287jR0wopaTro2Evmel+PrnoVcBI9WCnCXeVhIzC
         dKZGaup1sYif/wt683X1xk4iO8Nqc5Kw3PKS38c1vjhS3VDoVy4RUrP7Ter9okMfaBep
         NYr+D8PHN0MC7omr2BS8Ik9J3CdtB73TZp8yfoM3q8+zr+gRyPs1G2j+r5qmb90NV1Yj
         PEGgK6d/QxPp/ZQVZlYzIF3Il7D0uJTMXPI4ZWxzkRAWlogDKSxFaLfSvSvJIk38zq09
         5Q+IirnlEIkoGB3pDN5JjOdroYkGWQ5/OHhxno7Zm/LvzD8o2+I6W7affHiaZLltRFBp
         yc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346890; x=1734951690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn/5kpwOqqG1MTuhvXCpO8B2UonR68gMDB4krWFbmCE=;
        b=ortGhjzI0fvEkguVyhbzQGhZCMcVxITWIk+1U7aeTkcrZ7PmOuu6o9DViho2wgH2E9
         H+lCS6JXqx1+BeHGGRxZH1ZGMJRsBbsEPd9eEhWFpGEdFF4a0nlYaNAJZoA+j7vTs90j
         ZV9bTWD/8c5WokQugEYZrEgWk18E2MUqVhU9w5kNVCf+9PUjsjCnXj0jpj5vI2R5ns7n
         EEEjCwpWAGNCVnfqtkYNiSf7eK9NHE8UDgBjb7PttWAa/iMZKf+yN4kZue1L8jj1qTqt
         21eXiOSZvelz8d5x9Zy6L0ZtSVDhtcwQy0CMrmcOk3ZYyIim8kYzJ/fJIcAjcWb7Ed/i
         TMzA==
X-Gm-Message-State: AOJu0Ywz+WyWqFs1xaGzy2itklDRcwusc80ZwZRQqEIz+05vPZJ4tAKN
	kVUUJK4y1785bndTiccSMwCPjWk7uC4CCyM4p6XIvT9w7jL0UgDQ2IYAbXlA
X-Gm-Gg: ASbGncuRbM5XUvquaqVd+QE+2kNBf7aA7G0B6UfBS1nUn+hg0LgDOszNx1picShrlUS
	ByzPBt9xaUySGKwshaK3C1sLDTX9BUgWV2SdyNFEj6C3zR+cFBjCCeYU/PBrc2MMOKWUbnj33Ri
	kR7elMdYBRphNsMD6zzV9nylB5+Ix+5UFVrrbVQDK8x5hB7FgKy2sS9fyx99ruhfnxo3qHjiloL
	iytn5sWSByG/9cK1fPz1FU9ORWCcPIVaofMeeXRslYyACuHpZiRDZUs
X-Google-Smtp-Source: AGHT+IF7X+MT3EX6ZX5tXNLVPdboxLxxna4KPQk+3YmUlLYm+2wryMBdgxBU7uAE9ncfIvnFsqKsIQ==
X-Received: by 2002:a17:906:314f:b0:aa6:92de:ddae with SMTP id a640c23a62f3a-aab779585d2mr1047445666b.16.1734346890421;
        Mon, 16 Dec 2024 03:01:30 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ecacsm318006166b.145.2024.12.16.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:01:29 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/2] speedupmodem: ussd: ensure ussd content fits in buffer
Date: Mon, 16 Dec 2024 13:00:20 +0200
Message-ID: <20241216110106.567830-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional fix for CVE-2024-7539
---
 drivers/speedupmodem/ussd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/speedupmodem/ussd.c b/drivers/speedupmodem/ussd.c
index aafa4bc9..7d2df790 100644
--- a/drivers/speedupmodem/ussd.c
+++ b/drivers/speedupmodem/ussd.c
@@ -37,7 +37,7 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 	int status;
 	int dcs = 0;
 	const char *content;
-	unsigned char msg[160];
+	unsigned char msg[160] = {0};
 	const unsigned char *msg_ptr = NULL;
 	long msg_len;
 
@@ -54,6 +54,10 @@ static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 
 	g_at_result_iter_next_number(&iter, &dcs);
 
+	if (strlen(content) > sizeof(msg) * 2)
+		goto out;
+	}
+
 	msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
 
 out:
-- 
2.45.2

