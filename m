Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BE1E86E
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232647; cv=none; b=Douz+Mos3LHoQtcvJC7KPaF4cugIe4X5NFIyUes4wtSudfeqx5UFniGCsUQwuzlhU4KMVjmHRPfw4biWWcHfcQq6VcpzxuQulCgANmYZ6z7LwvgH0UnPY1slrBKToEMhy5KMLUVlZkdAXbq4jNGr+lHoAupfmTfBpYPAncVs7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232647; c=relaxed/simple;
	bh=jSWy8CwGRiYv0cq3IziHCITid6IFbar7bE5oZO2b2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlMUoSTbUVVmcU6O0G0e/YdhyAwpu9CsWUj99L3D19+aKvSsppxy/eyk2B7fkn1WUG+Gc7PMKXekBAOYP7KYx8wftIo67NQoTvcLCQFciU4qdKzFywB/7fxnf++FnYhJrO04JYThydsOHuP3E0v3/g3RhHuFDOZ/UY25UlN0N3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsP2+jyu; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsP2+jyu"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b273b9f1deso1935437eaf.3
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232645; x=1716837445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8DChPbPrdhNPVlh3RSEx/qrZqFQLllrdztRLTZg6U8=;
        b=bsP2+jyu71Sz/h9+f00wPjOpYadXmBpZhPv1m5uavzIcqEwKqjzTnhL9pVviRFzgoX
         h5rh0SyqT/rRaCFxZ8ekqaTuPRAbMHNQZo+MKl+G9MxREoI4h71NWFN8wtLoCUcwdDtd
         z6wPoWYPqJrfvAeplaQYp8dcn7u1lSdg19BGeEYFRfCzunSCv48401WgAy8S+EdieAY3
         nPxtCGR9o1mUxouZy46jubBdvolRca6XblU7EDjo98HrW6q1/rT8XpbqX1vJBYuJkfG0
         GWL8QffxCcTShiJN8Sdo48NTyZ1HUACRCp4PycmvVW8RGu86DtI/QQRBNljynpf8DObu
         l7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232645; x=1716837445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8DChPbPrdhNPVlh3RSEx/qrZqFQLllrdztRLTZg6U8=;
        b=DBcO6ocV+gUKNOPIZMdRfmkuX9sc5XnUuL9sUHyAnO1U/RdQ28nwS8OCkFD2tVQY07
         A3o9Tr5L4KKVrXiiFYWT2Pe+o7GrY5WOkdLaIdiVe20Xs4gPoIRYCQEzgVDtNBNTdgxn
         xilH1tz1lR4Ji9s5xugi2xcn5nmJYHC3SNsttEMgtr13SrvAK572RHwraDCHf3Qhvjr9
         1k42tMQIakJ7Onzd9CUzEEkuMW98VZjZ7vj5zhu5+09tyJfW6Z/H4z9/30vtM/q2r7M9
         1vgPImOuk0JPhmLVQxlDmHgboL0ggDk/jpBzGoffNuBkw7WVBUOnt3nwDwTH4aVey1bt
         8fig==
X-Gm-Message-State: AOJu0YxVLKDqT8pqu9+ZEvqBmDIvnX2jc6zAa2pS5/nVPt2IEA7qg4XV
	hs0vSMY5PP00rYqu0TRDZ/8TA/Iy3+4HmKvQ6SSMaTFhq2HprJoWSQNSow==
X-Google-Smtp-Source: AGHT+IGGhcXSSmXbsG2CvBKrqrLWXiY52AQcz9zQ6KSXz2vfpQh1+4fX1c3GLk2fKhi7VztxNUM1sA==
X-Received: by 2002:a05:6820:620:b0:5b5:3d56:5172 with SMTP id 006d021491bc7-5b53d566381mr1301154eaf.1.1716232644566;
        Mon, 20 May 2024 12:17:24 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:24 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/6] gobi: add / use DeviceProtocol property
Date: Mon, 20 May 2024 14:17:02 -0500
Message-ID: <20240520191722.184977-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using the kernel driver as a hint for whether qrtr or qmi is
being used, introduce an explicit DeviceProtocol property that should be
set by the detection logic to tell the driver whether to use qrtr or
qmux.

Split up QMI modem driver detection and setup logic inside udevng into
setup_qmi_qrtr(), setup_qmi_qmux() and setup_qmi_netdev().
setup_qmi_netdev() takes care of setting up of common networking device
properties, while setup_qmi_qrtr() and setup_qmi_qmux() setup QRTR and
QMUX devices, respectively.

While here, ensure that modem types are handled appropriately.  QRTR is
only available on embedded devices, while QMUX requires USB.
---
 plugins/gobi.c   | 34 ++++++++++++++-------
 plugins/udevng.c | 78 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8bd2c4060446..d8b78ad6f5b0 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -72,6 +72,11 @@
 #define GOBI_VOICE	(1 << 9)
 #define GOBI_WDA	(1 << 10)
 
+enum qmi_protocol {
+	QMI_PROTOCOL_QMUX,
+	QMI_PROTOCOL_QRTR,
+};
+
 struct gobi_data {
 	struct qmi_device *device;
 	struct qmi_service *dms;
@@ -85,6 +90,7 @@ struct gobi_data {
 	char main_net_name[IFNAMSIZ];
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
+	enum qmi_protocol protocol;
 };
 
 static void gobi_debug(const char *str, void *user_data)
@@ -98,11 +104,22 @@ static int gobi_probe(struct ofono_modem *modem)
 {
 	struct gobi_data *data;
 	const char *kernel_driver;
+	const char *value;
+	enum qmi_protocol protocol;
 
 	DBG("%p", modem);
 
-	data = l_new(struct gobi_data, 1);
+	value = ofono_modem_get_string(modem, "DeviceProtocol");
 
+	if (l_streq0(value, "qrtr"))
+		protocol = QMI_PROTOCOL_QRTR;
+	else if (l_streq0(value, "qmux"))
+		protocol = QMI_PROTOCOL_QMUX;
+	else
+		return -EPROTO;
+
+	data = l_new(struct gobi_data, 1);
+	data->protocol = protocol;
 	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
 	DBG("kernel_driver: %s", kernel_driver);
 
@@ -421,25 +438,22 @@ static void discover_cb(void *user_data)
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	const char *kernel_driver;
+	const char *device;
 	int r;
 
 	DBG("%p", modem);
 
-	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
-	if (!kernel_driver)
-		return -EINVAL;
-
-	if (!strcmp(kernel_driver, "qrtr"))
+	switch (data->protocol) {
+	case QMI_PROTOCOL_QRTR:
 		data->device = qmi_device_new_qrtr();
-	else {
-		const char *device;
-
+		break;
+	case QMI_PROTOCOL_QMUX:
 		device = ofono_modem_get_string(modem, "Device");
 		if (!device)
 			return -EINVAL;
 
 		data->device = qmi_device_new_qmux(device);
+		break;
 	}
 
 	if (!data->device)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index fb694858aa6c..aa2a216d4247 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -197,20 +197,14 @@ static gboolean setup_hso(struct modem_info *modem)
 	return TRUE;
 }
 
-static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
-			const struct device_info *net)
+static int setup_qmi_netdev(struct modem_info *modem,
+					const struct device_info *net)
 {
 	const char *attr_value;
 	uint32_t ifindex;
 	int r;
 
-	DBG("qmi: %s net: %s kernel_driver: %s interface_number: %s",
-		qmi->devnode, net->devnode, net->kernel_driver, net->number);
-
-	if (!qmi->kernel_driver)
-		return -EINVAL;
-
-	if (!net->number && modem->type != MODEM_TYPE_EMBEDDED)
+	if (!net->kernel_driver)
 		return -EINVAL;
 
 	attr_value = udev_device_get_sysattr_value(net->udev_device,
@@ -222,30 +216,60 @@ static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
 	if (r < 0)
 		return r;
 
-	ofono_modem_set_driver(modem->modem, "gobi");
-	ofono_modem_set_string(modem->modem, "Device", qmi->devnode);
 	ofono_modem_set_string(modem->modem, "KernelDriver",
 							net->kernel_driver);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net->devnode);
-	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
 	ofono_modem_set_integer(modem->modem, "NetworkInterfaceIndex",
 							ifindex);
 
+	return 0;
+}
+
+static int setup_qmi_qmux(struct modem_info *modem,
+				const struct device_info *qmi,
+				const struct device_info *net)
+{
+	DBG("qmi: %s net: %s kernel_driver: %s interface_number: %s",
+		qmi->devnode, net->devnode, net->kernel_driver, net->number);
+
+	if (modem->type != MODEM_TYPE_USB)
+		return -ENOTSUP;
+
+	if (!net->number)
+		return -EINVAL;
+
+	if (!qmi->kernel_driver)
+		return -EINVAL;
+
+	ofono_modem_set_driver(modem->modem, "gobi");
+	ofono_modem_set_string(modem->modem, "Device", qmi->devnode);
+	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qmux");
+	ofono_modem_set_string(modem->modem, "InterfaceNumber", net->number);
+
+	ofono_modem_set_string(modem->modem, "Bus", "usb");
+
+	return setup_qmi_netdev(modem, net);
+}
+
+static int setup_qmi_qrtr(struct modem_info *modem,
+				const struct device_info *net)
+{
+	DBG("net: %s kernel_driver: %s", net->devnode, net->kernel_driver);
+
 	switch (modem->type) {
-	case MODEM_TYPE_USB:
-		ofono_modem_set_string(modem->modem, "Bus", "usb");
-		break;
-	case MODEM_TYPE_PCIE:
-		ofono_modem_set_string(modem->modem, "Bus", "pcie");
-		break;
 	case MODEM_TYPE_EMBEDDED:
 		ofono_modem_set_string(modem->modem, "Bus", "embedded");
 		break;
+	case MODEM_TYPE_USB:
 	case MODEM_TYPE_SERIAL:
-		break;
+	case MODEM_TYPE_PCIE:
+		return -ENOTSUP;
 	}
 
-	return 0;
+	ofono_modem_set_driver(modem->modem, "gobi");
+	ofono_modem_set_string(modem->modem, "DeviceProtocol", "qrtr");
+
+	return setup_qmi_netdev(modem, net);
 }
 
 static gboolean setup_gobi_qrtr_premux(struct modem_info *modem,
@@ -310,7 +334,7 @@ static gboolean setup_gobi_qrtr(struct modem_info *modem)
 		return FALSE;
 	}
 
-	r = setup_qmi(modem, ipa_info, ipa_info);
+	r = setup_qmi_qrtr(modem, ipa_info);
 	if (r < 0)
 		return FALSE;
 
@@ -367,7 +391,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 	DBG("qmi=%s net=%s mdm=%s gps=%s diag=%s",
 			qmi->devnode, net->devnode, mdm, gps, diag);
 
-	if (setup_qmi(modem, qmi, net) < 0)
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -432,7 +456,7 @@ static gboolean setup_sierra(struct modem_info *modem)
 	}
 
 	if (qmi != NULL && net != NULL) {
-		if (setup_qmi(modem, qmi, net) < 0)
+		if (setup_qmi_qmux(modem, qmi, net) < 0)
 			return FALSE;
 
 		goto done;
@@ -510,7 +534,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 	}
 
 	if (qmi != NULL && net != NULL) {
-		if (setup_qmi(modem, qmi, net) < 0)
+		if (setup_qmi_qmux(modem, qmi, net) < 0)
 			return FALSE;
 
 		goto done;
@@ -847,7 +871,7 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	if (setup_qmi(modem, qmi, net) < 0)
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
 	if (g_strcmp0(modem->model, "1070"))
@@ -1161,7 +1185,7 @@ static gboolean setup_quectelqmi(struct modem_info *modem)
 
 	DBG("gps=%s aux=%s", gps, aux);
 
-	if (setup_qmi(modem, qmi, net) < 0)
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
 	qmap_size = udev_device_get_sysattr_value(net->udev_device,
@@ -1611,7 +1635,7 @@ static gboolean setup_sim7x00(struct modem_info *modem)
 	if (qmi != NULL && net != NULL) {
 		DBG("mdm=%s gps=%s diag=%s", mdm, gps, diag);
 
-		if (setup_qmi(modem, qmi, net) < 0)
+		if (setup_qmi_qmux(modem, qmi, net) < 0)
 			return FALSE;
 
 		ofono_modem_set_string(modem->modem, "Modem", mdm);
-- 
2.45.0

