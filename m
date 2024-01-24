Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24D1350D1
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130849; cv=none; b=tNXFnznHj3/QC/IEkSpahklF+TdykDHVIcNGrlAEy0/oeij5ixm6pV3OINuO63z7rshj5JayjL1Oq8Pd0SASC+drPNmSPVhZ9AlEtm8934OdKdeP09wi+Wk+sgPvTe8VXsjoCuwhNDGBrn64Xk3QH0d54GO86x7orU3vdMoO9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130849; c=relaxed/simple;
	bh=OTpnF8wBaH461nBqPMFltMg16Hcz9roFOGtNIJhg+Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNRs17N5TmESyVziInQ9egCu0y9lz+tWHJcKauCbpS7+eFtBf2NUFPRBPeN01wM0lC5HR+hOUsPQ7n69zn3QFnaJSKL8NQXUOBxpSJOAVYkaGvAt5uZD2dluW4EfX8mo4x6cigv0mnYn4X3BnKkYpSM6osZX/FOJcZzbbKV2CFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPMqX8lo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPMqX8lo"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd9030d68fso3585306b6e.3
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130846; x=1706735646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNhDHln08Azxi2EnQy1WNPfjtieEQtjUVMWvH5VM5GI=;
        b=VPMqX8loWEm8LtLcmcQhyZjfqujXKNrpWSb58CqPiwT/NFV3bruSDqLlUuAGpq5a+8
         SijHYC66EgvuS/F5/sJF7iZ5hy5l02t0oMiTw1QiRaMlhi0goA1On/LYf09PfyzrkASF
         A0r153l7RnCvT6DaWWzGI3Pwejux2NY0RMwPlYXPMxJk3lXo3hGwnLaUdGiRM4kp3yMz
         SDLtqGD4gHAqMqG6Rm/4mRzNqrLzKFx+zVuC2+OlaK0Z9luK8m2rmqOMwAZXnX63wtGu
         s/rWQJLCpMUcg54UKUD8nvwJ0zy6ht5fCVsOX9atU76hBOWjZD0ff28Tbuu7LJJLNLMT
         AXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130846; x=1706735646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNhDHln08Azxi2EnQy1WNPfjtieEQtjUVMWvH5VM5GI=;
        b=UjINtDpxkBEpiVWD59mBc6MdGqN8/lVuqs7qaWpsemRdnZJrm98eLHGQghuvF7eHm5
         6MbZSLjJVpy2ri0IsIXBEY4s1DltIypbpspQ5eH1kL0qdYlaq8gu4Ab65O8BXMefqdot
         /ikXqH/4NS4hpuNVw90hxEN2X7tq65AjTAsQr7fmOL9ZhmNzubx8PFqOZsCWhVob0yuS
         thJZNWX3NizLc7lrJ0Z9t+UL20h3eTnkWHjgYSNLD40yO833YyGuJ4SpPWaA5AsBkNw0
         obtjEwooswav5hkApEK9q80i1meD4hx3a4+cNfJbhx7vRaDSdX0AaB0HKOLxw4H/HXCl
         ByWA==
X-Gm-Message-State: AOJu0YzbkhJZLxE/ap7UDExeNL0bXY8+wuTDfYdhLgoGvgcPSswR++LB
	yt8ttthuw+oCrIVMRLs8ZTJKcVEJthxWAHrlun5n7vNtC6OmehLy7ISQ2klc
X-Google-Smtp-Source: AGHT+IFflII7wAIBRrGq6Mo++ZOle7qr3NJUPpkmx/AKcbv1ArouNPDAC52E4B50JbkOW23wKCF3xQ==
X-Received: by 2002:a05:6808:bc7:b0:3bd:cf03:2331 with SMTP id o7-20020a0568080bc700b003bdcf032331mr2035143oik.94.1706130845801;
        Wed, 24 Jan 2024 13:14:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t27-20020a0568080b3b00b003bdac23eb89sm2003318oij.34.2024.01.24.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:14:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] core: Remove unused declarations from ofono.h
Date: Wed, 24 Jan 2024 15:12:59 -0600
Message-ID: <20240124211317.611706-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 36a11599 ("gprs-provision: Remove no longer used atom/driver")
---
 src/ofono.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6a8c53a1..42298e43 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -587,14 +587,6 @@ bool __ofono_provision_get_settings(const char *mcc,
 				struct ofono_gprs_provision_data **settings,
 				size_t *count);
 
-ofono_bool_t __ofono_gprs_provision_get_settings(const char *mcc,
-				const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count);
-void __ofono_gprs_provision_free_settings(
-				struct ofono_gprs_provision_data *settings,
-				int count);
-
 #include <ofono/emulator.h>
 
 enum ofono_emulator_slc_condition {
-- 
2.43.0

