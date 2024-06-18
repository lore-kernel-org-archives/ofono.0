Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C616DC1E
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740961; cv=none; b=lN+pDhgZz1uuPCvubTFWs+0+u2C9nhOONETVygyVlW9Usju2pOEDJ3UR56vUE99QOS9l4tfMrwFGCBf+McD4K3AhcDUj2S734zm5KLs7PfE7OhGJGLbtZkAPEJmCdlLouVzoJpOincp/mpVBD/LPitcp2cazax27SXqepZECxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740961; c=relaxed/simple;
	bh=Y1PdZud7erIXoShijODcPVTJniAFQD+o57VgIzmdn1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EShtXqaKa5EjTzr3HgVqgCHS0l0llrFgxcyxICH0QXcO2r8AbSTO1WNfflRL7FXzan0cPY8YUbpFUzlMfRlGhictWt5vj1Xbu5BuzBO7EV0Pf2U0t8B7Xk8wEGKoECsCsUgLQXAki5mx0W16mdeH0ippsA8LJbk1inyfbFRtSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWsaBRc9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWsaBRc9"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2597922eb9eso592439fac.3
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740959; x=1719345759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=DWsaBRc9RQDg5DdbUWQYPA3FP0NA2Kk5glZO2LBXPtmol4GwNN5tCdSvoh8w/Aczz3
         KSpJgSmopW4w90ou2JfM4kQlNbm4/DIvRYlVjAYlQwzMAhe+V3mFX90yPXCbSue7tPcj
         U2DqsydxI6CtOQ71fLRPcll8FvTPegYWsrHDAZs9ocFYSuq8a5Vid8N7jZDOjWffSWgd
         cP67454SrWV+3vszbsll5nl/q/9eTsWIvUNFRTvP6CICSdTfs1fGwQbkAN8Ds9qdLIFC
         AwQ4+TTXpud1tQKpVPvyIh6karvneQRcJ1MVpnulAQmMQ9XiX+ySJ16ico0Eg38DTQt2
         7NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740959; x=1719345759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMJ76HT01RXhDJay/m4oOJX4o+vlJaUvm7hJAa6MQ2I=;
        b=mJRIKdn17qd38zObAepaJnBKKpfg6S3tjIW7KnD9mgG2dKfGgISz47TFFsP5F+nvop
         90TGjdo7urqfQtLE9udBdl0Viqu6MFnV3RDcmgUQaG3+U9kJgAk7Y3hsxJvotjUwBZZ5
         ZbsC6M+uYY+uz7mpgb0NFlLKUha58EbrrEZliZ5RU3smcT6tGOrJpl6G6Kf6g4VhLZjt
         93PlI7mfNfZBy0XGrP8jMBgJvxOK+L5UjNhBZk7VK/LLkhLnmjXeGYcUwoBCnFjTO+30
         fJFlddE7KzzBNtwSqNs5AZcCV647Otjj/+74v+L0OzrRhuildkn3k+8qPwB6M+QlQ7hr
         Df8g==
X-Gm-Message-State: AOJu0YypXaD74l4n2SJUKbUeePH17wUFeFJKqkb3gncGLskJcy/YJ97m
	RG7htWyvNQT91G0LiVsjeOsA0Qq6PUqhz0jilvucxZZutsEoaIXyYa3FBw==
X-Google-Smtp-Source: AGHT+IGzlILCVZ21hNGBx7YzkVFXGCPmOhIbzjLkqd0JyiOe0nYbn0Ns6MCmm1xUgM5oUg+VPwalfw==
X-Received: by 2002:a05:6870:218d:b0:254:b6f0:21b6 with SMTP id 586e51a60fabf-25c948edb19mr941847fac.10.1718740959486;
        Tue, 18 Jun 2024 13:02:39 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/33] udevng: Do not set DeviceProtocol
Date: Tue, 18 Jun 2024 15:01:51 -0500
Message-ID: <20240618200231.1129282-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute is no longer used by the gobi driver.
---
 plugins/udevng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5ef0bc253562..864f9c12b9c2 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -252,7 +252,6 @@ static int setup_qmi_qmux(struct modem_info *modem,
 
 	ofono_modem_set_driver(modem->modem, "gobi");
 	ofono_modem_set_string(modem->modem, "Device", qmi->devnode);
-	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qmux");
 	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
 
 	ofono_modem_set_string(modem->modem, "Bus", "usb");
-- 
2.45.0

