Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC848127B58
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550613; cv=none; b=hkYUv3fS25OJ6S5HpYLr9zPc2iWb62sVbFSw5Bg2P65/FTzvogtVZO9ysAoi5f2Ysg6+O17yU3oOJoRT7ekEyZhwl2CASKARPv6rpNuj57lHG2sGGh4y+g9kCdS31Zul2s8P3QQ0EsPDa0kF0W69z14Vsp3e8hFMjKwQuFeTv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550613; c=relaxed/simple;
	bh=44uUTdUYrFFhoo2p/+W3DjT5KxVPP3UerMDQquKt+0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc9xGrAtrVmyBb71HY7CnQpUBQG39H7p1/W03QaMWMu1qLZTWgE+HJMVf/Lm1/yt1PDc8Rw1IuBKiYob6mDwdkh3X/kqFcCEt3wlC/gsbfXg1rsWHVSc1C0MACQsEeVPMBqmwfi2uflemqMU4/FIqtudcu+ZAtXFTGq3e8AllEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=CUgmw168; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=BL1sYZ+W; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="CUgmw168";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="BL1sYZ+W"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEvuKX025485
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=CzASE58b3pdGttu0/4S1tA
	SkjVB2JL9ItqfqsLJBfNE=; b=CUgmw168Srcda+RL7dJ1AnC/6jos8/WUWBBfZU
	OQGBYLn8exBPHZRkMAP3w6FVzn1m8SXMO8C/1rYgZjSxHyh80y7tcZSuUI/woxrT
	6ffcYpMk2hIyDXMUHCgx/yaXc+M6uX0GY4W6FFaaq9GMb/u7piYAnPeL/s9iTJMi
	sTP5WRtIpwlwtxujb4d48qMCaUXNqpMegzN/Xc/3gjehAOQGsoQYkgzPz7Qr5BNH
	rPi+4FXFUumaOrJFM6bfHOLVgekyw3Lgne7U+Z0QLZ8i868vLeO8Lmr7zd2aMzae
	D7St4uqGafe6QngSv89D0+OSC8e+8CC+hxhn8cVpQYFLD+hg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565h0d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:30 -0800 (PST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7816e45f957so173045185a.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550609; x=1709155409; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzASE58b3pdGttu0/4S1tASkjVB2JL9ItqfqsLJBfNE=;
        b=BL1sYZ+WmtzoxbMtUGgUaKnANfIcRSOVXmCgc72jfw6lvgoggGL7BFdvgGx54/NMT8
         zUJErRfKdMCOqv4FxBYeGHTYDYY+Ygdc7mNjVsg/mBSkQROLNlR5Ikr2/rBfnnkFkg50
         kpLdb3rM+EiFXyis26O1GigjZeLe5wdJv2jB/Y6p0V2mvNRAZ3HMkuXQ/yjW7W3zecyA
         gzCG3w3oM6Uk8UMVB2IJBjFp07GyY/l6quMAE3NukZy18Yfj5znW624E3AxYLxGHBRHF
         QkpI6wwIP1eVBkVt+QloKBZCnUb91KJsRK5VBlDPTHg+S88be9OuHZfylBgi5c353p9w
         zXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550609; x=1709155409;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzASE58b3pdGttu0/4S1tASkjVB2JL9ItqfqsLJBfNE=;
        b=Rb9BSaAK1iLWhuuhVKZNPuSlEn07zpmFgILUoLP2hlPpfIaE4+LsaoqnfpmYjXGLUU
         PFgAo90vmx5ZwMTrwq0I6PIJJHL6UifAUrkaenCtZdOUkkGOvi8aiMbjSORboP/qnu2c
         U0UaeOfIolUWdKf5QKtQBGoBbNVn0Vit4GAnoNu3gYhPy7yhsgIBZ6AMmplUm6w8NtM2
         R6P/e0hCrrmqIXe+fY/yIZcVo1T3HHFteEBy3Tr23v91QF5FoQZ674Kt2RwpjU85dn86
         qGITtXWJn5gB+2GND4v/cHtT/c0f/69wCOhVPuQE9f7eRQM/6ko9oZmJrDeC8BXis+i6
         mowQ==
X-Gm-Message-State: AOJu0YyV0jZX+AalzkPrDR7hQiWqja6FbVPtJU8OZTPYk+AhLW5ACorj
	BpoeiM72cc3wCq83yj4JLLCIPqr40uXl+tl0SkISMHV748U5fodKHL4LY4WYUTEGyUi3Za4nY4T
	b6rdxp7fG2D1613lHInINtfEpu7saosRgIF8EQ2bXm23a03WSKWmTtRv22SX9xbqT3sqPVisN1J
	aS76ozNCrsr+VYpbZLcvjQJKOm9wmqT+UTJD/lqB4l6f6SIV8=
X-Received: by 2002:a37:f502:0:b0:787:1ccd:feda with SMTP id l2-20020a37f502000000b007871ccdfedamr22386771qkk.77.1708550609062;
        Wed, 21 Feb 2024 13:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkvpbnNQdvF1FzGw5vMBizeSCgGxKeS6ElI2iNPzdzEnfNpXMgQQVGrlt1jAkIypiLf//pSA==
X-Received: by 2002:a37:f502:0:b0:787:1ccd:feda with SMTP id l2-20020a37f502000000b007871ccdfedamr22386756qkk.77.1708550608624;
        Wed, 21 Feb 2024 13:23:28 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:28 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 6/7] qmimodem: Eliminate glib macros
Date: Wed, 21 Feb 2024 21:22:11 +0000
Message-Id: <20240221212212.181401-6-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221212212.181401-1-steve.schrock@getcruise.com>
References: <20240221212212.181401-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: DnuE8W-OKVvFSkjvLsf3xOc_StkCGQqU
X-Proofpoint-ORIG-GUID: DnuE8W-OKVvFSkjvLsf3xOc_StkCGQqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

---
 drivers/qmimodem/qmi.c | 100 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 150fd343..ba6ae0d2 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -204,15 +204,15 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	hdr = req->buf;
 
 	hdr->frame = 0x01;
-	hdr->length = GUINT16_TO_LE(req->len - 1);
+	hdr->length = L_CPU_TO_LE16(req->len - 1);
 	hdr->flags = 0x00;
 	hdr->service = service;
 	hdr->client = client;
 
 	msg = req->buf + QMI_MUX_HDR_SIZE + headroom;
 
-	msg->message = GUINT16_TO_LE(message);
-	msg->length = GUINT16_TO_LE(length);
+	msg->message = L_CPU_TO_LE16(message);
+	msg->length = L_CPU_TO_LE16(length);
 
 	if (data && length > 0)
 		memcpy(req->buf + QMI_MUX_HDR_SIZE + headroom +
@@ -235,7 +235,7 @@ static void __request_free(void *data)
 static bool __request_compare(const void *a, const void *b)
 {
 	const struct qmi_request *req = a;
-	uint16_t tid = GPOINTER_TO_UINT(b);
+	uint16_t tid = L_PTR_TO_UINT(b);
 
 	return req->tid == tid;
 }
@@ -261,7 +261,7 @@ static void __notify_free(gpointer data, gpointer user_data)
 static gint __notify_compare(gconstpointer a, gconstpointer b)
 {
 	const struct qmi_notify *notify = a;
-	uint16_t id = GPOINTER_TO_UINT(b);
+	uint16_t id = L_PTR_TO_UINT(b);
 
 	return notify->id - id;
 }
@@ -278,7 +278,7 @@ static void __service_find_by_type(const void *key, void *value,
 	struct service_find_by_type_data *data = user_data;
 
 	/* ignore those that are in process of creation */
-	if (GPOINTER_TO_UINT(key) & 0x80000000)
+	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
 	if (service->type == data->type)
@@ -515,13 +515,13 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 		}
 
 		str += sprintf(str, "%s msg=%d len=%d", type,
-					GUINT16_FROM_LE(msg->message),
-					GUINT16_FROM_LE(msg->length));
+					L_LE16_TO_CPU(msg->message),
+					L_LE16_TO_CPU(msg->length));
 
 		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
 					hdr->client, ctl->type,
 					ctl->transaction,
-					GUINT16_FROM_LE(hdr->length));
+					L_LE16_TO_CPU(hdr->length));
 	} else {
 		const struct qmi_service_hdr *srv;
 		const char *type;
@@ -547,13 +547,13 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 		}
 
 		str += sprintf(str, "%s msg=%d len=%d", type,
-					GUINT16_FROM_LE(msg->message),
-					GUINT16_FROM_LE(msg->length));
+					L_LE16_TO_CPU(msg->message),
+					L_LE16_TO_CPU(msg->length));
 
 		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
 					hdr->client, srv->type,
-					GUINT16_FROM_LE(srv->transaction),
-					GUINT16_FROM_LE(hdr->length));
+					L_LE16_TO_CPU(srv->transaction),
+					L_LE16_TO_CPU(hdr->length));
 	}
 
 	function(strbuf, user_data);
@@ -565,14 +565,14 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 	str += sprintf(str, "      ");
 	offset = 0;
 
-	while (offset + QMI_TLV_HDR_SIZE < GUINT16_FROM_LE(msg->length)) {
+	while (offset + QMI_TLV_HDR_SIZE < L_LE16_TO_CPU(msg->length)) {
 		const struct qmi_tlv_hdr *tlv = ptr + offset;
-		uint16_t tlv_length = GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length = L_LE16_TO_CPU(tlv->length);
 
 		if (tlv->type == 0x02 && tlv_length == QMI_RESULT_CODE_SIZE) {
 			const struct qmi_result_code *result = ptr + offset +
 							QMI_TLV_HDR_SIZE;
-			uint16_t error = GUINT16_FROM_LE(result->error);
+			uint16_t error = L_LE16_TO_CPU(result->error);
 			const char *error_str;
 
 			error_str = __error_to_string(error);
@@ -716,7 +716,7 @@ static void service_notify(const void *key, void *value, void *user_data)
 	GList *list;
 
 	/* ignore those that are in process of creation */
-	if (GPOINTER_TO_UINT(key) & 0x80000000)
+	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
 	for (list = g_list_first(service->notify_list); list;
@@ -754,7 +754,7 @@ static void handle_indication(struct qmi_device *device,
 	hash_id = service_type | (client_id << 8);
 
 	service = l_hashmap_lookup(device->service_list,
-					GUINT_TO_POINTER(hash_id));
+					L_UINT_TO_PTR(hash_id));
 
 	if (!service)
 		return;
@@ -780,8 +780,8 @@ static void handle_packet(struct qmi_device *device,
 
 		msg = buf + QMI_CONTROL_HDR_SIZE;
 
-		message = GUINT16_FROM_LE(msg->message);
-		length = GUINT16_FROM_LE(msg->length);
+		message = L_LE16_TO_CPU(msg->message);
+		length = L_LE16_TO_CPU(msg->length);
 
 		data = buf + QMI_CONTROL_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
 
@@ -795,7 +795,7 @@ static void handle_packet(struct qmi_device *device,
 
 		req = l_queue_remove_if(device->control_queue,
 						__request_compare,
-						GUINT_TO_POINTER(tid));
+						L_UINT_TO_PTR(tid));
 	} else {
 		const struct qmi_service_hdr *service = buf;
 		const struct qmi_message_hdr *msg;
@@ -803,12 +803,12 @@ static void handle_packet(struct qmi_device *device,
 
 		msg = buf + QMI_SERVICE_HDR_SIZE;
 
-		message = GUINT16_FROM_LE(msg->message);
-		length = GUINT16_FROM_LE(msg->length);
+		message = L_LE16_TO_CPU(msg->message);
+		length = L_LE16_TO_CPU(msg->length);
 
 		data = buf + QMI_SERVICE_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
 
-		tid = GUINT16_FROM_LE(service->transaction);
+		tid = L_LE16_TO_CPU(service->transaction);
 
 		if (service->type == 0x04) {
 			handle_indication(device, hdr->service, hdr->client,
@@ -818,7 +818,7 @@ static void handle_packet(struct qmi_device *device,
 
 		req = l_queue_remove_if(device->service_queue,
 						__request_compare,
-						GUINT_TO_POINTER(tid));
+						L_UINT_TO_PTR(tid));
 	}
 
 	if (!req)
@@ -864,7 +864,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		if (hdr->frame != 0x01 || hdr->flags != 0x80)
 			break;
 
-		len = GUINT16_FROM_LE(hdr->length) + 1;
+		len = L_LE16_TO_CPU(hdr->length) + 1;
 
 		/* Check that packet size matches frame size */
 		if (bytes_read - offset < len)
@@ -1027,7 +1027,7 @@ void qmi_result_print_tlvs(struct qmi_result *result)
 
 	while (len > QMI_TLV_HDR_SIZE) {
 		const struct qmi_tlv_hdr *tlv = ptr;
-		uint16_t tlv_length = GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length = L_LE16_TO_CPU(tlv->length);
 
 		DBG("tlv: 0x%02x len 0x%04x", tlv->type, tlv->length);
 
@@ -1044,7 +1044,7 @@ static const void *tlv_get(const void *data, uint16_t size,
 
 	while (len > QMI_TLV_HDR_SIZE) {
 		const struct qmi_tlv_hdr *tlv = ptr;
-		uint16_t tlv_length = GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length = L_LE16_TO_CPU(tlv->length);
 
 		if (tlv->type == type) {
 			if (length)
@@ -1185,9 +1185,9 @@ static void discover_callback(uint16_t message, uint16_t length,
 
 	for (i = 0; i < service_list->count; i++) {
 		uint16_t major =
-			GUINT16_FROM_LE(service_list->services[i].major);
+			L_LE16_TO_CPU(service_list->services[i].major);
 		uint16_t minor =
-			GUINT16_FROM_LE(service_list->services[i].minor);
+			L_LE16_TO_CPU(service_list->services[i].minor);
 		uint8_t type = service_list->services[i].type;
 		const char *name = __service_type_to_string(type);
 
@@ -1244,12 +1244,12 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 
 	if (_tid != 0) {
 		req = l_queue_remove_if(device->req_queue, __request_compare,
-						GUINT_TO_POINTER(_tid));
+						L_UINT_TO_PTR(_tid));
 
 		if (!req)
 			req = l_queue_remove_if(device->control_queue,
 							__request_compare,
-							GUINT_TO_POINTER(_tid));
+							L_UINT_TO_PTR(_tid));
 	}
 
 	return req;
@@ -1423,7 +1423,7 @@ static char *get_device_interface(struct qmi_device *device)
 
 	file_name = basename(file_path);
 
-	for (i = 0; i < G_N_ELEMENTS(driver_names) && !interface; i++) {
+	for (i = 0; i < L_ARRAY_SIZE(driver_names) && !interface; i++) {
 		gchar *sysfs_path;
 
 		sysfs_path = l_strdup_printf("/sys/class/%s/%s/device/net/",
@@ -1687,7 +1687,7 @@ bool qmi_param_append(struct qmi_param *param, uint8_t type,
 	tlv = ptr + param->length;
 
 	tlv->type = type;
-	tlv->length = GUINT16_TO_LE(length);
+	tlv->length = L_CPU_TO_LE16(length);
 	memcpy(tlv->value, data, length);
 
 	param->data = ptr;
@@ -1851,7 +1851,7 @@ bool qmi_result_get_int16(struct qmi_result *result, uint8_t type,
 	memcpy(&tmp, ptr, 2);
 
 	if (value)
-		*value = GINT16_FROM_LE(tmp);
+		*value = L_LE16_TO_CPU(tmp);
 
 	return true;
 }
@@ -1872,7 +1872,7 @@ bool qmi_result_get_uint16(struct qmi_result *result, uint8_t type,
 	memcpy(&tmp, ptr, 2);
 
 	if (value)
-		*value = GUINT16_FROM_LE(tmp);
+		*value = L_LE16_TO_CPU(tmp);
 
 	return true;
 }
@@ -1894,7 +1894,7 @@ bool qmi_result_get_uint32(struct qmi_result *result, uint8_t type,
 	memcpy(&tmp, ptr, 4);
 
 	if (value)
-		*value = GUINT32_FROM_LE(tmp);
+		*value = L_LE32_TO_CPU(tmp);
 
 	return true;
 }
@@ -1916,7 +1916,7 @@ bool qmi_result_get_uint64(struct qmi_result *result, uint8_t type,
 	memcpy(&tmp, ptr, 8);
 
 	if (value)
-		*value = GUINT64_FROM_LE(tmp);
+		*value = L_LE64_TO_CPU(tmp);
 
 	return true;
 }
@@ -1972,7 +1972,7 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
 						struct qmi_service *service)
 {
-	gpointer key = GUINT_TO_POINTER(type | 0x80000000);
+	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
 	GList **shared = l_hashmap_remove(device->service_list, key);
 	GList *l;
 
@@ -2058,7 +2058,7 @@ static void service_create_callback(uint16_t message, uint16_t length,
 
 	hash_id = service->type | (service->client_id << 8);
 
-	l_hashmap_replace(device->service_list, GUINT_TO_POINTER(hash_id),
+	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
 				service, (void **) &old_service);
 
 	if (old_service)
@@ -2119,7 +2119,7 @@ static bool service_create(struct qmi_device *device,
 
 	/* Mark service creation as pending */
 	l_hashmap_insert(device->service_list,
-			GUINT_TO_POINTER(type_val | 0x80000000), shared);
+			L_UINT_TO_PTR(type_val | 0x80000000), shared);
 
 	return true;
 }
@@ -2154,7 +2154,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		return false;
 
 	l = l_hashmap_lookup(device->service_list,
-				GUINT_TO_POINTER(type_val | 0x80000000));
+				L_UINT_TO_PTR(type_val | 0x80000000));
 
 	if (!l) {
 		/*
@@ -2249,7 +2249,7 @@ void qmi_service_unref(struct qmi_service *service)
 	hash_id = service->type | (service->client_id << 8);
 
 	l_hashmap_remove(service->device->service_list,
-				GUINT_TO_POINTER(hash_id));
+				L_UINT_TO_PTR(hash_id));
 
 	service->device->release_users++;
 
@@ -2313,8 +2313,8 @@ static void service_send_callback(uint16_t message, uint16_t length,
 	if (len != QMI_RESULT_CODE_SIZE)
 		goto done;
 
-	result.result = GUINT16_FROM_LE(result_code->result);
-	result.error = GUINT16_FROM_LE(result_code->error);
+	result.result = L_LE16_TO_CPU(result_code->result);
+	result.error = L_LE16_TO_CPU(result_code->error);
 
 done:
 	if (data->func)
@@ -2379,11 +2379,11 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 		return false;
 
 	req = l_queue_remove_if(device->req_queue, __request_compare,
-					GUINT_TO_POINTER(tid));
+					L_UINT_TO_PTR(tid));
 	if (!req) {
 		req = l_queue_remove_if(device->service_queue,
 						__request_compare,
-						GUINT_TO_POINTER(tid));
+						L_UINT_TO_PTR(tid));
 		if (!req)
 			return false;
 	}
@@ -2398,7 +2398,7 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 static bool remove_req_if_match(void *data, void *user_data)
 {
 	struct qmi_request *req = data;
-	uint8_t client = GPOINTER_TO_UINT(user_data);
+	uint8_t client = L_PTR_TO_UINT(user_data);
 
 	if (!req->client || req->client != client)
 		return false;
@@ -2412,7 +2412,7 @@ static bool remove_req_if_match(void *data, void *user_data)
 static void remove_client(struct l_queue *queue, uint8_t client)
 {
 	l_queue_foreach_remove(queue, remove_req_if_match,
-				GUINT_TO_POINTER(client));
+				L_UINT_TO_PTR(client));
 }
 
 bool qmi_service_cancel_all(struct qmi_service *service)
@@ -2470,7 +2470,7 @@ bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 		return false;
 
 	list = g_list_find_custom(service->notify_list,
-				GUINT_TO_POINTER(nid), __notify_compare);
+				L_UINT_TO_PTR(nid), __notify_compare);
 	if (!list)
 		return false;
 
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
