Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CE7F
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053380; cv=none; b=a6bRVYYZPd1GgkgT4cc7DUb8x4rEhsvRoMrowGxwceDvIyqYoP42dE/po0HcfCzBDHxFS8eG6zkXxMrS+zmaax0cbwGG3YgrI1kTfv2l+9BFTiJ3qNVQg/sacDYaigQqJs/Z4lWAkWtz0CbzVos5RrwtSitTBvvdP6KTXoqtl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053380; c=relaxed/simple;
	bh=iU/K99GihWrIaGjI9xibFkABYkbbLJZt6GoEJUZI14Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=V8pJjvs0WRQoqCb99WwYDP/QVh6DRTCAxflHCNXYji9pG88jh7NGqYJX/v56AspB5MqcP7XlASD3WStRxcCb4jp3xX+vRUfAoPrVPShjsjQErLRj4iX0DzurmtltXWqM85FpethMpOZ8e3VYVEhshXwGQckigV7SyX+F7sEp4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQKHP1Kn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQKHP1Kn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so713478a12.3
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717053378; x=1717658178; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqPfswdjdAslmZiC6an4tfDailMsTwqDoeQn60JFWS4=;
        b=fQKHP1KnTr3gwSEyVAxbye7EOdv93QjhxwX5RuVb2DDAusr6jJowXPQVCb3ALPRpHU
         tBA7kjYLK99quV1pDDyEhbovsu7cx/GVhvPZAPq6LiLgZKpyyqLUGqOQh+meCX+vpgZa
         1q9Hx2Vmq4Wzvnff7bivRvSEcRIvJtNy1Y1N3MU4Z62XpdY5yhzt+6xdHJjbsvCO8wEs
         RSnZ7rYmRg5/J3sHdDL/p78CD8lHbvvod/pVo5YD0yq+2/tr9irp4TXLj6ctPRpMaDqu
         T9vzoFRzBkDnMUea0wAaYGZs25kz4hvbtdYN6MjzwplPx+l96LUkrOpxlZaZ6PDJ0kx1
         nAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053378; x=1717658178;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqPfswdjdAslmZiC6an4tfDailMsTwqDoeQn60JFWS4=;
        b=mialyC7ioGhNtzLZ4stATsMbcJFh4YIM/zbiQk+ei2czWuVomdX3Re2RIzaW1mp+2x
         sUmh7brXnNURr023Spclw4u1GQidLmqbtsbg9AtAOkKmgPxTpEeY23hkeN9SQScKGuzq
         bAUw9Kr/v1M/10LZNJoF3gHvLEEdsM3i4egADB4mTIBG8hNLbQlL3NZ8WhIqGZ0E3KDx
         NtcFVeu5/VZhYOk5R11ZrIBn3/VJD7/YdapBsAtqNeYdt+0SvIozShRCcL7JNQy9nzOi
         ThDnpvP7PPOvMSJZEENqfZB3OfTkUj+PIjJqzs5opQhxBjrcTPhKSlnG6mW1KdtMp8xv
         wSaw==
X-Gm-Message-State: AOJu0YykKVejpiKFuL+VnNksD8xAhx1K+6eX+0ktwR+QsAWPwFFJSyS/
	q+riaIgp8pHnqgDhJrNMn1lTqx/Ycn7CUt3Zt70F8/oFGJDjBLGIEdB5Ug==
X-Google-Smtp-Source: AGHT+IHE+6aZAP1XkwIR4QOFzhTlQ9wA0WX7xd9Vq1fywq/G5jSmzKFsqYL9RYHjrisBNfKLYX5L0A==
X-Received: by 2002:a17:907:bb88:b0:a65:e393:31 with SMTP id a640c23a62f3a-a65e8e4adddmr200010266b.17.1717053377451;
        Thu, 30 May 2024 00:16:17 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a65f4b77e09sm29137866b.162.2024.05.30.00.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 00:16:17 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] udevng: fix tty subsystem device on usb bus detection
Date: Thu, 30 May 2024 10:15:38 +0300
Message-Id: <1717053338-2765-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

Fixes: cdd58360140a ("udevng: Add mhi subsystem detection")
---
 plugins/udevng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d3ce3d5..891412d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2509,8 +2509,8 @@ static void check_device(struct udev_device *device)
 	const char *subsystem = udev_device_get_subsystem(device);
 	const char *bus = udev_device_get_property_value(device, "ID_BUS");
 
-	if (l_streq0(subsystem, "net")) {
-		/* Handle USB-connected network devices in check_usb_device */
+	if (l_streq0(subsystem, "net") || l_streq0(subsystem, "tty")) {
+		/* Handle USB-connected net/tty devices in check_usb_device */
 		if (l_streq0(bus, "usb"))
 			check_usb_device(device);
 		else
-- 
1.9.1

