Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B259135A53
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545179; cv=none; b=SdFc3YWECAWPItJzoAP4k5Kqn5bcqFF0eX8APj02j38KCQqiZaKjKKNyZBeHPW1oybfi7SCaEPBSYqWBwXb04c9gmSmX1nKuY8BNQR26+c/Jv6RA4FkqLM+T98iF4RzLlpyxdSeEukI44bpp9NPl/LOkJhYCSzJ4xtWwIKP66x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545179; c=relaxed/simple;
	bh=Tgxj/4Usc6H0avH62H2FqIWVk3jK2SC/brrbG2BFAr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfRjnxitE91iLdWYXyS596ufQyxuebvf+Z2wrcaudZExMEuie0jZOgBGSg87MZJ7ZpezeUjCb7bFXO84bjrVMg4gSBHVYIEmQa9p4P7fhFmHCee7p6y19tXZcwHqb2L40ogp+zTC/CaQhaOa8LwSfANJfoTtNDwtPofv10r4QsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=INKh3WXT; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=GD8rAacE; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="INKh3WXT";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="GD8rAacE"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDTFiJ025477
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=Z5BTw2gx8qU4K88HwRtl8k
	13pVkmO2Y7LDnQzhHOS8s=; b=INKh3WXT8q3TK+82/6dPq69oHb41w3BrpNZWmi
	eArYET6N0xJRp5sx/+s6A5XYgvfzDbqbVBadaFIQl8A2s/vR1lNASsCIhzvXejuF
	DcWvdclh6o8UvLPJNRRxy+FFruF3v/9O25oLXb38S9wC3xouFRIne+vcKuVCq5Tw
	c8xjDurKSjzXpSQ1QR9cyTab36R5Wx6gXCukGyT7T/vl+VJijZF/iO3fV5xdZO0b
	8K5T1IPhSi5XK6oj9AhIpwFstwJYbfgDlhGZ7Z21/SScfPogZdND3AYElK35UxWk
	bCPvAX3STxQiLQ+9BIvxZyQ1hWjXnhtTFW8jmVF6AWJsiBQw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xhyq9twn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:17 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5acd9a8a58fso3126142eaf.2
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545176; x=1714149976; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5BTw2gx8qU4K88HwRtl8k13pVkmO2Y7LDnQzhHOS8s=;
        b=GD8rAacEstJQ2ETrw//bAkBp3wISoAzYoOf+VANckIq8iZ2vYnlSh3hm/Bv2rE4l2C
         xjePrzMl/9zTnjrEi9aM8Kbo6Kp9gaxkKpQkpfqLuz9PTj+ONpv7tKSIOZI4+ajs9fnE
         ltH0PWK1P6NOwKB4PnYMxFXZ9hCrOcIdUc9faEjWoRTuRxTL/0XfMX3GYvySXduwi4AZ
         3LaDgXOuWTrAtoSott+ZXCCt1sdKsIqNuVjo4wQ7qfD9u0r/vr56Hnap0Vi5H5GSC3sJ
         MDn1Wp1yljSFRutcqB5AdLIt/Qiui8o5jMUYQBpK3+H2DS7DMHdQr52hnO3BHUbwHnt8
         5M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545176; x=1714149976;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5BTw2gx8qU4K88HwRtl8k13pVkmO2Y7LDnQzhHOS8s=;
        b=B4CKmWiXmTUG71tWzLJEX7iqN678//0ZWl1yzLikJSsnzPjKYs82k6Ep25yveP+5dV
         Vvn8mHVlz04QYrUR4moPuPI0Zmn1bBZdOvp/3McR9Q+en7vrwRfJ7Vw7soCbFKqNqcaa
         1DsVuTGgT3UOSiRGzzDT8lpZDfFHipmf5Yru7pmVFTOU332l8gqXwYM5E5oep4yfEkzT
         K/uHM2FwWsGjyPDhgAQoAvPefp6tFm5lVm127ay5hHKLnvMmDqSxU33zwa/kinTsNICF
         g+6toWL0O5l01cLy+4bKBgpkjHKengQl2ZyzUC7R46q9eqzTfZdQpImRH1Q45ElAsWb3
         QkzA==
X-Gm-Message-State: AOJu0YyPsrAJAYDsiOMSbyWbBI5/P0px8ZOUhm8SpSgKapyICM3iNg8x
	xrAqqt3U3Zal8/fXr6zuwB+stVU8VX0GMrT40wTW78Kc2D8RCt44XX0Ph0Y0qnpFHIsmZx7foCX
	N0GMHJH/PFgryCbZp3gnwy4vD6jWh6AihCohgJajqF7X1KRtSv2AFe4pe5w0jBP8AoRrpvAnw14
	i0TIkteDmOrOdS6+g+bLULbwTmli26ty0oH6ov/tKzckzA4+w=
X-Received: by 2002:a4a:5892:0:b0:5a4:aea7:8066 with SMTP id f140-20020a4a5892000000b005a4aea78066mr3262993oob.5.1713545175962;
        Fri, 19 Apr 2024 09:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb+/yW+L6mMyHKe6SpcpwNIBqxi0zdoWnX8BzTMmi1vi+t2yjhqvxn5wtGzNBI21X+v8DLrw==
X-Received: by 2002:a4a:5892:0:b0:5a4:aea7:8066 with SMTP id f140-20020a4a5892000000b005a4aea78066mr3262968oob.5.1713545175564;
        Fri, 19 Apr 2024 09:46:15 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:14 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/8] qmi: Eliminate atomic ref counting
Date: Fri, 19 Apr 2024 16:44:52 +0000
Message-Id: <20240419164458.36078-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: UCWmw8wPOs1fnB6XFnLi7DZKgrsNP5mE
X-Proofpoint-ORIG-GUID: UCWmw8wPOs1fnB6XFnLi7DZKgrsNP5mE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404190127

This code is single-threaded so there is no need to use atomics.
While here simplify qmi_service_ref.
---
 drivers/qmimodem/qmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 7f91b57d15be..0811eaf2faec 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2660,10 +2660,8 @@ bool qmi_service_create(struct qmi_device *device,
 
 struct qmi_service *qmi_service_ref(struct qmi_service *service)
 {
-	if (!service)
-		return NULL;
-
-	__sync_fetch_and_add(&service->ref_count, 1);
+	if (service)
+		service->ref_count++;
 
 	return service;
 }
@@ -2676,7 +2674,7 @@ void qmi_service_unref(struct qmi_service *service)
 	if (!service)
 		return;
 
-	if (__sync_sub_and_fetch(&service->ref_count, 1))
+	if (--service->ref_count)
 		return;
 
 	device = service->device;
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
