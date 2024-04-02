Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FE15AAA7
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093387; cv=none; b=oky4PjjlQTcITdAWFOqgwT4msMwhOigIWGaAX4xLVcQxUTQgYPjW97pTYZivN6IBA1qcPk8MfN2vtRCYxhdSms34LGPZZK6KlF8WN3hGtUj+DDiI9M0FaFWZbB4im5ztiUHwQG2Pvu70fAalpInJstN7Cf8HCN/pyZGmZum3I0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093387; c=relaxed/simple;
	bh=JL274Hr1y4bipovqOK1g4oCcbLNtC2WR3OfSqcA45MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lO7Bl0hskU/dnpo4p6s7Xc7Uclmo8InI8MVIHabZkNhpAQrrx/STLYalsNmhSBcEDcfjtgxHCys+KFCxqwpisQbB6BWsCP8KZB5KQKYlw0FBc09YDRwbKtEl8kA+F+DRPa7vsQrYXo4s9jADjy2yYS7VdIMfcMEc+xLpsuF7meE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=QQaOrEwD; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=jBpU9uyC; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="QQaOrEwD";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="jBpU9uyC"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432DTI5T004275
	for <ofono@lists.linux.dev>; Tue, 2 Apr 2024 14:21:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=7kjaulNTMl7j0iZoXTfSytWnECd1ug3PXI+EtcSh7g8=; b=Q
	QaOrEwDemyVMvxFds2ywf9ImOpfCh7vZriUY4DoDobns1l7lywhSJq13EoSrIQ+c
	ieC6RXv2CTMp+bflH5lpTWC6CCQzHdP6YmzVAHeJ+w3HPmGu84+eE6JNeRcfJu7y
	HEGiDaJPX0SKaj4H8mPM0b+6gJMon4HeGVgyyTDNqma2uAGXQzbeHDbwtSAiM3Ko
	Ky9j4O7Yi8d3lQANs4DfZsXfJh+CU7a60Se7lSMgEJM3cKy/2Lz6XOg/tULG8RjV
	T588SWR6ww9myrQuHWRAztUO+jFR3WgachDy2S3e0Ipg9aDujnBYngnuMffUs8Iq
	FB/gSatk2sX6XscOnr86w==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3x6j9x2hr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:21:28 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366999e233aso2369225ab.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712092888; x=1712697688; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kjaulNTMl7j0iZoXTfSytWnECd1ug3PXI+EtcSh7g8=;
        b=jBpU9uyC96l/sX8htQzSmA1qxp8EUI3zzk7PpbDjUIFCx9fp4AQ4U5Bk9qDzSXGuPJ
         tWsFe89JzRxjQ7uis0PhiuiN8uGJn/lxczT82EplM6g91J7Fbfq5VlYnxPEXbm1jGgNc
         u0LGBii3Ewx2VxhVJMc4F7t8ZvzSAeS40NhE51uPCuzaAyJVPLwgx4lcJ/ETt3Cs3xtJ
         oB05aEJeKh7tu6cnkNo8bdRizDnYoxh3Qy/sBOxI5v0+KenwPSbFOex9yeSgL+nSvd9x
         c0VNYZ+J1tTEHuuX8asSCMjAJN7qpJYvIMzSqWuHIMGE0uvPH2lrf/zTUTvCY1Ig3ahs
         HIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092888; x=1712697688;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kjaulNTMl7j0iZoXTfSytWnECd1ug3PXI+EtcSh7g8=;
        b=wStKkEbkqbzI4cRWlq+DEf2J2zLDBpWNFgjTXKOrYOXork14H48uKsv/VgmPJ1a9Cs
         BcpWFKhAPviZLIm7AOlUskqpaz6oRlB2YAYmABxW1ABLcFrfO67IoWghvtAYut1Rda1m
         FA7L+haFnPKuFTkfo7NF5gbuGK4mRyYB+s0Qqrb8NHxP2RFrkQI3fq2ye4Kup1NMsDoX
         P4zCZ2yAX0V528gZMrZp7/7B2y7tm6Wficn5fAzMaDLUyVbRdAj/rp1Xcq77Q2QEy35I
         msdh3o2HV4xDzK48RrtlFt+B18C+IU+C1OwJontbrQ9NhFxI+mUnKpY9956G3Ig+Mhzg
         7GbA==
X-Gm-Message-State: AOJu0YyPt5MYzD9h6k4ZDTXB4lFF9SVqJkSH/m3QzPnG93h5XwZOC1Ek
	6tD8IH8efmSrG/Tntp1q5FqjFz4uMh/EdgIcmPj/0iAQSWCRSboyYHlb1kW5tnPefLsqYYQy7F8
	Sh+7tVkOTsTlkPHnXPU6tuOUoyD6XYslMkYqSx/wd1m0vhq7cxkupoLEiwE/Fmqm/wUGx9mmVMP
	xpqB7x5KSRsTPa83xuXa4njX4YRlTJJTAmUFmd4OzKaLoZZC4=
X-Received: by 2002:a05:6e02:c6c:b0:368:a060:281f with SMTP id f12-20020a056e020c6c00b00368a060281fmr554817ilj.3.1712092887575;
        Tue, 02 Apr 2024 14:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXu1pkAHCV6p5ThQkoB+gQXnKE2Ixp7BqrZVtHwATgrDwh1xn8RkeUsM/LuBt6OposLC2YwA==
X-Received: by 2002:a05:6e02:c6c:b0:368:a060:281f with SMTP id f12-20020a056e020c6c00b00368a060281fmr554808ilj.3.1712092887130;
        Tue, 02 Apr 2024 14:21:27 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-66101.corp.robot.car (144.199.192.35.bc.googleusercontent.com. [35.192.199.144])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b003688003d036sm332834ilo.61.2024.04.02.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:21:26 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] udevng: Detect embedded qmi qrtr modems
Date: Tue,  2 Apr 2024 16:20:09 -0500
Message-ID: <20240402212013.39038-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: cDG1BqWTBtE2fRO9xl6ES4YObhXtjIvp
X-Proofpoint-GUID: cDG1BqWTBtE2fRO9xl6ES4YObhXtjIvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=717 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020158

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
 plugins/udevng.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 4 deletions(-)

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
index 8bdcf0dbbccd..53cc0836a928 100644
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
+			int endpoint_id;
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
 
@@ -2133,6 +2274,26 @@ static void check_pci_device(struct udev_device *device)
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
@@ -2149,6 +2310,8 @@ static void check_device(struct udev_device *device)
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
