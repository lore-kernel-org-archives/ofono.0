Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD01E531
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100555; cv=none; b=aa+Uu6jCLTfYvGA11fzni0uOd1/cQdSL6yrwF7riDaDsddoxfJmBjqFndqGlEl5SDB2bHbbpQI6KXM5sKwERs0kU+RVkQ7fYNemBTxVc7L6N5BMoYnvpt+VmDgFT9Y0sxp64Fe+IBUlXCeK0Wtj39DbVFGnZii08bBVp6uMad1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100555; c=relaxed/simple;
	bh=JVgClpTxb4TNGukIPAL/OLbYQoKa4/ktBYPDojEu5Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lh+UoYgcfrpdwwKkYyJNxzp8wqrH0HJBLAHS3vqmYlT6TtwwaxsxgV9U1CKnVMn2xGUk+BPwRJs9Zfboog6Qi4XS7DOafwA+KaAHKnIXnbC6+k9i+LBQcwuWfXtGMpJ4+eGc4Rjq5IE6Z/uvoxhyT6k90pMZO5+K/fsDsr3ubPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=b11WTPQR; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=fRStiZlt; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="b11WTPQR";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="fRStiZlt"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432CU1jF010303
	for <ofono@lists.linux.dev>; Tue, 2 Apr 2024 16:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=d/P1OCckSToTcgnm6Qq4DYJ8Pq7iDk+HgjSlRXVeSj8=; b=b
	11WTPQRwwoc7kLcBVmTn6NhIlAJPbxoW7Zj9nWeF5Sr4X3GCty/UOo1rZbd8OMj6
	w2OhpF/tOycErAmg4t/AxMBnBUL6ls/dUXb6WyncL0DsGBl6eIFMioVzdJ7ISYZK
	pSire/DYB2I+YalGBPJXuEjULnuehpl0YDH76pMTPg5Vaf/QzhmTgdwZNgBCEC5F
	ePdsGtXBdrjlLP4d+LFcMot0o6KZKX8Qpbrcqo/b/k2gguS9nj0bVo8ElhYOD9F9
	ZRosjF/X2W111EnukXWTgMaXDQbqhfo9F8FjDr1F3pC1cWDIV0LZDR7Qn0TIB0pe
	bGvgknE8IUJuBWJwIiRDQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x8e0f8sjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 16:29:10 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e0ee5097feso7067502a34.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712100539; x=1712705339; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/P1OCckSToTcgnm6Qq4DYJ8Pq7iDk+HgjSlRXVeSj8=;
        b=fRStiZltwSX/1n7+Pt1NgzRBG8251amnoe8fEU7EtaA9hzexb0pFaP+GqQVCBENtUR
         eff+/VtohVARa36hnLMQmTVYy4GVysWlKHKNcJhCDT2Q5s5d8r0vSIDY1kEcP1rN9jY4
         X5d8+EARFU8p3XczTxZaUjJDvzerC5PbpbSaEjes9+w+tmE0SR05jMRAYip1K/kIsV/P
         xACELW4DDnWljlMXFxYq4w5UgOxOoL1Oka8V2HWaQPIk0/6vk0rtbFK/DRMQVZcDZkpJ
         sWh5ACGUgA7WRp6lg6pRnsmuizb6rzhXvLTTysaIiRhDWgR+N2cShPLoDlbcg0u2h+h7
         89oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100539; x=1712705339;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/P1OCckSToTcgnm6Qq4DYJ8Pq7iDk+HgjSlRXVeSj8=;
        b=T3spQAvjFypWWrajT/BpR+AS7xPVr7nZk6YP9unIXSbcgqM2QyTCinO3vJX9LmYSqG
         nDgIVzzcZJruiE5hGtRDAgSE+ecBfYW0FmzF288PfKZqwg71hT7hi0AM4TTAyfLC8FWH
         W9mGn6oUGbComroBL+EBce6zDA10up95e85RzpS11QtXWeOs0AJr5zouN0OgK9perKO1
         HRE0Ta+TVs1eNjgv+YSoCbjUcrOI8S4fvgtNJE4YwSuips89vlB8UxM0IZ76TRguSyUG
         r2tkllyM+xS3gTJbaQEvCLg2TsnPi3JWvnqmUXsyIoKxWH1m+UO/ZX4XVHA2AJlI6wf6
         2krg==
X-Gm-Message-State: AOJu0YxznUZV0t9jBkJlh7QgpWRELS77fqWtbadLcQdPWYEXkVAaWzEc
	gfANEybgCjn+LCVqC7XS5Xyp0pmm3RutIZjHgbet+GF5eOFMoa0MoCypUk4loImZBUAQ0OtD1Qb
	voo45zfPLz3yFuMDDitf8qutHZbaJe2xoA6oz6WS4o9Z+j/Gj4FBcyZxvafCu5zmbsTEhCuhtWC
	AHjiGnCw5OiVR7SSLpHI5/OwmH2lvM177RROgGEnZRH6IKR7I=
X-Received: by 2002:a05:6870:e607:b0:221:f921:467e with SMTP id q7-20020a056870e60700b00221f921467emr987100oag.21.1712100538938;
        Tue, 02 Apr 2024 16:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGlr1W9utbUGmFkYls3DwnAmJIEzYW/LkyqGfidulPrgxkHMfrnAkpWu5TChcpMJYb37VWQg==
X-Received: by 2002:a05:6870:e607:b0:221:f921:467e with SMTP id q7-20020a056870e60700b00221f921467emr987086oag.21.1712100538324;
        Tue, 02 Apr 2024 16:28:58 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-66101.corp.robot.car (144.199.192.35.bc.googleusercontent.com. [35.192.199.144])
        by smtp.gmail.com with ESMTPSA id cz3-20020a0566384a0300b0047d69cc97d1sm3438203jab.40.2024.04.02.16.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:28:58 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2] udevng: Detect embedded qmi qrtr modems
Date: Tue,  2 Apr 2024 18:28:34 -0500
Message-ID: <20240402232836.45973-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: X-MWiSkVKi6MhJBkvfqGzTZlk1rvzwUZ
X-Proofpoint-ORIG-GUID: X-MWiSkVKi6MhJBkvfqGzTZlk1rvzwUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=638 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020173

Embedded qmi qrtr modems are identified by the existence of
rmnet_ipaX and rmnet_dataX devices. Add a new "embedded" modem type
so that these devices can be collected during enumeration and then
configured for use by the gobi plugin. Modems of this type will be
exposed as /gobiqrtr_X.

Retrieving the endpoint ID is the main complication. It requires
using an interface IOCTL and extended structure that is declared
in msm_rmnet.h. This header is available many different places on
the internet including in Android sources, but it is not available
in popular Linux distributions. The minimum set of declarations is
provided here so that the IOCTL may be used.
---
 plugins/gobi.c   |  19 ++++--
 plugins/udevng.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8d3b7ef4cdfc..d58fb8aed1a8 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -419,16 +419,27 @@ static void discover_cb(void *user_data)
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
index 8bdcf0dbbccd..81a5bb4c773d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -33,6 +33,9 @@
 
 #include <glib.h>
 #include <ell/ell.h>
+#include <linux/if.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -43,6 +46,7 @@ enum modem_type {
 	MODEM_TYPE_USB,
 	MODEM_TYPE_SERIAL,
 	MODEM_TYPE_PCIE,
+	MODEM_TYPE_EMBEDDED,
 };
 
 struct modem_info {
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
@@ -241,6 +248,139 @@ static int setup_qmi(struct modem_info *modem, const struct device_info *qmi,
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
+/*
+ * The following rmnet declarations are contained in msm_rmnet.h which is not
+ * commonly provided in Linux distributions.
+ */
+
+#define RMNET_IOCTL_EXTENDED 0x000089FD
+#define RMNET_IOCTL_GET_EPID 0x0003
+
+/*
+ * This is the minimal set of fields needed to get the endpoint ID. The actual
+ * structure has many more union members.
+ */
+struct rmnet_ioctl_extended_s {
+	uint32_t   extended_ioctl;
+
+	union {
+		uint32_t data;
+
+		/* Ensure the struct is at least as large as the real one. */
+		uint8_t buffer[32];
+	};
+};
+
+static int get_rmnet_endpoint_id(const char *if_name, uint32_t *id)
+{
+	_auto_(close) int fd = -1;
+	int r;
+	struct rmnet_ioctl_extended_s ext_ioctl_arg;
+	struct ifreq ifr;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		ofono_warn("Failed to open socket. %s", strerror(errno));
+		return -errno;
+	}
+
+	memset(&ext_ioctl_arg, 0, sizeof(ext_ioctl_arg));
+	ext_ioctl_arg.extended_ioctl = RMNET_IOCTL_GET_EPID;
+
+	memset(&ifr, 0, sizeof(ifr));
+	l_strlcpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+	ifr.ifr_ifru.ifru_data = &ext_ioctl_arg;
+
+	r = ioctl(fd, RMNET_IOCTL_EXTENDED, &ifr);
+	if (r == -1) {
+		ofono_warn("Failed to execute RMNET_IOCTL_EXTENDED ioctl. %s",
+						strerror(errno));
+		return -errno;
+	}
+
+	*id = ext_ioctl_arg.data;
+
+	return 0;
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
+		if (l_str_has_prefix(name, "rmnet_ipa")) {
+			uint32_t endpoint_id = 0;
+
+			if (!get_rmnet_endpoint_id(name, &endpoint_id)) {
+				DBG("%s: endpoint_id: %d", name, endpoint_id);
+				info->number = g_strdup_printf("%d",
+								endpoint_id);
+			}
+
+			ipa_info = info;
+
+		} else if (l_str_has_prefix(name, "rmnet_data")) {
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
@@ -1594,6 +1734,7 @@ static struct {
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
+	{ "gobiqrtr",	setup_gobi_qrtr		},
 	{ }
 };
 
@@ -1644,6 +1785,7 @@ static void destroy_modem(gpointer data)
 	switch (modem->type) {
 	case MODEM_TYPE_USB:
 	case MODEM_TYPE_PCIE:
+	case MODEM_TYPE_EMBEDDED:
 		for (list = modem->devices; list; list = list->next) {
 			struct device_info *info = list->data;
 
@@ -1688,6 +1830,9 @@ static gboolean check_remove(gpointer key, gpointer value, gpointer user_data)
 		if (g_strcmp0(modem->serial->devpath, devpath) == 0)
 			return TRUE;
 		break;
+	case MODEM_TYPE_EMBEDDED:
+		/* Embedded modems cannot be removed. */
+		break;
 	}
 
 	return FALSE;
@@ -2133,6 +2278,26 @@ static void check_pci_device(struct udev_device *device)
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
@@ -2149,6 +2314,8 @@ static void check_device(struct udev_device *device)
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
