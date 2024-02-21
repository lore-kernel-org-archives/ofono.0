Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63284A1D
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553927; cv=none; b=ZiwWg7EqMQLfkK6M8adFjlJSVdodLdhw/0p5SPIVzxpblyAQc265aSAwsOA3ciZaeXOD7DrqIAZ83as1zsvN0YS7qV+uUFOfOhbPpmzj1otGEksesGRSyicfd1rlDeH0GjnjVme23SDD5Qq+RA86BNF0iCZogX0xb0l9mHpuUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553927; c=relaxed/simple;
	bh=44uUTdUYrFFhoo2p/+W3DjT5KxVPP3UerMDQquKt+0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJMokxJX4X4Bfy7PDr5a5XuyFkYQ+e62ZzGMKvUvqFgg80znI7WobIqyvvPL1keQtDLvWjt+xFbFqHxqYvwvkbQyyBpiOJEalY1QBUQhwwaWkqbodmvtb++jlcZiPv3Z9WXtFQsO3NLSLE2zrdWB13TF/yAvgL2ebJQLLnRjw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JpWBDI/a; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=pWFtn0fS; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JpWBDI/a";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="pWFtn0fS"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEjNAc018898
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=CzASE58b3pdGttu0/4S1tA
	SkjVB2JL9ItqfqsLJBfNE=; b=JpWBDI/aTa7QmbVUg+YDD+M8A8HxYb79Qj1i3L
	eF6eyvoJJ0Iv6s3FIJsMO53BzF94jTHf+lp+rFVzi8AvqUp60yMVF2iKUG71KUFe
	YcHyV0cYFcvHrg/BuFtlKbsnEUaZ5vnQcmBmqrUX+yC5yXqXD84cydcSSR+4Mzwk
	kgIDefOU0hKj1ATriww0thQxdYlSOMtLgem3fmQEz1cw6VKoi3qvoF309z6sshf/
	PVo8SRIqpjMUv2hPZBmYGTYm5zShyBZEYeA47xZMEuqnStvUADYWUbFfFF+aPNEy
	XwRm7AGFSZKtoTEPm5/tLLXe8iTvxbxEVCcHgjXY03zidu6w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563s2pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:44 -0800 (PST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f75058f07so14247156d6.0
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553923; x=1709158723; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzASE58b3pdGttu0/4S1tASkjVB2JL9ItqfqsLJBfNE=;
        b=pWFtn0fS79dsUponW+8E++niKj52XcyMXy9BkciJf94rICaKXkO4UC+Eo5+L8WUL5B
         j/xtoIu9vlneCAdJ93/gh/iz/ISGrNlZXFfWCUJu+en5PeWE1azX/6Wv9FE7zzlL0qh9
         i41lZ4RGmXUFPTKzUAW4dRqJhz/YefAUNhUGd1prSTQViwIpgn4EFL1jQds/clC/5g/N
         KzehIV9Fo2KW3+1RVzYCs8ab2a46giUbRzTqp0LZTiWDag4AUT/7i4XYPsYRbZbBBuZj
         ZRgrsAC6y2IX1MuvJ7MTVFE6PPUBj1RodPgkc1cSOG0dK0Q63mG3L2KzAVEP9lIHCOQX
         74tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553923; x=1709158723;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzASE58b3pdGttu0/4S1tASkjVB2JL9ItqfqsLJBfNE=;
        b=woTL6yzVV67yj5cGN9Phzy5h5udLyHqF0LOhrcxdR+RUml725vbrTpM9WteNsG2GFf
         fjiLk3DCp6dbV9vwKOZ4r+l4oV0WHQiojVNldVC44aLuLnaFjyyylnEPVikS8KC9JhXV
         VrXGppojM/KzZ6VMuK/VpcVkz/gT+BYUPJ/9cwkHq9ce9wabStI4snRcpwwVqtOCQ0xs
         UG2GFj0eIBccMSCtnQmX7uoyirIbbOAmi8Y5J7vbNwezXJxupl/NOJtcnTTGw5hrImmK
         KKxWoYP+U41rgHoTpHpitmEO0bcx4hSq9dWFEXyduNX0Mksk8UWmn+xTaJZQbLMM4UeK
         75pQ==
X-Gm-Message-State: AOJu0YzjaIHpzryrskOLJ4oby6VGJ1hlOAfzAIr3SWCRs95JD2l0AAlQ
	MKrYhuD+fmab+TpMwk8qCsf2JC1htW9tFZdVG79woywQIzq9iPUXHpNFOOKp+/55Y7JW+80cjSs
	4MoCim6mwzkDgNSnwA9i0+pRur5LanO7WWOGsOkpt5AqrRLmhM+eVjUxZdNOyB1smE8DewYAggU
	um8hThufv5+k01Y+vxKWJhNhukovzG3WajOPvlD0YBqsM9nlM=
X-Received: by 2002:a0c:db8f:0:b0:68f:8cc5:a26a with SMTP id m15-20020a0cdb8f000000b0068f8cc5a26amr5578115qvk.21.1708553923028;
        Wed, 21 Feb 2024 14:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESJ17+YHwFjFWd6UzcGgQI2nvhUlNuDCnYTGFJup4S9h/wQgNNNBYpC8QHnzBnChMsvaFfSg==
X-Received: by 2002:a0c:db8f:0:b0:68f:8cc5:a26a with SMTP id m15-20020a0cdb8f000000b0068f8cc5a26amr5578097qvk.21.1708553922559;
        Wed, 21 Feb 2024 14:18:42 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:41 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 5/6] qmimodem: Eliminate glib macros
Date: Wed, 21 Feb 2024 22:17:24 +0000
Message-Id: <20240221221725.185480-5-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221221725.185480-1-steve.schrock@getcruise.com>
References: <20240221221725.185480-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 4PzoEbzzp0tW0P3a5nQwP_JhKEezppOn
X-Proofpoint-GUID: 4PzoEbzzp0tW0P3a5nQwP_JhKEezppOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210175

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
