Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC597005A
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157323; cv=none; b=kinzAksHAAU9nMXB4l0RCwT44xex2cN6L7KCPWJy+4L8exSnC7pQOCQIWbxonRJ/1e+Ks9tyrh1+r+qEdfHdC/HxC3yCkMlk70j+OwWk/4x7KLsrihGW0+AwESvfVWeON/vGTzc+p6Kjcouk2yDWInvbTTYPwkVCa7CAchuAcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157323; c=relaxed/simple;
	bh=0nfuaSP6gKoMPLQfx+sWn3YgfpUNKb/jK2ZX+jHiCQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAnA/02DrmpRVoZD+KNNSOeatqgltd1/kd9jNkjlbXl4ZnCjaJ3Vzpg2zJFJffCm8+j24oQrDx7M4lJ/aiPQhgfN8YZX19A9oJwMpNzJ47ZduD6RvgILcDob24oanaJjWRZRhIFHKa3xJRQ6a7wjao5FlFuNJD1KNKsXyo6Ah2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=F6EQpwY1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=oMx9PE/i; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="F6EQpwY1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="oMx9PE/i"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDVp5R011822
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=jojanBxAb6l9xElYvxk2E5
	dp7BQRcUgBKPh8s2VW6xw=; b=F6EQpwY1D7WkELtpeGJcxeXirPZp0vy2dPvMg3
	L1/XhGWsEzjCGsCANh3U5qaLG4uFyC0Wkxqeo7fRxZ39r8oRi2SopeRQFPON7o9F
	RvXxZKFzU40YJrvaSrwN4nikucmWR/a75ZZTiNrP+e9Glrv8PzWo320O9d4rkEHE
	gWb3uGpSDILRPjA0qd7I9vt/vGE8sE1g3McMsjQjYBV8qA1ohd2w5BNOqNFhCl+t
	HVtWLW0yYUw3v7MRG66C1KPWTzf/AOk3knCP3CKMq7MxDrRgzOr09MFl3kU/eqoX
	HPFHV9ddKHch6T6sISROVTs3fJHnRZwFrmWe9RgXx1SH6rVw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wgygr2fex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-21e7751f76fso171284fac.2
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709157312; x=1709762112; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jojanBxAb6l9xElYvxk2E5dp7BQRcUgBKPh8s2VW6xw=;
        b=oMx9PE/ihswrcTwLbaeJnIVkciatT6VJfMDw+gHK9llVMOr2t1mTcXYf7Tyf7Bf7xN
         LONL6tjQB5fcBDU3/U2k1rLG3l0yPOwWbg3MdMJnG2Lhz9z2iLYvoR7JEQbJ63grPdQh
         Z3Nm456cqu5rLDpgB0dDN24J12lfcArspjftPRsWHaf8kTEuukA56UETV6QibcQkPcC7
         HXI43zC4pcO6U3Fa3XpCdJOmyvj6xpDxS4pKlJZk1lX0Iog2R3uylrnbDEQB3vZwkMVQ
         z4Uzd/SzsIqatZtZZz/kMjT2ixqmulv2kQBpr6AafbYua/C3VzuP73ewQOwufHbMOBqu
         +2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157312; x=1709762112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jojanBxAb6l9xElYvxk2E5dp7BQRcUgBKPh8s2VW6xw=;
        b=EidLk4Q2VgD8p1vxFcjQr5nxKBbD3645B+jQbMXpp/Jr+3+xg6VMvJoBww/7a/kdBB
         UpAbc3t+AnDfAUtiuApB+uvZBObsmCpwQDoK7iSzSU9YcD7V8jBbz/zj0Tz9iMh2yLm+
         Yu4TQondRHDijNr3XLLRzBE/hqa5BbiMA4p+oGOwkiHjxsmcEeAMdC6aV6e9gzJN/wWe
         auuu2oJHKhWqjGB1qPJkqqOu4/NAsQX2Fn5ndY28GbkD0ugdJffBRRktKgsD9xbSpSld
         nXWtyWLjLs3M3rBBUAUdFF/95tSHlm3KWJIKkGh5tyxzbHwn1tmA+bjhUKFVKchkS4bc
         /QCA==
X-Gm-Message-State: AOJu0Yzh28Om6UNCWguHN9Y1d5sFMJ/ZZCnhPqlhFwA77Oxdu4n5T7/d
	AizNIE/1g+sXsmX0vJ5UmrB/rDzBbNKdBMy8VvxyPrw4uKl6mzfnL7PMyV0nF03gXPAZ8vGcI9J
	KOjCoBXJ313OSXvjj9I3n0I44L1UryT5FwzP+rs4UjlTs2ynBnPARX1nFXqYgUKMMz7JRXaGiRf
	Z+B/IgJ+8Fd8p66hUIsjlxeVIgygvYZUCTdyfhSrm0iwKqvTw=
X-Received: by 2002:a05:6870:f14a:b0:21e:8dc7:342e with SMTP id l10-20020a056870f14a00b0021e8dc7342emr154033oac.25.1709157312496;
        Wed, 28 Feb 2024 13:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbGBLnCT8QfzIQAjU6Q9Ba6o1cYhW85k7Uzru7jKVMylMtCcrkgGMdlNdAwiTdXg81QFcwVg==
X-Received: by 2002:a05:6870:f14a:b0:21e:8dc7:342e with SMTP id l10-20020a056870f14a00b0021e8dc7342emr153983oac.25.1709157311066;
        Wed, 28 Feb 2024 13:55:11 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm33963qkl.91.2024.02.28.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:55:10 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/4] qmi: Add more service info to qmi_service
Date: Wed, 28 Feb 2024 21:53:17 +0000
Message-Id: <20240228215319.153068-2-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: WPbdxexpyOXrY6TsR3BZp-VRAXG4wCaN
X-Proofpoint-GUID: WPbdxexpyOXrY6TsR3BZp-VRAXG4wCaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280173

QRTR will need to know the node and port for writes.
---
 drivers/qmimodem/qmi.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index aca4df0d..a297a77f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -118,9 +118,7 @@ struct qmi_device_qmux {
 struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
+	struct qmi_service_info info;
 	uint8_t client_id;
 	uint16_t next_notify_id;
 	struct l_queue *notify_list;
@@ -315,7 +313,7 @@ static void __service_find_by_type(const void *key, void *value,
 	if (L_PTR_TO_UINT(key) & 0x80000000)
 		return;
 
-	if (service->type == data->type)
+	if (service->info.service_type == data->type)
 		data->found_service = service;
 }
 
@@ -1689,17 +1687,18 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 	service->ref_count = 1;
 	service->device = data->device;
 
-	service->type = data->type;
-	service->major = data->major;
-	service->minor = data->minor;
+	service->info.service_type = data->type;
+	service->info.major = data->major;
+	service->info.minor = data->minor;
 
 	service->client_id = client_id->client;
 	service->notify_list = l_queue_new();
 
 	__debug_device(device, "service created [client=%d,type=%d]",
-					service->client_id, service->type);
+					service->client_id,
+					service->info.service_type);
 
-	hash_id = service->type | (service->client_id << 8);
+	hash_id = service->info.service_type | (service->client_id << 8);
 
 	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
 				service, (void **) &old_service);
@@ -2528,12 +2527,12 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
-	hash_id = service->type | (service->client_id << 8);
+	hash_id = service->info.service_type | (service->client_id << 8);
 
 	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
 
 	if (device->ops->client_release)
-		device->ops->client_release(device, service->type,
+		device->ops->client_release(device, service->info.service_type,
 							service->client_id);
 
 	l_free(service);
@@ -2544,7 +2543,7 @@ const char *qmi_service_get_identifier(struct qmi_service *service)
 	if (!service)
 		return NULL;
 
-	return __service_type_to_string(service->type);
+	return __service_type_to_string(service->info.service_type);
 }
 
 bool qmi_service_get_version(struct qmi_service *service,
@@ -2554,10 +2553,10 @@ bool qmi_service_get_version(struct qmi_service *service,
 		return false;
 
 	if (major)
-		*major = service->major;
+		*major = service->info.major;
 
 	if (minor)
-		*minor = service->minor;
+		*minor = service->info.minor;
 
 	return true;
 }
@@ -2631,7 +2630,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data = user_data;
 	data->destroy = destroy;
 
-	req = __request_alloc(service->type, service->client_id,
+	req = __request_alloc(service->info.service_type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
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
