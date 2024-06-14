Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5351A01C8
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391190; cv=none; b=hJroA2exkjRhdN2wW+7dB+uKUP/SJAexGiYLjPeC4F49mH+bi/hHvIWflMwsObpX0pvj3tuefXC/EMohIjkdyaas5JBRdCxMhMH6b6j7mO80kI2NKWHvh3BxU5o0ZLDsWos8Em7b9OrK34UHsHroZxn5JYlvS+YpzGwLnkf5U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391190; c=relaxed/simple;
	bh=unJKtq2Z5x6N/Jk8IKUvMvgj4e7dYZCWPtDChk+1UUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+SkkHLS1HD+7ZuWmdPOHW/0uBjBMG0snQi55CLE+3ATp4kxHODcxjfk/DrYOg+2D6FUZym6qcMcrQxruh7XPQklQwA4bxjWo6BqpOv40j3GpxEcueWAm11qd/llPi1TI8/Mar4vLNTzhooGv4npST4cfn4eLZQMwTTrSFOZfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxHMs8WR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxHMs8WR"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24c9f628e71so1197738fac.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391188; x=1718995988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuZHh0M1cxFsKwrdJ9/jNYZOjq41OL8YScOg/IM1mOs=;
        b=IxHMs8WRZWEnY977EKwq/0n/CybmqKU2rKKf1AnXHdWJDybjNl93q5sJEWRFSqK3lB
         X6cAYUAbi0FuBDk4J83WThV8tWfErpM9Cxg2HR8VZS6dTqVJp+7EI1XDufjJpDXSNRN6
         RVlrhifSMcrN+lhgftDDXqY2S1+bkdhs8VsfMK0pQzgPbeQRlWD+WzjtSDRWBBKNvrho
         ULM3CtVowRdsoy6ZZ4gqDBylW7zh2k4IwX/M/EVqbiLy4T97CJmCPXieh8fAKgI0r68i
         qdMpK3nnUZ7ccl7d2/2+nD9qaKY15zZteqpwoL2tV97QsfGFROxXDQtxfZdo3hE6v+Qb
         o8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391188; x=1718995988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuZHh0M1cxFsKwrdJ9/jNYZOjq41OL8YScOg/IM1mOs=;
        b=i8wVVm/Bj2S/dvgpi7aKQB4HHKzaOdAZUrfp3eCq4Qcqt7FwOeW6Zl8d0RJ4y6zZMj
         nRv8J7TK6f/uxEhzbJQEv+yqavA6AnniNC9MtXMf3sGomLt6yZDkY3zWIBXei58BYDmT
         1teH2gEOeiS7EN1L02AH9HEbu8Y+8zd8Be57xrw1cTVhhikdhnEPElLlf/pGAYL55GvN
         mz85IzPRT0aHXxDWTIHcv8ZHVskjou/r39bAtgTEKjSqk7ZPQpD1tb7wN9knAdRJDRPB
         /S3vncifbawNxqt8KNaQaBYvuZYgC+45B2NqxQq1AA0BatwbkqSq58m4daWPDT/A9rsr
         k8FA==
X-Gm-Message-State: AOJu0YxO6x2+43HLOV4ch1bwLuoZam0ppw55THHTxSzliU7Fe1gSFLOL
	ZQKwJX3CYTbAc3MFFlVpX6WHpttE87JAS3OGVTO0lDdvTWM782ktYrMx4g==
X-Google-Smtp-Source: AGHT+IGCcVjOUoaq52ykqUR5tw5RdMq8ujWIt6cH7ncgsABPhapA49R0F+odcNdjvLvrX2RUpeD7sA==
X-Received: by 2002:a05:6870:1c6:b0:24c:a547:7b5a with SMTP id 586e51a60fabf-258428b6ce7mr4265337fac.14.1718391188449;
        Fri, 14 Jun 2024 11:53:08 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/27] gobi: Remove qrtr support
Date: Fri, 14 Jun 2024 13:52:19 -0500
Message-ID: <20240614185300.1086701-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
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
index 5402bedcc22e..f1a7df447a89 100644
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

