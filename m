Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CD78688
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471627; cv=none; b=pcWcNhrd71gh4BN2pfWGh//IfHfDQipGjK+2dgJc94MQAdIcPqom8DVkbbe9Q0wYVlrdX9ciOLaxl0lxK9ZpESI2P8kA9foNpsRr5Cb1/hbcZ42MxaTSE2JQRE4tj96l2yMVWp1uDeW0daY3h9f8cA8L9eicbAXBnu1UlMrspLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471627; c=relaxed/simple;
	bh=xZ0nJ012E2Af7YyZrZod/hF8TXF0e860VpAC9FStiHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U5YZ4+3ne3GMPVbozYAeHRFCXiLvFhP/ReN9k/BPZNW7NBvG7DNALuen4A/7WhiREhwPhUA/dnqQ8BUBqNqLw9BEb13yA8HBoMXDpI6pqXUHdKYFSlHJywurro1vEHf8/8u+qXNd8Gqqsbx/dMxXOk1rBibTFgfRhv4R1CDzXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PV+F/TBt; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=SgO0RNix; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PV+F/TBt";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="SgO0RNix"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KMkme4009509
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=PaASEMOHXkL/LbDJ3hduVb7VNTajajnC0k/Gq94+vsA=; b=P
	V+F/TBtgwXyKZVTNr3T6aG4As/FSajSH2W3egRnBCg9dg0M/jgR2BohmhNBFX7eM
	BAfEmP7sWQ2z/bsw4vhnBgcgwWP+VFdHtRQjtmuQIi66WZbIOYTn1wzcmAoTrQ+O
	BtHvziNycrUdKXn4zWHHFh8MiGHyX0MIPNyw2TQsbg3IgQO4SpIkDOuaHm1M+zco
	Pd2fxYPbe2SXVLAq8jefLuFUbSzigE7U2vom8zO7LhYWoU2ls9XTLMzXsRy2poc2
	QMekabwIAq8lc2F10NNqa2psPeCpiKJlIhX4Oym1TxSYuGzVxOd5bFgC5xbglKsD
	ur6qJ4qY7hjxL99qmtCEQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd56481g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:59 -0800 (PST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f992cd47bso12976886d6.3
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708471612; x=1709076412; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PaASEMOHXkL/LbDJ3hduVb7VNTajajnC0k/Gq94+vsA=;
        b=SgO0RNixb88gz2lWgpIFoadACzqboGlG34FNpgPXqR35KnCGnPhPpVqCVaFTmwqK23
         b9sYbnDdu7aY4QEZ0n8eLJSTepWrDKupsVo34eig34D8MQ8LEA8fsa7FHnBhl1UE2eX7
         G34oBxs1wS3QV3078WKEGOYibxpj5RIrRhmH9K+AH9eDjim9a1o8bR9jepTodyRqsoR+
         +x9wSTttdN4wcYLAAmQXi4z42WjJ0M0odsNa7DLDXV+VZjCB71JVehWrIF8AmBki8w3C
         QUZ/jX/X9Mj9LzfspEQR7/EoxnalVYupUO7VkHVeuV5SJSwtOb3H7L2CggY2WIBhBM6v
         FjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471612; x=1709076412;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaASEMOHXkL/LbDJ3hduVb7VNTajajnC0k/Gq94+vsA=;
        b=dfeZJarvSDwh+/at3lRUARzIHUbUgJ2jcdtrnTrRtc6xSn8MqSTzvuLAQ2+RYJ2Ys8
         Iz0DXLIZrzEnxkxPxMaeXqsp3OxrAQM2WMGu0ZyMilo0brOv/5+iZoSoWAPrplEouCF7
         gaEVC20aLsF3eDev0WwfxsTdDBKI+pSerPVln7SZCCgEeVuq6OCCPVhMfqfd/lFkmgrn
         39ny55tJ6xSK+Zd1UeXZkKhl7vKwRQ6nHc+UMLmI65K9KQivLEuODkOaffM4xvwmHJPF
         qvJ5XaZRfUqMPY9iyeZpGrCPq/F+mo9nLOEMqQorYscs73eUA3grGrhfjnppQB7fMW4V
         bCog==
X-Gm-Message-State: AOJu0YxBMUdkcuEys36eIwlGvJ/b9fkI7CQgtvxqnWEjQFhdaXpx2+2c
	wlNopTIwKL3uc0sz4re5hW9ku25+hlzDY1YobHlunjqL9RXBncjA4Qdw7ILXPraod0SQq8XzivN
	Tqr2WBakRvQ2SzjuCGbqpormh+uLbiH6YmHjzuU3d77vXuya257yt7OIWAWFoJw7cEkhpVrb1t1
	bt1D51MDg/WNvjBe7JnxXon5b3TCEwZxyhwEe8ZxOJKH6ViSU=
X-Received: by 2002:a05:6214:2681:b0:68f:9051:5879 with SMTP id gm1-20020a056214268100b0068f90515879mr4206327qvb.21.1708471612542;
        Tue, 20 Feb 2024 15:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV2GFYbQcJWm86Hll/JsgnPhKtmlmJBxN+VDbuxtMtzyb0m+VsA1/AXkBKL3kk0XZNkTTX6w==
X-Received: by 2002:a05:6214:2681:b0:68f:9051:5879 with SMTP id gm1-20020a056214268100b0068f90515879mr4206303qvb.21.1708471612034;
        Tue, 20 Feb 2024 15:26:52 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068f85706ecfsm1931983qvb.104.2024.02.20.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:26:51 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/4] qmimodem: Use ell new, malloc, and free functions
Date: Tue, 20 Feb 2024 23:25:26 +0000
Message-Id: <20240220232529.128477-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: goHO_4M3VW4aCy9wydB_LTpwtydVUIu5
X-Proofpoint-ORIG-GUID: goHO_4M3VW4aCy9wydB_LTpwtydVUIu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402200168

---
 drivers/qmimodem/qmi.c | 109 +++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c9c80975..b51df0e7 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -33,6 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <ell/ell.h>
 #include <glib.h>
 
 #include <ofono/log.h>
@@ -176,7 +177,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	struct qmi_message_hdr *msg;
 	uint16_t headroom;
 
-	req = g_new0(struct qmi_request, 1);
+	req = l_new(struct qmi_request, 1);
 
 	if (service == QMI_SERVICE_CONTROL)
 		headroom = QMI_CONTROL_HDR_SIZE;
@@ -185,7 +186,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 
 	req->len = QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 
-	req->buf = g_malloc(req->len);
+	req->buf = l_malloc(req->len);
 
 	req->client = client;
 
@@ -216,8 +217,8 @@ static void __request_free(gpointer data, gpointer user_data)
 {
 	struct qmi_request *req = data;
 
-	g_free(req->buf);
-	g_free(req);
+	l_free(req->buf);
+	l_free(req);
 }
 
 static gint __request_compare(gconstpointer a, gconstpointer b)
@@ -243,7 +244,7 @@ static void __notify_free(gpointer data, gpointer user_data)
 	if (notify->destroy)
 		notify->destroy(notify->user_data);
 
-	g_free(notify);
+	l_free(notify);
 }
 
 static gint __notify_compare(gconstpointer a, gconstpointer b)
@@ -677,7 +678,7 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 	else
 		g_queue_push_tail(device->service_queue, req);
 
-	g_free(req->buf);
+	l_free(req->buf);
 	req->buf = NULL;
 
 	if (g_queue_get_length(device->req_queue) > 0)
@@ -954,9 +955,7 @@ struct qmi_device *qmi_device_new(int fd)
 	struct qmi_device *device;
 	long flags;
 
-	device = g_try_new0(struct qmi_device, 1);
-	if (!device)
-		return NULL;
+	device = l_new(struct qmi_device, 1);
 
 	__debug_device(device, "device %p new", device);
 
@@ -967,13 +966,13 @@ struct qmi_device *qmi_device_new(int fd)
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
 	if (flags < 0) {
-		g_free(device);
+		l_free(device);
 		return NULL;
 	}
 
 	if (!(flags & O_NONBLOCK)) {
 		if (fcntl(device->fd, F_SETFL, flags | O_NONBLOCK) < 0) {
-			g_free(device);
+			l_free(device);
 			return NULL;
 		}
 	}
@@ -1049,13 +1048,13 @@ void qmi_device_unref(struct qmi_device *device)
 
 	g_hash_table_destroy(device->service_list);
 
-	g_free(device->version_str);
-	g_free(device->version_list);
+	l_free(device->version_str);
+	l_free(device->version_list);
 
 	if (device->shutting_down)
 		device->destroyed = true;
 	else
-		g_free(device);
+		l_free(device);
 }
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -1173,7 +1172,7 @@ static void discover_data_free(gpointer user_data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 
-	g_free(data);
+	l_free(data);
 }
 
 static void discover_callback(uint16_t message, uint16_t length,
@@ -1206,9 +1205,7 @@ static void discover_callback(uint16_t message, uint16_t length,
 	if (len < QMI_SERVICE_LIST_SIZE)
 		goto done;
 
-	list = g_try_malloc(sizeof(struct qmi_version) * service_list->count);
-	if (!list)
-		goto done;
+	list = l_malloc(sizeof(struct qmi_version) * service_list->count);
 
 	for (i = 0; i < service_list->count; i++) {
 		uint16_t major =
@@ -1317,9 +1314,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 
 	__debug_device(device, "device %p discover", device);
 
-	data = g_try_new0(struct discover_data, 1);
-	if (!data)
-		return false;
+	data = l_new(struct discover_data, 1);
 
 	data->super.destroy = discover_data_free;
 	data->device = device;
@@ -1370,7 +1365,7 @@ static void shutdown_destroy(gpointer user_data)
 	device->shutdown_source = 0;
 
 	if (device->destroyed)
-		g_free(device);
+		l_free(device);
 }
 
 static gboolean shutdown_callback(gpointer user_data)
@@ -1427,7 +1422,7 @@ static void qmi_device_sync_callback(uint16_t message, uint16_t length,
 	if (data->func)
 		data->func(data->user_data);
 
-	g_free(data);
+	l_free(data);
 }
 
 /* sync will release all previous clients */
@@ -1442,7 +1437,7 @@ bool qmi_device_sync(struct qmi_device *device,
 
 	__debug_device(device, "Sending sync to reset QMI");
 
-	func_data = g_new0(struct sync_data, 1);
+	func_data = l_new(struct sync_data, 1);
 	func_data->func = func;
 	func_data->user_data = user_data;
 
@@ -1510,7 +1505,7 @@ static char *get_first_dir_in_directory(char *dir_path)
 		if (dir_entry->d_type == DT_DIR &&
 				strcmp(dir_entry->d_name, ".") != 0 &&
 				strcmp(dir_entry->d_name, "..") != 0) {
-			dir_name = g_strdup(dir_entry->d_name);
+			dir_name = l_strdup(dir_entry->d_name);
 			break;
 		}
 
@@ -1537,10 +1532,10 @@ static char *get_device_interface(struct qmi_device *device)
 	for (i = 0; i < G_N_ELEMENTS(driver_names) && !interface; i++) {
 		gchar *sysfs_path;
 
-		sysfs_path = g_strdup_printf("/sys/class/%s/%s/device/net/",
+		sysfs_path = l_strdup_printf("/sys/class/%s/%s/device/net/",
 						driver_names[i], file_name);
 		interface = get_first_dir_in_directory(sysfs_path);
-		g_free(sysfs_path);
+		l_free(sysfs_path);
 	}
 
 	return interface;
@@ -1567,7 +1562,7 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 	}
 
 	/* Build sysfs file path and open it */
-	sysfs_path = g_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
+	sysfs_path = l_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
 
 	fd = open(sysfs_path, O_RDONLY);
 	if (fd < 0) {
@@ -1593,10 +1588,10 @@ done:
 		close(fd);
 
 	if (sysfs_path)
-		g_free(sysfs_path);
+		l_free(sysfs_path);
 
 	if (interface)
-		g_free(interface);
+		l_free(interface);
 
 	return expected;
 }
@@ -1633,7 +1628,7 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 	}
 
 	/* Build sysfs file path and open it */
-	sysfs_path = g_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
+	sysfs_path = l_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
 
 	fd = open(sysfs_path, O_WRONLY);
 	if (fd < 0) {
@@ -1654,10 +1649,10 @@ done:
 		close(fd);
 
 	if (sysfs_path)
-		g_free(sysfs_path);
+		l_free(sysfs_path);
 
 	if (interface)
-		g_free(interface);
+		l_free(interface);
 
 	return res;
 }
@@ -1666,7 +1661,7 @@ struct qmi_param *qmi_param_new(void)
 {
 	struct qmi_param *param;
 
-	param = g_new0(struct qmi_param, 1);
+	param = l_new(struct qmi_param, 1);
 	if (!param)
 		return NULL;
 
@@ -1678,8 +1673,8 @@ void qmi_param_free(struct qmi_param *param)
 	if (!param)
 		return;
 
-	g_free(param->data);
-	g_free(param);
+	l_free(param->data);
+	l_free(param);
 }
 
 bool qmi_param_append(struct qmi_param *param, uint8_t type,
@@ -1698,13 +1693,10 @@ bool qmi_param_append(struct qmi_param *param, uint8_t type,
 		return false;
 
 	if (param->data)
-		ptr = g_try_realloc(param->data,
+		ptr = l_realloc(param->data,
 				param->length + QMI_TLV_HDR_SIZE + length);
 	else
-		ptr = g_try_malloc(QMI_TLV_HDR_SIZE + length);
-
-	if (!ptr)
-		return false;
+		ptr = l_malloc(QMI_TLV_HDR_SIZE + length);
 
 	tlv = ptr + param->length;
 
@@ -1968,7 +1960,7 @@ static void service_create_data_free(gpointer user_data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 
-	g_free(data);
+	l_free(data);
 }
 
 struct service_create_shared_data {
@@ -2012,7 +2004,7 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 	}
 
 	g_list_free(*shared);
-	g_free(shared);
+	l_free(shared);
 }
 
 static gboolean service_create_reply(gpointer user_data)
@@ -2067,9 +2059,7 @@ static void service_create_callback(uint16_t message, uint16_t length,
 	if (client_id->service != data->type)
 		goto done;
 
-	service = g_try_new0(struct qmi_service, 1);
-	if (!service)
-		goto done;
+	service = l_new(struct qmi_service, 1);
 
 	service->ref_count = 1;
 	service->device = data->device;
@@ -2111,15 +2101,8 @@ static bool service_create(struct qmi_device *device,
 	if (!device->version_list)
 		return false;
 
-	shared = g_try_new0(GList *, 1);
-	if (!shared)
-		return false;
-
-	data = g_try_new0(struct service_create_data, 1);
-	if (!data) {
-		g_free(shared);
-		return false;
-	}
+	shared = l_new(GList *, 1);
+	data = l_new(struct service_create_data, 1);
 
 	data->super.destroy = service_create_data_free;
 	data->device = device;
@@ -2169,7 +2152,7 @@ static void service_create_shared_data_free(gpointer user_data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 
-	g_free(data);
+	l_free(data);
 }
 
 bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
@@ -2196,9 +2179,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (service) {
 		struct service_create_shared_data *data;
 
-		data = g_try_new0(struct service_create_shared_data, 1);
-		if (!data)
-			return false;
+		data = l_new(struct service_create_shared_data, 1);
 
 		data->super.destroy = service_create_shared_data_free;
 		data->device = device;
@@ -2243,7 +2224,7 @@ static void service_release_callback(uint16_t message, uint16_t length,
 	if (service->device)
 		service->device->release_users--;
 
-	g_free(service);
+	l_free(service);
 }
 
 struct qmi_service *qmi_service_ref(struct qmi_service *service)
@@ -2267,7 +2248,7 @@ void qmi_service_unref(struct qmi_service *service)
 		return;
 
 	if (!service->device) {
-		g_free(service);
+		l_free(service);
 		return;
 	}
 
@@ -2319,7 +2300,7 @@ static void service_send_free(struct service_send_data *data)
 	if (data->destroy)
 		data->destroy(data->user_data);
 
-	g_free(data);
+	l_free(data);
 }
 
 static void service_send_callback(uint16_t message, uint16_t length,
@@ -2496,9 +2477,7 @@ uint16_t qmi_service_register(struct qmi_service *service,
 	if (!service || !func)
 		return 0;
 
-	notify = g_try_new0(struct qmi_notify, 1);
-	if (!notify)
-		return 0;
+	notify = l_new(struct qmi_notify, 1);
 
 	if (service->next_notify_id < 1)
 		service->next_notify_id = 1;
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
