Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A31AE09E
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895115; cv=none; b=D83Rsv9EnDGKqoD/4TYTReOlqCxScCa1+01Yz5hCkdfdzwpuFvy0+A1qTAtDYRMF9opp1iSlVPYD53fTbnmuwN2J9YgmUi4Xc/7P8uYCYRbBrmmlCaNu2nVALC1mGEJDg5fIKENEoxG33hIlxYE27RWrJe/ralz6xAPG2FvM2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895115; c=relaxed/simple;
	bh=SFF15oEOE/+E0tbwO5fuCPcKrHEuiMdsM/IAIgKDYR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVJbP1KQvHWoRBTzsilAs+9uXmEvjYvS9Z8FqtZOBCdyZd8oMJl4IHzHZ90jgM+MKCVn+80swD2BaPqKNH0xMNAw4GQU31uw8wsoWepDaYd48O4HrDhU7exDgtLYmt0IlvxIPyYEN3DSaVaappQ0ZWKS2oJrpM1/Uz0wKPAii1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp9JIHkO; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp9JIHkO"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d21e00d9cfso549774b6e.2
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895113; x=1719499913; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl+oU570NwiMyhYtTo8ADyrZCetA3v81aYfFwn6Tyew=;
        b=Gp9JIHkOsW+/vvz7Amr1ytvdrscna5aPRo8gm/2Uh0YqLBjm5vQiSAI0ee3ecTQUJD
         x5apE3o7oLpYnYJW41jHH3xJxNFRzBuiALJ0X28tbXuQBWxk9MLRc8YLDUDI3XmdgmUZ
         zFyitpD7ee4VAz+VWx3s4U9ic4wZ5CIKRvHQgakCT6UoC+KtetXmwO6pq3H6bZkVlqiN
         77BJLkiptkDny+gZ6+BN+2n5Sm1ZvI6Yc4j5+VCHKSTaVZQ0QFXAV6Vjjg++m+O+gK1j
         hq8vlzm5LYFaJgPs6JuJlXjUJ7QkdndXfkMkaXj5SetObBhWYsUlCbx/QvrwmxHuMkpU
         pPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895113; x=1719499913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl+oU570NwiMyhYtTo8ADyrZCetA3v81aYfFwn6Tyew=;
        b=L4s4xtHVHDm0lMwVZmE6moHXC9cBYVpAfVd7V3hW9lKtXgdt9eAbahZwEtT/IcPsC+
         Hv3Ue/zhrtU/yLlNW5fozYSPqFeSxqyGJRjjUVh0aw2aw/p5IAqSgrOVWjgkvo11Vop5
         NgguJZAh5h5J3WE8ohz7YWnpGwFYHf4ZknX5uosi6yiOs3CQt3x9G2oqAGbQ5o3hf+jl
         QCe4etU5pi7dp3AasrZ1DxDwS7y7qfB2OXqLI+4xLhEUYJenOZJw6Pip4lCTU/I4YVbf
         5e1lQVOSX2U3RY5zmX57Fkq8j4tnz9ltH2Ml6/Ws2pxmwOqvZJ/Jmq8yFaCl7vEmIzfs
         lksw==
X-Gm-Message-State: AOJu0YypqcCbFI+VxLmR++fPUM8gE8Y7tWGVXQu3I3vhYYsjVQrGHlPt
	LKm+rTFG3MhfO/OirblWT7U7o0MhiVJr2sQgU1jVVO5OHTF14K1L2QRK2g==
X-Google-Smtp-Source: AGHT+IHkOVak4JREt1ky5IpAkr5Z0xxklwMGlcS2C7q+u35jYUmrqDPPsh67j3G0ArBtndw3BD78QQ==
X-Received: by 2002:a05:6808:19a6:b0:3d2:2999:e14e with SMTP id 5614622812f47-3d51b97dce5mr6573295b6e.18.1718895112999;
        Thu, 20 Jun 2024 07:51:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 06/33] gobi: Use correct attribute name in docs
Date: Thu, 20 Jun 2024 09:50:53 -0500
Message-ID: <20240620145139.1135899-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name should be NetworkInterfaceKernelDriver, not
NetworkInterfaceDriver.

Fixes: b3ff67d78830 ("gobi: ensure required properties are provided")
---
 plugins/gobi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5402bedcc22e..d8fd90153054 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -112,7 +112,7 @@ static void gobi_debug(const char *str, void *user_data)
  * NetworkInterfaceIndex
  *   The index of the main interface given by NetworkInterface
  *
- * NetworkInterfaceDriver
+ * NetworkInterfaceKernelDriver
  *   The kernel driver that is being used by the main network device.  Certain
  *   drivers such as 'qmi_wwan' or 'qmi_wwan_q' are treated specifically.
  *
-- 
2.45.0

