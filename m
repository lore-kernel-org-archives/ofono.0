Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A763D71
	for <ofono@lists.linux.dev>; Sat, 17 Feb 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708130938; cv=none; b=AhthITu2NqmKDS1od701j5esUQu7fftLn6sOZGj3A2jRNWvXYsxcHGS/ioOrpAIISsITXI7VENL+ro8KfVkk9w22xWCvveNDaYc4wtypaPQFzKo/0m75KkfcrFpYeO4HHOoHmvk9oQaYiArJNIy/qY03aWYG9IcF46rujk0YqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708130938; c=relaxed/simple;
	bh=5IDLS/4KKexI8Mp9AJBEk8V6lRGv2liwq19dAk/+L3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=STzXwCtWW7UF8J85rvE9uRZy5AWdIV8yERXT0qv1g6khf/21wHRigkjY/bPh5J02euXwSWJuxCXXzIQ4Qx/c/Ae+ZU+opWubBdnnrvhPwi3g5XXgvcMx6YxfG9NXFnQpTvekWQEyIC6+3QN+CdTcz/qAJLap1L/8/2oJBw0/Iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bc9b5gCi; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=P2CEDtgM; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bc9b5gCi";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="P2CEDtgM"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GEgfe6000425
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=BqaOMPxxr7BjrQFzF2vrdwo1ZfXpKmRI3sB+yyHkQ4Y=; b=b
	c9b5gCitX8xspiO+7gsWWKu/NeWQDZ6v5rPQJlKZjSwhn7H1S8M175V2001GOJDn
	mVdPUyTDHvzdyR14BGGzF0ZSpEV6J7YOSxAnGk5hobhfVgnEOgLVTjS9/oXKOaEm
	BvY8jXXl/Y9VtVmd5GG46jGfKu2IpkCsWmptfY9pzb8JjseCubyASU/ahSq+QCBo
	1IzOu1TcXGDEr7AjHylkVj2Nbm0L643L1TYtyq19YE1NGlT3WZvHKJe2wse1UTkO
	+dA69YCa4KpEjdcnRqJaJ5Tpw2pEjZneZboM84GnIqZstgBbp9SDQBJ5mmstAlzq
	1b9l+go2ibMtlvnkHyQHw==
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3w715mwmsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:01 -0800 (PST)
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso5437209276.3
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708129920; x=1708734720; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BqaOMPxxr7BjrQFzF2vrdwo1ZfXpKmRI3sB+yyHkQ4Y=;
        b=P2CEDtgMA4eCybWDlNB+qAgHdm8sZuMpmJPVYgM9I/+q8qG3fBHqQBKCjA7hswa6q1
         tMXmcKy4HmszZ/P+BexS+bTbLYk0LbGjXzndqY7R+0xvLBcLvpZhQp3tfyes2K9smSdz
         mxnA5bvqIOEJkw7v9SEzasMcyHjHHBrdxqfuCPwl3/O7J+AJYi2PdyCDbs4P37bo/u1J
         O0VXBV09lOmpyOhMGSG2LY+17ALaOXT2hoVwWgM4OFJ2faubaeetEar38QPQr6lWCn54
         f35miiVFCC3yPYnIJ7ZuEcCU23dMD5NwjWuW9560s09EQOs6UStgTe6dtAEMremS9Mw9
         SPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708129920; x=1708734720;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqaOMPxxr7BjrQFzF2vrdwo1ZfXpKmRI3sB+yyHkQ4Y=;
        b=CTv+WZEFiP/WvK8MZaTHj4KWY5m7PoNeAZQMTCPfGs+6OB7Y/gZzWnTN+a79eES9Tm
         wfP2ppTcsDgHusK4h4GW85k09XMkM7hVE6mhvDbmHxVj1fm6P358LDxL9eMXumTL0D0c
         bi/2miRwlAvvFP4fkNcsjDIOwEQMPFfGLZBZcdmbULO1BIrKGc/DHGhSvQJm8G/l4SZG
         SQxX+dnIMjQyGPyHY48LuUa6tsVRBeVWv7wGLeHt1D56m+skJiGMLPWDcFLR0fBqgGgh
         DiwOATN4xqKFBPmrgO8VihpiCGj16XgACK1TGyrd8ApVYyMIQKx2NAeMsLKFZ8oCTnBV
         0vVA==
X-Gm-Message-State: AOJu0YzrkQk8x4CK9BgLCJpJ7kmdbem2aH/pEXU1kIkfjLBrbAfJDI4U
	qh1CUcy2tNMJJiG68+LJgBhncPrc07OT5F4uexT5+bOdIzcMHLzBCYHxW/t88AvuZA8jG0WdDmF
	Li0KpcRHuaL250tRoOauZT/yDXwXYLCNsztFXne82r4EsiIKhViHpsxwJ7TgS3Jdxc7C137Kcra
	E5sMLZNFICRlCE/yEKiglRyQURbpXEbRxGujfpsH8SFA6Fx9Q=
X-Received: by 2002:a05:6902:4ca:b0:dcc:8e02:a6b6 with SMTP id v10-20020a05690204ca00b00dcc8e02a6b6mr6993814ybs.2.1708129919698;
        Fri, 16 Feb 2024 16:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH23MS60QTUmLDKWnFnNHnT1RUe+nadlNlA5M2PysLpb3enAo6/1USL9Kklg5tjnkxhWpfbUw==
X-Received: by 2002:a05:6902:4ca:b0:dcc:8e02:a6b6 with SMTP id v10-20020a05690204ca00b00dcc8e02a6b6mr6993804ybs.2.1708129919325;
        Fri, 16 Feb 2024 16:31:59 -0800 (PST)
Received: from localhost.localdomain ([140.177.143.152])
        by smtp.gmail.com with ESMTPSA id e3-20020a05620a12c300b0078606e85a8esm400312qkl.107.2024.02.16.16.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:31:59 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/2] qmimodem: Support 16-bit service types
Date: Sat, 17 Feb 2024 00:30:31 +0000
Message-Id: <20240217003032.76366-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: Kxi4HloLsN2ITHxA7NqxVFfV1c3pl9pq
X-Proofpoint-ORIG-GUID: Kxi4HloLsN2ITHxA7NqxVFfV1c3pl9pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_24,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170001

Prepare for QRTR which has service types greater than 255.
---
 drivers/qmimodem/qmi.c | 8 ++++----
 drivers/qmimodem/qmi.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 7f0d6054..3c8c00a6 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1115,7 +1115,7 @@ static const void *tlv_get(const void *data, uint16_t size,
 	return NULL;
 }
 
-bool qmi_device_get_service_version(struct qmi_device *device, uint8_t type,
+bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
 					uint16_t *major, uint16_t *minor)
 {
 	struct qmi_version *info;
@@ -1134,7 +1134,7 @@ bool qmi_device_get_service_version(struct qmi_device *device, uint8_t type,
 	return false;
 }
 
-bool qmi_device_has_service(struct qmi_device *device, uint8_t type)
+bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
 {
 	struct qmi_version *info;
 	int i;
@@ -2171,7 +2171,7 @@ static void service_create_shared_data_free(gpointer user_data)
 	g_free(data);
 }
 
-bool qmi_service_create_shared(struct qmi_device *device, uint8_t type,
+bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			qmi_create_func_t func, void *user_data,
 			qmi_destroy_func_t destroy)
 {
@@ -2227,7 +2227,7 @@ bool qmi_service_create_shared(struct qmi_device *device, uint8_t type,
 }
 
 bool qmi_service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
+				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	return qmi_service_create_shared(device, type, func,
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 8006e015..3fdf960b 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -97,8 +97,8 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
-bool qmi_device_has_service(struct qmi_device *device, uint8_t type);
-bool qmi_device_get_service_version(struct qmi_device *device, uint8_t type,
+bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
+bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
 					uint16_t *major, uint16_t *minor);
 
 bool qmi_device_sync(struct qmi_device *device,
@@ -158,10 +158,10 @@ typedef void (*qmi_result_func_t)(struct qmi_result *result, void *user_data);
 typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 
 bool qmi_service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
+				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_create_shared(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
+				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
 struct qmi_service *qmi_service_ref(struct qmi_service *service);
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
