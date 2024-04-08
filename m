Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723B149C63
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612111; cv=none; b=M39u6ez0ZgvS7r6Rz0VT3Y8Eqz9Jdht1uDfHZAFZ3VtVRtaGfq0Zc8stmtXci3omf6q3qiFYFTO1s+mRWTWSZcOIBsKPoEIMdZVizn0RasU92Y/q/mKYWJkp0AGRkZfpoJLjn/N4MGuaX/Z5TNmRLZyzOAhcLSz6t9+jkEn4ciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612111; c=relaxed/simple;
	bh=Fpgvufi7Eh+UTmKeguPF2wl6pbko0v7qagCWNnO8+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAdhGVyrGaOZi/gxQIo6xKtVrnZBkc1iJliY2Db4mxsXNYg5Ykhz8H9cOq38N7XO7zahEuJ1xx/xmBWH1feGr9XLTX5whVAhdl5UcwLBvttYpqBAdtl6TrSNY6jCL2/zC1pEr1bHQraWLWZWfdok+uOZsEmeUWNLFJ5+plOtIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=sqGQWFLT; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ToHXBdlt; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="sqGQWFLT";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ToHXBdlt"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438DWapa014633
	for <ofono@lists.linux.dev>; Mon, 8 Apr 2024 14:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=BrPFGc9RBYhrCjqh2lkAXMMtyLygCzcW/ncLivd27eg=; b=s
	qGQWFLTyNscuNWOqDNssYrSkcTLcdEtZyV69k1d8RnZEoa1pL3Rz0cl6LCZmGs0z
	wr4jxukCEw+y2aCmYP6M1TV/adsXR/huPr5qQ3mJq5Z3T2EM2MEEvLetbdgpaive
	GJDgxqaVXfjiTk7YYloA01bm+5W3fRoq2kBn43dvxmzYvKfTTMr43pu/g4B3ebqW
	Z3wDHE93T++SJ3SGeiQNJ6h1DkAKYilnI049Jo1Qzfeoq9f4iMMdPdYxgVB3TNTh
	WKoCRrpNy8ItK5BuqIwQczjpydy5OHFlF+0aLIMi1igVVmeYbJAlAEFK1bjcqSNu
	pUW9WI2CwxmpIXDR4zW9g==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xb3y51gnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:35:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5ea080228so100892539f.1
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712612107; x=1713216907; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BrPFGc9RBYhrCjqh2lkAXMMtyLygCzcW/ncLivd27eg=;
        b=ToHXBdlt2mxXgD2ZwPh8/moa05ZMS+7jY60hg8GdbQSyEOq1NfFrnYPFaEikDMV+y7
         tltvd+LBJredfHthsFId3yFxWlv8hpZJwQwObQul4btNmqMEES/l8aMrNE/kzjSf482Y
         TN3zpKX+xGl3wV735CJD1qTuRbEdV7i7c4dJVgoLNdiqULXyJITsAnXIeqeJMvF81VbZ
         lqaqUYjuvAQ6W9S6pwLhILHb/58YFb9AP9NN+ZR1t3F1+7sZRowKhU4oc7O29ZNXZ4AM
         ynqEZn1TTi78Pe6fjqVODwR1sau5xtBAHGVgs5U47y3+W1YpFA1lko3chLHK82Zu6wo7
         wScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612107; x=1713216907;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrPFGc9RBYhrCjqh2lkAXMMtyLygCzcW/ncLivd27eg=;
        b=P8vRXVr+wG4KST7GXBbPKDGaWb40IEq+7R5kHTCXtjeCPNKsooUojZcH3owRvBoU4j
         rMfkThcFQIsnoXZI5u4gOkBPga81/K2k7xOce7imWHd4GuT2o3I0Gkhe7Rx7FOAWEO4f
         SVmLPAfoK5G7r8b7PjRAR1px1V/RsawIxJkztVLAkUyUgliDXq6c5G2JoMmlxbGirDoG
         ASKB10DRwvmQ3UakEGYyQYxJlQn1YB85z4iN848bINf67ZlneHPe2F5GqTYIA7Yl6lpU
         Dd4hKgIi4BlJ3uY0p++iPOuKPyXLMTGMhvxwpwaHL7SPlRiAvacBx2kxSCBAil1/N7+G
         U6oQ==
X-Gm-Message-State: AOJu0YxWyLZdQPJsN+Nv3bNiV8Y0kzEaCe+00qyvoQUV+H5m+gRhdGCZ
	IW8ujCnEHlqzk/kkxCsv4IYFlvZ+FY2UjOCovsWRkEBVAONJRIYWbjvqwsuHyPsE5HrfBDDspds
	6y2bjq5D/LB7AiqoEB99kie44cftVFjrGERp+BBGxitEHfYSi9qvqkBCiD7C1sPK0p0meLd6jpL
	phSYH38c4TlHHWDSoNVoIgcHseL6MRw544PisLchMXWPpIyuA=
X-Received: by 2002:a5e:a808:0:b0:7d6:16ad:4867 with SMTP id c8-20020a5ea808000000b007d616ad4867mr159749ioa.3.1712612106776;
        Mon, 08 Apr 2024 14:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrXR3yiWhpU/B7QBwOcxMB3ZCWoCqfyNdT8AvM/NC8zv8BGEMFtk7dV046PJ03jtGkXGtaw==
X-Received: by 2002:a5e:a808:0:b0:7d6:16ad:4867 with SMTP id c8-20020a5ea808000000b007d616ad4867mr159740ioa.3.1712612106449;
        Mon, 08 Apr 2024 14:35:06 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-583422.corp.robot.car (105.32.128.34.bc.googleusercontent.com. [34.128.32.105])
        by smtp.gmail.com with ESMTPSA id ca17-20020a0566381c1100b0048281ab15a7sm1813440jab.46.2024.04.08.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:35:06 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/2] udevng: Detect embedded qmi QRTR modems
Date: Mon,  8 Apr 2024 16:34:38 -0500
Message-ID: <20240408213453.53910-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: qMobTYG4sQr2vZY-IBdH2Pl5kV-FiC40
X-Proofpoint-ORIG-GUID: qMobTYG4sQr2vZY-IBdH2Pl5kV-FiC40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=861 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080165

Embedded qmi QRTR modems are identified by the existence of
rmnet_ipaX and rmnet_dataX devices. Add a new "embedded" modem type
so that these devices can be collected during enumeration and then
configured for use by the gobi plugin. Modems of this type will be
exposed as /gobiqrtr_X.
---
 plugins/gobi.c   |  19 +++++++--
 plugins/udevng.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7a07b080d895..431df17e2332 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -420,16 +420,27 @@ static void discover_cb(void *user_data)
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	const char *device;
+	const char *kernel_driver;
 	int r;
 
 	DBG("%p", modem);
 
-	device = ofono_modem_get_string(modem, "Device");
-	if (!device)
+	kernel_driver = ofono_modem_get_string(modem, "KernelDriver");
+	if (!kernel_driver)
 		return -EINVAL;
 
-	data->device = qmi_device_new_qmux(device);
+	if (!strcmp(kernel_driver, "qrtr"))
+		data->device = qmi_device_new_qrtr();
+	else {
+		const char *device;
+
+		device = ofono_modem_get_string(modem, "Device");
+		if (!device)
+			return -EINVAL;
+
+		data->device = qmi_device_new_qmux(device);
+	}
+
 	if (!data->device)
 		return -EIO;
 
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8bdcf0dbbccd..14ae2f392da4 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -43,6 +43,7 @@ enum modem_type {
 	MODEM_TYPE_USB,
 	MODEM_TYPE_SERIAL,
 	MODEM_TYPE_PCIE,
+	MODEM_TYPE_EMBEDDED,
 };
 
 struct modem_info {
@@ -206,7 +207,10 @@ static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
 	DBG("qmi: %s net: %s kernel_driver: %s interface_number: %s",
 		qmi->devnode, net->devnode, net->kernel_driver, net->number);
 
-	if (!qmi->kernel_driver || !net->number)
+	if (!qmi->kernel_driver)
+		return -EINVAL;
+
+	if (!net->number && modem->type != MODEM_TYPE_EMBEDDED)
 		return -EINVAL;
 
 	attr_value = udev_device_get_sysattr_value(net->udev_device,
@@ -234,6 +238,9 @@ static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
 	case MODEM_TYPE_PCIE:
 		ofono_modem_set_string(modem->modem, "Bus", "pcie");
 		break;
+	case MODEM_TYPE_EMBEDDED:
+		ofono_modem_set_string(modem->modem, "Bus", "embedded");
+		break;
 	case MODEM_TYPE_SERIAL:
 		break;
 	}
@@ -241,6 +248,75 @@ static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
 	return 0;
 }
 
+static gboolean setup_gobi_qrtr_premux(struct modem_info *modem,
+					const char *name, int premux_index)
+{
+	const char *rmnet_data_prefix = "rmnet_data";
+	int rmnet_data_prefix_length = strlen(rmnet_data_prefix);
+	char buf[256];
+	int r;
+	uint32_t data_id;
+	uint32_t mux_id;
+
+	r = l_safe_atou32(name + rmnet_data_prefix_length, &data_id);
+	if (r < 0)
+		return FALSE;
+
+	mux_id = data_id + 1;
+
+	DBG("Adding premux interface %s, mux id: %d", name, mux_id);
+	sprintf(buf, "PremuxInterface%d", premux_index);
+	ofono_modem_set_string(modem->modem, buf, name);
+	sprintf(buf, "PremuxInterface%dMuxId", premux_index);
+	ofono_modem_set_integer(modem->modem, buf, mux_id);
+
+	return TRUE;
+}
+
+static gboolean setup_gobi_qrtr(struct modem_info *modem)
+{
+	const struct device_info *ipa_info = NULL;
+	int premux_count = 0;
+	int r;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list = modem->devices; list; list = list->next) {
+		struct device_info *info = list->data;
+		const char *name;
+
+		name = udev_device_get_sysname(info->udev_device);
+		if (l_str_has_prefix(name, "rmnet_ipa"))
+			ipa_info = info;
+		else if (l_str_has_prefix(name, "rmnet_data")) {
+			int premux_index = premux_count + 1;
+
+			if (setup_gobi_qrtr_premux(modem, name, premux_index))
+				premux_count++;
+		}
+	}
+
+	if (premux_count < 3) {
+		DBG("Not enough rmnet_data interfaces found");
+		return FALSE;
+	}
+
+	ofono_modem_set_integer(modem->modem, "NumPremuxInterfaces",
+							premux_count);
+
+	if (!ipa_info) {
+		DBG("No rmnet_ipa interface found");
+		return FALSE;
+	}
+
+	r = setup_qmi(modem, ipa_info, ipa_info);
+	if (r < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
 static gboolean setup_gobi(struct modem_info *modem)
 {
 	const struct device_info *qmi = NULL;
@@ -1594,6 +1670,7 @@ static struct {
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
+	{ "gobiqrtr",	setup_gobi_qrtr		},
 	{ }
 };
 
@@ -1644,6 +1721,7 @@ static void destroy_modem(gpointer data)
 	switch (modem->type) {
 	case MODEM_TYPE_USB:
 	case MODEM_TYPE_PCIE:
+	case MODEM_TYPE_EMBEDDED:
 		for (list = modem->devices; list; list = list->next) {
 			struct device_info *info = list->data;
 
@@ -1688,6 +1766,9 @@ static gboolean check_remove(gpointer key, gpointer value, gpointer user_data)
 		if (g_strcmp0(modem->serial->devpath, devpath) == 0)
 			return TRUE;
 		break;
+	case MODEM_TYPE_EMBEDDED:
+		/* Embedded modems cannot be removed. */
+		break;
 	}
 
 	return FALSE;
@@ -2133,6 +2214,26 @@ static void check_pci_device(struct udev_device *device)
 			device, kernel_driver);
 }
 
+static void check_net_device(struct udev_device *device)
+{
+	char path[32];
+	const char *name;
+	const char *iflink;
+
+	name = udev_device_get_sysname(device);
+	if (!l_str_has_prefix(name, "rmnet_"))
+		return;
+
+	iflink = udev_device_get_sysattr_value(device, "iflink");
+	if (!iflink)
+		return;
+
+	/* Collect all rmnet devices with this iflink under a common path. */
+	sprintf(path, "/embedded/qrtr/%s", iflink);
+	add_device(path, NULL, "gobiqrtr", NULL, NULL, MODEM_TYPE_EMBEDDED,
+							device, "qrtr");
+}
+
 static void check_device(struct udev_device *device)
 {
 	const char *bus;
@@ -2149,6 +2250,8 @@ static void check_device(struct udev_device *device)
 		check_usb_device(device);
 	else if (g_str_equal(bus, "pci") == TRUE)
 		check_pci_device(device);
+	else if (g_str_equal(bus, "net") == TRUE)
+		check_net_device(device);
 	else
 		add_serial_device(device);
 
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
