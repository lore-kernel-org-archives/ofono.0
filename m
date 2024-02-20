Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9C6BB3C
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442918; cv=none; b=IWnXEfh1cLZCNcZ6kKRs68TOKSu9vzaWTIfpEiKlx8q4EgB7ek+ODFJeTq5mRJTi4fGZTfTplzLNGWe1zIgtAJ9yB5HW+HGGQjgu4a6tZVWtW8cqf9zug4bfJknmZ5OobAtZcS8pofwcLf23IuT2oZ0QRqslZUlPLvM0j+g8KE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442918; c=relaxed/simple;
	bh=kIaiQ4gDj7fUaIBGRwes6xNwL4ErBDqjLIIqnxBSlX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lL3vt8jYjZhU4TFSGarPMPjvhnj2lZsv3rzS4Lu6c+v/VbPn0OCaLg5meVuVmI7ZA/aWltqCgh0IAsXDXdPvX9OlnmVlmuDWsiIED9ox6PMBxT4dIRT8Q0PyIviqybZzQWodI+ixGJ/WqPXn/FrOGN5/eTIItrU10NDCL4S0X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmWjMv/L; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmWjMv/L"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c15d1bd5b1so1486246b6e.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708442916; x=1709047716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RiBzTSul/AzrKWHoG0nH5S8YCmulae7J8/HhyNaTVso=;
        b=HmWjMv/LwE/hqHK+3KJ0H9y4qzy213Yhi1avIwxAR2xgAA8xCborQVomLeGJfCUEEm
         M/TeidaDJpphVR8JvDKwg8x+uoKc0U1FsIP5wBZHMkvvQwjWY88DfeSw7YELYlRmT52t
         VnhUdSPVSi7GwkAbuPxtieVEv84L5HkArfBLSsojMX5X3Q/soQawnQf8jAvtha7HeGd2
         29/FZcy1+4jVQuI9x/pFFMG2DO5qzSj+Y5kGhGrXXAtf3h7abn9u9aUzIlEUAHUmYWxZ
         GgMRLMnaVsAzWMNykmgFfCunGz7VEH1yJEMqxrdaH/evoWKRP1g7Mrn5dl953fqpbr+O
         Ktuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442916; x=1709047716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiBzTSul/AzrKWHoG0nH5S8YCmulae7J8/HhyNaTVso=;
        b=vTC0XvI7T8rLuBz67hUMYk6mIbr58536n1z3yLAw6GgU3Cl3JxA1U7RkR5O9Ugl/eL
         7TNaxlocxHzOamg+c9vROpcnmgCKjPPJYDof3s+VkQlMlthbaNvzdU0e+hpMl087QMVr
         GBO+kUKuYkLA7aOriL1qqfvlptkbEuKxg1UGoTKcamxKh3rQOD2UAjGtjwniYWHGaySn
         zKbP6vd5A5Q3KSCIWB56xH5trzESIzxzVtCjOKaezN4U4giQdiWBltksaCd1CVwF5tgR
         kAJRPNgiilFGZtW+KZWq9vJNmyW3eP8IuAdCtyXgfcWvD62vFktDbfXg7WC+Ubqy425c
         QUoQ==
X-Gm-Message-State: AOJu0YwTob5C0qEFQ79Bb5nbcPyAUNVnOhW7e2I0he3iJMqEVL6I5T+c
	u3m8vQzu27Ds5xyUaqvGQT2m7YSGrLQkfmCowCdC+pAjxXgKKsE9FQ35/9OH
X-Google-Smtp-Source: AGHT+IGbfhe4yHm1K01KOGLeQnDQkSmfVk7qaSOU23bg/Q38xFiHRXo1YDmYm/xkzvzArHDCMVsQQw==
X-Received: by 2002:a05:6870:239f:b0:21a:d9e:3eb3 with SMTP id e31-20020a056870239f00b0021a0d9e3eb3mr13568873oap.41.1708442916018;
        Tue, 20 Feb 2024 07:28:36 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id mj12-20020a0568700d8c00b00219f34db8f6sm1869513oab.46.2024.02.20.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:28:35 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] build: Drop use of ln -t
Date: Tue, 20 Feb 2024 09:27:36 -0600
Message-ID: <20240220152748.1249770-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems, such as ones based on busybox, do not support the -t
option.
---
 Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e7fd030f..e19bf976 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1090,7 +1090,7 @@ ell/shared: Makefile
 	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_GEN)for f in $(ell_shared) ; do \
 		if [ ! -f $$f ] ; then \
-			$(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
+			$(LN_S) -f $(abs_srcdir)/../ell/$$f ell; \
 		fi \
 	done > $@
 
@@ -1098,7 +1098,7 @@ ell/internal: Makefile
 	$(AM_V_at)$(MKDIR_P) ell
 	$(AM_V_GEN)for f in $(ell_headers) $(ell_sources) ; do \
 		if [ ! -f $$f ] ; then \
-			$(LN_S) -t ell -f $(abs_srcdir)/../ell/$$f ; \
+			$(LN_S) -f $(abs_srcdir)/../ell/$$f ell; \
 		fi \
 	done > $@
 
-- 
2.43.0

