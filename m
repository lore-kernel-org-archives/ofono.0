Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212F58234
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200943; cv=none; b=cHeuuGgg80M7wSfPtBh7CEayPmjFM+3pjwHc8Uk2awEou1GEQ4pErEOCmV19mCvWA2Lgb8xJfeAzre2VK0uMfIRw7coDYJPKu2kE8zq3xik5H3HtMm582Efvc14Lk2c4xqnrL09Ndnh4V6S64/w+6rgOJ0Ss3dKHWv12frPlF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200943; c=relaxed/simple;
	bh=VxiNCbJgXUDufobgSg9P4c/09/0x6nwZw9r6NZ5DSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzIKap2xugatBsW4RKe7ci8AQpHc+j0hNBdXnyl7PU5OBj/BOOTfG7UCvYSIpR1j7jjCobnFb0XfvxmVgiR/8wjJMtAueil7V6DpmxvYx220KhH6El6SPVIN9oeJNgnN9rH3mDJLF8khc16tpTrv6CaSb6tiuaxNLsZvxIVaBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=pH2IqWYj; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=C2ab8RQE; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="pH2IqWYj";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="C2ab8RQE"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BHeLW2030781
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=91N3vXZ8ENQBllmUnaxqYTXGCB6BCxGB4Sv9846mNaU=; b=p
	H2IqWYjzrOcsYRlNr2T28m34UBH48dS8ll+db+snc3m18ZULtOOQPq7lkyBgcqwH
	WMjr8qbrCPkL1MCAN5LNy5U6P9z17w+O6FCMBQRAyzyqOqcYZKwLeKA/6hoxn5zZ
	ADpycQ9VipZIOhT52R1YUjIS8KZcw/nSw1bRWoVrWqi0O9+KoTT8jjam+SvMea7e
	ajP9bnj9hb12Tj8ZuUu2ozfMFJIh1PL6kBMMie5hauJTCwS49vprPYAzyiajmG9R
	QHE517Ax2fxkD3hLf9w5po3V9Irr9gj/LPCjip0LKrR/YA2oTK9a5VTJNbaFn62u
	BBbRuCoS9rvZJTSI4yjQQ==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wrn27sk6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:20:59 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3665283d42cso16593595ab.2
        for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710199258; x=1710804058; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91N3vXZ8ENQBllmUnaxqYTXGCB6BCxGB4Sv9846mNaU=;
        b=C2ab8RQEzKurn4Z4zDwfJZSodp3Ba2+QrosBE961KyEi/WiKhhPGhGOgEQ/rjVBx2Y
         KJXYCU6kuUg6V2aHnk3e4+Am0cXlY4CkHVhPxMhDJ1J1YeipUEa1djEE93Vk67hl6nNI
         J5gQtOk+wy2nIjL0Tw9/PS67pFXtmBPJUETy+osaODY65H1oAyFGTmo9eZ8xXENUJAbU
         GszwoMnGs8aLPiqs2A1bNR7O7YIsSkw39anFEOjITO5maww/z5GNxCF6ZT5S9WEnaRk2
         CfqJrUbwZiY4RvjjyiUJvjytzVmLSA0dVW4X33QWnSae+Y9hbtQLAajxupdVjUcB20wd
         4tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199258; x=1710804058;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91N3vXZ8ENQBllmUnaxqYTXGCB6BCxGB4Sv9846mNaU=;
        b=aRtG3w3Zmi/iScJXJ7a7x3rvSlU9mwhFd95YD5RfA7euFWIuLy76z6KGJUum9aG42Q
         urJNPvSaagO0UQkm7TYoH6xAKozj2IXYwuC9Em5pNXk1nSqpnMXxM7uAboFrT2cdi3//
         +CjkBTtFBvd8PZk/YyQdzuJj4RCrfQG3axjAZVeNobL9Q1YO5Iri8Mvc6RKtMK+0EdfP
         ITOm6oB5oyhPVnFU+xvTvzoulQd4fen9LKe2fdaCnO/8AGR5tix+B2s6SaFAiYNAZH6P
         ixYXXYSIkvVZ/gOP9b6P+19fk/ftS2tpdvTwIMTXCeIjdA9jXy5dnSjGCZPSM6f5Xzpm
         kpQQ==
X-Gm-Message-State: AOJu0YyFkPYSKXeZyrhGV5pVAr0bvWRrVjr9JyOa34kpdezTG+V+lFpV
	+o4C2AP8gmRm3QULt8nfXu0tmvVeEvmoYrOfk0O923Gm+HohMlhizygt677TvXIiS46Tcji2bKN
	oXmVBwYge/vXqaUnwFJbK1vPhQrplZsdSZQ/zV/kJYJar+NJy0X0N8P8+Vw0vlhAo9CSQYF3SL3
	VvjAGbomEspq/Dh0RgHxHo26ZLa2dAAxiKlW/rIzwt4ZY/H8M=
X-Received: by 2002:a05:6e02:1d07:b0:363:d816:937b with SMTP id i7-20020a056e021d0700b00363d816937bmr10542536ila.3.1710199258587;
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWQwlhJXuK5+86/d0EZuTteJfLx1n/kELQW/9yA0890FROqvd1LmlT5I4U28MPcK8VHQpYuw==
X-Received: by 2002:a05:6e02:1d07:b0:363:d816:937b with SMTP id i7-20020a056e021d0700b00363d816937bmr10542524ila.3.1710199258166;
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-164157.corp.robot.car (98.32.128.34.bc.googleusercontent.com. [34.128.32.98])
        by smtp.gmail.com with ESMTPSA id n14-20020a056e0208ee00b003660537d47asm1975643ilt.69.2024.03.11.16.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:20:57 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/3] qmi: Discover timeout could cause a crash
Date: Mon, 11 Mar 2024 18:20:32 -0500
Message-ID: <20240311232036.49381-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 07cfKOXKrrckhZls_PZw_rRlOBq03EZL
X-Proofpoint-ORIG-GUID: 07cfKOXKrrckhZls_PZw_rRlOBq03EZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110180

The DISCOVERY_DONE macro assumes that the provided data is valid.
Unofortunately if the queue is empty due to a discover timeout, the
value would either be NULL or the next "discovery" item on the queue
which is not necessarily a discover action. This change addresses
each of these possibilities.
---
 drivers/qmimodem/qmi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3408c32a..31f88114 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -46,8 +46,15 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 
+enum discovery_type {
+	DISCOVERY_TYPE_QMUX_CLIENT_CREATE_DATA,
+	DISCOVERY_TYPE_DISCOVER,
+	DISCOVERY_TYPE_SERVICE_CREATE_SHARED,
+};
+
 struct discovery {
 	qmi_destroy_func_t destroy;
+	enum discovery_type type;
 };
 
 struct qmi_service_info {
@@ -1651,6 +1658,7 @@ static int qmi_device_qmux_discover(struct qmi_device *device,
 	data = l_new(struct discover_data, 1);
 
 	data->super.destroy = discover_data_free;
+	data->super.type = DISCOVERY_TYPE_DISCOVER;
 	data->device = device;
 	data->func = func;
 	data->user_data = user_data;
@@ -1790,6 +1798,7 @@ static int qmi_device_qmux_client_create(struct qmi_device *device,
 	data = l_new(struct qmux_client_create_data, 1);
 
 	data->super.destroy = qmux_client_create_data_free;
+	data->super.type = DISCOVERY_TYPE_QMUX_CLIENT_CREATE_DATA;
 	data->device = device;
 	data->type = service_type;
 	data->func = func;
@@ -2045,8 +2054,17 @@ static void qrtr_received_control_packet(struct qmi_device *device,
 		DBG("Initial service discovery has completed");
 
 		data = l_queue_peek_head(device->discovery_queue);
-		DISCOVERY_DONE(data, data->user_data);
+		if (!data) {
+			DBG("discovery_queue is empty"); /* likely a timeout */
+			return;
+		} else if (data->super.type != DISCOVERY_TYPE_DISCOVER) {
+			/* The first client action should be discover */
+			DBG("discovery_queue head type is not discovery: %d",
+				data->super.type);
+			return;
+		}
 
+		DISCOVERY_DONE(data, data->user_data);
 		return;
 	}
 
@@ -2164,6 +2182,7 @@ static int qmi_device_qrtr_discover(struct qmi_device *device,
 	data = l_new(struct discover_data, 1);
 
 	data->super.destroy = discover_data_free;
+	data->super.type = DISCOVERY_TYPE_DISCOVER;
 	data->device = device;
 	data->func = func;
 	data->user_data = user_data;
@@ -2575,6 +2594,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data = l_new(struct service_create_shared_data, 1);
 
 		data->super.destroy = service_create_shared_data_free;
+		data->super.type = DISCOVERY_TYPE_SERVICE_CREATE_SHARED;
 		data->device = device;
 		data->func = func;
 		data->user_data = user_data;
@@ -2616,6 +2636,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 		data = l_new(struct service_create_shared_data, 1);
 
 		data->super.destroy = service_create_shared_data_free;
+		data->super.type = DISCOVERY_TYPE_SERVICE_CREATE_SHARED;
 		data->device = device;
 		data->func = func;
 		data->user_data = user_data;
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
