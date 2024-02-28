Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13586244
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157323; cv=none; b=LyAHq4zE8qA3t4Kl5xX7QNka59In1fM7gDTvY0YYVOvCLrarZ2qHilh3U0z8KWXwFzowVyVVDL9BFE+CTK/z8R5VGxKj4GijWMqquW4hNXFfIyOLVKp2iVu2liNDBW67UzDjsOxNJz7vCaYkOFHUKn1JK8elqJIwHLaxQVyvRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157323; c=relaxed/simple;
	bh=PtVKPKXACHePnBQCQpjxqBhgy4wgRGNf+6PYU7G6wKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjr7044QG4s91Q4R4WbICnfNZ0dX5bVMnjoli0v2SPNKDL8MrovVYQ6sEh9WZwt40PX3yBuuUroDwF0lQGBT55UBhTZzzMVnV68tjKBzZUgSGLxcFUayLR3FqWJbtNMPXsWLyK90vTzeMInZ9ImgtjEDwO9v4LjUYHPzYkrm/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bkhwUxPV; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=CvJ8qL+T; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bkhwUxPV";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="CvJ8qL+T"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SD02dU028564
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=L6yPoWdmlQbD8Hky3/uBef
	6MJ1eq/dO2PC0HlTk2Wrg=; b=bkhwUxPV/LiH3i75JyA5pOWwKs46MDzZAc+jfG
	86RccJZBBvaA/BPfEXcFD/NLN3yXytsqGCYhA12pEnSi0rtsnLJD0tgsnORnRxX6
	gv3oPKNpwdJyaOL2RkxrTTLKVcHq1rVdkiJLmWqZxIDE9IvN9/y9YS8YRvZ47qWc
	zpwMyZ/LwhTiRMhDK8XhUjPLhodZV7j8INhF61/4RXYUxssRZvEX73pz/w0eZVxg
	5fMxaDBfUPDKYYGgsQ23D+DmuAesCHchvLwcoogtLm4ezzo8vDP3Pf3uhHHzD3ex
	dVyWDAI5oNFv+2j4H1igEw0Ln4wrHAx+7eS7pkM+xAALK47g==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wfewa3t07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:14 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6e49d73202cso167945a34.1
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709157314; x=1709762114; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6yPoWdmlQbD8Hky3/uBef6MJ1eq/dO2PC0HlTk2Wrg=;
        b=CvJ8qL+TgaEG37Ab6rmbm21QGa/39gDSlKJjwmPRqRt0LZq/LBdHvKcR1kdsA/5WHA
         6Xf4PQR0d6ozAfOYQ5hqXiwCqzi2NKaWTMrpaEzK3AoYQgx7Cl2raK2xeU0FGeRNziFP
         zlF8dUL+UI8fl6AZ+leEtjYX5xm0ikkNSsCEAJahs10v2GTCnwLQiYYpvtUdS7XYjpYT
         dDAVjQqfTFRRjisYSLRFvtttevnf9bL0Vx11aen5PSzawjrZP8D6codijb6tGPBoXFGC
         yorZ1x0mQE6FhqIS7uasPzzx9WDMzoLQENy2QIKbZROSmAUPBy6CGLy7PNYpf3funaWQ
         S6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157314; x=1709762114;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6yPoWdmlQbD8Hky3/uBef6MJ1eq/dO2PC0HlTk2Wrg=;
        b=chJHZDhUsnE3mmxUiNTAAJcFjBlKe1bqA5K4JHYhXIu6EPZlLgWroHuAK+LwRTZWlG
         02s2XBL4ow5JeyciODDDGIYHToxxQ9VEjFYN6eRjZQl6Ab78MlMo5eVqRRgaKlO51vD7
         g0dq0He/KsDllbI2f1sBehfARA8CXhow1DcRoeAtkCP/F57No4Hud/M3WmetrElV2IQW
         xoKBse4cI5bnou2PPPhqAuC9jjxu3St3lrqGb2LVjiy8tjvUq8cSvgQwSI1gIOogt5Aj
         z/uB7FcSmPeGph8u0DazghzAWG0E3F7AykvZIEF9/7k56Cy3jvWN8xtD/9O3/ZB0nsvw
         PZRA==
X-Gm-Message-State: AOJu0Yzka5bR2b60DjZfipxR5jQko8vj+u+Qa22V4I+Sonzy6qnqkHve
	ZdAsDE9quOq1aNLeC8KJZOiUhE7jagCAxxLKKpVyooZQxAV2YIgm1PBVCIWwbpV0ed4Jl4ZJlPJ
	BBKrnk9REbbwpoyVUlFedS9uFyu7s9Ad8iPT9rZsCVEgU+zf48rHlQjF+ASaj7Wsk7IbJZSKcCI
	2qeaYSm/4UhRsXxm/Oh5QmOgWRoOmQNJgeGPGJqouChOpRURE=
X-Received: by 2002:a05:6870:170a:b0:21f:db0e:4aab with SMTP id h10-20020a056870170a00b0021fdb0e4aabmr148419oae.59.1709157312378;
        Wed, 28 Feb 2024 13:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWmQG+nS6zdTlMNB5a5WWtx+UG5fxPumbeLYw8EhAqm1AfmUP9nkXuDDaV4yoeYRCpzLmnmA==
X-Received: by 2002:a05:6870:170a:b0:21f:db0e:4aab with SMTP id h10-20020a056870170a00b0021fdb0e4aabmr148400oae.59.1709157312036;
        Wed, 28 Feb 2024 13:55:12 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm33963qkl.91.2024.02.28.13.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:55:11 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 4/4] qmi: Enable basic client creation if it is not subclassed
Date: Wed, 28 Feb 2024 21:53:19 +0000
Message-Id: <20240228215319.153068-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240228215319.153068-1-steve.schrock@getcruise.com>
References: <20240228215319.153068-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: rk5jz10jMW_f_ggxM-sKx45cs6cAa-bB
X-Proofpoint-ORIG-GUID: rk5jz10jMW_f_ggxM-sKx45cs6cAa-bB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=944 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280174

QRTR does not require client ID allocation requests.
---
 drivers/qmimodem/qmi.c | 93 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index afa7b962..6e4c99dc 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1388,6 +1388,25 @@ static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
 	return req->tid;
 }
 
+static struct qmi_service *service_create(struct qmi_device *device,
+			const struct qmi_service_info *info, uint8_t client_id)
+{
+	struct qmi_service *service = l_new(struct qmi_service, 1);
+
+	service->ref_count = 1;
+	service->device = device;
+	service->client_id = client_id;
+	service->notify_list = l_queue_new();
+
+	memcpy(&service->info, info, sizeof(service->info));
+
+	__debug_device(device, "service created [client=%d,type=%d]",
+					service->client_id,
+					service->info.service_type);
+
+	return service;
+}
+
 static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
@@ -1398,6 +1417,20 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 	DISCOVERY_DONE(data, data->service, data->user_data);
 }
 
+static void service_create_shared_no_discovery_reply(struct l_idle *idle,
+								void *user_data)
+{
+	struct service_create_shared_data *data = user_data;
+
+	l_idle_remove(data->idle);
+	data->idle = NULL;
+
+	if (data->func)
+		data->func(data->service, data->user_data);
+
+	__discovery_free(&data->super);
+}
+
 static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
 						struct qmi_service *service)
@@ -1664,6 +1697,7 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	struct qmi_device *device = data->device;
 	struct qmi_service *service = NULL;
 	struct qmi_service *old_service = NULL;
+	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
 	uint16_t len;
@@ -1686,21 +1720,12 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	if (client_id->service != data->type)
 		goto done;
 
-	service = l_new(struct qmi_service, 1);
-
-	service->ref_count = 1;
-	service->device = data->device;
+	memset(&info, 0, sizeof(service->info));
+	info.service_type = data->type;
+	info.major = data->major;
+	info.minor = data->minor;
 
-	service->info.service_type = data->type;
-	service->info.major = data->major;
-	service->info.minor = data->minor;
-
-	service->client_id = client_id->client;
-	service->notify_list = l_queue_new();
-
-	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id,
-					service->info.service_type);
+	service = service_create(device, &info, client_id->client);
 
 	hash_id = service_list_create_hash(service->info.service_type,
 							service->client_id);
@@ -2443,6 +2468,43 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
+	if (!device->ops->client_create) {
+		struct service_create_shared_data *data;
+
+		/*
+		 * The hash id is simply the service type in this case. There
+		 * is no "pending" state for discovery and no client id.
+		 */
+		service = l_hashmap_lookup(device->service_list,
+						L_UINT_TO_PTR(type_val));
+		if (!service) {
+			const struct qmi_service_info *info;
+
+			info = __find_service_info_by_type(device, type);
+			if (!info)
+				return false;
+
+			service = service_create(device, info, 0);
+			l_hashmap_insert(device->service_list,
+					L_UINT_TO_PTR(type_val), service);
+		}
+
+		data = l_new(struct service_create_shared_data, 1);
+
+		data->super.destroy = service_create_shared_data_free;
+		data->device = device;
+		data->func = func;
+		data->user_data = user_data;
+		data->destroy = destroy;
+
+		data->service = qmi_service_ref(service);
+		data->idle = l_idle_create(
+				service_create_shared_no_discovery_reply,
+				data, NULL);
+
+		return true;
+	}
+
 	shared = l_hashmap_lookup(device->service_list,
 					L_UINT_TO_PTR(type_val | 0x80000000));
 
@@ -2486,9 +2548,6 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		return true;
 	}
 
-	if (!device->ops->client_create)
-		return -ENOTSUP;
-
 	r = device->ops->client_create(device, type, func, user_data, destroy);
 	return r == 0;
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
