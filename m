Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3413EFF6
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220737; cv=none; b=ZxVG1oSmmvY+mlTukvhNgMBN1/GkHEwZ4L+cpa9f2E4PZPl5v7Eg9UpAtFqZqT0s520aiBT1bTjlN2dxPr9m/naeNsS+7Di7yGiYwOtDwmZ+b0Ya/qUYeeaM+ODh646HXIAR7IaXONpNNtssfsdzBdsmbnjrFtHG0f0GY6eLPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220737; c=relaxed/simple;
	bh=mdyeeo6t8VMSlA29up5NNef9fKIVRtGaa/g+r2OqOWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJ6ePcr2VyLfszaFtLcrb2UltvfnLztAo7h6IOEVF0HjXn53MxeM3ZttYB3guwRMMwjd8F0pNknetM8vnInZdBw3Vt5caA/ZTeWj0+WEaosXMbsBt2IOLX4Ky0X4CDxP7L2wfUlVAvmP/Y4JCeM+kT9nhgaQ0gluzaM4dku0ad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=cz4K9pkV; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=phTq5Fh/; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="cz4K9pkV";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="phTq5Fh/"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TEt40U026678
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=lZcRQU7u0NQBlxFG1DuU6aHSEQqOnkvZfPP7LhZp9JU=; b=c
	z4K9pkVeRgy2LISjUi2AleMcATlb7QbvpGETiSehUTq15cfFPNVVdKlbYTmvAwUy
	vn/jxuF6wSYdhaj/OBmdfiKQCYaoSS/iw3ndLEprL4WfbLvMBgpx33d0NSgmNhGa
	ug4cadsuyjE7QSj9xfpiStUL73HvuXzA0KbNgXhDUUY6/FGT4pYpeNXyjnsTXqCe
	Tat9+5Eg7xvGiUklBRpTkpdCLUtEumfDtF9bedvfwe3sd/Ly2FEnVaoic51+9rqD
	d6gXvwEkV0MOAQN5MDwSq7K6tzwdJskC96ZV2GgzCy45e77Rwg3g4CU27b+aa2Xr
	BboCkVXxLTzbEHxdC3Ixg==
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3whamm2dvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:14 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c79b35a7d9so101758439f.0
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709220727; x=1709825527; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZcRQU7u0NQBlxFG1DuU6aHSEQqOnkvZfPP7LhZp9JU=;
        b=phTq5Fh/2X431TV4VTdJO+uDu8YseBoL9Vucs71jynQd7CJ2u4lpct3WDK6HWuUxMX
         P0U7WW8bMtVTF/M7+fvUqYwEUGkBlsCUbQOJQZG5/+nreQih22BeR+mE8nd+TDfp/Oqe
         Uh/bz+7uHzheyHVMfFu4ELYavALlBdB8HEOCPmx/JX5kmTR/KS7RDE6uG41fHhhT5CN3
         19ELz46zKqD1HZeQ7nLizFJFpzbyeylh/QjPQtn8Dc1rJnCJSo8GwR4AwfkzjrgzO/74
         HJeseictak23cD/WQZGls1SY/WRH8FiMLDQOYJfFohO86E7xtUuDWSm1pDfW05VyJ986
         tf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220727; x=1709825527;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZcRQU7u0NQBlxFG1DuU6aHSEQqOnkvZfPP7LhZp9JU=;
        b=cC44FABvkSVMw30QIfEhBWB/0GNliYVERyaQGkUAtNj3QW1GFeSKt7+q/6Fi4kanbP
         KltTYOAk9pINVnO2oJpVowudETMNlRMk26uDT453ehrpWi5u6raEIGpH6AFmCfZSL8ys
         fg6zT7cQsOCUnJuZC5cLso7TV/FCL/Xtv/6lS60d0BVeNXJbNnu/sx69HUbAUd/rkWnG
         b8B2hjL4re/tUTLI1xdiGt3G9rpMBr8tFF3f7aThCMzKbXbnZ5++uyxB0dVKT+zWQAj8
         WIEhk5SC54Cg6S/ewLFPw4jUjCF3w5sp4XR2cD1860gKCU6KQrqoM5YvAgIaf8pz/XbY
         /1yg==
X-Gm-Message-State: AOJu0Yx4Fh/FtiRnl2LQd9RS9FWub0qQjiwyyOioF5W3L1DZl1e59X/6
	WwohfKTRIqENZbWJ5X10biS8+dlf4khEfCvwKTEu1TI5scjLjeXGEdOch6GdZWJIG4cbmjBbwSK
	pN21Uw/ej/PuX31jtC4YPPGFe5mabIR172l7HJ9cHGAYF8Rpt1RRF7Yxy2bu+p4sa8mHMoUgI91
	l/afqe5qMxPqA0auZWodIf5Kh+oIW6UX0aUQlpClNwY83EthM=
X-Received: by 2002:a6b:d913:0:b0:7c4:6b0f:ee7 with SMTP id r19-20020a6bd913000000b007c46b0f0ee7mr2755767ioc.7.1709220726969;
        Thu, 29 Feb 2024 07:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnXxuCtJv/VHCpE/shJq6GO8fzi2ygcinQuEm0B8yrSHA0E/2RhIycyd1SgbNpU4MdfFUZHQ==
X-Received: by 2002:a6b:d913:0:b0:7c4:6b0f:ee7 with SMTP id r19-20020a6bd913000000b007c46b0f0ee7mr2755723ioc.7.1709220726446;
        Thu, 29 Feb 2024 07:32:06 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-217274.corp.robot.car (150.199.192.35.bc.googleusercontent.com. [35.192.199.150])
        by smtp.gmail.com with ESMTPSA id g2-20020a028502000000b00473e3c9d039sm381696jai.18.2024.02.29.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:32:06 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/4] qmi: Create a method to find a service by type
Date: Thu, 29 Feb 2024 09:31:38 -0600
Message-ID: <20240229153151.36410-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: bySNqLK6vPqn1TpaUW4WBYzK7YpL2Z3J
X-Proofpoint-ORIG-GUID: bySNqLK6vPqn1TpaUW4WBYzK7YpL2Z3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290119

---
 drivers/qmimodem/qmi.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ffb26326..d65a1c15 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -953,39 +953,42 @@ static const void *tlv_get(const void *data, uint16_t size,
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
+		struct qmi_service_info *data = entry->data;
 
-		*major = info->major;
-		*minor = info->minor;
-		return true;
+		if (data->service_type == type) {
+			info = data;
+			break;
+		}
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
+	return __find_service_info_by_type(device, type);
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
