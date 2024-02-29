Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246501386A5
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220731; cv=none; b=hgkR+4uuuMbb2InUUPbIg9tJrJjp5WYfD0rLMSraQajURl/vUBfN/M+u4MYIbb5esarvzRYBW3SV9wUR4YAaf3Ozfa49V3x9TJGAhjcLVPmBUC4D6CF0X6bo2V3SzI1NsW0erGtiknwleax23tK+TRmr4WfLQkHwJRw6fjMtzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220731; c=relaxed/simple;
	bh=1fM1vXMyxo/9g23iyWbfivoIq8u1mrPr+h+RWYzUzLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCMcILgTkEVpI5yEIUghNfLiPV+N+f/H9dCVM2Ue1uhW1gjsL0JJcpt1/DzGh/Vdt81VXE1jlaiS7aN7JN41+HuYIcMrIeTcu+KTe5fyExF7S0wzyIilucCOEysmlHq6ZgGLCYyMJ5/IBxdQypRS6oryvtBhO9v58f5NHSxfeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UJQKdnr6; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UG46XsFb; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UJQKdnr6";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UG46XsFb"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TFSltw003363
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=5kohQ7WQuq2D5N+7aA5ozT
	xQA/INH9bQm/KJLtJzuRE=; b=UJQKdnr6SEX34ZlAMeykV+nxLiKioCkBZ69f9a
	cBgJCqxCzYXmx7VwJX8QdsQabj0ACSUmF2gvzhmrd5KyD5WFnCchtzsY+ilyg4Q/
	R8zEtv+D/Tx6HZSVMcBCcEVFejhAa9Fg9Vqhb+xbbd6HiAUu2ucH5oBMSdL7IQZg
	2oDPrMzP4S3TaocBAT6XUCQFT1swhOPC25lS6COGmeyBL87T6Sb8B7ypG4YloCLD
	ecLa5oyY+5bhQPR+j2a0y+dX2df23oxlyGI+X2k2X1/t36xsPLDuAiB0lLI5EM0H
	SIgmeIzyJU+49l11Pw0mce//NWvwW/IrWFwFyJyALpbFFccQ==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjenkrgqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:08 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7857e6d5dso131686039f.1
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709220727; x=1709825527; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kohQ7WQuq2D5N+7aA5ozTxQA/INH9bQm/KJLtJzuRE=;
        b=UG46XsFbFAKPx78NNVy2nZY/TngSCfJA3LF3bHCahIwaVd4vEkg2cejGSiXh+MnP/p
         wFnsLndE4T4/XTzLvh0aHWpm/ztE+wBxgbHEsCgqUWuOXXRls3rqEaIMkQlA8VdK84iJ
         t7t5K1mynHO6z6IEDd5CIfFB/DRkJdLmsOALMKle1TyAFVAXn49J1HAlX49W+K4+0xh9
         hRVPL4/qFMZRkTFVqVPgQUCGKrLADXREMHdoJueKIF2PPCqDMJ3HyBYN3YYPS6k/AWFf
         OPV4Zt+k385ydpzRg/oWSuQmmBhX3XqZ3ByOPupLMsumONvdo/3FsrVIJK7uU1GC7Asn
         +wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220727; x=1709825527;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kohQ7WQuq2D5N+7aA5ozTxQA/INH9bQm/KJLtJzuRE=;
        b=LPkJWBIxyrjvTSN4BQHa5kU77sNYjRgE1M5/e1Tuoi0hnvPkGnWiehP8ez/DuLf1OD
         T6KYD3+40mY5cfNNVpLBRPVR8agYZ6Sc8gbuEEHTj/evLQqZWViCOaihPTX9g13IUo2U
         vyZFnHkWBvEKaLCWNhDJjNyYgrc2LiH6tWioepRzmP+09lDGLDpyguYKbPdJNGxmoGaH
         KwW8F3qi1TQhvIyYfDRwZPtltj7kY413g9G6dbGP7wBXcrluoexMVMs0XRWDqlzsXyXb
         +4Kt0J1qG5gViYwUJePEowhjMIqSMwbM00LOx7xPa3oSBHOk3hGO1b06f2Lp23hxU3f2
         6A8Q==
X-Gm-Message-State: AOJu0YxQaK18GsSfLS+2EuKVJjDNlDsy+6WvwQQPAbtr6Ytwu28lL0W2
	Ff0SNdjKGhbUloo2iWaDrkEbFPxt4eOq9yvUicRJiZ1mTm7L5fGhPgLQqUyGGn8tbYIG1t/56V/
	8KO6vV1Ar8WMlzXDpO9nE+BCFdwkasiZZt8kmP9B5abdF/ij96bQxccOBZ7DwKQvyMHrGiGJ8ca
	mXvatNkAIIjZITXGbI34bVEgxn6yG7TKn+ux/wcJgilqhYtVo=
X-Received: by 2002:a5e:9810:0:b0:7c7:9184:df98 with SMTP id s16-20020a5e9810000000b007c79184df98mr2760382ioj.12.1709220727580;
        Thu, 29 Feb 2024 07:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsmStIrflPN39IhZP7cA4iPi+yFXI1ewVlFhJnkzFZ9VwvSCLo6hpysTIbk06KdwWR8oNcoQ==
X-Received: by 2002:a5e:9810:0:b0:7c7:9184:df98 with SMTP id s16-20020a5e9810000000b007c79184df98mr2760362ioj.12.1709220727208;
        Thu, 29 Feb 2024 07:32:07 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-217274.corp.robot.car (150.199.192.35.bc.googleusercontent.com. [35.192.199.150])
        by smtp.gmail.com with ESMTPSA id g2-20020a028502000000b00473e3c9d039sm381696jai.18.2024.02.29.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:32:07 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 3/4] qmi: Allow for 16-bit service types in the type hash
Date: Thu, 29 Feb 2024 09:31:40 -0600
Message-ID: <20240229153151.36410-3-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: AgGg1NhfYUZvwAxYfONVg0Axkugds18P
X-Proofpoint-GUID: AgGg1NhfYUZvwAxYfONVg0Axkugds18P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290119

Only QMUX has client ids and they fit into 8 bits.
---
 drivers/qmimodem/qmi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d2f28bec..acb10d6b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -734,6 +734,11 @@ static void service_notify(const void *key, void *value, void *user_data)
 				result);
 }
 
+static unsigned int service_list_create_hash(uint16_t service_type, uint8_t client_id)
+{
+	return (service_type | (client_id << 16));
+}
+
 static void handle_indication(struct qmi_device *device,
 			uint8_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
@@ -757,8 +762,7 @@ static void handle_indication(struct qmi_device *device,
 		return;
 	}
 
-	hash_id = service_type | (client_id << 8);
-
+	hash_id = service_list_create_hash(service_type, client_id);
 	service = l_hashmap_lookup(device->service_list,
 					L_UINT_TO_PTR(hash_id));
 
@@ -1696,8 +1700,8 @@ static void qmux_client_create_callback(uint16_t message, uint16_t length,
 					service->client_id,
 					service->info.service_type);
 
-	hash_id = service->info.service_type | (service->client_id << 8);
-
+	hash_id = service_list_create_hash(service->info.service_type,
+							service->client_id);
 	l_hashmap_replace(device->service_list, L_UINT_TO_PTR(hash_id),
 				service, (void **) &old_service);
 
@@ -2525,8 +2529,8 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 
-	hash_id = service->info.service_type | (service->client_id << 8);
-
+	hash_id = service_list_create_hash(service->info.service_type,
+							service->client_id);
 	l_hashmap_remove(device->service_list, L_UINT_TO_PTR(hash_id));
 
 	if (device->ops->client_release)
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
