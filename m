Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4991AE85F
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895135; cv=none; b=t/h2r94tsGKt23LG1/XEnpJbc5MILLdsSaxA5dWX8noN+Mepiyl6NsuMdp0ItVvhcJ8X1TGs180b28G4fNiOv25UNkSyiofDqOOCNzwMBupe89DAngFC6B6d7aQR5Anh+MOLEx7EFgsCrhmP0mbQWU6XZ6ayyfP+VfBwNvtm5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895135; c=relaxed/simple;
	bh=Pi2H5lcgUBz/wFF+rbHv7QL8yhksrdPM0eJW8AZvD0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnNk1LHTgpR7+Jk8lVRmZKP51WgM6JOAZWNZDxwQX0m26iMdjYbY0foB2Eb6c4dRyXQlvgo2h6xVJbLw0iPNpEaOR2ORtw3wJVwkjQH8DH+977V9cS+AGervHDOF6DzIOCxJ/0QDH+Tr+jAYf3jpuOv0fqKzZ0mkKF+l4cyhDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7iF0dbs; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7iF0dbs"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d2469e797fso472257b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895132; x=1719499932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1uARSvSci0bypKfsDPhFVwggcZ/HwJ+tRt+gbS2N5E=;
        b=O7iF0dbsZYpeXScdGL0JyS7tuT0k4BJI6Z9W/5kwkqKuYoVznMx1Ikm6bi7bwj5a7R
         5pJ3k5hcmsnAdcFkeViLFUCKeA0Okl/K64nn5NGKMWiWsivr93cwHHECActUP+ZGzxq4
         ov6yFYi958bK5fMrIOW9iVt3uCU51x2j1tzCj/3iS2L/pusIPhWu/SRPSTg8bRT2YUY6
         ip8wG241w2AY//7sCg7FzlkvyYbJURjaZKBPhSU+7nwCS6C/9wSuPaBtL0qXAjNKNW3C
         JQ6SHIlYeR965m6xnSJ3m86YUNiy4S3yNkcBy5u/2EF4mPgHsbdF0wzxZNFlGJPlJOuN
         5sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895132; x=1719499932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1uARSvSci0bypKfsDPhFVwggcZ/HwJ+tRt+gbS2N5E=;
        b=bbFAgmar+q9cZDxx4jd4X+pR7ViamxjoNuVYjf2EDE/yjD+B2Oj3mjeuR8JadNWI0r
         c6MsVjochiNG1aAm/9Wsfglin3F4yzHo3seHGjS+gFdt/t9/O0xcOKKE2OcVCezNvOTj
         gtvYRUoIg60SMg6w4ZpCUnTf8b/umxcIBcxciMSo5ResFjo+WSZ6pR0FAW5/4dTqtiSG
         5Xfq0BdjLJAcQhVpOa6C+7e3C1iJvpBOBnAQUIdufh8DZ9Gsea+/lST75wodM6wSW9FI
         xwcnXYCpyzXsAtTZH5//GVtYFxLRYlqwZE9bCRY4Ww1Gt+b72U1TdRK8BDvmIni4innf
         fXxw==
X-Gm-Message-State: AOJu0YwN4uS66pEtVdIgW2ZKUeS0u9zyCo0i24p9irjN0FMUr6B8K8wa
	YwzwSNZvwcGUh5Jgpa9uXoH/UX48dNYfP5iADsZ6oRmL7taCJalQUBBgng==
X-Google-Smtp-Source: AGHT+IEEzUW1jn/wjootxG5caKO2ClGXxBzD5uB5RoJ0o+1wDuEuwV+PKtwrrcQyYje1GAwIjsDLOg==
X-Received: by 2002:a05:6808:2109:b0:3d5:2ab9:9db2 with SMTP id 5614622812f47-3d52ab9a134mr730535b6e.19.1718895132591;
        Thu, 20 Jun 2024 07:52:12 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 24/33] qmi: Move expected data format handling into gobi
Date: Thu, 20 Jun 2024 09:51:11 -0500
Message-ID: <20240620145139.1135899-24-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
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
index 46f4d50e2ee1..3f337efe7b06 100644
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

