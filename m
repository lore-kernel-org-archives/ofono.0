Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A718627C
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157321; cv=none; b=gOo9V3vUzYQgWckWZiJI/j4cxdoLdHGLL9YL0ioMOmwr2IOkWxRN6zllGWUmN5qBEfDH6ut/qOfHzFK6LXgrblooxfgiwuaJgEFXLkuItyfh3veYB7qQBi9Cz/3cSRuXkZyGc1idBF+LaAQ0RiQqaE0xGiyUla/4KnIjaWzjsbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157321; c=relaxed/simple;
	bh=cJhO+e3E1sgxLx1pMijX0P3/3w1U4z4Csz5SEPqYmDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aOxa50hyPb4T7jjQq95iYcWY4GRI5unfaFvhxrmeyhCm8k3Ozj7rpC23Gz8BSI/fTdNqee11B1NJaRxyTmiTDP75f6gqZ+N0dQpkub4Uok9Dmyp3ZugN2nbZKOanWWhjXkXL2F1yO6kfc/BmJ9IVuvXvXOrPxRiiBFTbWUCwy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=llhp4NP6; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bRdoLmZ5; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="llhp4NP6";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bRdoLmZ5"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SGJCoY023941
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=qwvee3Lj+wq9GpF+Oqh79fyShcGxwGdm8LOe+UIQdBs=; b=l
	lhp4NP6KIKIKm9+ldqNX/yRrbfLm29MUg5pX8DAuCrSxdv7tJ7ccdKFP6pL1B++T
	QkJ1jzryUmkfh8QEhYC9HNVsN55LhVDpXRFpN3hCr0rqo5BRghjb1TCO+8WntnNf
	CO2IYmtPsyU7me7inTpjKxufAbPt7VrfR3sFZ+RyB1hWrInnnY0M2pi7X0r4LfIZ
	lNRVZZNZP7YaUGIuzwIRICM2PL3MElPKZbWHwY/miz+B/9nbGEdGDhYyN6yzkfun
	IKgb9IBLW6oZFQ02MvODh3RBe28j2vucsMC8fVptCywmW1Z/IVzaOQzH3MkREn1e
	+Br+bx/Zz899r1X7FA7sg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wff1xks7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:12 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-205fc343d1aso224661fac.1
        for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 13:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709157312; x=1709762112; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwvee3Lj+wq9GpF+Oqh79fyShcGxwGdm8LOe+UIQdBs=;
        b=bRdoLmZ5LTqJARauseV9h3PszNMfj1PG1bjHEPxNvuY0IcOAGPCDz2osRxl7cFlKbN
         8m92m2AIPRnFpWA5m/eHkeRCUZ+9ZFSspSXt1/rOBcbTcem86zD/5Eo9aIU0ZK6GQx0s
         /QDPz/aU5JvZwBNGpR3X+bg+oy2roFcavuo6Cxo75tymE7GUNcrNx3JBV0BGBjqjEHPv
         MqRqxiqGl/TUU7TP+EkXvE+pXBxvfDByEA2/HzULPhPGwroVXr72RP3oCqEGJQI6bDCF
         QBx+YoO9pmO7PKAvRHmTbLSRNXcYmh09QFoiC85BtWMaPPHnbDDSF08JCnpdWygGBGCY
         mBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709157312; x=1709762112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwvee3Lj+wq9GpF+Oqh79fyShcGxwGdm8LOe+UIQdBs=;
        b=qZ4nu+O98iFfez15acoWW7bxBX+ZF/ti6s6xYQ8bDHep+cVkGUv3NT/z7EFAy5D1u3
         ZkQ0NXrtif3w1M3VKxYlhrH6Y6s6heRUhnWLea7L6+TFEHXQfmMms+jFzfbJ00gTIA5u
         twA2IhaWbg9ij28eyGTkEszUYaEKmyKUn4mwpFL57zze2DxcHZ6w/cK+VcPUZr/GtRsB
         +k4PYNzHSC8qXos/B/nek6DQKU0/82+lkCqP6gubS+DBNo5UFwIsBYk81iqHgEak0xT3
         mjUi2EkP4cfn0LAq8YMfb0mwTd3IWSDH2fWfDADTThlfg4+1Rm0yGq2Q6tg9dSjzM4eX
         LG/Q==
X-Gm-Message-State: AOJu0YxCUJAScPfiyWTLoTSXwXcR+lIWaIbbOH3ml30a/8xnWwfvqbZw
	cRof/sTbHQykos2V0PmDunx4zyzzIvLlXbqELhmbnKf1AWnGQk59Sc+AoNyCAJV+s0+qMuB2EI2
	pvrXme0MSvNmx1zl+zxNX6jpo3lTBNMXe7+7G4xaRjLMr6/6lbuYXx4bYbNNDTv3NR5ztHpgg9w
	q/fz/9w5zFfPRiaRp8tDPWUyVdlzrQL/SSPCItVgoXatYrPDc=
X-Received: by 2002:a05:6870:30b:b0:21f:d1e6:d8e1 with SMTP id m11-20020a056870030b00b0021fd1e6d8e1mr156271oaf.27.1709157310710;
        Wed, 28 Feb 2024 13:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeimwLPjsvHio1Gw7sZJPxzEm59CgI+ZCnBpcxDnG+z2tLXhn/r58EcbuHqHWJpqgVdAHI6w==
X-Received: by 2002:a05:6870:30b:b0:21f:d1e6:d8e1 with SMTP id m11-20020a056870030b00b0021fd1e6d8e1mr156257oaf.27.1709157310239;
        Wed, 28 Feb 2024 13:55:10 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b00787c6ed9a68sm33963qkl.91.2024.02.28.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:55:09 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/4] qmi: Create a method to find a service by type
Date: Wed, 28 Feb 2024 21:53:16 +0000
Message-Id: <20240228215319.153068-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 0z9ycmWB95o7vpLmtQK9YwMcBp9FLaOd
X-Proofpoint-ORIG-GUID: 0z9ycmWB95o7vpLmtQK9YwMcBp9FLaOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280174

---
 drivers/qmimodem/qmi.c | 43 +++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ffb26326..aca4df0d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -953,39 +953,44 @@ static const void *tlv_get(const void *data, uint16_t size,
 	return NULL;
 }
 
-bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
-					uint16_t *major, uint16_t *minor)
+static const struct qmi_service_info *__find_service_info_by_type(
+				struct qmi_device *device, uint16_t type)
 {
+	const struct qmi_service_info *info = NULL;
 	const struct l_queue_entry *entry;
 
 	for (entry = l_queue_get_entries(device->service_infos);
 						entry; entry = entry->next) {
-		const struct qmi_service_info *info = entry->data;
-
-		if (info->service_type != type)
-			continue;
+		info = entry->data;
 
-		*major = info->major;
-		*minor = info->minor;
-		return true;
+		if (info->service_type == type)
+			break;
 	}
 
-	return false;
+	return info;
 }
 
-bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
+bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
+					uint16_t *major, uint16_t *minor)
 {
-	const struct l_queue_entry *entry;
+	const struct qmi_service_info *info;
 
-	for (entry = l_queue_get_entries(device->service_infos);
-						entry; entry = entry->next) {
-		const struct qmi_service_info *info = entry->data;
+	info = __find_service_info_by_type(device, type);
+	if (!info)
+		return false;
 
-		if (info->service_type == type)
-			return true;
-	}
+	*major = info->major;
+	*minor = info->minor;
+	return true;
+}
 
-	return false;
+bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
+{
+	const struct qmi_service_info *info;
+
+	info = __find_service_info_by_type(device, type);
+
+	return info != NULL;
 }
 
 struct discover_data {
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
