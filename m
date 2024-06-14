Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D11A2549
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391203; cv=none; b=HByBwD7pV1ctnp4MrsdQd5Z/hQKNGOvE/ysRgTEb3SVVQYUz2ai9p49L52Cm+OKP8u4uhhyNObbHdmMSLYhYPgf972HuysmzgLCw8ttYB5+Qt0v0szVLyX3/C8qWsNd2SeL1JAAf/UphUgbhAqMUyHsxlrqtmnCVKIolUxPVLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391203; c=relaxed/simple;
	bh=WBE9HPbSajYoDJgDK5MzFtluRBmbO0zG7WgoWBQpGrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZA1+rgmdA40feSnDoH1pR0Ho9TY2/FtkNdU592YqCF6pWw93B3QbzuM+oGPg8w6v+8xAnGvHd4gosYlSjqKugdySLRheUOK0l2WV6Ia9F488Dgd9ZD0rE2AqmDuX3qeN/n0f+H66HaDPii5Eni9V+ZIwtOw2JX28I8uHAD00v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnMyci7X; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnMyci7X"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f9603730d5so1338362a34.1
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391200; x=1718996000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJQUzN4O/NLx7GggDayONSbQhWY+6wzApJP6fwYg/Ec=;
        b=UnMyci7Xq2ibupprSDP5huMcbzfcwLr61faYsyRsiXwfDoUuRcpPP4qVdpcuRMy0/5
         Y5V/rwk1e+Kvl/AQo9avh2tmVPdJJUbha7jvlMBo19zZNnyopP3B1r0xiC3K1rq6w/cM
         4RjJR2U8F0G7giSMFXLSPb7YLPycHDGm2YhiQXANrX9vIFh6yVbeRCnVRBD3k/p4X3d0
         Cv1HpXPNC22KWDijdsir5xNGA8II9jOHKCiOS3YELeyYYudWpmjSx1NsZoARfZ8QoyR9
         JtsDI1lrcFiivChggzcLbzqY/DudyxsHlOmUG5b6O/w8uSUMRHhaVJNvW78AqVYsPELT
         b4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391200; x=1718996000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJQUzN4O/NLx7GggDayONSbQhWY+6wzApJP6fwYg/Ec=;
        b=TThjblzW/dTVsAlI0pINBesnZ8DQ27dq4zD4jebqTMWwg6hT59rpVDmIHpcw1czGbo
         IMxRoUEJDAGsoCyfgkvVdXXgg/79PXkAoiVehhor4IJwMIGsl22lVxlalNBK1FPXytp2
         pmxWLDuy+FNBLB+oDxIt1RrN7cLDX4M8KknM2WCaq0PSseUotpfb604BzIDVUHxqVqRu
         wFakmuQmHFAinCIXd6ttChCtgWJjpXlCpwwtWyHuruDhKrBGAfoQVTdqiDdHSjxU9u8k
         6QgaUU22vjxr3ulYPxhiVN/FkCjX3U+wcmG/R4qws66zqoxXtUMlMCzHotaokR0fZiYM
         c8Ng==
X-Gm-Message-State: AOJu0YxdR357vUPGqusSbmXz3zd73MGS2uYu7F+6xz9ULv0Pb8P2y6S+
	Yth4MU0x0tH4a2WRhtz2yiEjMIRNDNzC+k5I/jd1Z1iBsVn/Xtjl871sEQ==
X-Google-Smtp-Source: AGHT+IEJhBTjK9i34YF8XZhp2WTO6QsnzsVWIwxIRqehh3H74msiPKt2LBEFy46+oseshXPphakzJA==
X-Received: by 2002:a05:6870:c095:b0:254:7cd4:9092 with SMTP id 586e51a60fabf-258428eb176mr3626654fac.20.1718391199942;
        Fri, 14 Jun 2024 11:53:19 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:19 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 23/27] qmi: Move expected data format handling into gobi
Date: Fri, 14 Jun 2024 13:52:35 -0500
Message-ID: <20240614185300.1086701-23-denkenz@gmail.com>
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

The expected data format logic inside qmi_device was specific to the
qmi_wwan driver used for USB QMI (QMUX) devices.  Move it to the gobi
modem driver that manages such devices.  The code is greatly simplified
since 'gobi' knows about the network interface name directly.
---
 drivers/qmimodem/qmi.c | 197 -----------------------------------------
 drivers/qmimodem/qmi.h |  11 ---
 plugins/gobi.c         |  67 +++++++++-----
 3 files changed, 47 insertions(+), 228 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 4dba8186c09d..306ca6092e5c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1028,203 +1028,6 @@ int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 	return device->ops->shutdown(device, func, user_data, destroy);
 }
 
-static bool get_device_file_name(struct qmi_device *device,
-					char *file_name, int size)
-{
-	pid_t pid;
-	char temp[100];
-	ssize_t result;
-	int fd = l_io_get_fd(device->io);
-
-	if (size <= 0)
-		return false;
-
-	pid = getpid();
-
-	snprintf(temp, 100, "/proc/%d/fd/%d", (int) pid, fd);
-	temp[99] = 0;
-
-	result = readlink(temp, file_name, size - 1);
-
-	if (result == -1 || result >= size - 1) {
-		DBG("Error %d in readlink", errno);
-		return false;
-	}
-
-	file_name[result] = 0;
-
-	return true;
-}
-
-static char *get_first_dir_in_directory(char *dir_path)
-{
-	DIR *dir;
-	struct dirent *dir_entry;
-	char *dir_name = NULL;
-
-	dir = opendir(dir_path);
-
-	if (!dir)
-		return NULL;
-
-	dir_entry = readdir(dir);
-
-	while ((dir_entry != NULL)) {
-		if (dir_entry->d_type == DT_DIR &&
-				strcmp(dir_entry->d_name, ".") != 0 &&
-				strcmp(dir_entry->d_name, "..") != 0) {
-			dir_name = l_strdup(dir_entry->d_name);
-			break;
-		}
-
-		dir_entry = readdir(dir);
-	}
-
-	closedir(dir);
-	return dir_name;
-}
-
-static char *get_device_interface(struct qmi_device *device)
-{
-	char * const driver_names[] = { "usbmisc", "usb" };
-	unsigned int i;
-	char file_path[PATH_MAX];
-	const char *file_name;
-	char *interface = NULL;
-
-	if (!get_device_file_name(device, file_path, sizeof(file_path)))
-		return NULL;
-
-	file_name = l_basename(file_path);
-
-	for (i = 0; i < L_ARRAY_SIZE(driver_names) && !interface; i++) {
-		char *sysfs_path;
-
-		sysfs_path = l_strdup_printf("/sys/class/%s/%s/device/net/",
-						driver_names[i], file_name);
-		interface = get_first_dir_in_directory(sysfs_path);
-		l_free(sysfs_path);
-	}
-
-	return interface;
-}
-
-enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
-						struct qmi_device *device)
-{
-	char *sysfs_path = NULL;
-	char *interface = NULL;
-	int fd = -1;
-	char value;
-	enum qmi_device_expected_data_format expected =
-					QMI_DEVICE_EXPECTED_DATA_FORMAT_UNKNOWN;
-
-	if (!device)
-		goto done;
-
-	interface = get_device_interface(device);
-
-	if (!interface) {
-		DBG("Error while getting interface name");
-		goto done;
-	}
-
-	/* Build sysfs file path and open it */
-	sysfs_path = l_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
-
-	fd = open(sysfs_path, O_RDONLY);
-	if (fd < 0) {
-		/* maybe not supported by kernel */
-		DBG("Error %d in open(%s)", errno, sysfs_path);
-		goto done;
-	}
-
-	if (read(fd, &value, 1) != 1) {
-		DBG("Error %d in read(%s)", errno, sysfs_path);
-		goto done;
-	}
-
-	if (value == 'Y')
-		expected = QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP;
-	else if (value == 'N')
-		expected = QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3;
-	else
-		DBG("Unexpected sysfs file contents");
-
-done:
-	if (fd >= 0)
-		close(fd);
-
-	if (sysfs_path)
-		l_free(sysfs_path);
-
-	if (interface)
-		l_free(interface);
-
-	return expected;
-}
-
-bool qmi_device_set_expected_data_format(struct qmi_device *device,
-			enum qmi_device_expected_data_format format)
-{
-	bool res = false;
-	char *sysfs_path = NULL;
-	char *interface = NULL;
-	int fd = -1;
-	char value;
-
-	if (!device)
-		goto done;
-
-	switch (format) {
-	case QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3:
-		value = 'N';
-		break;
-	case QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP:
-		value = 'Y';
-		break;
-	default:
-		DBG("Unhandled format: %d", (int) format);
-		goto done;
-	}
-
-	interface = get_device_interface(device);
-
-	if (!interface) {
-		DBG("Error while getting interface name");
-		goto done;
-	}
-
-	/* Build sysfs file path and open it */
-	sysfs_path = l_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
-
-	fd = open(sysfs_path, O_WRONLY);
-	if (fd < 0) {
-		/* maybe not supported by kernel */
-		DBG("Error %d in open(%s)", errno, sysfs_path);
-		goto done;
-	}
-
-	if (write(fd, &value, 1) != 1) {
-		DBG("Error %d in write(%s)", errno, sysfs_path);
-		goto done;
-	}
-
-	res = true;
-
-done:
-	if (fd >= 0)
-		close(fd);
-
-	if (sysfs_path)
-		l_free(sysfs_path);
-
-	if (interface)
-		l_free(interface);
-
-	return res;
-}
-
 static int qmi_device_qmux_write(struct qmi_device *device,
 					struct qmi_request *req)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 02924f805bba..702e8c5006b5 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -41,12 +41,6 @@
 #define QMI_SERVICE_RMS		225	/* Remote management service */
 #define QMI_SERVICE_OMA		226	/* OMA device management service */
 
-enum qmi_device_expected_data_format {
-	QMI_DEVICE_EXPECTED_DATA_FORMAT_UNKNOWN,
-	QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3,
-	QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP,
-};
-
 enum qmi_data_endpoint_type {
 	QMI_DATA_ENDPOINT_TYPE_UNKNOWN   = 0x00,
 	QMI_DATA_ENDPOINT_TYPE_HSIC      = 0x01,
@@ -89,11 +83,6 @@ int qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
-enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
-						struct qmi_device *device);
-bool qmi_device_set_expected_data_format(struct qmi_device *device,
-			enum qmi_device_expected_data_format format);
-
 struct qmi_qrtr_node *qmi_qrtr_node_new(uint32_t node);
 void qmi_qrtr_node_free(struct qmi_qrtr_node *node);
 void qmi_qrtr_node_set_debug(struct qmi_qrtr_node *node,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 422a853c4c7f..9c44c887b08d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -76,12 +76,13 @@ struct gobi_data {
 	unsigned long features;
 	unsigned int discover_attempts;
 	uint8_t oper_mode;
-	bool using_mux;
-	bool using_qmi_wwan_q;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
+	bool using_mux : 1;
+	bool using_qmi_wwan : 1;
+	bool using_qmi_wwan_q : 1;
 };
 
 static void gobi_debug(const char *str, void *user_data)
@@ -134,6 +135,8 @@ static int gobi_probe(struct ofono_modem *modem)
 
 	if (!strcmp(if_driver, "qmi_wwan_q"))
 		data->using_qmi_wwan_q = true;
+	else if (!strcmp(if_driver, "qmi_wwan"))
+		data->using_qmi_wwan = true;
 
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
@@ -332,12 +335,49 @@ error:
 	shutdown_device(modem);
 }
 
+static void setup_qmi_wwan(const char *interface, uint32_t llproto)
+{
+	char raw_ip;
+	char new_raw_ip;
+
+	if (l_sysctl_get_char(&raw_ip, "/sys/class/net/%s/qmi/raw_ip",
+				interface) < 0) {
+		DBG("Couldn't query raw_ip setting");
+		return;
+	}
+
+	if (raw_ip != 'Y' && raw_ip != 'N') {
+		DBG("Unexpected value: %c", raw_ip);
+		return;
+	}
+
+	switch (llproto) {
+	case QMI_WDA_DATA_LINK_PROTOCOL_802_3:
+		new_raw_ip = 'N';
+		break;
+	case QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP:
+		new_raw_ip = 'Y';
+		break;
+	default:
+		DBG("Unknown WDA Link Protocol");
+		return;
+	}
+
+	DBG("raw_ip: %c, want: %c", raw_ip, new_raw_ip);
+
+	if (raw_ip == new_raw_ip)
+		return;
+
+	if (l_sysctl_set_char(new_raw_ip, "/sys/class/net/%s/qmi/raw_ip",
+				interface) < 0)
+		DBG("Fail to set raw_ip to %c", new_raw_ip);
+}
+
 static void get_data_format_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	uint32_t llproto;
-	enum qmi_device_expected_data_format expected_llproto;
 
 	DBG("");
 
@@ -347,24 +387,11 @@ static void get_data_format_cb(struct qmi_result *result, void *user_data)
 	if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
 		goto done;
 
-	expected_llproto = qmi_device_get_expected_data_format(data->device);
+	if (data->using_qmi_wwan) {
+		const char *interface =
+			ofono_modem_get_string(modem, "NetworkInterface");
 
-	if ((llproto == QMI_WDA_DATA_LINK_PROTOCOL_802_3) &&
-			(expected_llproto ==
-				QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP)) {
-		if (!qmi_device_set_expected_data_format(data->device,
-					QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3))
-			DBG("Fail to set expected data to 802.3");
-		else
-			DBG("expected data set to 802.3");
-	} else if ((llproto == QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) &&
-			(expected_llproto ==
-				QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3)) {
-		if (!qmi_device_set_expected_data_format(data->device,
-					QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP))
-			DBG("Fail to set expected data to raw-ip");
-		else
-			DBG("expected data set to raw-ip");
+		setup_qmi_wwan(interface, llproto);
 	}
 
 done:
-- 
2.45.0

