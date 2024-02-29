Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0931419A6
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220732; cv=none; b=maCEvj9TUXiUtSYFMi4NTrqyVm/7rCAmDsTlmWCLUyjlj6p3MP/ZmWZLf3hT2BctcdqwT8kn0besaEmoFzVqmd2aBW/aCTYCgErbAZ4sv27OBda87uxDQzXkxpwMCrsvMXzBE2W8RoCGrMEFvEgXlgooBul4pfjl1GWAAAxsRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220732; c=relaxed/simple;
	bh=DFiWaSseb5rj60msozPSDI3pqYIqTrd1+lHby52/O4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlqDXwCgrUCH1Tp3gbPB3K11JO3uydQJKYpt19ViZUPYY97SIMsaXiIxUxx+7NukgojdK9FokakreBhOeFORkudcjwavt6u8GFfFgeZdHdE8CwVWUD4OTo3muwnlupzDzds4VECHliY0A4gmcViZsSYxfIar/nF3uJ3SBQUqkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=nIMZqxp/; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Dqt39KKt; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="nIMZqxp/";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Dqt39KKt"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEelrc029063
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=dg/S+QefKH2+Y4bJ8L0kxj
	OlpVGXNK6qbRNIlEC0hFg=; b=nIMZqxp/ZqXTM14A7E3GaPAkhiq+3Kb67NZGgb
	rbLR2nrP61OSGXPZdW8rLGor8lqwcxJy6EYnlnKozbuAIpg0+2E5t/whUmRXaaeV
	trDFx2cSY4pyfZFrZq6a6N9yw2t6Op1E7cD8id/J3wxMJO4JhKTxi7CiC9KLM3gg
	0J8uvexOeEX1Rp1dxemCCO3zylD3TC/IkwjnOmKBjJujpeDVaiVYJ92LKkFLHTm5
	TLXWWCRpK6uI4zm9qxXtUp8IquRp2eRG9SzdOlFP4hKTQ1vwmJHJ0X1IwX5JqFpl
	mSycbdLSPFDzJymOd78wIJCIRv8ceTCsqvWwv9sf7GP6sFmw==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wj6jch3gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:09 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c49c867608so100408439f.3
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709220729; x=1709825529; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dg/S+QefKH2+Y4bJ8L0kxjOlpVGXNK6qbRNIlEC0hFg=;
        b=Dqt39KKts1Z0OKWi5Z+StEfYCR8Sxx2IrXAtmNbQ3PhoEA4OF+QezpRFMaihvLHGoQ
         fulZJeUZsksz61DvAuYNXV6mbGxhvn29BbiEIK64c2lzdGEbUYybmfbGHPAm3YHwqKHE
         iyFO4kA7qkJJFxYUl+yQ0UwSsqY7qZ+auP36YdyxYpznq+Lil3bVuOGOEA6spLWK0lgV
         FstBTo9K9zWUyAvTGC8j/ghA1bjA5azWohhFw6XXuyjxwbqkQEcgrGdw63/1/1evF9jG
         hVQUA6IB0XpfV/RWpaMQX8hXM6Nlcnxe7bwoIX300bCoo5LfKYWa6p7bsSWDEcDxx0jH
         CUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220729; x=1709825529;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg/S+QefKH2+Y4bJ8L0kxjOlpVGXNK6qbRNIlEC0hFg=;
        b=nm6nFvKvEMtsYNgdOuK89R+/RdeCfNlJEIe2IhVqlghohDZOyHA/lQ8SdAWijc5N1b
         c+tT1UL+G8sECGMW57YYWEJR5cdiyR3HB8hAfd0XIVV+aH9jo1rxqxFPVjJQ+CP9xcDZ
         y9pVBwScygX85rXMbKcaAyCs7QAyMO2aVR9aAtN1Geu3s8e4t/Zd44ANZYA/UJQiZ3lW
         n0XEK501oufbOvU0Ixk2Z5lovZSOPYyus13Z2lQAkPFmSm0JkMG2aQaSk4XUcpUu66gy
         layOwC2aST6x5xCEHe0KIWAJjoVdLUKXfMAa1MQIV2X2M+YV9J+qKKTZsejqcrQYPOLW
         Zv0Q==
X-Gm-Message-State: AOJu0Yx3a4U9mYXg9IRMEsLNyd4U2gvyH5/m6kJRk5Ag2n5pMiWsHsj3
	9QuAf9bs5tbVWDpSfG7HMuyGjpDNDAmgBgFlUqbVcPJIUe6+pzPIdkanszn5Q7J+VdZDRdnj4Pq
	0SktYPECsS1/WOC3gkSVPnwpBQIer7gwYB9cc0S5GWfaVrzTYfsTRYSXkElVrrwV5jMhlrZSW0C
	S3yqZvgR1o62GSi/PcHHCkVQrX5CHdcd3oUJSJYlkNcBoZsEc=
X-Received: by 2002:a05:6602:2804:b0:7c4:9459:3762 with SMTP id d4-20020a056602280400b007c494593762mr2738147ioe.9.1709220728853;
        Thu, 29 Feb 2024 07:32:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGriNEnkakVoM2IMn//2hxvfGHGG2b3xVw5olSEOpGUaYnc/KdKHk8PdBoIWK3elY6MMB9QKg==
X-Received: by 2002:a05:6602:2804:b0:7c4:9459:3762 with SMTP id d4-20020a056602280400b007c494593762mr2738119ioe.9.1709220728486;
        Thu, 29 Feb 2024 07:32:08 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-217274.corp.robot.car (150.199.192.35.bc.googleusercontent.com. [35.192.199.150])
        by smtp.gmail.com with ESMTPSA id g2-20020a028502000000b00473e3c9d039sm381696jai.18.2024.02.29.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:32:07 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 4/4] qmi: Enable basic client creation if it is not subclassed
Date: Thu, 29 Feb 2024 09:31:41 -0600
Message-ID: <20240229153151.36410-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229153151.36410-1-steve.schrock@getcruise.com>
References: <20240229153151.36410-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: Y-G5Ipj0rcsCy6Hr5e8RzTRNHYHRN3re
X-Proofpoint-ORIG-GUID: Y-G5Ipj0rcsCy6Hr5e8RzTRNHYHRN3re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=980
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290119

QRTR does not require client ID allocation requests.
---
 drivers/qmimodem/qmi.c | 81 +++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index acb10d6b..58400aaf 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1386,6 +1386,25 @@ static uint8_t __ctl_request_submit(struct qmi_device_qmux *qmux,
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
@@ -1662,6 +1681,7 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	struct qmi_device *device = data->device;
 	struct qmi_service *service = NULL;
 	struct qmi_service *old_service = NULL;
+	struct qmi_service_info info;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
 	uint16_t len;
@@ -1684,21 +1704,12 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	if (client_id->service != data->type)
 		goto done;
 
-	service = l_new(struct qmi_service, 1);
-
-	service->ref_count = 1;
-	service->device = data->device;
-
-	service->info.service_type = data->type;
-	service->info.major = data->major;
-	service->info.minor = data->minor;
+	memset(&info, 0, sizeof(service->info));
+	info.service_type = data->type;
+	info.major = data->major;
+	info.minor = data->minor;
 
-	service->client_id = client_id->client;
-	service->notify_list = l_queue_new();
-
-	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id,
-					service->info.service_type);
+	service = service_create(device, &info, client_id->client);
 
 	hash_id = service_list_create_hash(service->info.service_type,
 							service->client_id);
@@ -2441,6 +2452,45 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
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
+		data->idle = l_idle_create(service_create_shared_reply,
+							data, NULL);
+
+		/* Not really discovery... just tracking the idle callback. */
+		__qmi_device_discovery_started(device, &data->super);
+
+		return true;
+	}
+
 	shared = l_hashmap_lookup(device->service_list,
 					L_UINT_TO_PTR(type_val | 0x80000000));
 
@@ -2484,9 +2534,6 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
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
