Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8F16DC3C
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740975; cv=none; b=frptila5ShbvW0C6+7Gz1O1pzTdYrNTv0xvuJHlLjNe+RaJuQST34+WKuPYp9wMMe8OIxErLsnulbU2tPLBUVjlYwKwspsUxsg29ff+VnTRird3xm5wrzQbAeta5WDzCKbKI4B35FUw7ms+oarUAGgfgaC2mz/PtXuCjKvWbJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740975; c=relaxed/simple;
	bh=2Wuo2H4uW10SGkoxfVOHIIyd4V9tJAWoZ+ylIolJprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5r5BVSGnY62vwIsOd+629Vpyy+52GktfO7pKMh7+5JBJxWS7muwTy1dpqUc28tX1BnRZKaI92Esm6qzBft984Q/+SiWd0RDRr2xVzyUW5TNZniiethbX/abR1LO7v2JiEOxK/jFei+luHiQu3qtS54xvp7TIaLYv8NPNaIcnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NECFJVJ9; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NECFJVJ9"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c1adbcaad3so87824eaf.1
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740972; x=1719345772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rGSV/QTbvGJi49PTqC3UjUvGPRyxvWmblgbTvNr5QA=;
        b=NECFJVJ9vIx5YEghmSQWlM77f1MTuwjNO6V1MmSMgrzZcdsBWJzsTZG2tpX1cQ+pvt
         IqfVXrt3lQIaqb7g3fuIwQLUxwfAn9bPt7+OdPwvdBnEcc9ZL0iL4p+rkaoVpyEcZ1rg
         JH8q0yQUbACegy8DX27LKfuItNcDwx0c4XHyg0264GSJClDbFRNH7NMHdIl9FNFMxKyj
         zMw//Xtb3jLLzMsr7E2nl881KaA0+lO0w7DX50UhUwad9Y65Q8nbC9BhGKjlX9mLUeBw
         yR48us8skG6JtoOYlZs7nQyDOIfAefdwEMrqzJz9r7ONvjdpIDIoTuOTpK0TH3Z4bqc5
         HykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740972; x=1719345772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rGSV/QTbvGJi49PTqC3UjUvGPRyxvWmblgbTvNr5QA=;
        b=Lre9YhBYwKOOmAzYN3+0DPJjFPbAGbYRLOot/HmdjcHU/C12bwnDJKX3YelhLTuZAO
         t0K5Vwl46Ml5KWr4w2/vU+yB50q3vsbL6Atz36y0tLqwufMFim3pIcve/PPwYNZfaI0x
         LCovGqB2exHkzXIZvAWumw5s6gQUAj16uUT2gMjUT4fIGshDf+CQNGpmyh2kRWv7EYc9
         Euac4vmwgvT1Ep5bWWkpnV8dya6q1I5rvu3vEmrmDxJFuFJ48Af1KfbIzLZ+v7yMp8Zf
         BkD8hSDRewpbcs9VCHyx113j4CZoOfNNHeIEr7WQooRRYf2wrXAb382tWozJosK8hOS9
         EBPA==
X-Gm-Message-State: AOJu0YyO4YqcA28PRI3bn1Xd5iXYTO4tNmw3UOp2lAV2R4K5A43/MqIp
	NhYdaCv8PtppXtwY2hPfWCdat1VR2YS+deVVtrZ+AgS2a0yPiQHxuMC8XQ==
X-Google-Smtp-Source: AGHT+IE4lVa66goo7pxNZTaol43DlVLpDi51QLOoDcxJ6IXPB2uToR0DWemZEoPtMMOmnml8fGUIUw==
X-Received: by 2002:a05:6871:511:b0:24f:e15a:6536 with SMTP id 586e51a60fabf-25972fc5035mr1649134fac.18.1718740972371;
        Tue, 18 Jun 2024 13:02:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 24/33] qmi: Move expected data format handling into gobi
Date: Tue, 18 Jun 2024 15:02:06 -0500
Message-ID: <20240618200231.1129282-24-denkenz@gmail.com>
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
index 6e6fc6912622..1158600989c5 100644
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
index cd740a7f5b6f..7570a7db3876 100644
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

