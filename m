Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223C1EA84
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082719; cv=none; b=KmhvD0senU1TTarfgnONy5UI3Q5hQBjFkMNDnOOy83cOw4u3wytqbpBXHgypRbtoPUvxmwUtnp4JdskLF/xmwBMeRgspFwyvLSvE7xe3jCWBfEUv8J19vFKzrViRzf2+v9yWBTG6P+qpE47E4du76bJh97BLXAnnInJNX0JyJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082719; c=relaxed/simple;
	bh=HkEZgaqAD97w5ZCrZHZrRaa8u8UJmQyYN5Bof3loaKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S018QrEuqJxL7X+nbTPeWiFg/Vv08zP1n8kGEagu+1zMHTLuYCIAZ/jq7FBadbJX9t+3gQtGiS6VjYHAzDc+YG+Zot9RXNz7VHa1brmnD7i5I/A1pmei2nN47GrMl3tfeRvL3ss/4t4pjPpe1vfuzvGFaE6K+uWcrpAm7tZSHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3cJwfoN; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3cJwfoN"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d1b33e9ac6so515182b6e.1
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717082717; x=1717687517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAlq4X7UE2lFWDJuJQqAUZuWhAg2MFQ0l9yYqeRjFd8=;
        b=U3cJwfoN2IYaok9mOfehfRX20BWyiVG2fDxpTjzB2Yy8J58VxuWiwg9ds0xhbJgN+L
         kWKt7zeMpNmBx7kwqe6q07qw6c5Bjud80NToprTF9+4UzHeLSqLWGbOAOrK9HiJBwAZL
         kGzhV682Q5uIfICawD+q8lPzrhPgZ9Lcxt2VAfoVxOEuIrTLt4xYPwyuc9NsT9Z/9dQz
         8mYPRKVfuO2uGc3631kvrQm+hYOncSW5JNpfMC04EYdxCii6bpigREtT1RxmtNCnFJ3r
         Sv/tFTet4VyFsV1VPeAYlPfj91r66M/EDR+zj6kAtkAYrowg3MY1mHNP0vAkI9jo9Hxi
         tOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082717; x=1717687517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAlq4X7UE2lFWDJuJQqAUZuWhAg2MFQ0l9yYqeRjFd8=;
        b=feZoX/9fG2N8Jj8mSH9QQWG97Px3Wt57Ytx+CxJvauhi+B07qhiWNisWzd30PRPcHe
         CKOwl1YsyLndLv4RWh+tTzL3w2g3fcVCtWATAWPrpue0cXm+P84+2xcHEFfQUK/mSI/X
         OpgTmslPUIHlEgOaICsTAHLotx77SxZkpVTC/lLIldK+Hu11mL2IyOfk20Bikvh3w/dB
         JpQpcbVSYPNTW6qFUob1a1YHpWMwYWnVIW6mmhnow5PjpSwuncmdWQWVz28JqmcFBUBB
         uQ1zpoB3qYgXgHQca4H9gY9c/QaqvIQ7L8+HMB+owHM1E5oS32fnE+KSYyXYOVr/ch3f
         utHg==
X-Gm-Message-State: AOJu0YxcU0MhdHRsh7Zf1cQ1UNeKdzQHPJ/aS+OwwBp2D9RuhCI9MhqK
	do8GhonWJ6eKEXayDvCdZuVuN/g2rH7bk28lchMcZnpJqYGE1eO7q7uJAQ==
X-Google-Smtp-Source: AGHT+IG/Nhr/DCEz3R/e0R9b9bP/VfO+7I9CJQsbwahfTqJfaWQCy4uLrECjbcPHtMLAzRt+vrtXuQ==
X-Received: by 2002:a05:6808:1288:b0:3c8:4dc7:3963 with SMTP id 5614622812f47-3d1dd2be12dmr1104522b6e.13.1717082717276;
        Thu, 30 May 2024 08:25:17 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1b36c1eeesm2017889b6e.23.2024.05.30.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:25:16 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 2/2] udevng: Fix detection of USB attached tty devices
Date: Thu, 30 May 2024 10:25:03 -0500
Message-ID: <20240530152513.279243-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240530152513.279243-1-denkenz@gmail.com>
References: <20240530152513.279243-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devices on the USB bus, that are part of the tty subsystem were not
forwarded to check_usb_device.

Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
Reported-By: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 plugins/udevng.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 07c87eb8aa08..87969461ac5b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2510,17 +2510,16 @@ static void check_device(struct udev_device *device)
 	const char *subsystem = udev_device_get_subsystem(device);
 	const char *bus = udev_device_get_property_value(device, "ID_BUS");
 
-	if (l_streq0(subsystem, "net")) {
-		/* Handle USB-connected network devices in check_usb_device */
-		if (l_streq0(bus, "usb"))
-			check_usb_device(device);
-		else
-			check_net_device(device);
-
+	/* Handle USB-connected devices in check_usb_device */
+	if (l_streq0(bus, "usb")) {
+		check_usb_device(device);
 		return;
 	}
 
-	if (l_streq0(subsystem, "usb") || l_streq0(subsystem, "usbmisc"))
+	/* Check the rest based on the subsystem */
+	if (l_streq0(subsystem, "net"))
+		check_net_device(device);
+	else if (l_streq0(subsystem, "usbmisc"))
 		check_usb_device(device);
 	else if (l_streq0(subsystem, "pci"))
 		check_pci_device(device);
-- 
2.45.0

