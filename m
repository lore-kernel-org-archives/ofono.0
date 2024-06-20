Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C71AE0B4
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895118; cv=none; b=SrYNfQDhYGXpNZSKBdVdSpV+1/D6du4YFDVNdIsuqdE9nRZA5huuuMDnFWBzCNNVYo7lio7Fchnhtl4kbVDti/hDO65AWaAxnAer7pv59Oab/j6bCMU9tZRWtw4vBTXhMLCxWFz7QeO6IV/pfE+RJzeqmwSLUy+9OxLFZ9HQOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895118; c=relaxed/simple;
	bh=aOiIF2qWhosuhySXMbzaARIfXrdtQwwPTF1EeT6t4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWoLjXCGXzy5sJnOHQResEXDU7ZbBRNgugrShOu5iXMPE6iGEi2hmJTKOsezwvRTm+BtGWpxJaz9AD7D0VUj8PlnP6dubjgydTDChphHWyj7NEgKRXV/uOhq0LIGOoPNOl485wr6fxtAYKADrRHkwhTEZAfRHimT1Bbsk+IfmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZSnXkA5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZSnXkA5"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d518cdb252so453200b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895116; x=1719499916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFznyV02qpqrwykiXcHYRRv4uVXbs4n0PtmvjIgp3qE=;
        b=QZSnXkA5hm+/Ph+eVb2xUGbpkWjshZiesJJ9uKOPrZKJCdYD9XjrlgByFT+DiWe0wO
         QJE5VAWCDB1OAMURaA8izIZi1ot1FDn/1Z3b9K1qO4jVXPIkfSSe4YcyzK8Dr2jw1Axd
         2e0s0IQw/So5eqU5N7bNdsch81awSI0voxwzUvCjLdHgAWcaHoUo22OwUQVC09lNh4HW
         sBhX5OMrvqgXSxTC8SxeTe+6KZoR1Xs0b3uh64tP1VEWg3ThCx27R48+pIA/egLGyRjj
         tC2ANHpflMuIjRCGIsPdUo5wFVF8efnu49LFS0hTSWsEdF5HF+1Oq+Q1bNNOE/JxizSF
         1JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895116; x=1719499916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFznyV02qpqrwykiXcHYRRv4uVXbs4n0PtmvjIgp3qE=;
        b=PDkNMPV4qzrIabVYCoDrR0LgiQtB/GC/QQS7zYRNimqxhexQZ8gEE6fLyveq+MJcTA
         MtPSLZKNpa88kOnfDnr/ztaE6Npkohcx7ziGJO949wGNg89I0JEEGLsPoyx2DvRrJIyY
         fbNlI5IoTJ8Bzy+O6CdTzxlbzx0qjrm4oz9/8bsx8AHmneFNwaeQdPDuURzBrNY6iTwa
         JcJE6NGJvWe+Bm7mpHUZ9bw6BIOvVXWBD1ZPeDW4ms+vLwxb6BGSyoWDpyKeKV5Qqtnr
         yUrlS5g1R+CtwfXITV0CjAQlKt2SG+yY3oVY6KVOoTUz+kdI5A6Ud4m8kJBYc+QkLlwo
         rZ9A==
X-Gm-Message-State: AOJu0YxuD3GYJizWI2LlzutZx8oSktYDghC6+mbR0kJc3h+90xEeS+HJ
	0u7ZedknUpuxYfZ4tRZXJXMelcPhUz1+yFhxJxaPABf0QfJdcOWFufMIjg==
X-Google-Smtp-Source: AGHT+IEzxR15d5S2BJSogpkqOMhWJTpYemq9hwNRHJ9vbs9gvVngkLkzJdOKEbQJGxjwet3OxP1ZBQ==
X-Received: by 2002:a05:6808:2dcd:b0:3d2:1f88:3e86 with SMTP id 5614622812f47-3d51bac6050mr6967776b6e.37.1718895114489;
        Thu, 20 Jun 2024 07:51:54 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:54 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 08/33] gobi: Remove qrtr support
Date: Thu, 20 Jun 2024 09:50:55 -0500
Message-ID: <20240620145139.1135899-8-denkenz@gmail.com>
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

QRTR based devices will now be managed by the qrtrqmi driver.
---
 plugins/gobi.c | 38 ++++----------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index d8fd90153054..d1da5fbc366b 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -55,11 +55,6 @@
 #define GOBI_VOICE	(1 << 6)
 #define GOBI_WDA	(1 << 7)
 
-enum qmi_protocol {
-	QMI_PROTOCOL_QMUX,
-	QMI_PROTOCOL_QRTR,
-};
-
 struct service_request {
 	struct qmi_service **member;
 	uint32_t service_type;
@@ -87,7 +82,6 @@ struct gobi_data {
 	char main_net_name[IFNAMSIZ];
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
-	enum qmi_protocol protocol;
 };
 
 static void gobi_debug(const char *str, void *user_data)
@@ -101,10 +95,6 @@ static void gobi_debug(const char *str, void *user_data)
  * Probe the modem.  The following modem properties are expected to be set
  * in order to initialize the driver properly:
  *
- * DeviceProtocol
- *   Can be "qrtr" or "qmux", tells the driver which QMI encapsulation protocol
- *   is being used.
- *
  * NetworkInterface
  *   The string that contains the 'main' network device.  This can be
  *   "rmnet_ipa" on SoC systems, or "wwan0" for upstream linux systems.
@@ -122,8 +112,6 @@ static void gobi_debug(const char *str, void *user_data)
 static int gobi_probe(struct ofono_modem *modem)
 {
 	struct gobi_data *data;
-	const char *value;
-	enum qmi_protocol protocol;
 	const char *if_driver;
 	const char *ifname;
 	int ifindex;
@@ -131,15 +119,6 @@ static int gobi_probe(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	value = ofono_modem_get_string(modem, "DeviceProtocol");
-
-	if (l_streq0(value, "qrtr"))
-		protocol = QMI_PROTOCOL_QRTR;
-	else if (l_streq0(value, "qmux"))
-		protocol = QMI_PROTOCOL_QMUX;
-	else
-		return -EPROTO;
-
 	if_driver = ofono_modem_get_string(modem,
 						"NetworkInterfaceKernelDriver");
 	ifname = ofono_modem_get_string(modem, "NetworkInterface");
@@ -152,7 +131,6 @@ static int gobi_probe(struct ofono_modem *modem)
 		return -EPROTO;
 
 	data = l_new(struct gobi_data, 1);
-	data->protocol = protocol;
 
 	if (!strcmp(if_driver, "qmi_wwan_q"))
 		data->using_qmi_wwan_q = true;
@@ -519,19 +497,11 @@ static int gobi_enable(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	switch (data->protocol) {
-	case QMI_PROTOCOL_QRTR:
-		data->device = qmi_device_new_qrtr();
-		break;
-	case QMI_PROTOCOL_QMUX:
-		device = ofono_modem_get_string(modem, "Device");
-		if (!device)
-			return -EINVAL;
-
-		data->device = qmi_device_new_qmux(device);
-		break;
-	}
+	device = ofono_modem_get_string(modem, "Device");
+	if (!device)
+		return -EINVAL;
 
+	data->device = qmi_device_new_qmux(device);
 	if (!data->device)
 		return -EIO;
 
-- 
2.45.0

