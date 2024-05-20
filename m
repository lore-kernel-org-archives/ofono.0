Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F901E50B
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232648; cv=none; b=llxjyN8878A3sjYnUt5NO00B4haLE0wf8fFoV7N1qBkp3pL/igCxD7WgxCLA8y8RjzYddR6GoG/BFmSI1h+IlwEQIN6RxYbdAOPcFQkidM8FslkjT/gYYdiQDZSdzAMILGFOjkRBE+p3DxFpurF86TSDznRhMkrZnk8qAb5/u2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232648; c=relaxed/simple;
	bh=Ni6GPyNMc4m96IJar6T6tiDgXMyaq9IfZM4JRv2nAhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq2fVGLFHPcwAwuy1SdUbWz6xfuTC8R3paGlVMdB7JUJfGok5K/5WeAK7j7qLqCjWWy3h+tZfFsokxNTOyVq9LM5oN8/QWaufbeDqePcnmX+rMgmC7PHfALgqtTF6IL+Gb4Rj3mFUW1s7mE7DKmNDwhbtwZuDsc/hm3S2GIrLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/5befwU; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/5befwU"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so3429911eaf.1
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232646; x=1716837446; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiSbTm8aXaamR9RlNUw666aijxdt1fEiRyX+ox5bVt0=;
        b=Y/5befwU6KsiSiPKQhe6DXTmHKwTtaL5tQhlaKYo6kp3Mqh++7NvIdkP453NA6oQde
         VhNLksZCT0bUvMp2aqazmlBJAb1ATOwBXRM1+jGmA5NGdpRM0Ma+mlN3OsdqbUT77q7V
         L4d3dRoqd/VWLMFZurvITdomPS545LJ4zjcUkRC2a3VWTf+j54qGouf3j8ElS04t7E0/
         r2dMcNCWEVzo107nfeLZqe9sIKKKNjQjd61ctDbI5692YAqFwccy5g0aZgs7v/ByJx54
         IJX17AF9tKDb59PL67al8nhn2MjBjTsx39RxwxIW8hcl3j8wRwHWVaZLdjsvkoYKQXvh
         8Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232646; x=1716837446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiSbTm8aXaamR9RlNUw666aijxdt1fEiRyX+ox5bVt0=;
        b=Qu+7WbmgB/0re8ziPsiR0LyAxtbuthA9vxdDlEbcQqx2t5K/KFtFRyoZZFB/T/LhOl
         EcGEwyBiDfP3pjgrTNGmm1A41EIGz98AfcsrtJYmF3eUEzd+9p3If//pQCdo37+PCcIZ
         0QEfcfSvQ+6+LesJtp9UC0YopNDp09GveyIahLZ1LKupmFNDrjtaId8I8fZS8Ck/C9QO
         qgZVZCfXme5ZC1U4hD7e1MJwg1fl8Vnuv16r2KBMtRnxszWVlzv0ApMZynCMFAyZMY72
         cVgUJM1ow6JZohXZJIGtEeD5H3ecTCcwT4qja0XaO4W0VT4oTYFj+cjtE7JUhhslsuHx
         7nZg==
X-Gm-Message-State: AOJu0Ywjt1Dp2ngxTyF/vqsQF3FKmMD5sDam5paD54DHmC/XcNhJt7Nf
	XpXerVX1r8aAXiidcPjPS8bgoab0Yrrer8VkZ7JiuTRmWIsqSd/2Wy0IJg==
X-Google-Smtp-Source: AGHT+IGZeJuF9mwS57t9mVOXvvDjY8lGtN83L2XjzHKfX3RwhN8kNnK0ajnbHQy8hBSNNpD7mFTUuA==
X-Received: by 2002:a4a:8553:0:b0:5b2:f1cb:1a3f with SMTP id 006d021491bc7-5b2f1cb1b21mr16274564eaf.7.1716232646099;
        Mon, 20 May 2024 12:17:26 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:25 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] gobi: ensure required properties are provided
Date: Mon, 20 May 2024 14:17:04 -0500
Message-ID: <20240520191722.184977-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520191722.184977-1-denkenz@gmail.com>
References: <20240520191722.184977-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that a minimum set of properties required to drive the modem are
provided by the detection framework.  Also, while here, document these
properties.
---
 plugins/gobi.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 5bb0b5ace0ca..bb4560c43a06 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -100,12 +100,37 @@ static void gobi_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 
+/*
+ * Probe the modem.  The following modem properties are expected to be set
+ * in order to initialize the driver properly:
+ *
+ * DeviceProtocol
+ *   Can be "qrtr" or "qmux", tells the driver which QMI encapsulation protocol
+ *   is being used.
+ *
+ * NetworkInterface
+ *   The string that contains the 'main' network device.  This can be
+ *   "rmnet_ipa" on SoC systems, or "wwan0" for upstream linux systems.
+ *
+ * NetworkInterfaceIndex
+ *   The index of the main interface given by NetworkInterface
+ *
+ * NetworkInterfaceDriver
+ *   The kernel driver that is being used by the main network device.  Certain
+ *   drivers such as 'qmi_wwan' or 'qmi_wwan_q' are treated specifically.
+ *
+ * Bus
+ *   The bus of the modem.  Values can be "usb", "embedded", or "pci"
+ */
 static int gobi_probe(struct ofono_modem *modem)
 {
 	struct gobi_data *data;
 	const char *value;
 	enum qmi_protocol protocol;
 	const char *if_driver;
+	const char *ifname;
+	int ifindex;
+	const char *bus;
 
 	DBG("%p", modem);
 
@@ -120,7 +145,14 @@ static int gobi_probe(struct ofono_modem *modem)
 
 	if_driver = ofono_modem_get_string(modem,
 						"NetworkInterfaceKernelDriver");
-	DBG("netdev driver: %s", if_driver);
+	ifname = ofono_modem_get_string(modem, "NetworkInterface");
+	ifindex = ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
+	bus = ofono_modem_get_string(modem, "Bus");
+
+	DBG("net: %s[%s](%d) %s", ifname, if_driver, ifindex, bus);
+
+	if (!if_driver || !ifname || !ifindex || !bus)
+		return -EPROTO;
 
 	data = l_new(struct gobi_data, 1);
 	data->protocol = protocol;
@@ -133,8 +165,6 @@ static int gobi_probe(struct ofono_modem *modem)
 	l_strlcpy(data->main_net_name,
 			ofono_modem_get_string(modem, "NetworkInterface"),
 			sizeof(data->main_net_name));
-	DBG("net: %s (%d)", data->main_net_name, data->main_net_ifindex);
-
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
 
-- 
2.45.0

