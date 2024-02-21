Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335F12880E
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553923; cv=none; b=NEE3pBI1oDG0L6/raK5mj2YxfQI/yvK6LiijD10XohOBCbShXbjiUYGu7n8NGtMYRifweFLsoIXC3PMPWsQsbgCd3O+TmMmAmG5hLoieV0sgMXayXm7rwS4fSBjNEzpJ+WKb8LhPQLf73wQkJegGtKbnX/zMPZoC7WZGlfVjTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553923; c=relaxed/simple;
	bh=35xLVs3zJ+JNeJx0FDJyLA4CUaxVkmhU8KrSdwycpPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKBssclbrA//fXGt1vbcWp4AGCXsVC51pqn1FFLl1eOhNd1/Mo9oyix4nKIotnE1louzpfkJNIQRyQuEvpfNvubQ1Hu/HNXCAO40RE4ay46/L4cJogMr/3w0pL2alftM7UjMIOB2fcKtAD7liZejjUCWVq8zIM1gCI1OqmeJMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=McXRf6Yn; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=iAUTGFkl; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="McXRf6Yn";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="iAUTGFkl"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDA1Vq027307
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=KiOLlf0FI6bAWwarlXS1fi
	8A/EMgkRkenG107RD8O5w=; b=McXRf6YnC1XzssIqwXf6C7XKvipJbZpTresFOW
	1jHMg8Aa6fspRULxF8/IjgBC50zeDg4zmsY7gE/SkVnhZrLspKRWutyCPugrVy1A
	1tkmT8ZJOvur6BSWsWXAXJnZY7JQXF+oRTU0JDc465EHf7h4nZtshsWY/W09dnUu
	mObkU61VhQf6hWjgj8ozt8IZEmoVdW2IS6nLrTFiAScOT3ABXAGAN3FYr7U1DwTW
	GPktZvdi2aDw3gShmBkMPwkD76yRDPCrO6XzEKz5ZTNcVP+00jhsDIwmtWNaCPpF
	5atboQH2DKgWPqKoVR0fM6G/NE0WHp1lWfuCHYUlr6UtNLzQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563h2td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:41 -0800 (PST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6800e52d47aso5259586d6.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553920; x=1709158720; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiOLlf0FI6bAWwarlXS1fi8A/EMgkRkenG107RD8O5w=;
        b=iAUTGFklCIdHP6xWggAZvuYdVUaXqNNLToFalZxsZCRKOFGQ5IxqNNtePi+FwTxEpS
         0DLzDr6nK9XNJkd4NfaGPvT5Y+0hH9qUieN3EtP9qVL2h9tHz/kWXX1SJ0s4JF6Qt7HP
         vuSrcbBM38Zhn0C21zpxELEi7Ds7Vd9p/YcvcROTcFI2dT32ZUcPuTcZEa9Qd/7FfMJQ
         IZUEZOxv2zxMIo+Ekik0jpQpsRz+2IaToccG1YlnnHPUWd/mzOxtBQmLJ1JqTENjT0p7
         hAcstcx2BM+6Pi8J2Qinu/w88t4umfhLGXv8wt69se3UhdIKXVIiDqDHklNqQMFV4Hu1
         CgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553920; x=1709158720;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiOLlf0FI6bAWwarlXS1fi8A/EMgkRkenG107RD8O5w=;
        b=lSe+YDToz8W+nN9cF0+c9gZPrCz1sKRBOCaS+AgFbzow92oRG1vYzoLzP3mgsgimb+
         rjxF/s2hbEEtDMprxJg7kaRCh4vhsKZY908B/pi+GH5s3DcKVUUdjh27Jb7QLYufv6n9
         M7EzfXAwD8jEbk3aQK4rqOFxwl0Tzv4pKTF5gtPP4Guzrcjp7MzjWueC51emBDO8hC9J
         hYO+O1pTQmnj1oROkEMzxBMTXKtkxc3tlD5IZ2qFZRYnpVCiygHwIOaa30F/vnKxmnzF
         xUg/VuDxl4o109oc2nxpbcjuG2y6Gn4ohLSt90cvAUWwiX49MZxLDts5/7ai90LnSZks
         JnzA==
X-Gm-Message-State: AOJu0YxAzaViXyV5EaDgaQrNXsUs0kgKQFpoxWQMrTuS9A4ZBMCoAKrh
	hE0SxUC8zfiwGGzW5QTUwb+7kyinlrWFHTYqJVj+s3FfMhEt4Baz228Aw3opAPSOvr9vgoiocGF
	jp7RF8zwXto1gGUxcHCuSxyOfUXvDAvtu2+RNWe7UpaWeWQr9hBDI4wmkoyDI55xduw+bK2NAwe
	OrbKcTVCyNmRYzdMm2eHCRw+cbN5IP/yVnJcQD++sxWvLOvFc=
X-Received: by 2002:a0c:8bc2:0:b0:68c:88fd:d314 with SMTP id a2-20020a0c8bc2000000b0068c88fdd314mr1234772qvc.14.1708553920139;
        Wed, 21 Feb 2024 14:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA5wTCxm+xxCOury1KOXzDsJuQSRK9qQ+fgbVerRZIILDwV1/QsXxz1Dz7fRMKHlG9ynw0Aw==
X-Received: by 2002:a0c:8bc2:0:b0:68c:88fd:d314 with SMTP id a2-20020a0c8bc2000000b0068c88fdd314mr1234750qvc.14.1708553919755;
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/6] qmimodem: Use l_timeout and l_idle for discovery
Date: Wed, 21 Feb 2024 22:17:21 +0000
Message-Id: <20240221221725.185480-2-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: h8OlZSwK9eFRgccL06qLR1zYKbE5yqOH
X-Proofpoint-GUID: h8OlZSwK9eFRgccL06qLR1zYKbE5yqOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210175

---
 drivers/qmimodem/qmi.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d2d4eefa..6880dc45 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1101,17 +1101,19 @@ struct discover_data {
 	void *user_data;
 	qmi_destroy_func_t destroy;
 	uint16_t tid;
-	guint timeout;
+	struct l_timeout *timeout;
+	struct l_idle *idle;
 };
 
-static void discover_data_free(gpointer user_data)
+static void discover_data_free(void *user_data)
 {
 	struct discover_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->timeout)
+		l_timeout_remove(data->timeout);
+
+	if (data->idle)
+		l_idle_remove(data->idle);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1253,17 +1255,33 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 	return req;
 }
 
-static gboolean discover_reply(gpointer user_data)
+
+static void discover_reply_idle(struct l_idle *idle, void *user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+
+	l_idle_remove(data->idle);
+	data->idle = NULL;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+}
+
+static void discover_reply_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_request *req;
 
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
-	data->timeout = 0;
-
 	if (data->func)
 		data->func(data->user_data);
 
@@ -1271,8 +1289,6 @@ static gboolean discover_reply(gpointer user_data)
 
 	if (req)
 		__request_free(req);
-
-	return FALSE;
 }
 
 bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
@@ -1295,7 +1311,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 	data->destroy = destroy;
 
 	if (device->version_list) {
-		data->timeout = g_timeout_add_seconds(0, discover_reply, data);
+		data->idle = l_idle_create(discover_reply_idle, data, NULL);
 		__qmi_device_discovery_started(device, &data->super);
 		return true;
 	}
@@ -1305,7 +1321,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 			NULL, 0, discover_callback, data);
 
 	data->tid = __request_submit(device, req);
-	data->timeout = g_timeout_add_seconds(5, discover_reply, data);
+	data->timeout = l_timeout_create(5, discover_reply_timeout, data, NULL);
 
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
