Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC41BC44
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822063; cv=none; b=cZMKAB2B1uSQW+3TxyPAvoigXI54/n0sKwXe2HJURJykYKk22nPRBstBb8eygH3bL1zef4PFu5TkKLCJUVuL52l+lf9SdseNJt0iBR+JvXTcLFIl4PDtTXzTW+kMN2P8sfGnOsu1b7C9J/oynv/dKFP9EGpz2qPDeweXYQIBIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822063; c=relaxed/simple;
	bh=VjYRIbziQEjwjIVZUs/yJUpmg2SpJ4Xw5suodgxD9kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtaXs86u37asJOeV65+Hl2nr/SNSA8pW088dV5TAd987BAXJJG+YRaMHUTuLmTUocKhKbXaUQ+EeEfSUm7gV9a0xxTHGnvUAQ4sPqLrk0G27xBZQpP1JaFCWkhJCbc/8zJdq+fY77iusX/PjFgqUjfTraW7H96Tz+n+AzmJG4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnXdTDHp; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnXdTDHp"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23a9d3c9153so91749fac.1
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713822061; x=1714426861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0qomm9vVU2FkHei0a999+J0rKsASxApuZf/MDEtUZE=;
        b=TnXdTDHphHVOINY9tSDfjzzNFJ5iJ47ojJI5vW6GK2PAapCpBZcTPzJuCX7CjVzH4i
         DfLd9bFY/QctlA2vCtBq4aLPZUGGl3pP38yNuv+ybsTzCUKv8ZShC1XTQl+8TO35sUui
         itzFHP+J0vVmn20mTHPYijxEOYJATACgT+5hszDdGk7TUSG9lZmPjJ51wmhPhlKOsTKA
         wmMFCCK6vawmOfeSNSBlbJK0sfwPxbPBE7Qcd0bdnFnmO1X1c6komLxj4qAqXA+6H0qm
         UbsQvJyLOMrLRDTA1dzn3DjsQ8/fefs+Q2aYcQz07QqqEp/buV1cQqPjzhc4IX8OAg+0
         sVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822061; x=1714426861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0qomm9vVU2FkHei0a999+J0rKsASxApuZf/MDEtUZE=;
        b=GK8Sgkyfk+vTgQdYuFKmn+MYkcGbZl7j2aHBQ7EpdKE/u4UJHtQdhkGDx3Stpe6q1h
         9+wIwWUAEtCm2N/4LxO0vvlN1J+pO5bSqgpFxhyKndC58sFSjvI5fAoD2Fdk8l9q9NLp
         gP0dfNlumvG/H1bM5bYoFTRMxZ9MR1d/GPl04dlpCSC2a3DzpfQQKOGVaDCseZbvT1q8
         ENFWuVPzb1vliScP2GHXUzwoIWi00JdLFNM5LYw0mFaP4JlVNNeygm5SgVXye33BD+0l
         xijkVaN+j0bDFGWZlLEnUdm/1pOez1MSNoW0ca6zdg6rUzAmEsPEvh7gq+LBceIpDSB7
         FrVg==
X-Gm-Message-State: AOJu0YyIoFwbCPu9FCHu7ZyuTNeJz5tSC/MKcp7yRIVTk0WNVhgUzBi0
	Kn44le2VwjZ/EZwSi/7SemvGunW35n0FgvRh0wYd5QyMlvS3EN+dkHHEVg==
X-Google-Smtp-Source: AGHT+IHDiNzvptJjQG+n8RkdVLO0i8ttBfy/w5Nh2d3MFYPGik62Zqe6+s1xkDDLRqA7xEdWXdBH2w==
X-Received: by 2002:a05:6870:c0a:b0:22e:13ee:b45a with SMTP id le10-20020a0568700c0a00b0022e13eeb45amr16422547oab.13.1713822061370;
        Mon, 22 Apr 2024 14:41:01 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id xm8-20020a0568709f8800b00239b3c03b8fsm1076122oab.42.2024.04.22.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:41:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] qmi: Remove redundant NULL check in qmi_param_new
Date: Mon, 22 Apr 2024 16:40:43 -0500
Message-ID: <20240422214058.3411417-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l_new cannot fail, and thus cannot return NULL.  Remove the check and
simplify the code.
---
 drivers/qmimodem/qmi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5032233ec1ec..dfd41317651c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2345,13 +2345,7 @@ struct qmi_device *qmi_device_new_qrtr(void)
 
 struct qmi_param *qmi_param_new(void)
 {
-	struct qmi_param *param;
-
-	param = l_new(struct qmi_param, 1);
-	if (!param)
-		return NULL;
-
-	return param;
+	return l_new(struct qmi_param, 1);
 }
 
 void qmi_param_free(struct qmi_param *param)
-- 
2.44.0

