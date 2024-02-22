Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023314036A
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646122; cv=none; b=esE+RUy1v30/g5Qf3rniccfUx4dr9Ti4JCGOPBCrGZUQNlkRuF+0DWqFar14kKLCYrpk3sO0Dctx24bwmgLNouBTq1nRWP2j9yzUDVnAP//iaP59Hn8XyNIbBKauA1TN8eWyEpMC47ktWFtGZ63l2RP7CQWtVDqjykUf/2k4Kac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646122; c=relaxed/simple;
	bh=DVkdYBEpaJ49DQQ2oFWdTU7OIJjpVv86L6rmsXBvzC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q919ygeaaD46DcT+8D8d+Mo2h4Gd3hWW4WCuTb+aSHmVZYo/znxhOqT6SwaUDz4wue8bWHajfbS62sU3lUNGFdhAGIKeuitUt7Iu7BdE8fCsJoV0yoSJu7jNlGFQzri6a5zyygnPTwdUE5lNdASWfCeninryVGgN4fcJZkWw0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=QL1VW9VW; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=c7EQePeE; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="QL1VW9VW";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="c7EQePeE"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MKwIvh007635
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=biLhsYLCEEM4n5Cjtlt1jP
	lucDUy26914M3S3r83TbQ=; b=QL1VW9VWA4LUqwf9hpBXaw3lswmKzD7mOy9qrQ
	xDD57D9zPYLRdbeLxkITwTZSc0Jkt0B2W5krEbKyhCK5NPHWF4szjckOWkPPKpfr
	9M1TbDfpN6W/J24LboWDUZLNegUD7d+jbd+b3TcZrf5jvi/086hluK2M6EJCrjGL
	hVQcN6wN6XrLKklkKFJ1DOWBJos9/txpALML2/mKzcklNqqfbXwPwKgrsfwUe/ti
	Amgzj2trv3APE/UyCzv1lLnYvQDYAlQHS1QEkzO8trGFkHktla48N4oLGLXv9fGx
	Z8ZQor6y/JccdutXVDeP4qdBuDhef8e4+Rg20CwcDPq8H9pw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563a1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:14 -0800 (PST)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4b92015b9dcso216087e0c.2
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 15:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708646113; x=1709250913; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=biLhsYLCEEM4n5Cjtlt1jPlucDUy26914M3S3r83TbQ=;
        b=c7EQePeE3MGRNCJSULTpySFKNxHAoiCD/hb99yGDx/3FenBfByj4cPdt+f53mE2O+C
         4GchoinVf5uCnM9O+njeM1scID8LgJ0SvbI/RdYRRx0rnNID2Y/V378I/eexpZXigtkV
         7oLe78rAYKbdFtEBywUD2ArT1WJqqPifmxrUuUCrKTmVM5NyvZXgq6HFTiHUJv1ATNg7
         c+lcuH4zhWIH5MDFMOu2Pgq1IrN+ava5c47XFLDr28kB/qW6YgTcvlsjjbdICWdSTZ5o
         ilTRHuxExmv5Nk8gruE6wnVFWgsSUCnXZAqYYNW/xGLgZemAFaVGVhrzcDN5lJaoltyI
         Ki0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646113; x=1709250913;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biLhsYLCEEM4n5Cjtlt1jPlucDUy26914M3S3r83TbQ=;
        b=UaMgM3zPc0fHcRybXWt2noOt0R9f3/mjG1+R6mp+yBXFdkQf3crQZ5yYQuNsh94u07
         +V6gfUMlu9sY0+NAt2iXeoIxTmp+bqQ1GkCbUybkpH3dgfD42PiZS9zZhLem/sliLoYQ
         eP9vIaRutASqmjuA4l2XROQ+t/ZLKoFcr9ITqf9D7ZBuiHHDQnphdcxl0wp7AOT3ZeC2
         VI3yF8O5THOwF+n4mdYF3aopaVTbpvPgaALDfeiryeLCi36hk/HySBNyuOrzHy0M8Tj8
         +jfKw3ff7V7rgLcWpMRDGB69dvl/zada4uuJF1UfptaA7c/OESIWxhrqik4G0Qi8pwWP
         OwfQ==
X-Gm-Message-State: AOJu0Yzc1XNfzvVbCRjwnFxlnYQDYdjk6dVMLigiOS0Kdm9nR6F6Sb8f
	9fJ7lNMZOjdXMcYNusaM3CJNg/dHj0NL3sNXWPNeBFurKC7hUmO+6qr9INsSJDuG2Gb0lPi1Dji
	EugnRTlMgBGJ5ZrqJ2d24iGlVj/hfA6u448TlwKPY46t4IcsIrArCPs3Br2y9UqIEY71aNm2rGB
	Wo3UYdi47QQJV2Fel0I5q/pd1ke2Z3lin1p6tpfKNPEvDQmiQ=
X-Received: by 2002:a1f:e044:0:b0:4c8:8025:f451 with SMTP id x65-20020a1fe044000000b004c88025f451mr537365vkg.12.1708646113115;
        Thu, 22 Feb 2024 15:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv8ZwrF7z8+fjKLrqtRPMVfA8PO0SN6fiymYqe1WoxUp8awffvDGG8CjX/Oe0tXLDs/MOx5g==
X-Received: by 2002:a1f:e044:0:b0:4c8:8025:f451 with SMTP id x65-20020a1fe044000000b004c88025f451mr537351vkg.12.1708646112692;
        Thu, 22 Feb 2024 15:55:12 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id ny13-20020a056214398d00b006862b537412sm7473837qvb.123.2024.02.22.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:55:12 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmimodem: Use l_queue instead of GList for pending service creation
Date: Thu, 22 Feb 2024 23:53:56 +0000
Message-Id: <20240222235356.32485-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240222235356.32485-1-steve.schrock@getcruise.com>
References: <20240222235356.32485-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: G8GRiMIV1-n2FK5DHzhxZIXE5bttlT_u
X-Proofpoint-GUID: G8GRiMIV1-n2FK5DHzhxZIXE5bttlT_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=710 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220184

---
 drivers/qmimodem/qmi.c | 43 ++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 168dee1a..99b3d84d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1382,24 +1382,27 @@ static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 
+static void service_create_shared_schedule_callback(void *data, void *user_data)
+{
+	struct service_create_shared_data *shared_data = data;
+	struct qmi_service *service = user_data;
+
+	shared_data->service = qmi_service_ref(service);
+	shared_data->idle = l_idle_create(service_create_shared_reply,
+						shared_data, NULL);
+
+}
+
 static void service_create_shared_pending_reply(struct qmi_device *device,
 						unsigned int type,
 						struct qmi_service *service)
 {
-	gpointer key = L_UINT_TO_PTR(type | 0x80000000);
-	GList **shared = l_hashmap_remove(device->service_list, key);
-	GList *l;
-
-	for (l = *shared; l; l = l->next) {
-		struct service_create_shared_data *shared_data = l->data;
-
-		shared_data->service = qmi_service_ref(service);
-		shared_data->idle = l_idle_create(service_create_shared_reply,
-							shared_data, NULL);
-	}
+	void *key = L_UINT_TO_PTR(type | 0x80000000);
+	struct l_queue *shared = l_hashmap_remove(device->service_list, key);
 
-	g_list_free(*shared);
-	l_free(shared);
+	l_queue_foreach(shared, service_create_shared_schedule_callback,
+						service);
+	l_queue_destroy(shared, NULL);
 }
 
 static void service_create_shared_data_free(gpointer user_data)
@@ -1699,14 +1702,14 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	unsigned char client_req[] = { 0x01, 0x01, 0x00, service_type };
 	struct qmi_request *req;
 	struct qmux_client_create_data *data;
-	GList **shared;
+	struct l_queue *shared;
 	unsigned int type_val = service_type;
 	int i;
 
 	if (!device->version_list)
 		return -ENOENT;
 
-	shared = l_new(GList *, 1);
+	shared = l_queue_new();
 	data = l_new(struct qmux_client_create_data, 1);
 
 	data->super.destroy = qmux_client_create_data_free;
@@ -2148,7 +2151,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
-	GList **l = NULL;
+	struct l_queue *shared = NULL;
 	struct qmi_service *service = NULL;
 	unsigned int type_val = type;
 	int r;
@@ -2159,10 +2162,10 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (type == QMI_SERVICE_CONTROL)
 		return false;
 
-	l = l_hashmap_lookup(device->service_list,
+	shared = l_hashmap_lookup(device->service_list,
 				L_UINT_TO_PTR(type_val | 0x80000000));
 
-	if (!l) {
+	if (!shared) {
 		/*
 		 * There is no way to find in an l_hashmap using a custom
 		 * function. Instead we use a temporary struct to store the
@@ -2179,7 +2182,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	} else
 		type_val |= 0x80000000;
 
-	if (l || service) {
+	if (shared || service) {
 		struct service_create_shared_data *data;
 
 		data = l_new(struct service_create_shared_data, 1);
@@ -2195,7 +2198,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 		} else
-			*l = g_list_prepend(*l, data);
+			l_queue_push_head(shared, data);
 
 		__qmi_device_discovery_started(device, &data->super);
 
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
