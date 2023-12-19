Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60838FAF
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI5KMAkv"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so9486239f.1
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011265; x=1703616065; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duRuQpcYqQGqy8vucHn13pHPeIPskYlgbS6cuGOPPUE=;
        b=VI5KMAkvFukHLTENlMy3mATHbU6n69cl3RfAlQcCLq1aFJQ+ylKvuEV1jN6aNhd/Hu
         WXFqqt/8rbmV73R+LdCb7uDppHh5RR7avIjmHOKOU6vsnI2V49SHyVTMVZLrBs2h6O3M
         cMCft4NKVP28GI8R8DwlRw9rmaydB/BrDbxhQ/VgYm4RcxD0h+Pf6JpW8ZwvEwqnwJ1D
         gEtbN4kwOMm1Ksb37Ex6xYluCvNBs2lT8YUpx1XvohPrrLGvkVE9gaByEEcBtuCq4jL7
         Ti7c4fx5HY+qoyWTzbx7SLVQTCvIiI+8L7LIP8912wVdTnGQ8Oa0tHYtVQ5wyGcmaQVd
         Fhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011265; x=1703616065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duRuQpcYqQGqy8vucHn13pHPeIPskYlgbS6cuGOPPUE=;
        b=mXUsNWS64XLdzD65Ar3SIhKp18Pb+6sjGx8j+EiekRNeWfC8Z1YKc7webubxajmJYP
         CPo5F5yjXEAaL6osomJ4CmFaWQxwYO/R2mlJAfgLjVqKUMg7jEteM98uQAqGhMJnEtRp
         VXDTWPKkJPysu1DsCTR8eJavy0+rTbrII7XLs3WfC7enQu34j9koJhX8oghq3t9kwNle
         GjwbEgk/D659ukF1SL6U9NVu2fVXxI4lm/TnI2uXVbI7FQZvWvwt0AgkMmfSDanuYR8x
         DUDFY2TyjnmOMfOZRYLuFn4oGD7T4ohJ2ETpQkUWlUc/5Xr78IXBqIaGJT3zAwtNMIiw
         cAhw==
X-Gm-Message-State: AOJu0YxBHde8/eSoNOf9y7Ggrb8yDM7wjYoWE/xSRYYZgRlBYeFjUB3W
	L1mwWSQ76RYsYyFWN2e5iAun+XIaq7s=
X-Google-Smtp-Source: AGHT+IGpfaSbmAWBqaLEu9kzdmyQj0iNiwnzp3VwhtVSYao1frNStR4oZwqdSUjJa0w4fO2G4ZjTug==
X-Received: by 2002:a5e:de4a:0:b0:7b7:f3a1:c34b with SMTP id e10-20020a5ede4a000000b007b7f3a1c34bmr1337068ioq.33.1703011264739;
        Tue, 19 Dec 2023 10:41:04 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/15] build: Fix typo that breaks --fsanitize=leak check
Date: Tue, 19 Dec 2023 12:36:58 -0600
Message-ID: <20231219184016.420116-1-denkenz@gmail.com>
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

