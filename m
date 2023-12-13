Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F015C084
	for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6XYH7U/"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9e756cf32so4930426a34.2
        for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 13:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702504341; x=1703109141; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duRuQpcYqQGqy8vucHn13pHPeIPskYlgbS6cuGOPPUE=;
        b=A6XYH7U/kiqysqjFXrgHT+lfQUhgsS9m++8g+LRWNdF3zX5Gl/jPARJ0itvQ1d9+lo
         fR12Gi563bHbQLbMlwnxH96sPhl22NqFabWVZxsQ7SQ0UGe8xozK5ojhshFSO+j9n5lG
         yS2Ccx6LHy0AS5v93flZOMBIur3op4j5Mi2u15loSPjAa1ySk54tSNxsX1Vi2XqU8oZs
         asXvWGApRckP7jhPmyK+R8Pmx4R+fI0JnhCRg2jo1Axv2HcDh/r+YCTbtMIu50gOenb3
         O/sKDtC2VD+/A+/ImEZTn2gRtCT2OA21BKeTCDQpoH1gsnT6JLJ8hL6GfrmzbwFdd46T
         /16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504341; x=1703109141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duRuQpcYqQGqy8vucHn13pHPeIPskYlgbS6cuGOPPUE=;
        b=YHGFKaqaGQjGzNHiT9gtBf0SUsVWdUgtuuUb+yhwvoHiDLHB2GSvu+7EWfh0Je02TC
         Yext76kcZdo58qbANRD68ol83jMblUmiBpbMzGf7tu9V2Y8BN9gHLe0gfJkgj7X6dixD
         59+b2/h9o8W+f82h3lBMIaBUNlYHvEZ+gUgyL3W2UXzVs4rBryg7Kg8MQxs+qMoFfVdD
         RdKRHbmPo/awKw2HTt+QAG2q9QIYWDHJOXYNFyvq+AaWP9wO2h8Z+uL1qmtHwyccO9kP
         q7p+RNGV2t8aS9UhSeNrYML33rwhPDiJpIstlJlnA65W/JM6aEzbtLGUVvUAaQ91+meg
         I6gw==
X-Gm-Message-State: AOJu0YwB1QupHbrj037Qxd7P2IYSTLnOHLnf9ZZ1dc/Pr+YrCw/6CnKA
	i9bXa8LYO6u2b/UIsRPGIHINjmg8biM=
X-Google-Smtp-Source: AGHT+IFihXdPE6zFPWozPlqlE07/5aeEqqhQUU6sHyN1a+0teflkKJS96PqtBxfXa8sKdQhDz5a2qw==
X-Received: by 2002:a05:6830:1e73:b0:6da:32d9:4166 with SMTP id m19-20020a0568301e7300b006da32d94166mr2228505otr.18.1702504341481;
        Wed, 13 Dec 2023 13:52:21 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d7412000000b006ce33ba6474sm2925612otk.4.2023.12.13.13.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:52:21 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] build: Fix typo that breaks --fsanitize=leak check
Date: Wed, 13 Dec 2023 15:51:25 -0600
Message-ID: <20231213215132.287577-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 acinclude.m4 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 4932ac6b..656888d7 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -23,8 +23,7 @@ AC_DEFUN([AC_PROG_CC_ASAN], [
 ])
 
 AC_DEFUN([AC_PROG_CC_LSAN], [
-	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=leak], ac_cv_prog_cc
-_lsan, [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=leak], ac_cv_prog_cc_lsan, [
 		echo 'void f(){}' > conftest.c
 		if test -z "`${CC-cc} -fsanitize=leak -c conftest.c 2>&1`"; then
 			ac_cv_prog_cc_lsan=yes
-- 
2.43.0

