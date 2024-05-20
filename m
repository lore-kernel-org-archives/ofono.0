Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B679EF
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232650; cv=none; b=huiDJ3m71teF7Web8ZzzD5cuXxoqZHUFp3zMDQBKwQQT04BqxjbizWYKiy44NTA+6sXP8tnz4+TQ9/CxMj03d/uMI7yGqg0kywuRSeJBpaWrh6icTfTW6eGWcdVkDA8mIp+T6TWmmC7O+s2ktLUfKfojSnZ8uvjM6XyOS8wq8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232650; c=relaxed/simple;
	bh=LddFCFknC033tln6KPG+wWcJeZa6RauF6VQ3lXar8C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Un/T5bTL+glsn6OxvwIh0oye8SkaXVN1G1SVrQI1Yhp8QoeAvwBq+ITMscr1nliaVbwbXk33DsO2HBx5jkCeQt/8HZbEiW4DQKCUiBufJCE+/Q/SKd4RY5tNfUVTKgbr74t/vfJ+8OJs9dupvV/mf6bB51+/MG9HpmhZGmdHCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIV3jT5I; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIV3jT5I"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2dec569e3so1944539eaf.2
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232648; x=1716837448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4+ZKE1V1KrAMn85U7hirtbrB3mX8NkrhC7SCNsCHPs=;
        b=QIV3jT5I0rmsnCYXtILX3hDL153kQHoKmTuHz3s4qzzdSlODSPUxCxmKaJbob23XS7
         egmKC2udZ7X6LFx6ZrKC7y87lHcBid5j+HjRVlud/xLvgdJiDChluZ9MbZ4QUEo9eP2Z
         6jgoks0CffiMx/uDBxhhP0yiYpTyyJDbPLsQ9h5ekisaq/dxtgtliqb7o0j5Alw6dpKF
         SZkfPNbbqi0PQBvbVa0DEFOfn5CPkjkRHyyTLvHHGPDgi/RYXWWoM4MtiOlb5HBn7Kub
         we+Frlii2IKQmpx1L7uZyoEGrdan2DcgeMYPVHPCvEpGjBNOy99V/1bKelfSrELBFAcd
         w0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232648; x=1716837448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4+ZKE1V1KrAMn85U7hirtbrB3mX8NkrhC7SCNsCHPs=;
        b=GSeVG0u66zuCSMl+ojeBjw51wZJAH9hBohneygL39A4rfgLxamEO91STOs9Bx2ryzV
         F+POdbTkuIDx3+qitOix3nI2FLrJv73EB6nY7FQVKtGLxToB3k1LExG1ZVHLNyEKnBGs
         Ce0ZefmJpEsQXSh1LTuxiODbPC+AChzpC54iSgZcgrAkX8IZ7KzjygfGYK6usZRrbAK+
         Ro3RxyoiM2iiPC5fp+xqhwOmLArpsae54v+EgOQBOdNh1IcS02JpOpbkMRHNkEz1yQ7/
         VeR1BQWO1snkVkilBnYXuLMwIs31KlG07wwUiJaKTkiKamf/Mnf6AACT/Km9cT1CXoZg
         NFJQ==
X-Gm-Message-State: AOJu0YwhrP3rKWVvIXenTkLhT63EznHLmSOFL+5k0t+YOqqjtBrWaMe7
	ce+Sc+2Ipw2ZvPCtihPKpHVMJgdGY6U/fTxS1FnnhRhFQtFiFLoAELkmRg==
X-Google-Smtp-Source: AGHT+IF0pAGQJYtgNJQhoZq9p3zBLMsIJkGCHrX+jKWfS3qoULzDZdfLU+RIMC/3JNXJFYIzq0Xlyg==
X-Received: by 2002:a05:6820:221a:b0:5b3:232a:5c0e with SMTP id 006d021491bc7-5b3232a5c17mr10438481eaf.4.1716232647590;
        Mon, 20 May 2024 12:17:27 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] udevng: Add mhi subsystem detection
Date: Mon, 20 May 2024 14:17:06 -0500
Message-ID: <20240520191722.184977-5-denkenz@gmail.com>
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

For now, only Qualcomm derived firmware devices that support QRTR +
mhi_net are detected.
---
 plugins/udevng.c | 201 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 189 insertions(+), 12 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 80a57434de78..d3ce3d5b3f7c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -44,6 +44,7 @@ enum modem_type {
 	MODEM_TYPE_SERIAL,
 	MODEM_TYPE_PCIE,
 	MODEM_TYPE_EMBEDDED,
+	MODEM_TYPE_MHI,
 };
 
 struct modem_info {
@@ -282,6 +283,9 @@ static int setup_qmi_qrtr(struct modem_info *modem,
 	case MODEM_TYPE_EMBEDDED:
 		ofono_modem_set_string(modem->modem, "Bus", "embedded");
 		break;
+	case MODEM_TYPE_MHI:
+		ofono_modem_set_string(modem->modem, "Bus", "pcie");
+		break;
 	case MODEM_TYPE_USB:
 	case MODEM_TYPE_SERIAL:
 	case MODEM_TYPE_PCIE:
@@ -1730,6 +1734,42 @@ static gboolean setup_sim76xx(struct modem_info *modem)
 	return TRUE;
 }
 
+static gboolean setup_mhi(struct modem_info *modem)
+{
+	const struct device_info *net = NULL;
+	const struct device_info *qrtr = NULL;
+	GSList *list;
+	int r;
+
+	DBG("%s", modem->syspath);
+
+	for (list = modem->devices; list; list = list->next) {
+		const struct device_info *info = list->data;
+		const char *subsystem =
+				udev_device_get_subsystem(info->udev_device);
+
+		DBG("%s", udev_device_get_syspath(info->udev_device));
+
+		if (l_streq0(udev_device_get_property_value(info->udev_device,
+								"MODALIAS"),
+					"mhi:IPCR"))
+			qrtr = info;
+		else if (l_streq0(subsystem, "net"))
+			net = info;
+	}
+
+	DBG("net: %p, qrtr: %p", net, qrtr);
+
+	if (!net || !qrtr)
+		return FALSE;
+
+	r = setup_qmi_qrtr(modem, net);
+	if (r < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -1772,6 +1812,7 @@ static struct {
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
 	{ "gobiqrtr",	setup_gobi_qrtr		},
+	{ "mhi",	setup_mhi		},
 	{ }
 };
 
@@ -1823,6 +1864,7 @@ static void destroy_modem(gpointer data)
 	case MODEM_TYPE_USB:
 	case MODEM_TYPE_PCIE:
 	case MODEM_TYPE_EMBEDDED:
+	case MODEM_TYPE_MHI:
 		for (list = modem->devices; list; list = list->next) {
 			struct device_info *info = list->data;
 
@@ -1854,6 +1896,7 @@ static gboolean check_remove(gpointer key, gpointer value, gpointer user_data)
 	switch (modem->type) {
 	case MODEM_TYPE_USB:
 	case MODEM_TYPE_PCIE:
+	case MODEM_TYPE_MHI:
 		for (list = modem->devices; list; list = list->next) {
 			struct device_info *info = list->data;
 			const char *syspath =
@@ -2315,11 +2358,137 @@ static void check_pci_device(struct udev_device *device)
 			device, kernel_driver);
 }
 
+static const struct {
+	const char *driver;
+	uint16_t vend;
+	uint16_t dev;
+	uint16_t subvend;
+	uint16_t subdev;
+} wwan_driver_list[] = {
+	{ "mhi",		0x17cb, 0x0308, },
+	{ }
+};
+
+static int parse_pci_id(const char *id, uint16_t *out_vend, uint16_t *out_dev)
+{
+	_auto_(l_strv_free) char **ids = l_strsplit(id, ':');
+	int r;
+
+	if (!ids || !ids[0] || !ids[1] || ids[2])
+		return -EINVAL;
+
+	r = l_safe_atox16(ids[0], out_vend);
+	if (r < 0)
+		return r;
+
+	r = l_safe_atox16(ids[1], out_dev);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
+static bool add_mhi_device(struct udev_device *device,
+						struct udev_device *parent)
+{
+	const char *syspath;
+	const char *kernel_driver;
+	const char *pci_id;
+	const char *pci_subid;
+	uint16_t vend, dev, subvend, subdev;
+	unsigned int i;
+
+	/* Use syspath of the MHI device as the modem path */
+	syspath = udev_device_get_syspath(parent);
+	if (!syspath)
+		return false;
+
+	kernel_driver = udev_device_get_property_value(device, "ID_NET_DRIVER");
+	if (!kernel_driver)
+		kernel_driver = udev_device_get_driver(device);
+
+	/* vid / pid is on the parent of the MHI device */
+	pci_id = udev_device_get_property_value(parent, "PCI_ID");
+	pci_subid = udev_device_get_property_value(parent, "PCI_SUBSYS_ID");
+
+	if (!pci_id || !pci_subid)
+		return false;
+
+	if (parse_pci_id(pci_id, &vend, &dev) < 0)
+		return false;
+
+	if (parse_pci_id(pci_subid, &subvend, &subdev) < 0)
+		return false;
+
+	for (i = 0; wwan_driver_list[i].driver; i++) {
+		if (wwan_driver_list[i].vend != vend)
+			continue;
+
+		if (wwan_driver_list[i].dev != dev)
+			continue;
+
+		if (wwan_driver_list[i].subvend &&
+				wwan_driver_list[i].subvend != subvend)
+			continue;
+
+		if (wwan_driver_list[i].subdev &&
+				wwan_driver_list[i].subdev != subdev)
+			continue;
+
+		add_device(syspath, NULL, wwan_driver_list[i].driver,
+				NULL, NULL, MODEM_TYPE_MHI,
+				device, kernel_driver);
+		return true;
+	}
+
+	return false;
+}
+
+static void check_wwan_device(struct udev_device *device)
+{
+	struct udev_device *parent;
+
+	parent = udev_device_get_parent_with_subsystem_devtype(device,
+								"mhi", NULL);
+	if (!parent)
+		return;
+
+	/* If this is an MHI device, find the MHI parent */
+	parent = udev_device_get_parent(parent);
+	if (!parent)
+		return;
+
+	add_mhi_device(device, parent);
+}
+
+static void check_mhi_device(struct udev_device *device)
+{
+	struct udev_device *parent =
+		udev_device_get_parent_with_subsystem_devtype(device,
+								"pci", NULL);
+
+	if (!parent)
+		return;
+
+	add_mhi_device(device, parent);
+}
+
 static void check_net_device(struct udev_device *device)
 {
 	char path[32];
 	const char *name;
 	const char *iflink;
+	struct udev_device *parent;
+
+	parent = udev_device_get_parent(device);
+	if (parent && l_streq0(udev_device_get_subsystem(parent), "mhi")) {
+		parent = udev_device_get_parent_with_subsystem_devtype(device,
+								"pci", NULL);
+		if (parent)
+			add_mhi_device(device, parent);
+
+		return;
+	}
 
 	name = udev_device_get_sysname(device);
 	if (!l_str_has_prefix(name, "rmnet_"))
@@ -2337,25 +2506,29 @@ static void check_net_device(struct udev_device *device)
 
 static void check_device(struct udev_device *device)
 {
-	const char *bus;
+	const char *subsystem = udev_device_get_subsystem(device);
+	const char *bus = udev_device_get_property_value(device, "ID_BUS");
 
-	bus = udev_device_get_property_value(device, "ID_BUS");
-	if (bus == NULL) {
-		bus = udev_device_get_subsystem(device);
-		if (bus == NULL)
-			return;
+	if (l_streq0(subsystem, "net")) {
+		/* Handle USB-connected network devices in check_usb_device */
+		if (l_streq0(bus, "usb"))
+			check_usb_device(device);
+		else
+			check_net_device(device);
+
+		return;
 	}
 
-	if ((g_str_equal(bus, "usb") == TRUE) ||
-			(g_str_equal(bus, "usbmisc") == TRUE))
+	if (l_streq0(subsystem, "usb") || l_streq0(subsystem, "usbmisc"))
 		check_usb_device(device);
-	else if (g_str_equal(bus, "pci") == TRUE)
+	else if (l_streq0(subsystem, "pci"))
 		check_pci_device(device);
-	else if (g_str_equal(bus, "net") == TRUE)
-		check_net_device(device);
+	else if (l_streq0(subsystem, "wwan"))
+		check_wwan_device(device);
+	else if (l_streq0(subsystem, "mhi"))
+		check_mhi_device(device);
 	else
 		add_serial_device(device);
-
 }
 
 static gboolean create_modem(gpointer key, gpointer value, gpointer user_data)
@@ -2414,6 +2587,8 @@ static void enumerate_devices(struct udev *context)
 	udev_enumerate_add_match_subsystem(enumerate, "net");
 	udev_enumerate_add_match_subsystem(enumerate, "hsi");
 	udev_enumerate_add_match_subsystem(enumerate, "pci");
+	udev_enumerate_add_match_subsystem(enumerate, "wwan");
+	udev_enumerate_add_match_subsystem(enumerate, "mhi");
 
 	udev_enumerate_scan_devices(enumerate);
 
@@ -2539,6 +2714,8 @@ static int detect_init(void)
 							"usbmisc", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "net", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "hsi", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "wwan", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "mhi", NULL);
 
 	udev_monitor_filter_update(udev_mon);
 
-- 
2.45.0

