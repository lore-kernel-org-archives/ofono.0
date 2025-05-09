Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB225E813
	for <ofono@lists.linux.dev>; Fri,  9 May 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820898; cv=none; b=uqjBc4brZt6+UuZW/IUf0bICdDjquDlrusCsGABFAfFLYXYwCvqbcfCOLc/JTJw1f+WFdckPPpOfiXXtXlfoxefsx0aFSTyqz5n4SSP2QVW5EK/+ScyCSyRvqCmSw45hb5qecflPXUNw5ua6ryXukKeOIi6BuVN0rPpx/zEqIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820898; c=relaxed/simple;
	bh=BzPTrlS0TUUHwPn8UxjUwnXBJ66eonUpYY1lw4FKDCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEaFPW5SmokHRq7q7TAFUyV3sbhxlFZJT//ISupScmkdZkl6IolayFESZlYzl+A1qeqzmTRqrFDWRz7aSi5eEm58TAXFzns80wLLRjTXUmOgnjT103Gv5MrQBHjOKXnoN2XVtWbyq4Ax3+8AIKwQ3np0jycWooV5rVES6F2YIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO8Aqd9t; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO8Aqd9t"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72bc3987a05so1581637a34.1
        for <ofono@lists.linux.dev>; Fri, 09 May 2025 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820896; x=1747425696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHCGlEtgu00aMcx/bowlPU8rknqAQ3TJmYOCMMJO8vk=;
        b=cO8Aqd9tWmD/ZPzj7UNQyjOdKO9KWnY4P/EI75wUPnEfW4o3gkYpQYTPJGEPtfqom2
         pM8UFgd/jeQmaxFzM+ZLvT+Cg9QM9BLkf5c76Bx6PqhhWz4nZfUSEDDFnuZIPGcO4bhu
         0RT+HUJ1HeiQFCiUivGtzir6UpYq7O4uqRio13VQ/OHupgD6o9VnwRuXz6NmpXpZ/+Rm
         17BE6/Dj0RtkqHmY7kQAPtqQl2wYgDLQ4Ng5Z++XPL1KkQ4JpKLJfAuI/M2tntIE9+DD
         zhv+rEZfBZaFSqBGAmWB84GhxyKAMQijDJLiJzenJgDiGBOL0iuSeubW3ohf+8IbbJWV
         xggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820896; x=1747425696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHCGlEtgu00aMcx/bowlPU8rknqAQ3TJmYOCMMJO8vk=;
        b=JKdSknqWf0Kh1Z5tYcbZnUKth2NiQAR5EtzytnP+ia3vJLtzvhBbppVjRNt9yaPr8j
         rpVK/6DI3rRs8r76tZGvMp6uA1BUrfUOB/4gXLusd7OculnH6RrlyTeGZTBSZuJ7+Dfp
         ykM4SK21PtqdESWnOJXnBFfozo0ZYRzRw3pqib9yj+C5U3akUQaRstlIHl8xyjI8zwW/
         FWwKy/MKA12JJNFPkVRWcBnloMtY63aSkZrhONisTFiEABY9bWpO3Vvo2+ENO8EgSy0s
         kyRGCJDXsfhvCODs1RTKRUKQYPSxGkeYr0Hc1KzA6OK6w6pH/5gC0ZIGAV3dyZuuWSzy
         X9Fw==
X-Gm-Message-State: AOJu0YzGwErV2u2EdwRMbivDfWGfWVnv4NU5qLSgWKf6Wjy2HYjsJoN5
	opoX1dhMTPSSaonk3kIQRba2MNLfyZ0cr65D0+d8mrdeKVyHdLZ5SISsNg==
X-Gm-Gg: ASbGncs/IlWz6o0BzfKszolu4OUYEYg+YJR7gxsEZhYRkVE68XOZpu/vZ3DvRSF+bi7
	CEiUwB8m5jjzq9uQ2OWuT0NqDEt3ZdpBI3XZlP48J49Eoexw41oxH+IPhUy1Quwqq777BuQLiMS
	CmwnxJCu39ZCt0WHhbFUzhrEQyV6OUds1OJJQUyqFwzIY0RL7hpaXj7MetEa8s2fiJvULeMgLQx
	mBWKFg5Bx07YkyBgaCereSPZxQjcvlfce7NDK1ohkdrNW9TcS1teWdh8JpqJcPxg0g7ckvYDZKu
	0usSYHLzG3NX7UxRUWcuJ8KUOpt3TgsTRKG75vlE3LIzeYckqOvvxLvUOAJmSGmMwg+q9EvMgqE
	Ksmuw97uv4/ZAj7yN4RTRJtyfsrWA3Pb7d5r0
X-Google-Smtp-Source: AGHT+IHLoWoJTBlc/kiLfGyuEtByNP2j2aW2QKl2sgOXOVLVZvMdfq3mj5sfvP6QqtQKCG+Gv1+tmg==
X-Received: by 2002:a05:6830:391c:b0:72b:8593:d3eb with SMTP id 46e09a7af769-73256d091b0mr2762033a34.2.1746820895624;
        Fri, 09 May 2025 13:01:35 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264b2e5asm667326a34.19.2025.05.09.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:01:35 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/5] udevng: mhi: Detect MBIM mode devices
Date: Fri,  9 May 2025 15:01:10 -0500
Message-ID: <20250509200131.42020-3-denkenz@gmail.com>
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

MHI devices can operate in QRTR or MBIM mode.  MBIM mode devices should
utilize the 'mbim' driver.
---
 plugins/udevng.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 503c262abbff..320cd3a65a2c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1653,6 +1653,7 @@ static gboolean setup_mhi(struct modem_info *modem)
 {
 	const struct device_info *net = NULL;
 	const struct device_info *qrtr = NULL;
+	const struct device_info *mbim = NULL;
 	GSList *list;
 	int r;
 
@@ -1660,29 +1661,53 @@ static gboolean setup_mhi(struct modem_info *modem)
 
 	for (list = modem->devices; list; list = list->next) {
 		const struct device_info *info = list->data;
-		const char *subsystem =
-				udev_device_get_subsystem(info->udev_device);
+		struct udev_device *udev_device = info->udev_device;
+		const char *subsystem = udev_device_get_subsystem(udev_device);
+		const char *devtype = udev_device_get_devtype(udev_device);
 
-		DBG("%s", udev_device_get_syspath(info->udev_device));
+		DBG("%s %s %s", udev_device_get_syspath(udev_device),
+				subsystem, devtype);
 
-		if (l_streq0(udev_device_get_property_value(info->udev_device,
+		if (l_streq0(udev_device_get_property_value(udev_device,
 								"MODALIAS"),
 					"mhi:IPCR"))
 			qrtr = info;
 		else if (l_streq0(subsystem, "net"))
 			net = info;
+		else if (l_streq0(subsystem, "wwan") &&
+				l_streq0(devtype, "wwan_port")) {
+			const char *type =
+				udev_device_get_sysattr_value(udev_device,
+									"type");
+
+			if (l_streq0(type, "MBIM"))
+				mbim = info;
+		}
 	}
 
-	DBG("net: %p, qrtr: %p", net, qrtr);
-
-	if (!net || !qrtr)
+	DBG("net: %p", net);
+	if (!net)
 		return FALSE;
 
-	r = setup_qmi_qrtr(modem, net);
-	if (r < 0)
-		return FALSE;
+	/* Prefer to drive MHI devices in QRTR mode if available */
+	if (qrtr) {
+		r = setup_qmi_qrtr(modem, net);
+		if (r < 0)
+			return FALSE;
 
-	return TRUE;
+		return TRUE;
+	}
+
+	/* Otherwise, try MBIM mode */
+	if (mbim) {
+		ofono_modem_set_string(modem->modem, "Device", mbim->devnode);
+		ofono_modem_set_string(modem->modem,
+					"NetworkInterface", get_ifname(net));
+		ofono_modem_set_driver(modem->modem, "mbim");
+		return TRUE;
+	}
+
+	return FALSE;
 }
 
 static struct {
-- 
2.48.1

