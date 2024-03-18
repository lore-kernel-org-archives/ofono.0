Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E05579D
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788385; cv=none; b=V3iYf0Yr3nQd7LyZllM2AYl2hXG32xbynykOZFXAs0FVGQmaM0sdyPWBk86T6Rn7xYH+oEjpRQ44QZB4VmuaIf25rLn2sAWeHpRozI6kqfbDGG95iC1AFvIhEd3jGq1bIEGoKQU0+NsGot/HvoML0gW8aT9qjylRRPVhcZxCbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788385; c=relaxed/simple;
	bh=zzHnNA+xkCpL76k9+Gmd8XMykna+lALwtXMoFvH+ctg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JyXEt6mnCend/6aVETnaXvJ8lqU/e855i6XSUyFTXZB0rt5SXnfxcDNx34x+WNHundNCK2IX96CcCiik0wPAJJrKzysomHjTlq740mCgGGBfWKO7zLeVKItE+Kyufik84MuSad674lKYtzlCRcfD1zO6N4ZrblEMO3F+2cFiQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=MqPXeXsd; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=q7TRAT/B; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="MqPXeXsd";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="q7TRAT/B"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ICbku1002187
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=cs9p1cL/rZIsbibDtqAPQTWyzcPHwDtkrD7ZXGzh90Q=; b=M
	qPXeXsdF804U4/QswsGYuNghBjHHHgPN0yEbcmDB7uqGeHWXk4qoJJZdqRmrUyUq
	nA+2xzGodREFovc/yyajRZWie6qy24FfNAD6B3NC6zPdgnjzHJvr9TnmM8sHsnc+
	VNVrbSiE5iK100hFYx1p4h94G43FXzOAG61dcMkekJJyXJIO5cInRFXHfAYAwQst
	WMcGoe3Lic3lkwgqUobhfDCJpOu6EqeZ/zfXI9QVQ9lh7tD2NaCiYJisRTZ5jXWu
	ieYBfP0B0tjBdrWlhpzWeQDM2imWbbbau2Sat9ULG7ou9XsB9POF0TLLwALKNokA
	EHZcONG3F4zExpm/u9png==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wwayxhauv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:17 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso304085239f.3
        for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710787096; x=1711391896; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cs9p1cL/rZIsbibDtqAPQTWyzcPHwDtkrD7ZXGzh90Q=;
        b=q7TRAT/BdAO5X4OEdveLI2NmSm0cEV1lIK8ZiqzOqHeUOsPZopPZQfj9GjAYkVn8ZE
         MOGEaJQ7r1u5uOCUTgSKPU/euLTHkJMp4CTWMSRdDUfkHGLYJwMBXQyU0VsgQiC7hQYK
         NmMv06MKPiJ7rMg7KSFhdx/f+pDsCPh3e21uAFQq71uf65uAc4bhSh3Lb3zYFTpPyoeo
         NA6q1a0xkfaHwFLfXK1KVrWZDn4NIt5/JhsL3xUcJ22TCMQ1C33vcM6uZyolNWvsZOKn
         2Qv26GAz3kNfMKM+tUA3SmiRwFwoozhut5aqx0Oj1bKW6H/t1FhsTor3bLiQlYJzUs/S
         7bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787096; x=1711391896;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cs9p1cL/rZIsbibDtqAPQTWyzcPHwDtkrD7ZXGzh90Q=;
        b=BjcVtUeje33PHqXx8Evvs44XRm5ZvSavc/8Otgtm7k3wUCq3+ggqIK147DyhBN6Sn5
         Zm2vfBSP+3V78FR06wonh509ye+8IQdEI0gKrfHXgMSGoku8Y/ngsHGjxsGMoEUjy4R5
         tFv/lMX9lT9R0oGCnAB8a+lvsA365gffiavddBV7AEVWF5Nkdotwf4gy8gUF7dFIdXQm
         Saapx8Vs2RHSVrsQWw+fpXlQKgmSWYcoi8yDoz4uunVYPA0CPKayfzu5E9cpHTWXwMcz
         HaimS20ix7KBKC73MteeitfoA1SWtW6GXR/QkksFuCH9NfifsWCOCiGBeTtJILsL5zhN
         YXag==
X-Gm-Message-State: AOJu0YwJxa4/7Zp+xUdc64jURH51fZ67p25/pfwaXHN1wUUMS8mjpZ4d
	fLfqc6gBLBAPstvd5un6TGWnIhx4b9HpOJdVmEHeGfYeFZkB7o8piTIU2PAM4pqVFrxMxM9Kkb8
	WZ1pK4YdPp40tMGXbEhRpg0XFB8FTrfvzS+HrW82oriRfrnqNixUiF66e64w8N63vmBEy7zn9NO
	D7wN6A8BwkuIrCvMy0m2afVEgmnH64dku1T2MKvcyiZ0CiS3o=
X-Received: by 2002:a6b:7301:0:b0:7cc:25b:55ea with SMTP id e1-20020a6b7301000000b007cc025b55eamr239969ioh.13.1710787096442;
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG18wCNYmlAHUf8FTk5T/CTzDSyD0jxBeqH7h1u7gJaDLDM3bRdBBCMYTrBU14/hTFiu2r82Q==
X-Received: by 2002:a6b:7301:0:b0:7cc:25b:55ea with SMTP id e1-20020a6b7301000000b007cc025b55eamr239948ioh.13.1710787096057;
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-768618.corp.robot.car (133.199.192.35.bc.googleusercontent.com. [35.192.199.133])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d9f06000000b007cc6af6686esm873477iot.30.2024.03.18.11.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:38:15 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/3] qmi: Discover timeout could cause a crash
Date: Mon, 18 Mar 2024 13:37:46 -0500
Message-ID: <20240318183754.71578-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: LrBWgI4bTD5fkMZSSP5nokMu5sFejVue
X-Proofpoint-GUID: LrBWgI4bTD5fkMZSSP5nokMu5sFejVue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180141

Sometimes the QRTR discover timeout would occur simply because the
control packets are being processed slowly. Handle this by extending
the timeout each time a service is discovered. Then ensure the
discover data on the queue exists before processing it, just in
case there was an actual timeout.
---
 drivers/qmimodem/qmi.c | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3408c32a657d..6eda68d7a571 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -43,6 +43,9 @@
 #include "qmi.h"
 #include "ctl.h"
 
+
+#define DISCOVER_TIMEOUT 5
+
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 
@@ -1660,8 +1663,9 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 						qmux_discover_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
-	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
-								data, NULL);
+	data->timeout = l_timeout_create(DISCOVER_TIMEOUT,
+						qmux_discover_reply_timeout,
+						data, NULL);
 
 	__qmi_device_discovery_started(device, &data->super);
 
@@ -2017,6 +2021,8 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 						const void *buf, size_t len)
 {
 	const struct qrtr_ctrl_pkt *packet = buf;
+	struct discover_data *data;
+	struct qmi_service_info info;
 	uint32_t cmd;
 	uint32_t type;
 	uint32_t instance;
@@ -2038,14 +2044,16 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 		return;
 	}
 
+	data = l_queue_peek_head(device->discovery_queue);
+
 	if (!packet->server.service && !packet->server.instance &&
 			!packet->server.node && !packet->server.port) {
-		struct discover_data *data;
-
 		DBG("Initial service discovery has completed");
 
-		data = l_queue_peek_head(device->discovery_queue);
-		DISCOVERY_DONE(data, data->user_data);
+		if (data)
+			DISCOVERY_DONE(data, data->user_data);
+		else
+			DBG("discovery_queue is empty"); /* likely a timeout */
 
 		return;
 	}
@@ -2057,21 +2065,24 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 	node = L_LE32_TO_CPU(packet->server.node);
 	port = L_LE32_TO_CPU(packet->server.port);
 
-	if (cmd == QRTR_TYPE_NEW_SERVER) {
-		struct qmi_service_info info;
+	DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d",
+		type, version, instance, node, port);
 
-		DBG("New server: Type: %d Version: %d Instance: %d Node: %d Port: %d",
-			type, version, instance, node, port);
+	memset(&info, 0, sizeof(info));
+	info.service_type = type;
+	info.qrtr_port = port;
+	info.qrtr_node = node;
+	info.major = version;
+	info.instance = instance;
 
-		memset(&info, 0, sizeof(info));
-		info.service_type = type;
-		info.qrtr_port = port;
-		info.qrtr_node = node;
-		info.major = version;
-		info.instance = instance;
+	__qmi_service_appeared(device, &info);
 
-		__qmi_service_appeared(device, &info);
+	if (!data) {
+		DBG("discovery_queue is empty"); /* likely a timeout */
+		return;
 	}
+
+	l_timeout_modify(data->timeout, DISCOVER_TIMEOUT);
 }
 
 static void qrtr_received_service_message(struct qmi_device *device,
@@ -2206,8 +2217,9 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 	l_util_hexdump(false, &packet, bytes_written,
 			device->debug_func, device->debug_data);
 
-	data->timeout = l_timeout_create(5, qrtr_discover_reply_timeout,
-								data, NULL);
+	data->timeout = l_timeout_create(DISCOVER_TIMEOUT,
+						qrtr_discover_reply_timeout,
+						data, NULL);
 
 	__qmi_device_discovery_started(device, &data->super);
 
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
