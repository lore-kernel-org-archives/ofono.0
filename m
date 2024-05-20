Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F521E86E
	for <ofono@lists.linux.dev>; Mon, 20 May 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232650; cv=none; b=BjNv2fYaSsb3gSEdbX9LCoRdCZ8hN7IV2qqBVSRCNchyydbuWC/bDHPxEmtvQ5g+Qpev2LpNHBYZl0NhWGBY6tameo3h9GEDB1ZTCnbabwsklmeTvA9bthMqefWGrWuwAjc/WGOytORH9wP6jCT4Ype4kCJOn6Wyynw/VydM6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232650; c=relaxed/simple;
	bh=cMSQiU1K5XbNUNmUxsUE6vsXhRSN3VGF2kPAq2+mJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxUBYxEdAmCahg9DFc0DfL3wM3qd3uv1i6l3cX4jKZJarz6xYGHPQ+dR8KAAQjSRMvXQMdUzgU6YnFMG47NOYopD5Dg1kDvTlV/6tfCaFts75D5y1cwmjbCYSn5cIjXJcBsrGpUEPIbs/vz0B7VLuTBHOdIQc9Zcx+3ZcxvFOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8sh1gHK; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8sh1gHK"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b31f2c6e52so1176792eaf.2
        for <ofono@lists.linux.dev>; Mon, 20 May 2024 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716232647; x=1716837447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xnR6NHOaOLqaULXJww6HIqzaKX0gxy2gZJy7vrmW4g=;
        b=j8sh1gHKbdcrrNBLqt3k8ymae/Xk2Gj1eOPf/J9ARk4oSWZM6neh1VkvX64C18FjH3
         hX0DvMBnykhBIXwiI/8cw2Jou0VlFMLYux/DR/hzF2MZfmdNiWwJNIwshOa4ndwRyFEP
         PKwveeFsAxhLEHOSli71vpmpxibnhYmL7VFrhN+d5w03fDctBFehnEHMm8wOTYHXiNQE
         QLT6HVyL7NimnXO1TdZT+lGpTmtdoR6wVOG5GKIZSsI/l4HJ0bmjfhf0cAJd9369fklY
         AIbDzWKjA6DZ//+lIgTOHuVPtKSc/M8ZhiTKnKk/L/caJQaD5SRiF5ohRAjCoY2nQnfE
         PXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716232647; x=1716837447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xnR6NHOaOLqaULXJww6HIqzaKX0gxy2gZJy7vrmW4g=;
        b=kK+qCUC4ZcZpjDuGcWDkOD9Sks/XC+chpU9Hxe4yJCuoA2tqMqhT6A+MnP90TfHYe7
         cFrJrT/fcHNJeozdiFmT7m7zxi6bp6XRQPyaaIEa/pASAE1uxpUzdwHyw0v4f8iN87UF
         9Ev79PxTZvDTqbHyYi9vqM+Jn0bpfiJogaVhLdaTMejMBl0RTAOw/NlPvyU442kMHY++
         0NcITdO47yZ3umfPLEslpV6BX/pOSOKBNS7TXedRWaXlEDDyAb4RGvITXQH/BYdaieDL
         2u4Fi7hbI0V0migKVECBVZQcG05VaTUWLBcH0QOg+evzFjT7wg/zGX5PZcjxe6MGUT6X
         17kQ==
X-Gm-Message-State: AOJu0YyhTh8z/qjss6SM7H8gJXxVuxow+42jp7YLA89LfwA7EtKkDmeP
	wDSnFC2ICS5fVvU8Dai1lKJ3mh3Pf1ozSWFHd5JKf/Hm1nyTzc1eFNbVAA==
X-Google-Smtp-Source: AGHT+IGQqrG+GLXVrgGuPvy5Vn0XjKg1B8a1IzpBy9fsAk9NLGGsERZ3/gOQVZfbuLqDq/AIhfNa3Q==
X-Received: by 2002:a4a:641:0:b0:5b2:72e5:c12d with SMTP id 006d021491bc7-5b281957032mr29657736eaf.5.1716232646659;
        Mon, 20 May 2024 12:17:26 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b5390b9c54sm236387eaf.0.2024.05.20.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:17:26 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] udevng: add and use get_ifname() for netdev nodes
Date: Mon, 20 May 2024 14:17:05 -0500
Message-ID: <20240520191722.184977-4-denkenz@gmail.com>
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

For USB devices, 'devnode' member contains the path to the character
device, typically under /dev.  For example, /dev/cdc-wdm0.  For network
devices that are part of the USB composite device, 'devnode' was
overloaded to contain the network interface.  Unfortunately, this code
path / logic was only active when add_device() was called with
MODEM_TYPE_USB.  For non-USB bus devices 'devnode' was always NULL.
This led to NetworkInterface properties being set improperly:

ofonod[4874]: plugins/gobi.c:gobi_probe() net: (null)[mhi_net](2) pcie
ofonod[4874]: plugins/udevng.c:create_modem() could not register modem 'mhi'

Fix this by introducing a new get_ifname() helper which will query the
network device node information for the network interface name as
follows:
	- Query ID_NET_NAME property.  This is used on newer kernels.
	- Query INTERFACE property.  This is used on newer and legacy
	  kernels.
	- Fall back to sysname in case none of the above properties are
	  present.
---
 plugins/udevng.c | 85 +++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index c7db66238681..80a57434de78 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -78,6 +78,23 @@ struct serial_device_info {
 	struct udev_device *dev;
 };
 
+static const char *get_ifname(const struct device_info *info)
+{
+	struct udev_device *udev_device = info->udev_device;
+	const char *net_name;
+
+	net_name = udev_device_get_property_value(udev_device, "ID_NET_NAME");
+	if (net_name)
+		return net_name;
+
+	net_name = udev_device_get_property_value(udev_device, "INTERFACE");
+	if (net_name)
+		return net_name;
+
+	/* Fall back to using sysname (M: field in udevadm) */
+	return udev_device_get_sysname(udev_device);
+}
+
 static gboolean setup_isi(struct modem_info *modem)
 {
 	const char *node = NULL;
@@ -96,7 +113,7 @@ static gboolean setup_isi(struct modem_info *modem)
 			if (g_strcmp0(info->interface, "2/254/0") == 0)
 				addr = 16;
 
-			node = info->devnode;
+			node = get_ifname(info);
 		}
 	}
 
@@ -142,7 +159,7 @@ static gboolean setup_mbm(struct modem_info *modem)
 						"gw") == TRUE ||
 				g_str_has_suffix(info->sysattr,
 						"NetworkAdapter") == TRUE) {
-			network = info->devnode;
+			network = get_ifname(info);
 		}
 	}
 
@@ -178,9 +195,12 @@ static gboolean setup_hso(struct modem_info *modem)
 			app = info->devnode;
 		else if (g_strcmp0(info->sysattr, "Modem") == 0)
 			mdm = info->devnode;
-		else if (info->sysattr == NULL &&
-				g_str_has_prefix(info->devnode, "hso") == TRUE)
-			net = info->devnode;
+		else if (!info->sysattr) {
+			const char *net_name = get_ifname(info);
+
+			if (g_str_has_prefix(net_name, "hso"))
+				net = get_ifname(info);
+		}
 	}
 
 	if (ctl == NULL || app == NULL)
@@ -218,7 +238,8 @@ static int setup_qmi_netdev(struct modem_info *modem,
 
 	ofono_modem_set_string(modem->modem, "NetworkInterfaceKernelDriver",
 							net->kernel_driver);
-	ofono_modem_set_string(modem->modem, "NetworkInterface", net->devnode);
+	ofono_modem_set_string(modem->modem, "NetworkInterface",
+							get_ifname(net));
 	ofono_modem_set_integer(modem->modem, "NetworkInterfaceIndex",
 							ifindex);
 
@@ -230,7 +251,8 @@ static int setup_qmi_qmux(struct modem_info *modem,
 				const struct device_info *net)
 {
 	DBG("qmi: %s net: %s kernel_driver: %s interface_number: %s",
-		qmi->devnode, net->devnode, net->kernel_driver, net->number);
+			qmi->devnode, get_ifname(net),
+			net->kernel_driver, net->number);
 
 	if (modem->type != MODEM_TYPE_USB)
 		return -ENOTSUP;
@@ -254,7 +276,7 @@ static int setup_qmi_qmux(struct modem_info *modem,
 static int setup_qmi_qrtr(struct modem_info *modem,
 				const struct device_info *net)
 {
-	DBG("net: %s kernel_driver: %s", net->devnode, net->kernel_driver);
+	DBG("net: %s kernel_driver: %s", get_ifname(net), net->kernel_driver);
 
 	switch (modem->type) {
 	case MODEM_TYPE_EMBEDDED:
@@ -389,7 +411,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 		return FALSE;
 
 	DBG("qmi=%s net=%s mdm=%s gps=%s diag=%s",
-			qmi->devnode, net->devnode, mdm, gps, diag);
+			qmi->devnode, get_ifname(net), mdm, gps, diag);
 
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
@@ -465,10 +487,11 @@ static gboolean setup_sierra(struct modem_info *modem)
 	if (mdm == NULL || net == NULL)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "NetworkInterface", net->devnode);
+	ofono_modem_set_string(modem->modem, "NetworkInterface",
+					get_ifname(net));
 done:
 	DBG("modem=%s app=%s net=%s diag=%s qmi=%s",
-			mdm, app, net->devnode, diag, qmi->devnode);
+			mdm, app, get_ifname(net), diag, qmi->devnode);
 
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "App", app);
@@ -543,10 +566,11 @@ static gboolean setup_huawei(struct modem_info *modem)
 	if (mdm == NULL || pcui == NULL)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "NetworkInterface", net->devnode);
+	ofono_modem_set_string(modem->modem, "NetworkInterface",
+					get_ifname(net));
 done:
 	DBG("mdm=%s pcui=%s diag=%s qmi=%s net=%s",
-		mdm, pcui, diag, qmi->devnode, net->devnode);
+		mdm, pcui, diag, qmi->devnode, get_ifname(net));
 
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Pcui", pcui);
@@ -646,11 +670,11 @@ static gboolean setup_icera(struct modem_info *modem)
 				mdm = info->devnode;
 		} else if (g_strcmp0(info->interface, "2/6/0") == 0) {
 			if (g_strcmp0(info->number, "05") == 0)
-				net = info->devnode;
+				net = get_ifname(info);
 			else if (g_strcmp0(info->number, "06") == 0)
-				net = info->devnode;
+				net = get_ifname(info);
 			else if (g_strcmp0(info->number, "07") == 0)
-				net = info->devnode;
+				net = get_ifname(info);
 		}
 	}
 
@@ -823,7 +847,7 @@ static gboolean setup_telit(struct modem_info *modem)
 				gps = info->devnode;
 		} else if (info->sysattr && (g_str_has_suffix(info->sysattr,
 						"CDC NCM") == TRUE)) {
-			net = info->devnode;
+			net = get_ifname(info);
 		}
 	}
 
@@ -1022,7 +1046,7 @@ static gboolean setup_samsung(struct modem_info *modem)
 		if (g_strcmp0(info->interface, "10/0/0") == 0)
 			control = info->devnode;
 		else if (g_strcmp0(info->interface, "255/0/0") == 0)
-			network = info->devnode;
+			network = get_ifname(info);
 	}
 
 	if (control == NULL && network == NULL)
@@ -1249,7 +1273,7 @@ static gboolean setup_mbim(struct modem_info *modem)
 		if (g_strcmp0(subsystem, "usbmisc") == 0) /* cdc-wdm */
 			ctl = info->devnode;
 		else if (g_strcmp0(subsystem, "net") == 0) /* wwan */
-			net = info->devnode;
+			net = get_ifname(info);
 		else if (g_strcmp0(subsystem, "tty") == 0) {
 			if (g_strcmp0(info->number, "02") == 0)
 				atcmd = info->devnode;
@@ -1407,7 +1431,7 @@ static gboolean setup_ublox(struct modem_info *modem)
 				g_strcmp0(info->interface, "2/13/0") == 0 ||
 				g_strcmp0(info->interface, "10/0/0") == 0 ||
 				g_strcmp0(info->interface, "224/1/3") == 0) {
-			net = info->devnode;
+			net = get_ifname(info);
 		}
 	}
 
@@ -1452,7 +1476,7 @@ static gboolean setup_gemalto(struct modem_info *modem)
 			else if (g_strcmp0(info->number, "03") == 0)
 				mdm = info->devnode;
 			else if (g_strcmp0(subsystem, "net") == 0)
-				net = info->devnode;
+				net = get_ifname(info);
 			else if (g_strcmp0(subsystem, "usbmisc") == 0)
 				qmi = info->devnode;
 		}
@@ -1470,9 +1494,9 @@ static gboolean setup_gemalto(struct modem_info *modem)
 		if (g_strcmp0(info->interface, "2/6/0") == 0) {
 			if (g_strcmp0(subsystem, "net") == 0) {
 				if (g_strcmp0(info->number, "0a") == 0)
-					net = info->devnode;
+					net = get_ifname(info);
 				if (g_strcmp0(info->number, "0c") == 0)
-					net2 = info->devnode;
+					net2 = get_ifname(info);
 			}
 		}
 	}
@@ -1535,11 +1559,11 @@ static gboolean setup_xmm7xxx(struct modem_info *modem)
 				} else if (g_strcmp0(subsystem, "net")
 									== 0) {
 					if (g_strcmp0(info->number, "06") == 0)
-						net = info->devnode;
+						net = get_ifname(info);
 					if (g_strcmp0(info->number, "08") == 0)
-						net2 = info->devnode;
+						net2 = get_ifname(info);
 					if (g_strcmp0(info->number, "0a") == 0)
-						net3 = info->devnode;
+						net3 = get_ifname(info);
 				}
 			} else {
 				if (g_strcmp0(subsystem, "tty") == 0) {
@@ -1548,7 +1572,7 @@ static gboolean setup_xmm7xxx(struct modem_info *modem)
 				} else if (g_strcmp0(subsystem, "net")
 									== 0) {
 					if (g_strcmp0(info->number, "00") == 0)
-						net = info->devnode;
+						net = get_ifname(info);
 				}
 			}
 
@@ -1992,13 +2016,6 @@ static void add_device(const char *modem_syspath, const char *modem_devname,
 
 	if (modem->type == MODEM_TYPE_USB) {
 		devnode = udev_device_get_devnode(device);
-		if (devnode == NULL) {
-			devnode = udev_device_get_property_value(device,
-							"INTERFACE");
-			if (devnode == NULL)
-				return;
-		}
-
 		usb_interface = udev_device_get_parent_with_subsystem_devtype(
 							device, "usb",
 							"usb_interface");
-- 
2.45.0

