Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63125FA00
	for <ofono@lists.linux.dev>; Fri,  9 May 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820900; cv=none; b=Ao2Wpbop5TuMqryeuW1ERPecw2a/9qX0kGFJ7rUwCeXu0+QYs/VO50ZO5wcqKokmERaki6uG2Vu/1rz79NZp+/6RZn+DMtjMUw/xMWupiZ65UWYF0mAK5rGBpc9MI/NxabtIn2B/3VWb6x/8QpPEpdkmSVonil1VQ4KSOIbAHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820900; c=relaxed/simple;
	bh=Dwd6BcJQOcx8XCEnBM2QDoBsVksbnWl2zGB3lFQL5XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvD9enCmpVQk6p6fdIrlWX/ONHzK/PE9s2A+ofypZnGdQF0h8EOX6P9UiV8Yvp/6MIg/7K8dy0Xe2De8NNcYvKEqR//W5V754kHZOFshWYB8BzNhXvxRoTyMIk0RWA5QKaYUcOlFg5Iw14HsAC3weWTsimqf9CwEOAJB4C6rlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UupXScSj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UupXScSj"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c16e658f4so1460824a34.1
        for <ofono@lists.linux.dev>; Fri, 09 May 2025 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820897; x=1747425697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeKxW7wdej8z2XFtjnn+ZmcIb6dIVu+fY3JWZgeA9/g=;
        b=UupXScSjk23o8ND6UxpYBM7+MbX0DPIRdr/qzVzcv1ARqH+ynMxGJkjgx6hZk6w8+r
         Tt4y3TJKeVw6yaXG2hmd3YGY4iEGldJqStJ11T/2QAdYhcyAfmcqDhyurMl0GRApBtY6
         g3i+ZZZaPb0ReM1OB1JUob3vIYB/q+Hqvg87MRPQXdReq9189T7LJCjkwNM1PMXv1zZ7
         Ikh1rflCnvzTGgzyaZ4b1Y/0japKubUF0X01YD1FQMZLTRthCSDZBLTYNx7VPXH1AKyK
         GiKJ+9KWQGiP0ktAcR4jad0/W/iKJiL3SsJOiAqoMxrchjE1yCPi+9aWDL46YxBge9/g
         XTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820897; x=1747425697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeKxW7wdej8z2XFtjnn+ZmcIb6dIVu+fY3JWZgeA9/g=;
        b=Zb4yL32F32Bn/0DIFAjAryg8PEJKXMX79Wc7Guk1uLITsYOne5E85nUvO4D2L1FbZa
         MtAdQWJvID0I9VV63c3OW9jK3ujZHnb154Qxe1iLHJn7FupSfFXHhgW7WG45wRTt2pil
         SZzTCNtGnvygxB6Ngt7QDj4JjzymT1lErdZOd1tx+8nbfpDqC3Ab44aOtmhviti6w1+c
         QGQeIje3C0GZPjstDDHv4tdNLg1ydw3J284bzcajm15DWBaxFGVEj54mhyT6yJS18epP
         bxK/q7QrQXP71HfdIhl7+km4rsC0Krwiat7sPNL5mLL5yRu70+kIMp+w72zrT6Y67FwX
         Iwog==
X-Gm-Message-State: AOJu0YxMmZ3FNntPIeo3N8Ogs7U0EoVaotTkKhDN8esap6kfEihjvtOK
	+xpl2yhrtu81Ce1HmVmExQ7CR4+i3KvxD2yjwxugyF/hMibydM+oA/iHqA==
X-Gm-Gg: ASbGnctKMRD3O+jVHgPyF8zGLNDgY1zins2xwO+NZVztWhwQ+tSO8wcE4dfnLntlbs7
	jM7qUsckN9miPVULjZfmkK/glMdalEbXjPVu8vRVnC+xQqzNd+dJ6QS+NhDzeuXueZEnoKnNsls
	5cvXSzt6cTXatkOEoBYePUqQE5kW+7ZiOeUy1xsS1VAu8b24QhjC4wplSSx/2p+0AFo05QojuI0
	0BfbqHTd2y+8i5gYJ8J6xRePqDRLegcH00Mwn2zJMSV9A8LmlbCbn3efh4/Vl0hubySP7vUceAz
	aOiSvPwoy/ZbKtrmjMEudX7NQhhSVctyUUbmlYnnmsocbwhcWpQPLY0kIEeo7WAb7oodSYN17iA
	0MJLo8znL2YUDaxrrmdLQJVvBGw==
X-Google-Smtp-Source: AGHT+IHJy09MjSyxSyPHUpdcKqJR1T0VFfhS/dQ56lTueD1yYiJSOqjP+L0RMSvDH3ZqVW+SkF7L2g==
X-Received: by 2002:a05:6830:6b0b:b0:72b:98f8:5c82 with SMTP id 46e09a7af769-73226ab1ffamr4160787a34.21.1746820897486;
        Fri, 09 May 2025 13:01:37 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b2e5asm667326a34.19.2025.05.09.13.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:01:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/5] mbim: Print the device as a string
Date: Fri,  9 May 2025 15:01:12 -0500
Message-ID: <20250509200131.42020-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509200131.42020-1-denkenz@gmail.com>
References: <20250509200131.42020-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of printing 'device' as a pointer, print it as a string:
ofonod[2672]: plugins/mbim.c:mbim_enable() /dev/wwan0mbim0
---
 plugins/mbim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/mbim.c b/plugins/mbim.c
index fa4a25d58eee..b31f8b66711d 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -269,7 +269,7 @@ static int mbim_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	DBG("%p", device);
+	DBG("%s", device);
 	fd = open(device, O_EXCL | O_NONBLOCK | O_RDWR);
 	if (fd < 0)
 		return -EIO;
-- 
2.48.1

