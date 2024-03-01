Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A45EE64
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336755; cv=none; b=hU8afWH+FrKbxqhN3fWgfq37Y+nZqMRIo1uQyiro9TJv+lhLVWsyyOf/ItPpTRbVWOfdX2a61TYYFI6oCV892CO/G5AMi2XHMBwz4TM7o4FVKzX8dx0YgtTAKgKBvy6oB6RPHZC+mfvcWizk8ZNq/LpIaGxX5XKc/KLmi4hT068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336755; c=relaxed/simple;
	bh=KdyoEURJLvexlSecaodikI+afQxJ+Eka8oMRBUnQ/FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU7SawDYSkNfCpzeR+LV5Vep4R3+iC+oG/kd6kQyBXg9lYevw/9Dtd+sWUB9YPaWxkTPEkxSoVjVYTRpdRB3IS2zb20tSWykD7OBjFQOTFzfi1FRbdQfeLALoPbEc4BYQtrtuq0z0Ces8dbCMcjGMXpOD0N5hzABn4EIqxruGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=icQxkPD8; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lVs2hSIZ; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="icQxkPD8";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lVs2hSIZ"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421FWGn3009998
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 15:45:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=LfvOTbDRdyK6APQJzsz5j5
	UXNAaBgl7MAYAH3u946J4=; b=icQxkPD81UlfURnp//AUVUScf4YcbhnFsBFy8a
	JryYxNskL5hVQzafUomlS7dVh7DbRG9sXLgV25ecynMUm4YD0TZvYJ/e6jXcmqkX
	zc9PKb16mXwhxXZHq7OySCVaspLuaTO8xf2lu4SvB/lND8BKCmyFfbYLjhRkEzXj
	9aLfM+R81sZ4Hxm7WyQtpyShPQc7qtwbSq83m8KemdjVZw/72nWpwWiT5E7Tbjqs
	84pjoFJRScbaYBCporbHCtJoy4nk5HcLR0LDLGKY094NHptBTKcBdkSiaQQSTBT5
	Btf0g/0yydjj8s5Hoo+G2kD1cGwObSqs4JBT4GGq5qiJDsFA==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjxassed1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:52 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7ee7fa1caso298555039f.0
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709336751; x=1709941551; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfvOTbDRdyK6APQJzsz5j5UXNAaBgl7MAYAH3u946J4=;
        b=lVs2hSIZMDYq/SyS05Gg9/tMNyBVOkCwnQ2we1brcKE45Weu7F15+IhWwg2Cf4efjG
         4ZH44g0TOL/NQOgHzgobPLoV3ym6d1HtWGEgxaj4tdvGRisOio/n+cDWuH7HKZjDCE4E
         ggqS6TqmcUugBf+n9J38yYgB/Qh/It8BP3G7jlOo1wRcGmNTqBPBVjRAumxkVORoR4sl
         R1IIFrnQxq8ypNWenC2uwiHF82se++MTDPc4QC2sqigSwhgJcIQieGHWUFscep4s1x91
         F/qVgJgo419Xq8EfK7JxlXCTOcI+UA6db4xMuZhusFQR/LdpfyxctHl1jUkdtlWhi+8b
         EUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336751; x=1709941551;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfvOTbDRdyK6APQJzsz5j5UXNAaBgl7MAYAH3u946J4=;
        b=HkSd+p9NIePW2Oj+IUbf6z1DstnxqDhjKzLweY1a3gJtff4LWcRpDijgMK3aXgh64S
         ucR8baZRJmhCHlO9IJsJS2DjvR9HsqLkP96h99vKnd45RIiWBZMuU8xLDVmN06wmoxCF
         qUzflO7Pcnymln0fbB+8T0y3xObKCYoyv3ffKtKR75sx+QwmYXuDgOkWXT8iBjYH/hLn
         2LM5Vo+RJe8kV57yQ+2CCOV9EUt4+ZXPVK4cku4nUbhRK7u7h89TlHk4dpP9uBVgpgVO
         PTbiigoBKkP3TsrEhs9jq9lLXlHeKdgaMuAgtQWVAAjWMu41ICE/nwlPJe0PdhIo4Hsr
         Dtew==
X-Gm-Message-State: AOJu0YyTPtyQ7D7GSpa3/B9yz6CAIBZ34ehCEBd8vhavES54PLkPLTYO
	bYSbJDXRTs594kaiOWo7CwkvXZwQ8DrCDHBiJU8MVH+DxG1LQ0G9peHR8T1VXfqwPF8fmp/sXxK
	iAZl0mBx868TXkiJ3ySeNYxRA+rHVf37kNBaAgCrX1yKW9bYFjuGAbM5/H4APgOr26qNXZGElUL
	hUm+5W6o1ArEswDMUD1dq1WB58aIh7bhJVJchF3gc8R3NgbV0=
X-Received: by 2002:a05:6e02:20c7:b0:363:c4b9:d931 with SMTP id 7-20020a056e0220c700b00363c4b9d931mr3764509ilq.20.1709336751012;
        Fri, 01 Mar 2024 15:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1VIBO0PH7aoYuQI6emgCQ2PjAa0xRRRNqHtrOAhsFrZzNtvqj9aTGEm+kizRBaEMxvJEdIw==
X-Received: by 2002:a05:6e02:20c7:b0:363:c4b9:d931 with SMTP id 7-20020a056e0220c700b00363c4b9d931mr3764498ilq.20.1709336750692;
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b00365bd7f608esm1137012ilo.40.2024.03.01.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v4 2/4] qmi: Store the service info in the request
Date: Fri,  1 Mar 2024 17:45:33 -0600
Message-ID: <20240301234539.1581017-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301234539.1581017-1-steve.schrock@getcruise.com>
References: <20240301234539.1581017-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: zQcpo7lpq38UQF-PzAbsfaEurXTYD-6k
X-Proofpoint-GUID: zQcpo7lpq38UQF-PzAbsfaEurXTYD-6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010195

QRTR will need this to write to the appropriate node and port.
While here create helper functions to simplify request allocation.
---
 drivers/qmimodem/qmi.c | 59 ++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 44d1738d..a2a715e9 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,6 +63,7 @@ struct qmi_request {
 	uint16_t tid;
 	unsigned int group_id;		/* Always 0 for control */
 	uint8_t client;
+	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
 	uint16_t len;
@@ -260,6 +261,30 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	return req;
 }
 
+static struct qmi_request *__control_request_alloc(uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	return __request_alloc(QMI_SERVICE_CONTROL, 0x00, message,
+					data, length, func, user_data);
+
+}
+
+static struct qmi_request *__service_request_alloc(
+				struct qmi_service_info *info,
+				uint8_t client, uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	struct qmi_request *req;
+
+	req = __request_alloc(info->service_type, client, message,
+						data, length, func, user_data);
+	memcpy(&req->info, info, sizeof(req->info));
+
+	return req;
+}
+
 static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
@@ -1495,9 +1520,8 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 
 	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-				QMI_CTL_SYNC, NULL, 0,
-				qmux_sync_callback, data);
+	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
+					qmux_sync_callback, data);
 
 	__ctl_request_submit(qmux, req);
 
@@ -1623,9 +1647,8 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, qmux_discover_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
+						qmux_discover_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
@@ -1769,10 +1792,9 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	qmi_device_get_service_version(device, data->type,
 						&data->major, &data->minor);
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			qmux_client_create_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
+					client_req, sizeof(client_req),
+					qmux_client_create_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(8, qmux_client_create_reply,
@@ -1806,10 +1828,9 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 
 	qmux->release_users++;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID,
-			release_req, sizeof(release_req),
-			qmux_client_release_callback, qmux);
+	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
+					release_req, sizeof(release_req),
+					qmux_client_release_callback, qmux);
 
 	__ctl_request_submit(qmux, req);
 }
@@ -2691,11 +2712,11 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type,
-				service->client_id, message,
-				param ? param->data : NULL,
-				param ? param->length : 0,
-				service_send_callback, data);
+	req = __service_request_alloc(&service->info,
+					service->client_id, message,
+					param ? param->data : NULL,
+					param ? param->length : 0,
+					service_send_callback, data);
 
 	qmi_param_free(param);
 
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
