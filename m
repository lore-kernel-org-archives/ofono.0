Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5C55787
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326191; cv=none; b=Y7Tz6oz4Uy/NiePrnCELMwuZ1FiV6vv8i6xHDAmQ5L4nIdwfgeKIXvgpbEzqrgPt6q186MoAzP6676YqMzYOmaSAffR7T1B3xkIY7/J20mewxdg+tpbX7G6XvzqmKQx8AmH1J1aKFD0QLrM41h3DLR03yryf1FmHP2Mp3mOzkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326191; c=relaxed/simple;
	bh=v32FdwnFdFQGcwO0Ly6X55qBG37DYHE2h1IQUhxCLfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5uyyDBAOS24xxg0XBxvI16eEV3szA3/Let8qlpLADUDfPhymbaLK7hjjv8pT97QWhV7nAmDh69USF4H/aZZ2odLdQSifhljEgmfmZ+Z+9LSXwMt9mUatluelUxuC08vtj42uh2yKSLLFcfY/C58hsCneRAcpC+/5QzAkJWQ4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=gpxIxa7Z; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=V9tpFdP2; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="gpxIxa7Z";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="V9tpFdP2"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421H8f8X003294
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 12:49:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=o/XGZR5AhEuPvGO7LWFciT
	etMIsNkBXkD1tlFNthuS8=; b=gpxIxa7Z5pPjM0w2NgU9SjHb0jceWwcFTLfTYp
	2o0guBIUwLhWOpMsZQ8JhisraaiFZtG8255Vmwve7lJUH/5DMku9lfb5kpgJYimS
	2JurrHhoG8o3LYNhPjOD7Znq38FHkY8G/S29/KrN5z+jGKc5wYaQavOr+W+yb38O
	u0Y3MXvt3oVJRtDq2ZJc1LouDPRLrQoeZXc4p6/waunWs4WOQjgdl5GQpmj0IT4y
	Gpn19A1KmVkPCwpni+V1F+o5iJSJzZiUCunexLr/RGIpQ0OwZ8ilEZ1ysf1pRCfW
	/fD87KkW44lAmfjKBRUBhlntxv6n7q6gobqsQM6/byg52FFA==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wkk5mr85n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:42 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3653092aee9so28218315ab.0
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709326181; x=1709930981; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/XGZR5AhEuPvGO7LWFciTetMIsNkBXkD1tlFNthuS8=;
        b=V9tpFdP2s1H+NTuoQTBepWOY3RxFbfxITQK1GFhVDdRmfLEfzqvQUJmmFNVo9D49ii
         B8o3vk9mgX2IcjY2YeCMBnmDdU4Uwka3xZpqt+uHmhEX1U4bfvBhU05e9PrnanTAqSNg
         UAbekpctdU23dFPLSI0YQg+QQZxf0tIdKUxOFZAMaLDpxHcUzQV2+AunMiWuf7YsofNr
         eA1h5j5YR4wtPnpChTQBrLEYHpfZZNjQ73L+DLWXE1yQd/9i27EgD1uLyc+iEGz/WAMP
         S63iuuHdNPe6UmnaDbCuVrfVvJUNTbU79CSKJ3zEPNiUpqIN5rYDAmYtmWYzAdWLFZmw
         A81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709326181; x=1709930981;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/XGZR5AhEuPvGO7LWFciTetMIsNkBXkD1tlFNthuS8=;
        b=vH2HZ/9SWkBHlYfXRu1WybjNHCblD1Ps4QXhZTNJ7ZlaZQqicmpazqWRB144L/walp
         6M2rtW0wDxwBi9Eau3P2n+oYsusXdW+gmnK4dd+5erjFoFH0a+Jb/1thAhgns5k74E6H
         J3qjZk4gfwN5xw9vEQASB0ZywfTL1+GxJHw4tYDtAcW2k/6RgPLSbEfznf6LnGIcEJzY
         fCdJ3qeAxaDpcO/64e4/2NVbFHLa4jzUwm84WHsek4i6TjkrbVs4Owj7Qz6fhVy7muDo
         643dLFOgsq0lHG3AK7mvhligpmQOZ+mfhd4uePD2/cnFPWHciRi8eqMwz+cYQKJCvCLm
         ND0Q==
X-Gm-Message-State: AOJu0YyeZthc9db97vaZ1yO4gTVIysO+YYioI6/QBOsO4l75NHTd6Hbk
	EmuDPt3n3o9/CLfXW/ejgFAcbuny0Gyuxx+Cdsx5ZNungWhJ0DzLNy84IQRbcEXUm9evkD4yZAd
	4OWiDQLB6Ss/2ZKtFosyyPDztdpmNM74C0HACnoF3HNyxORAHvO4P9Feae8Hnwr8SdS3vlsd8dw
	BUxa8XavnM4O4t7JCjCBF2VkcW3c9Yxr1DgaIqiJm4xHqA7YeOaQ==
X-Received: by 2002:a05:6e02:1ca3:b0:365:aaca:d171 with SMTP id x3-20020a056e021ca300b00365aacad171mr3223803ill.31.1709326181595;
        Fri, 01 Mar 2024 12:49:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ2vGcKIHlrFKcZ/HLYe2DrA68E/G/2erkLCpwNbGcuuCjnhrNqFCZ+IcwA4ilxkT55BgyTw==
X-Received: by 2002:a05:6e02:1ca3:b0:365:aaca:d171 with SMTP id x3-20020a056e021ca300b00365aacad171mr3223792ill.31.1709326181209;
        Fri, 01 Mar 2024 12:49:41 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm1089407ilq.6.2024.03.01.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:49:40 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 3/3] qmi: Enable QRTR service writes and reads
Date: Fri,  1 Mar 2024 14:49:26 -0600
Message-ID: <20240301204929.87220-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301204929.87220-1-steve.schrock@getcruise.com>
References: <20240301204929.87220-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: ecETVJyi06A9LKyidC8y4NLKNzz1MTYK
X-Proofpoint-ORIG-GUID: ecETVJyi06A9LKyidC8y4NLKNzz1MTYK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_21,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010173

For simplicity the QRTR write method simply skips the QMUX
header. In the future it might make sense to add another ops
function that would allocate a larger buffer and populate
the QMUX header in the QMUX implementation.
---
 drivers/qmimodem/qmi.c | 282 +++++++++++++++++++++++++----------------
 1 file changed, 176 insertions(+), 106 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 349cead9..633a31c3 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -62,7 +62,7 @@ struct qmi_service_info {
 struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
-	uint8_t client;
+	uint8_t client;			/* Always 0 for control and qrtr */
 	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
@@ -216,8 +216,7 @@ static void __qmi_service_appeared(struct qmi_device *device,
 				l_memdup(info, sizeof(struct qmi_service_info)));
 }
 
-static struct qmi_request *__request_alloc(uint8_t service,
-				unsigned int group_id,
+static struct qmi_request *__request_alloc(uint32_t service_type,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
@@ -229,7 +228,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	uint16_t hdrlen = QMI_MUX_HDR_SIZE;
 	uint16_t msglen;
 
-	if (service == QMI_SERVICE_CONTROL)
+	if (service_type == QMI_SERVICE_CONTROL)
 		hdrlen += QMI_CONTROL_HDR_SIZE;
 	else
 		hdrlen += QMI_SERVICE_HDR_SIZE;
@@ -237,7 +236,6 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
 	req->tid = 0;
-	req->group_id = group_id;
 	req->len = msglen;
 	req->client = client;
 
@@ -246,7 +244,7 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	hdr->frame = 0x01;
 	hdr->length = L_CPU_TO_LE16(req->len - 1);
 	hdr->flags = 0x00;
-	hdr->service = service;
+	hdr->service = service_type; /* qmux service types are 8 bits */
 	hdr->client = client;
 
 	msg = (struct qmi_message_hdr *) &req->data[hdrlen];
@@ -267,21 +265,20 @@ static struct qmi_request *__control_request_alloc(uint16_t message,
 				const void *data, uint16_t length,
 				qmi_message_func_t func, void *user_data)
 {
-	return __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00, message,
+	return __request_alloc(QMI_SERVICE_CONTROL, 0x00, message,
 					data, length, func, user_data);
 
 }
 
 static struct qmi_request *__service_request_alloc(
 				struct qmi_service_info *info,
-				unsigned int service_id, uint8_t client,
-				uint16_t message,
+				uint8_t client, uint16_t message,
 				const void *data, uint16_t length,
 				qmi_message_func_t func, void *user_data)
 {
 	struct qmi_request *req;
 
-	req = __request_alloc(info->service_type, service_id, client, message,
+	req = __request_alloc(info->service_type, client, message,
 						data, length, func, user_data);
 	memcpy(&req->info, info, sizeof(req->info));
 
@@ -530,94 +527,49 @@ int qmi_error_to_ofono_cme(int qmi_error)
 	}
 }
 
-static void __debug_msg(const char dir, const void *buf, size_t len,
-				qmi_debug_func_t function, void *user_data)
+static void __debug_msg(char dir, const struct qmi_message_hdr *msg,
+			uint32_t service_type, uint8_t transaction_type,
+			uint16_t tid, uint8_t client, uint16_t overall_length,
+			qmi_debug_func_t function, void *user_data)
 {
-	const struct qmi_mux_hdr *hdr;
-	const struct qmi_message_hdr *msg;
 	const char *service;
-	const void *ptr;
+	const void *ptr = ((const void *) msg) + QMI_MESSAGE_HDR_SIZE;
 	uint16_t offset;
 	char strbuf[72 + 16], *str;
 	bool pending_print = false;
+	const char *transaction_type_string;
 
-	if (!function || !len)
+	if (!function)
 		return;
 
-	hdr = buf;
-
 	str = strbuf;
-	service = __service_type_to_string(hdr->service);
+	service = __service_type_to_string(service_type);
 	if (service)
 		str += sprintf(str, "%c   %s", dir, service);
 	else
-		str += sprintf(str, "%c   %d", dir, hdr->service);
-
-	if (hdr->service == QMI_SERVICE_CONTROL) {
-		const struct qmi_control_hdr *ctl;
-		const char *type;
-
-		ctl = buf + QMI_MUX_HDR_SIZE;
-		msg = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE;
-		ptr = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE +
-							QMI_MESSAGE_HDR_SIZE;
+		str += sprintf(str, "%c   %d", dir, service_type);
 
-		switch (ctl->type) {
-		case 0x00:
-			type = "_req";
-			break;
-		case 0x01:
-			type = "_resp";
-			break;
-		case 0x02:
-			type = "_ind";
-			break;
-		default:
-			type = "";
-			break;
-		}
-
-		str += sprintf(str, "%s msg=%d len=%d", type,
-					L_LE16_TO_CPU(msg->message),
-					L_LE16_TO_CPU(msg->length));
-
-		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
-					hdr->client, ctl->type,
-					ctl->transaction,
-					L_LE16_TO_CPU(hdr->length));
-	} else {
-		const struct qmi_service_hdr *srv;
-		const char *type;
-
-		srv = buf + QMI_MUX_HDR_SIZE;
-		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
-		ptr = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE +
-							QMI_MESSAGE_HDR_SIZE;
-
-		switch (srv->type) {
-		case 0x00:
-			type = "_req";
-			break;
-		case 0x02:
-			type = "_resp";
-			break;
-		case 0x04:
-			type = "_ind";
-			break;
-		default:
-			type = "";
-			break;
-		}
+	switch (transaction_type) {
+	case 0x00:
+		transaction_type_string = "_req";
+		break;
+	case 0x01:
+		transaction_type_string = "_resp";
+		break;
+	case 0x02:
+		transaction_type_string = "_ind";
+		break;
+	default:
+		transaction_type_string = "";
+		break;
+	}
 
-		str += sprintf(str, "%s msg=%d len=%d", type,
-					L_LE16_TO_CPU(msg->message),
-					L_LE16_TO_CPU(msg->length));
+	str += sprintf(str, "%s msg=%d len=%d", transaction_type_string,
+				L_LE16_TO_CPU(msg->message),
+				L_LE16_TO_CPU(msg->length));
 
-		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
-					hdr->client, srv->type,
-					L_LE16_TO_CPU(srv->transaction),
-					L_LE16_TO_CPU(hdr->length));
-	}
+	str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
+				client, transaction_type, tid, overall_length);
 
 	function(strbuf, user_data);
 
@@ -667,6 +619,61 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 		function(strbuf, user_data);
 }
 
+static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
+				qmi_debug_func_t function, void *user_data)
+{
+	const struct qmi_mux_hdr *hdr;
+	const struct qmi_message_hdr *msg;
+	uint8_t transaction_type;
+	uint16_t tid;
+
+	if (!len)
+		return;
+
+	hdr = buf;
+
+	if (hdr->service == QMI_SERVICE_CONTROL) {
+		const struct qmi_control_hdr *ctl;
+
+		ctl = buf + QMI_MUX_HDR_SIZE;
+		msg = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE;
+
+		transaction_type = ctl->type;
+		tid = ctl->transaction;
+	} else {
+		const struct qmi_service_hdr *srv;
+
+		srv = buf + QMI_MUX_HDR_SIZE;
+		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
+
+		transaction_type = srv->type;
+		tid = L_LE16_TO_CPU(srv->transaction);
+	}
+
+	__debug_msg(dir, msg, hdr->service, transaction_type, tid, hdr->client,
+			L_LE16_TO_CPU(hdr->length), function, user_data);
+}
+
+static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
+				uint16_t service_type,
+				qmi_debug_func_t function, void *user_data)
+{
+	const struct qmi_service_hdr *srv;
+	const struct qmi_message_hdr *msg;
+	uint16_t tid;
+
+	if (!len)
+		return;
+
+	srv = buf;
+	msg = buf + QMI_SERVICE_HDR_SIZE;
+
+	tid = L_LE16_TO_CPU(srv->transaction);
+
+	__debug_msg(dir, msg, service_type, srv->type, tid, 0, len,
+						function, user_data);
+}
+
 static void __debug_device(struct qmi_device *device,
 					const char *format, ...)
 {
@@ -723,13 +730,15 @@ static void wakeup_writer(struct qmi_device *device)
 	device->writer_active = true;
 }
 
-static uint16_t __request_submit(struct qmi_device *device,
-				struct qmi_request *req)
+static uint16_t __service_request_submit(struct qmi_device *device,
+						struct qmi_service *service,
+						struct qmi_request *req)
 {
 	struct qmi_service_hdr *hdr =
 		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 
 	req->tid = device->next_service_tid++;
+	req->group_id = service->group_id;
 
 	if (device->next_service_tid < 256)
 		device->next_service_tid = 256;
@@ -772,7 +781,7 @@ static unsigned int service_list_create_hash(uint16_t service_type,
 }
 
 static void handle_indication(struct qmi_device *device,
-			uint8_t service_type, uint8_t client_id,
+			uint32_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
 	struct qmi_service *service;
@@ -805,7 +814,7 @@ static void handle_indication(struct qmi_device *device,
 }
 
 static void __rx_message(struct qmi_device *device,
-				uint8_t service_type, uint8_t client_id,
+				uint32_t service_type, uint8_t client_id,
 				const void *buf)
 {
 	const struct qmi_service_hdr *service = buf;
@@ -1284,7 +1293,7 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 	l_util_hexdump(false, req->data, bytes_written,
 			device->debug_func, device->debug_data);
 
-	__debug_msg(' ', req->data, bytes_written,
+	__qmux_debug_msg(' ', req->data, bytes_written,
 				device->debug_func, device->debug_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
@@ -1371,7 +1380,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		if (bytes_read - offset < len)
 			break;
 
-		__debug_msg(' ', buf + offset, len,
+		__qmux_debug_msg(' ', buf + offset, len,
 				qmux->super.debug_func, qmux->super.debug_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
@@ -1945,6 +1954,48 @@ struct qmi_device_qrtr {
 	struct l_idle *shutdown_idle;
 };
 
+static int qmi_device_qrtr_write(struct qmi_device *device,
+					struct qmi_request *req)
+{
+	struct sockaddr_qrtr addr;
+	uint8_t *data;
+	uint16_t len;
+	socklen_t addr_len = sizeof(addr);
+	int rc;
+	ssize_t bytes_written;
+	int fd = l_io_get_fd(device->io);
+
+	/* Skip the QMUX header */
+	data = req->data + QMI_MUX_HDR_SIZE;
+	len = req->len - QMI_MUX_HDR_SIZE;
+
+	rc = getsockname(fd, (struct sockaddr *) &addr, &addr_len);
+	if (rc != 0) {
+		DBG("getsockname failed: %s", strerror(errno));
+		return -errno;
+	}
+
+	addr.sq_node = req->info.qrtr_node;
+	addr.sq_port = req->info.qrtr_port;
+	bytes_written = sendto(fd, data, len, 0, (struct sockaddr *) &addr,
+							addr_len);
+	if (bytes_written < 0) {
+		DBG("Failure sending data: %s", strerror(errno));
+		return -errno;
+	}
+
+	l_util_hexdump(false, data, bytes_written,
+			device->debug_func, device->debug_data);
+
+	__qrtr_debug_msg(' ', data, bytes_written,
+			req->info.service_type, device->debug_func,
+			device->debug_data);
+
+	l_queue_push_tail(device->service_queue, req);
+
+	return 0;
+}
+
 static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 					qmi_debug_func_t function,
 					void *user_data)
@@ -1967,10 +2018,10 @@ static void qrtr_debug_ctrl_request(const struct qrtr_ctrl_pkt *packet,
 	function(strbuf, user_data);
 }
 
-static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
-					const struct qrtr_ctrl_pkt *packet)
+static void qrtr_received_control_packet(struct qmi_device *device,
+						unsigned char *buf, size_t len)
 {
-	struct qmi_device *device = &qrtr->super;
+	struct qrtr_ctrl_pkt *packet = (struct qrtr_ctrl_pkt *) buf;
 	uint32_t cmd;
 	uint32_t type;
 	uint32_t instance;
@@ -1978,6 +2029,11 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	uint32_t node;
 	uint32_t port;
 
+	if (len < sizeof(*packet)) {
+		DBG("qrtr packet is too small");
+		return;
+	}
+
 	qrtr_debug_ctrl_request(packet, device->debug_func,
 				device->debug_data);
 
@@ -2023,22 +2079,32 @@ static void qrtr_handle_control_packet(struct qmi_device_qrtr *qrtr,
 	}
 }
 
-static void qrtr_handle_packet(struct qmi_device_qrtr *qrtr, uint32_t sending_port,
-				const void *buf, ssize_t len)
+static void qrtr_received_service_message(struct qmi_device *device,
+			uint32_t port, const unsigned char *buf, ssize_t len)
 {
-	const struct qrtr_ctrl_pkt *packet = buf;
+	const struct l_queue_entry *entry;
+	uint32_t service_type = 0;
 
-	if (sending_port != QRTR_PORT_CTRL) {
-		DBG("Receive of service data is not implemented");
-		return;
+	for (entry = l_queue_get_entries(device->service_infos);
+				entry; entry = entry->next) {
+		struct qmi_service_info *info = entry->data;
+
+		if (info->qrtr_port == port) {
+			service_type = info->service_type;
+			break;
+		}
 	}
 
-	if ((unsigned long) len < sizeof(*packet)) {
-		DBG("qrtr control packet is too small");
+	if (!service_type) {
+		DBG("Received packet from unknown service on port %d",
+			port);
 		return;
 	}
 
-	qrtr_handle_control_packet(qrtr, packet);
+	__qrtr_debug_msg(' ', buf, len, service_type,
+				device->debug_func, device->debug_data);
+
+	__rx_message(device, service_type, 0, buf);
 }
 
 static bool qrtr_received_data(struct l_io *io, void *user_data)
@@ -2052,7 +2118,7 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(qrtr->super.io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
-	DBG("Received %zd bytes from Node: %d Port: 0x%x", bytes_read,
+	DBG("Received %zd bytes from Node: %d Port: %d", bytes_read,
 		addr.sq_node, addr.sq_port);
 
 	if (bytes_read < 0)
@@ -2061,7 +2127,11 @@ static bool qrtr_received_data(struct l_io *io, void *user_data)
 	l_util_hexdump(true, buf, bytes_read, qrtr->super.debug_func,
 			qrtr->super.debug_data);
 
-	qrtr_handle_packet(qrtr, addr.sq_port, buf, bytes_read);
+	if (addr.sq_port == QRTR_PORT_CTRL)
+		qrtr_received_control_packet(&qrtr->super, buf, bytes_read);
+	else
+		qrtr_received_service_message(&qrtr->super, addr.sq_port,
+							buf, bytes_read);
 
 	return true;
 }
@@ -2162,7 +2232,7 @@ static void qmi_device_qrtr_destroy(struct qmi_device *device)
 }
 
 static const struct qmi_device_ops qrtr_ops = {
-	.write = NULL,
+	.write = qmi_device_qrtr_write,
 	.discover = qmi_device_qrtr_discover,
 	.client_create = NULL,
 	.client_release = NULL,
@@ -2712,7 +2782,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __service_request_alloc(&service->info, service->group_id,
+	req = __service_request_alloc(&service->info,
 					service->client_id, message,
 					param ? param->data : NULL,
 					param ? param->length : 0,
@@ -2720,7 +2790,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 
 	qmi_param_free(param);
 
-	tid = __request_submit(device, req);
+	tid = __service_request_submit(device, service, req);
 
 	return tid;
 }
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
