Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80853127B50
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550612; cv=none; b=OBEc3mDxsUqNrdUATUj4wTUAYohfYuGN8NuXOQxlUctrZ9/ZEHYQmDhud8YObwSFDr8NVjFPIzXfa7W+kOhb4zl4K4R44HG6kSj+zxz5+Y29exk+QzXiQguUdLWVF5jycckKoAICWia7U8xe6E1SZpfhJ5YlhYCvUNh8b9F9oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550612; c=relaxed/simple;
	bh=WniWKL3o+Lw9aUcS7REGARPFErGoEMeQVi2aUhEULC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRO7SPRtVoZu7Lh24o6w74Mx1xh9mPHhmmC9SIFMHl7rXjwOF2XMVdUOyM74vzTV06hgkMiSeBmCa/Px2Qf6AZlmGMCIa1vj65694q2K7H+tN4X3AIw6uYYFP0cYumG2baGs1pjo/hxQ8Sn2xhz7lbmj3Zeel6T9vkARUMwNP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Mb89JjtG; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=c7EycesX; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Mb89JjtG";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="c7EycesX"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEvwwu031180
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=s2Vy1Eua0fbApHAroqAH/9
	JyCMxf3BUZfBn2lcvCuJg=; b=Mb89JjtG8GWv/eki29TSIylKBHMTFUXRJExMva
	mCyCe0yS1/PYZoSKy8TlD9pQXY7GZ4s3u9zAxGuE+jKpk76sNHXAw1ahqF95DmFq
	Ja2hhsdWkCnt4ZDYFgbMEb46nytHf/w905cX6IsTcfZToA/OOAIE7TSlOeHSw9Hm
	Y0cRVXbqk8hHDM7o0/9QKoIpnC0Nkj6p6oMJmaxjHsMTakRTa8kZLeIYma809RFb
	tdGY2Lq+j1cvkNDsql5g47UoMlN/QjRXWZ2jTp3ySk2hGG/wSSpXtMCn/ZIsmX2m
	r9SM/mrxjdL2MYr2p1Eq7oN37ehoA0sSSEj8YqRTJ4o+e0Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd56490fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:29 -0800 (PST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78794e4b233so34530685a.0
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550608; x=1709155408; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Vy1Eua0fbApHAroqAH/9JyCMxf3BUZfBn2lcvCuJg=;
        b=c7EycesX+ZFoi/eNaDCUDFjY/3EIa64iidoYz7ZXmCsGkb/OWjxHdS3AYR28u3YPT5
         gWOc3LJWvbWTPsjWBrtrKnOQfhx8/eGKJkpjBBsNq7hrN0VBWcxCA9Z81aoGFSvdHZMu
         YccjLdMVSdH2VFrGZaeOxD9Qj1Mib1NEuExxSEX9T5KLoY0p7c6R8AouHc6+wI3EqxyC
         pyAUGkt4q//1siZB6oMP6whFrG1mM1ut/TcKQw1TKxqkVZIvevwzWtxs3lu/mq8FKzLa
         OJLTMa2ZSbia+RwpAZzt28IghFUyKTV1WNVV+ylR3voUg64P4QMLN2sxbeaxhOJQSoFm
         GJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550608; x=1709155408;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2Vy1Eua0fbApHAroqAH/9JyCMxf3BUZfBn2lcvCuJg=;
        b=tdFFZ3GSCIlPiSvTvT3YiISmVAI24O3+RAttlp7CLMqLnxIx0Lr1NeZ0dD63cqg7bg
         k0t8/FQXv4LaujRRt/UdwKVKlgZdA808IIfNjmz02JifBT7QhtJ7PgEFt2+r+lLN+TzP
         zs/P/hvxfZoMRCzhWSnIePDVIUeiy+00gI1VF/x7LTPX1RfPfq7SE2n4WRGe9eXUlgTS
         5RxbRzpWvNAc+fbNNfu34V8mUBt8AqWhwOVjCkdQOojKOth2ywWQTmJvV79ZnFqeqjjW
         gj9nz0w7IxgZP5TzSs6v7Bq70zkJqX8pRZmnZjgqoYw64o7gx+P4pGwqez9pJ1A1N8H6
         nyvQ==
X-Gm-Message-State: AOJu0Yxik4CoIVFFtJxLI4MAYC6ltJ826m4gbRDwNWjLjlRxowJDIang
	tXBtUovUrHMV5qYNtlwMTEzJRD8vknVFQCEpgJGdL7YU7o7h41N97NwIb/6yNQAm4gB0zPvXMb1
	OU9I2Pyzgp/f/PpztmOnCwxUUlLt1TBIYRQGk/Om9gMyIj80umyW7TqxXE0cZoab06S/f21dPVX
	DUstRskx0UKpmwNp5MBbhNGcY8k5cSNDhiUx9Ei1dS32jztp4=
X-Received: by 2002:a37:c408:0:b0:785:b88a:1437 with SMTP id d8-20020a37c408000000b00785b88a1437mr20516442qki.37.1708550607891;
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWD3y/S/z36qBmDdQhMHhWsiPL4v6Ojr+DSBNhuSHyeylI8s79D93wKU6BgcJKonaA88atdQ==
X-Received: by 2002:a37:c408:0:b0:785:b88a:1437 with SMTP id d8-20020a37c408000000b00785b88a1437mr20516423qki.37.1708550607306;
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 4/7] qmimodem: Use l_idle and l_timeout for service creation
Date: Wed, 21 Feb 2024 21:22:09 +0000
Message-Id: <20240221212212.181401-4-steve.schrock@getcruise.com>
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
X-Proofpoint-GUID: bpYMsIthJ3bCr7ceJkbSbf_8yqE13-tL
X-Proofpoint-ORIG-GUID: bpYMsIthJ3bCr7ceJkbSbf_8yqE13-tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_08,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=930 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

---
 drivers/qmimodem/qmi.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index eed69178..5f050742 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1908,7 +1908,7 @@ struct service_create_data {
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	guint timeout;
+	struct l_timeout *timeout;
 	uint16_t tid;
 };
 
@@ -1916,10 +1916,8 @@ static void service_create_data_free(gpointer user_data)
 {
 	struct service_create_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->timeout)
+		l_timeout_remove(data->timeout);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1934,19 +1932,18 @@ struct service_create_shared_data {
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	guint timeout;
+	struct l_idle *idle;
 };
 
-static gboolean service_create_shared_reply(gpointer user_data)
+static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
 
-	data->timeout = 0;
+	l_idle_remove(data->idle);
+	data->idle = NULL;
 	data->func(data->service, data->user_data);
 
 	__qmi_device_discovery_complete(data->device, &data->super);
-
-	return FALSE;
 }
 
 static void service_create_shared_pending_reply(struct qmi_device *device,
@@ -1961,26 +1958,29 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 		struct service_create_shared_data *shared_data = l->data;
 
 		shared_data->service = qmi_service_ref(service);
-		shared_data->timeout = g_timeout_add(
-				0, service_create_shared_reply, shared_data);
+		shared_data->idle = l_idle_create(service_create_shared_reply,
+							shared_data, NULL);
 	}
 
 	g_list_free(*shared);
 	l_free(shared);
 }
 
-static gboolean service_create_reply(gpointer user_data)
+static void service_create_reply(struct l_timeout *timeout, void *user_data)
 {
 	struct service_create_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_request *req;
 
+	DBG("");
+
 	service_create_shared_pending_reply(device, data->type, NULL);
 
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
-	data->timeout = 0;
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
 
 	if (data->func)
 		data->func(NULL, data->user_data);
@@ -1989,8 +1989,6 @@ static gboolean service_create_reply(gpointer user_data)
 
 	if (req)
 		__request_free(req);
-
-	return FALSE;
 }
 
 static void service_create_callback(uint16_t message, uint16_t length,
@@ -2093,7 +2091,7 @@ static bool service_create(struct qmi_device *device,
 			service_create_callback, data);
 
 	data->tid = __request_submit(device, req);
-	data->timeout = g_timeout_add_seconds(8, service_create_reply, data);
+	data->timeout = l_timeout_create(8, service_create_reply, data, NULL);
 
 	__qmi_device_discovery_started(device, &data->super);
 
@@ -2108,10 +2106,8 @@ static void service_create_shared_data_free(gpointer user_data)
 {
 	struct service_create_shared_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->idle)
+		l_idle_remove(data->idle);
 
 	qmi_service_unref(data->service);
 
@@ -2168,8 +2164,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 
 		if (!(type_val & 0x80000000)) {
 			data->service = qmi_service_ref(service);
-			data->timeout = g_timeout_add(
-					0, service_create_shared_reply, data);
+			data->idle = l_idle_create(service_create_shared_reply,
+							data, NULL);
 		} else
 			*l = g_list_prepend(*l, data);
 
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
