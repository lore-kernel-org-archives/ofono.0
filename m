Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E12E822
	for <ofono@lists.linux.dev>; Sat,  7 Dec 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596569; cv=none; b=A7WY3HA8efPWc5mY4BPZt86IlyhQ1+1GexoqlSG3TcVcSOWtSQALyeW4U3I/odECP2RPaQaeRvcOigBO5dgdXcvRA+mq8ERI6mscOAQl8NKQ/Q2mW5Esd4t9yRDAiIdEO5AhMfpE9UEySRnICOvKVwqrp1H4sUSWfjzJVY50NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596569; c=relaxed/simple;
	bh=3fe08zQUE7F2QsLdDDAUOrrYTVq1/sKkG6DYA8v1tYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/1podMPyxdXymxgLI4qlrh1+3j7BUz080NQKwsb0frtFt5AezUFV5IU6TMdX/0Tfw+osgaFsMof8gkiwu+kyqcrAHYrELXMpPtVqfH/8dC5O9S35XY7Bcpqw7nW7P+KVscT5ttoPsv0Hr0ARHJ82nU8dZBwmIpsehz7pHLi0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze/halET; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze/halET"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6332dde13so243715166b.1
        for <ofono@lists.linux.dev>; Sat, 07 Dec 2024 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733596565; x=1734201365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDVaxUQKi9kOnvZ0EmHFuxT3u3SS3js7Dx2X0OkD1iQ=;
        b=Ze/halETQxaLNGUZUxCNc8qFsh8r5UZF1BGP9WupjGK735Mtcfq7xvPen/QG4KveDc
         42eR77Y1AYDOaOnEMZL8e1Wv5srfOQPdeblOf0m/RREPp4OCzuxdn4SKIEMES+n5PFY4
         x9xBuLpqV+CfeQITbD93xGmZvFomwVEAKAI8f2filHzIlNW+K5M8+846BFlXiQ0yvuJm
         FvjC04+NneM8eY0OHFB4EvswQnGAJ12Fl0d86FB21HtCqUZ2drJOoOKj5K+0mVL6sYum
         7ZANXDI+mMaYClQbGGYhpKl5IGVldcWrKINF89wRbs4VXe07ucAoA8ZevoK5aV9qMGS+
         kSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733596565; x=1734201365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDVaxUQKi9kOnvZ0EmHFuxT3u3SS3js7Dx2X0OkD1iQ=;
        b=TZlJAjYK/ibFYFnmmX76JZ2RXxYd0mbsLVHPKGvC5a0qKTtuNs03XzEGqYbAWMLzw9
         bQRaRULQkkhvdmuQa8+D2pQmKp6yzjN5zDjNSKBC5sbRNdACcAnkZhCt8o+6X/l/gPtD
         R3wHpd0nXsnAnFq/s2Xaue8ozEz70T81yiRbSIsXBlVT0xCOZN7fxNgUCakGJ73iDMRK
         qYxS77dqfReOpvF7voxbZGlos3BpJQwQRMioVUKODrCW1Ie04vxpcWLNCBKGF7CuoaHy
         CCcj7SziKPc/R2GsqokzKDMh1gSGG8+ydEOBuG/o3EhZ4PwxCPjPDUPUBNUxBhiLO7wU
         lbzQ==
X-Gm-Message-State: AOJu0YwDDnGB0XvxQG4R2UHDCDCVrDRY1NuSu5ZOdWDWddnMZo7syOHm
	kU2fFwOGRfaah8Hgde5rsPCcqlSaKmUvqlun/8EpRvMtVsgxwBuFWxLeAw==
X-Gm-Gg: ASbGncuHY8fNFBxhzAyyU5J8wn1eb3EBc0VZwRtcqJM8LRcoKj+FKEkODXJQ6GAQW4a
	1ZlfonC8Pq7JZhjALcgebtgbunEF42I5W14cwz2qSjo7BW831O0oiRKrbtuqAA+gVXdCGMkJ+fN
	DQCjGleDPony6XwtvBWO7hL3EQ8SQtqgFGglcBoSnYQy1CAyCA/+jV8zyU4BTxLQRCKUZ1xCcfe
	R4RKtNKsDcwz8/0ql0uqvK1J7LprBBghnpPIrhdf43SA0VlJxukDBxT+KSiNPo41b/lQvN1
X-Google-Smtp-Source: AGHT+IEZdDk8lwvY9sErjV74NGmIB/g8ieOcRi7Uin4VqH5b5XaGA85yJy1bYWDp7BMVafNu2/CfZQ==
X-Received: by 2002:a17:906:3ca1:b0:aa6:2d35:3ca2 with SMTP id a640c23a62f3a-aa63a00aad2mr631122466b.23.1733596564696;
        Sat, 07 Dec 2024 10:36:04 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4fcsm420460266b.103.2024.12.07.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 10:36:04 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: gprs: query for tethered default profile instead of embedded
Date: Sat,  7 Dec 2024 20:35:51 +0200
Message-Id: <20241207183551.198810-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least the modem in Motorola Droid 4 returns error if embedded 3gpp
profile is queried, however, it does not error if tethered one is used.
qmicli uses same when doing --wds-get-default-profile-number=3gpp
---
 drivers/qmimodem/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 27060f9f..49259234 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -418,7 +418,7 @@ static int qmi_gprs_probev(struct ofono_gprs *gprs,
 		uint8_t family;
 	} __attribute((packed)) p = {
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
-		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
+		.family = QMI_WDS_PROFILE_FAMILY_TETHERED,
 	};
 	struct qmi_param *param = qmi_param_new();
 
-- 
2.25.1

