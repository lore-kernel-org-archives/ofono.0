Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABB1C2A8
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740961; cv=none; b=XRFsFJDbtrH21LUG9+C/N+fJUzXikWw2NJuXZTb8LPzc8nXW/ZAzsjH/5LA19c1JpLX6Jfc+3GdtBgav1JUvhRP5/MC5n/6RDq5dglxsCw0YSnVfpqy07PLjZiH0DSiom7ys3Jfjt5IJ7RfkFopsWdm5Ky7mN0e9JOB07le6Xzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740961; c=relaxed/simple;
	bh=aOiIF2qWhosuhySXMbzaARIfXrdtQwwPTF1EeT6t4JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcxBJf6C+QeJqiCwBrh5NWk57v4zhrwiaWhDv+gLhgZeZ9Ka139ElLjXzj3NqfSRG5878KwKpG9OOYkL2GK1Br14bgbhuqLB7KX8/7rmg1iuE1r9cVcaRJSzorEqkEcuZXkgmisMR6q88wizp4RmKHe7jqtnE/HnsxSHzqSqzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3tDJMsJ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3tDJMsJ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25c9af0102cso9980fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740959; x=1719345759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFznyV02qpqrwykiXcHYRRv4uVXbs4n0PtmvjIgp3qE=;
        b=Y3tDJMsJYpLpUBoFydSmyjDphNU3xcbl7z9md1HIl9DPiuPO4O+KLT1Tur7pAS+qYL
         wO4piPZ40kpdi9G44b7ElRUcUltY5Zke1X+pdPShGovNDy+Box3mTxcyu0JeclLc2+Rb
         AEaxw64bJmmBr2qM1cR9l8amNBdbIfTNStmr6PsGmsPJNF5kxWWwRkC5UauCEysgeCzY
         TrhY34iIZStEl0QAnq7lEW5BwmNbfd1s8jySFceFGWWqh5Mlsiwtll0LVzKOuD5zFC4t
         8F23GGQKBXvQjraV4PuatcdggwsJUhDgfR+dG4S9UkHTK/jFptv0XGcCvPFZ6PTba2Xs
         asbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740959; x=1719345759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFznyV02qpqrwykiXcHYRRv4uVXbs4n0PtmvjIgp3qE=;
        b=xKPJqng4agN+CMIp9HwgVVpphHxhuTKdpS0en6ZFsK+62kRGyDpi6lFS4AJ/EWd33l
         8J7epg30H7JIGjE0SsgezyzZE70GRWU6dB9wxmkekzvrFM79GDzSyz5WxxgbLNNYEJS0
         NUHSwKu/fnvjMKWx1YsjOLRLOX8Ml6tDf9MKN3FjMpOLZklfYNBHr19GYL6r/cr8rqPH
         oQV6o5HM7GXqMVbz+gzTJaTqCsGlmimixCEJh0I7BamAu0o5D1YCba0EDhnENHjco8S5
         iAgHaxNZPAF6NIDqf4saZT+EzNjkqeR7tPSyMNntb8BTP1cWa+TrL3tICUbOzmY8q2qz
         DyAA==
X-Gm-Message-State: AOJu0YwfOwEAy8R8ivimljpARW3S0z5SwObX+ujbhr6gJqXU3QxZbFlK
	rCilnCuBhQcUNpCn2O/8EcOajcOw8z3GYy7OdG94PruIn1R4weNdObjMVw==
X-Google-Smtp-Source: AGHT+IEaN0ehWBuN2SOhMbojdbxs3BLrMXJI27dnLabtt6kgSpJZcVssxHaYf8mqScO+6m1Rtof/yQ==
X-Received: by 2002:a05:6870:1705:b0:254:9c46:8877 with SMTP id 586e51a60fabf-25c9499a393mr828942fac.16.1718740958863;
        Tue, 18 Jun 2024 13:02:38 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:38 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/33] gobi: Remove qrtr support
Date: Tue, 18 Jun 2024 15:01:50 -0500
Message-ID: <20240618200231.1129282-8-denkenz@gmail.com>
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

