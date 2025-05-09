Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D425EF82
	for <ofono@lists.linux.dev>; Fri,  9 May 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820896; cv=none; b=X+dE3mwFB96ravZ36RXjEatY0NHZ6mMi5VJgZ/JI03FZ+vdiOPWnsRSYugqSamuGw+/pOgGhFnJPTkNlA8SsTVgKiJlzfjIQG9zjc2qY6674bOEqsrlGLgwG4fLzLjHMVvSSMCkZMdIzPgk5HucMDBQcxd7Hkf7erG0pZ4BsnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820896; c=relaxed/simple;
	bh=FOF7YXQWi7bZk4UMTTI6p7A7y7b5oVCoUz65uUEsGLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXXS/A13NSZRxNNPAgI/Xq+xPT/bq7HST3CF4AQ3DP5UKOF5znfAQIZnRdxSaHhy/DrlgWLl25wz5LJ3Z/joBJSBkRMnPpdI1IORzNmdjB2Au+gWU6YTcT7utbTnVSvM1DmS8AkeuImoVO6nQQaA5SNF3EN8CQpHfVgY+n6EmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNWd0hc1; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNWd0hc1"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f9832f798aso2099469b6e.2
        for <ofono@lists.linux.dev>; Fri, 09 May 2025 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820894; x=1747425694; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CK7WAgU6MAGz9Hf5W4YiZl7NzsTfueXL1oe9rJ/qDqM=;
        b=LNWd0hc1oYkBf73W0BnGG4xcYdpzfYsr4IW6wS0XPjlFwNGQzScR9Whb0HVkuXsy9m
         t7ctFaUlY0EUh+x8zIu/xaoNMC22v29CWx+hJtw3FO9iCT5VQ61GKTXMPCRaLzfm8LIw
         cdnmFbUhMk49IMIw/ROz/iWSwK9sBTomnSR3yMSzxjLqeDrJtcaXT9PYt/9Wj3izhVPX
         iiww6Esy88Ue3pygMjFhR8xm/fCCaoqLI71XodD1hULSjhiUT3/IGSJnqjRtjxbZ5BUW
         /5d4nJMjfaKHY/nFp4APFe2mF4rnnKD0O7CujPUBclkiL5gyZB33b+/3//1RbZARLjPR
         Uk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820894; x=1747425694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK7WAgU6MAGz9Hf5W4YiZl7NzsTfueXL1oe9rJ/qDqM=;
        b=bglh75OtXhhjevZvwOF6TrM8FBD5MET8+rRqkmp/crN9/tfmSTN5ZwFPWV5O7yEdlw
         LM6uGry7P/OFArfeBvMH7/1Iu1TH+iFrO/19gjsvKdTbbkfyvDVpgL0ZDkCd5Btc1lbF
         dxTYarxDKniGMGEjiAUmt5QxncrDr9bpXzrKCJp8BZGST6iWc7gQ4SjfFIrVTGaTjW/P
         LtXO3K6Qvu6ACCeHQUvj9jkb9rPMucNO385gDoCA1dJq0bTKd79fkp15/FL7LKXkZBE+
         VLj/+NxiHH1U25hwOkO62ahCSGVJUkvt899CXQvweL0fJbzHIGSAfR5jrOxO0TcPLAWG
         Ol9A==
X-Gm-Message-State: AOJu0YxdTHcLYTgmpCnsoU31/7IQTbfucaAi4Wjb09Eyyujr6mTw/hOr
	BFRaH2vulzedGg7QkyL/IsNE6LhuR08Y+rQvO60QqUa4v578ZFEWhbktSA==
X-Gm-Gg: ASbGncsiaLqW2cuS26UfUDDvL1XAikihpnr3qa6Ezx1nYMuotJQKIQR6pUBXsGY2sJn
	+Nvq1l8PCm4mn3RaqG2huDI2poqIPzC33JofnQnF/TBBIyXo5aVTsg8NLVAUC5tTanUWwYNHsLv
	e/7tHz6Z5cOHiQK0h7SMY/y/yDk/MScQSmKzP/0aa17G3e/2zLFv7l/7WUCBaJ87txYwYx2ZmW5
	LmMLyD9W1XaHTsmyDE7eNfHbW/8fsTJhxxL8icRq6FDQmy0D7KQQ8Ls2vbhLumDqhPAYiC6mFIW
	Xkj2A3Nm+3Aoe/TRLzv8Q93iUwgHQNS1i76b6xkvvhudC8vE1/RDYOBkZG+0eEoyXINcBD7GrOb
	M6C6Tr83iGnwh6z6YuKB/IccoTQ==
X-Google-Smtp-Source: AGHT+IGKHaFrvM4kpoHv68uGhrnJ3X3T+5wyfXZ5KkRQER4GW+k/236Hay5TEtUk2xiTC/NPCAiOVg==
X-Received: by 2002:a05:6808:1993:b0:402:12e9:a2a4 with SMTP id 5614622812f47-4037fe51dcfmr3798418b6e.22.1746820893888;
        Fri, 09 May 2025 13:01:33 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b2e5asm667326a34.19.2025.05.09.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:01:33 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/5] udevng: Record devnode even for non-USB devices
Date: Fri,  9 May 2025 15:01:08 -0500
Message-ID: <20250509200131.42020-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful for WWAN AT/MBIM/QCDM ports that are being created by PCI
based devices.
---
 plugins/udevng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index b8df66de5c71..38de3df0f3c3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1972,8 +1972,9 @@ static void add_device(const char *modem_syspath, const char *modem_devname,
 		g_hash_table_replace(modem_list, modem->syspath, modem);
 	}
 
+	devnode = udev_device_get_devnode(device);
+
 	if (modem->type == MODEM_TYPE_USB) {
-		devnode = udev_device_get_devnode(device);
 		usb_interface = udev_device_get_parent_with_subsystem_devtype(
 							device, "usb",
 							"usb_interface");
@@ -1990,7 +1991,6 @@ static void add_device(const char *modem_syspath, const char *modem_devname,
 			label = udev_device_get_property_value(usb_interface,
 							"OFONO_LABEL");
 	} else {
-		devnode = NULL;
 		interface = udev_device_get_property_value(device,
 							"INTERFACE");
 		number = NULL;
-- 
2.48.1

