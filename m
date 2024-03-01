Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435B22093
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313111; cv=none; b=dFU4xVf1XRvtKYPgIq5g5kapj8o0KunS2b2GgfN5cFZiyXaoBQFdJUkQbqiAq3wp4fEfv3FJDp37/oD67C8fCjZX1iL3eZQdJi/lHi+lguNWMtNt4F+0ggh3IExQx4TrrGbyWtNpwPIJo4j8zZebfzgTc2a2L7meylAbtqBSwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313111; c=relaxed/simple;
	bh=V10rNa3OwqjxpxswfdAZbyjGIpjhf5Xs4SQGByyRdlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5Ot+jJoNM/y/G+aKcWsuN35hbVgTXHofzV9eE01YIToGJQlcf/fbwY2ittkWoTUGvMShTiFeW0qLTzym3JpzRPVSWl0ekFM+5IZSKb9k62lvy1Sa+F8/waLOs5mHN6JL3dp5QMZ8sTAcO8K7ZsylBPEla19ZOu07wRkmdcQmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PQ+eVErQ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=iPJbO/v9; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PQ+eVErQ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="iPJbO/v9"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421DpOsX002096
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 09:11:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=OOq23WvXXcgZved9eolPft
	hLmwa4BZ/bXQwpyt3bRXI=; b=PQ+eVErQlo4S8txVeBaSgGDadKrwRVLfHmzXbx
	i6CtAcnxyi/5yCczmB/ylVn2MHQTt1crIGNCzbF9DbTLj3WeCDrhxJwmuP9zVr23
	1ao3yJa4OHIjSnZ+uo0UGKJfNGJ8vrHjnsHUqoSkrkNWfNLQv/FgI4gzEHnGdWYN
	c9UUsdGFrk2x6sCFvHaB9mvWFNcA7BRF8ipJWJTqBGuSqhknyD03MMej3T5Hu1PI
	uj7rZb6+px4EH77C87sUoApv4FhF1MOQe3xu8nc9G/WsW/DnDQccGGavmKxd4peT
	Vhqo3JuLQAByjToUeLkGjDqAX4zcoNwPo/KiRs+SIxDkPqaQ==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjenksmhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:42 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7877d4e2eso334529739f.3
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709313101; x=1709917901; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOq23WvXXcgZved9eolPfthLmwa4BZ/bXQwpyt3bRXI=;
        b=iPJbO/v9D661w8xDgkWN6BJs976ez3cD68mOSHgEeWp9FmkGIZYKhlW7MKn3LAdFNU
         RFeu/j8/8zWtdQPsynic8/In75ApuPDxiStQwLtEmo+IPws2rSefniSwl2zEu5ou/+5w
         2BKLt3ldizywaJSBY0Y1hNC7nt/Os7M1jcy+RSxdTnqqXyJdtgEaQ3KO4bd8/52DKvOv
         7CpdD4333dmi/k9Wy4VYijG3tElp+v7thykVAlXWlnrmfrEpWxpm9rR5OrRzxgeVcW60
         e1S+aODZpa6Jtll4ETIpUJO/CXyIIG+oNy9b+1AW9LPXEkyFyD5ClnKQxlR1SvxulQvh
         bMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313101; x=1709917901;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOq23WvXXcgZved9eolPfthLmwa4BZ/bXQwpyt3bRXI=;
        b=r/tG2vu99rLkUp+nni68O4fVs1oy7x8ECenjsA4mhowaXAVbA86ixo3v+6bCjrMk5+
         MlfjayrT1Dl02KqkFM/IPRrlVfcZB7DIdRVZOGG1qw6+1KDblhhr+iNtXiJreeYb+8/G
         K0nTJd1gXAnxFigP+Eg2rsnM4P5t3K+/By8bUDXpCLBNEMfHM4Kg2EcZjTdR9l+zgzkz
         QHDtbGWH5yE4l1U5o6kftnSbzJzAKCTJ2Mz90fcB3V9LfZl4To9vi2rxVLphfdupDaMD
         Yuft/Qg8HIPsvjbsNw8aKhle1T6plBIPK+jnVdX4RyW9LWJZjGJrlV+9nWHeucsX4h/D
         pZ7Q==
X-Gm-Message-State: AOJu0YyfmEL/vNku9Lobjm6guWzqxVVt60wie/kppvg2MIJIuVMolsgP
	orJaOGBE99qYA+ZDbewnTJsWcx/g3L5SvCgVcl8w/LXYtc6bnmlFt+688WeP7R1EkE6cMQCDYdq
	0TOG5+tY5u5xbkk87jJMmfWs38ONUEPEFrXRMHvlK1haO9YUKJbby9SUnm6dx4lay4v8pKpkOMM
	ViY++tJTfri37HaSlXKnzLPRMoCvQIZ+sR7CFzcFPvTlLDwD4RGw==
X-Received: by 2002:a6b:c88a:0:b0:7c8:af2:7a8a with SMTP id y132-20020a6bc88a000000b007c80af27a8amr2400810iof.20.1709313101422;
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3B7X0ozaD9GjWL8BXQg/dCAJ6tQhk7dnWlPTEut0LAbUxo8W0ZmdzSCgWpObu+MB+xzmkYw==
X-Received: by 2002:a6b:c88a:0:b0:7c8:af2:7a8a with SMTP id y132-20020a6bc88a000000b007c80af27a8amr2400790iof.20.1709313101005;
        Fri, 01 Mar 2024 09:11:41 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id gs22-20020a0566382d9600b004745a061467sm881059jab.87.2024.03.01.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:11:40 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/3] qmi: Store the service info in the request
Date: Fri,  1 Mar 2024 11:11:21 -0600
Message-ID: <20240301171124.38735-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301171124.38735-1-steve.schrock@getcruise.com>
References: <20240301171124.38735-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: nubMP1HAU6QXXRlKs8mUegRsf-D4-PPC
X-Proofpoint-GUID: nubMP1HAU6QXXRlKs8mUegRsf-D4-PPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_19,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010143

QRTR will need this to write to the appropriate node and port.
While here create helper functions to simplify request allocation.
---
 drivers/qmimodem/qmi.c | 60 +++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ce40d6a1..85ece8fc 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,6 +63,7 @@ struct qmi_request {
 	uint16_t tid;
 	unsigned int service_id;	/* Always 0 for control */
 	uint8_t client;
+	struct qmi_service_info info;	/* Not used for control requests */
 	qmi_message_func_t callback;
 	void *user_data;
 	uint16_t len;
@@ -262,6 +263,31 @@ static struct qmi_request *__request_alloc(uint8_t service,
 	return req;
 }
 
+static struct qmi_request *__control_request_alloc(uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	return __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00, message,
+					data, length, func, user_data);
+
+}
+
+static struct qmi_request *__service_request_alloc(
+				struct qmi_service_info *info,
+				unsigned int service_id, uint8_t client,
+				uint16_t message,
+				const void *data, uint16_t length,
+				qmi_message_func_t func, void *user_data)
+{
+	struct qmi_request *req;
+
+	req = __request_alloc(info->service_type, service_id, client, message,
+						data, length, func, user_data);
+	memcpy(&req->info, info, sizeof(req->info));
+
+	return req;
+}
+
 static void __request_free(void *data)
 {
 	struct qmi_request *req = data;
@@ -1494,9 +1520,8 @@ static bool qmi_device_qmux_sync(struct qmi_device_qmux *qmux,
 
 	__debug_device(&qmux->super, "Sending sync to reset QMI");
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-				QMI_CTL_SYNC, NULL, 0,
-				qmux_sync_callback, data);
+	req = __control_request_alloc(QMI_CTL_SYNC, NULL, 0,
+					qmux_sync_callback, data);
 
 	__ctl_request_submit(qmux, req);
 
@@ -1622,9 +1647,8 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, qmux_discover_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_VERSION_INFO, NULL, 0,
+						qmux_discover_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(5, qmux_discover_reply_timeout,
@@ -1768,10 +1792,9 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	qmi_device_get_service_version(device, data->type,
 						&data->major, &data->minor);
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			qmux_client_create_callback, data);
+	req = __control_request_alloc(QMI_CTL_GET_CLIENT_ID,
+					client_req, sizeof(client_req),
+					qmux_client_create_callback, data);
 
 	data->tid = __ctl_request_submit(qmux, req);
 	data->timeout = l_timeout_create(8, qmux_client_create_reply,
@@ -1805,10 +1828,9 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 
 	qmux->release_users++;
 
-	req = __request_alloc(QMI_SERVICE_CONTROL, 0, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID,
-			release_req, sizeof(release_req),
-			qmux_client_release_callback, qmux);
+	req = __control_request_alloc(QMI_CTL_RELEASE_CLIENT_ID,
+					release_req, sizeof(release_req),
+					qmux_client_release_callback, qmux);
 
 	__ctl_request_submit(qmux, req);
 }
@@ -2690,11 +2712,11 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->info.service_type, service->service_id,
-				service->client_id, message,
-				param ? param->data : NULL,
-				param ? param->length : 0,
-				service_send_callback, data);
+	req = __service_request_alloc(&service->info, service->service_id,
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
