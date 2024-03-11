Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E658AAC
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200972; cv=none; b=KkmeBmx6Mr4Iv3OBzhPnIkzghYEN74uNkI7OcfmbGQLXYnYpyEvzP8mGaox8VmJbjHUgS6zd6iblT0BDFprhAAbi14xcXF+dGzZIqFATr9mZedTrlUGLbU/1MZYBKWgEiDAQuO1MQ6Xl3iueA0la+W7jbD/02Td060UwP1PLrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200972; c=relaxed/simple;
	bh=ObVWJLSI2kYOBCkMLjGtaDZRUmeTiO6RWwXEMdcRDcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxPks/vPzTQCmLg2L5jyrUtrm9UQL9Fy7EAoe9vxGMMyUCqyHJsB9Q4WukTvmUWZJM/DAJKIkpNLN05XeM8veW2C3GE+darF58GpNgLeHYtmKSVtxiwGPoKS7rI17ThW0UqW9lyTPS6U3CV5AnYmATJCZII2Tpd/ai7dNgWe8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lVXdKCEh; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=WHngBhjI; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lVXdKCEh";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="WHngBhjI"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BI2uSX023681
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=syW8skL7cewwt46HKm20mY
	DLy25nXDu3saTQAhOANCI=; b=lVXdKCEhx8iK+9gDrWqKIk03vzgCgLqTJ4Gy11
	adC13d+q+WxdTaF4aksQAIoSwNgwBwoFysVrbgdtWNEW3mJNGlfcAWZFPUdrv+yO
	LpR+bbRkDmK9lLdKUF2OkfUJpbaVcGSX3DmzB8BGhfuzgt+yrKux3ZEisrKe/53D
	ji9uGX/KlUfJOKC338AtPXHvFO0/2YIlaWPT/obl3yIsWozfXwC66ETndodFd0fZ
	IlK1hNTlJ0wqdJzccnPW3KFfv3c7c50DMoh7Tt+u52iFB5S95B8zpWXtH0h/uRFp
	f9dA12pB4mvYAgLVoR6UqSON3cUErKtGk9E9aUX5+xLe2tBQ==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wrmup9k2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:01 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366586f2796so14338095ab.1
        for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710199260; x=1710804060; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=syW8skL7cewwt46HKm20mYDLy25nXDu3saTQAhOANCI=;
        b=WHngBhjIXDFn8HvsIr8lpU/laxgo2QgQshjt6CzwaWtWSW/o58JUIYlnCQFWhvIROW
         PHsRfcZ3V247DA7qWDrl3y4wBk0mxLWkwaS0224JWAumJ6BmfOvvYABA8+B1n8wqHAmk
         srMjMb+zcWc10wWGTc59jZDGvHud8oiBTdYQJlWjm9l6NCjLBb1JHS8xHYj6AI/Uga66
         jWnWKuWSoW0LE5Mhql5lq5s+Rv5XPBnnRl6/1kiClISBCjw2s/gzrr3YkLzS3VLf7kHV
         VEqpZ0xmcgOgLf6GL7U7ca7Vg8YI4IkvfvgYHlRGHfM1LHDizwoa0bgKeyoTORMjHZLV
         Nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199260; x=1710804060;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syW8skL7cewwt46HKm20mYDLy25nXDu3saTQAhOANCI=;
        b=vLeXavKSH3TrJx3/ZvIkI54ipZKtYH8PgbnsrG2xMXttfXd8udN0sfZ3qAD1YNJDFi
         t1kIM7KE9ke4oWznhlqNUWxcsYe/5lJuVAygLGNwTEbIgx0LXFqfSlASGswghXphDsGq
         umMe8UQQ/MYvu71vHwWRWa5tGOiOICgvEBwRsuRRSLX91+MnYqqWTYVMABGLJKEq98rR
         0cJkGUlahVA+nFhDkuxYDxWCWR0KjN77EEtc8ATS2IlCg+9DqlPqRV/l6TCbyzYr9Vr/
         aPCnFbAN3LaPDUzIkiTL+rN76I6Qqqjqctk0blACkhuqSOUJLbGGQ6q8uU3lC3frzm9t
         D6Yw==
X-Gm-Message-State: AOJu0YxY9lWdyV5YJr5A5lQlVynjtO7pzc8V0I6iBF8Kj9RVCjtvCCBY
	7bd9DVniovwYKE/mIbfSpNryTa0/7fvSjytOTbDI8CWCVC5KhT4jz8qtCYxF13oAHEEpY2FDbjW
	3lY689MwwBDqEY4xtJgg71WM8DfyduI7W5HuSdQRYgZvtFKrClYNN1+IM7gfEU+cb7iN6MrKPjK
	xHMGEO+xpSq4gjdZlK7nS1oDpMrZBgDTYVxOCAaw0rTAUEyls=
X-Received: by 2002:a05:6e02:1b04:b0:365:da4:ec9d with SMTP id i4-20020a056e021b0400b003650da4ec9dmr9729861ilv.15.1710199259978;
        Mon, 11 Mar 2024 16:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa8TILQ4FXxjMhiGiRFvDCgMdDX6rI68lPYNTdeqZ8OhLlEXK5n9CH4a02zF8DljJ68LyTAw==
X-Received: by 2002:a05:6e02:1b04:b0:365:da4:ec9d with SMTP id i4-20020a056e021b0400b003650da4ec9dmr9729844ilv.15.1710199259599;
        Mon, 11 Mar 2024 16:20:59 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-164157.corp.robot.car (98.32.128.34.bc.googleusercontent.com. [34.128.32.98])
        by smtp.gmail.com with ESMTPSA id n14-20020a056e0208ee00b003660537d47asm1975643ilt.69.2024.03.11.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/3] qmi: Allow QRTR services to be destroyed
Date: Mon, 11 Mar 2024 18:20:34 -0500
Message-ID: <20240311232036.49381-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311232036.49381-1-steve.schrock@getcruise.com>
References: <20240311232036.49381-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: DpVBrL7gJyIm52cnomj3i2UTpkXVEduD
X-Proofpoint-ORIG-GUID: DpVBrL7gJyIm52cnomj3i2UTpkXVEduD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=697 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110180

QRTR services were never being destroyed because they were being
created with a reference count of 1 and immediately incrementing the
count to 2.
---
 drivers/qmimodem/qmi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 15324e6a..b3f05ada 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2573,6 +2573,15 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 	if (!device->ops->client_create) {
 		struct service_create_shared_data *data;
 
+		data = l_new(struct service_create_shared_data, 1);
+
+		data->super.destroy = service_create_shared_data_free;
+		data->super.type = DISCOVERY_TYPE_SERVICE_CREATE_SHARED;
+		data->device = device;
+		data->func = func;
+		data->user_data = user_data;
+		data->destroy = destroy;
+
 		/*
 		 * The hash id is simply the service type in this case. There
 		 * is no "pending" state for discovery and no client id.
@@ -2589,18 +2598,11 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 			service = service_create(device, info, 0);
 			l_hashmap_insert(device->service_list,
 					L_UINT_TO_PTR(type_val), service);
-		}
 
-		data = l_new(struct service_create_shared_data, 1);
-
-		data->super.destroy = service_create_shared_data_free;
-		data->super.type = DISCOVERY_TYPE_SERVICE_CREATE_SHARED;
-		data->device = device;
-		data->func = func;
-		data->user_data = user_data;
-		data->destroy = destroy;
+			data->service = service; /* ref_count starts at 1 */
+		} else
+			data->service = qmi_service_ref(service);
 
-		data->service = qmi_service_ref(service);
 		data->idle = l_idle_create(service_create_shared_reply,
 							data, NULL);
 
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
