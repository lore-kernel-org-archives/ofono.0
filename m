Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDF78688
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471630; cv=none; b=RtSzZeYsUtFX3+PbPY3XpRv1F/4kYeRhYikW9SlCgyeNGV+uKnRqv5U95z+hirDdXvQDPljCaCXgzAsEhQEEO97I5u9QaEknobtJ7VbipWY9tK/mUJeeHOJ1cq4nYwYNmIEs49/jT3e8DZs+YR0Svfhl5YnRdSwY2Wz4ol6z3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471630; c=relaxed/simple;
	bh=Ap1U95Zq3BSYIWTxpXVrgmHvj7EDrJjVR1s/CjLvOGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfK79xPbztQ62wlcFgNXRplFs4lhFpcIq2jCHgZx2bsogBiEtSDQyAtYpvjF4LF+sh+jMyKYuTph21FzMA78iclPOZeb/IwtC6b126g/1km132wV7fdPtYekyOOB28CVdYb48MyTNJHzr7aj4uiGpQvBhOVB6RZcXxHX0SjtrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=qUE9Qgcd; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=RCi7OlW6; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="qUE9Qgcd";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="RCi7OlW6"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KMknKV011066
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:27:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=4UqkteEN/KCpYsgQWhJs4P
	54uS0qN87qxwf5z1QdjMQ=; b=qUE9Qgcd63+irLhLjXXBv4Iuc1zSHqt0/3yxeL
	2XOAcbWLAUWVwoK3KENu1scQ2jBefPv8uBktXIecnKIVpzT5HnDIFqp5xK/+TSyd
	dgqiELytMERK1Mb9RjAbIooUuG0KYoajOvNMF3JbeizIRnsZ1Z+eTqcFnSbBhIY7
	5cXyrIKOA4THrY6z8rPSW8ugfExQlQx6oHkxoBCptHHNhOPd7IioxgrW7DpBmhzi
	1dokSs0Sdaz7rOdc4Kih1hxz4JjqhaJ9w8bM3IHpRDKMefeN3Tyn4PbyEvn1A5rW
	FpleLZk7XpYuNS5H6ZiEL5Yv8X62bq7rqVeZ9rLxQt86tWiw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565g1fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:27:08 -0800 (PST)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4c9bde37500so789597e0c.3
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708471613; x=1709076413; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UqkteEN/KCpYsgQWhJs4P54uS0qN87qxwf5z1QdjMQ=;
        b=RCi7OlW68eq6ZVSD2T/oNbay6fi/yEFsjr9MdcSA08YrVgGgmHzak3ohpeL/H6/FMR
         Rki0RJLRIAlrOkyM0ZsPfpiai6Yz+cxGPpnXiKbw+2f6p6HcBW2FBTPDhjobrYM29Pgd
         EJCb+iOGo30oUj4yTClpzecYEEYClKVamGbdSsrkISaoRE44gG7m/7VkGhx+NLCNO62W
         MFykZJGH7iMbiYHXswAJd5VEqavATph0yHusOuQ5pI4npdelyHLnt2o+mkiyaesbJGr6
         Et/1A2hB7Kq+UxgbErDO/2jxr+NZhgARIENS3pM7n/sAWXJ/DWUPI9rvqyHTHlXU1rEV
         wlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471613; x=1709076413;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UqkteEN/KCpYsgQWhJs4P54uS0qN87qxwf5z1QdjMQ=;
        b=keIJGWlrKBvyNqzi306YIMstQzwDu9R16OZRR4lAXB7kkaMuDZ+r+vXU5y5ipM73cE
         Sk3Ld5MZ/LbfbWaBwr5x7VU94KsIh8gbr3u1+ghSlpaUdSo/3QbKWjIfiJKM0q69O+50
         oaV3YB8Buq7OJ1HOiJMcSOukkcuh6OlTbYtQ0MPqe3kdgGVR3nTOTCdqb685BL82OdKz
         /LQ9tSgToCrdTPme+2V0pHUXIbFa8A4abg14M77wBgHFnW5RvtqRtkCGuuQIz1+Gj/De
         HH1vEqTIwBngozPpFJhuOn2/xygDb3VGcgGWM2cS8T6fuWOJNuTHoYHJxVr7QCxWhOkz
         XhNA==
X-Gm-Message-State: AOJu0Yzu4fvVhfdQf7C8J+v9wODyypQX13+qCtT9ougA4Vhn+Zhn5C9H
	wpqCDAzt+KLHQwLbODy4HHb5QTZFDXroshOreQke9DOHcJSKv8NH7SbqJ9W/s+0JCUNpO/mXJbs
	lOS4A2NO/J3UdcZIt3voDF2/G4gKSAPIkir6Z/rrK32VPj9zGWJt1zN9sjIfIg2GOYIFsAdB1yX
	+dY6R4PElFBuKEVTrmbe6eElvxPh0MCXfywdYpHkvkNjzopZM=
X-Received: by 2002:a1f:eb41:0:b0:4c9:9ff9:b334 with SMTP id j62-20020a1feb41000000b004c99ff9b334mr5823877vkh.4.1708471613153;
        Tue, 20 Feb 2024 15:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH16Jnm2qlCNZNwh1JZeG2MWtD5H4OLrsDqLfkYvPi14jpALOIRD+rmYQz6QINapur9ZDBjPg==
X-Received: by 2002:a1f:eb41:0:b0:4c9:9ff9:b334 with SMTP id j62-20020a1feb41000000b004c99ff9b334mr5823866vkh.4.1708471612741;
        Tue, 20 Feb 2024 15:26:52 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068f85706ecfsm1931983qvb.104.2024.02.20.15.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:26:52 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/4] qmimodem: Use l_util_hexdump
Date: Tue, 20 Feb 2024 23:25:27 +0000
Message-Id: <20240220232529.128477-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220232529.128477-1-steve.schrock@getcruise.com>
References: <20240220232529.128477-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: YtR0QqDmdgMi1-rCwMx08qTaaOgMQ0lI
X-Proofpoint-ORIG-GUID: YtR0QqDmdgMi1-rCwMx08qTaaOgMQ0lI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402200168

---
 drivers/qmimodem/qmi.c | 51 ++++--------------------------------------
 1 file changed, 4 insertions(+), 47 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b51df0e7..b8f019cc 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -271,49 +271,6 @@ static gboolean __service_compare_shared(gpointer key, gpointer value,
 	return FALSE;
 }
 
-static void __hexdump(const char dir, const unsigned char *buf, size_t len,
-				qmi_debug_func_t function, void *user_data)
-{
-	static const char hexdigits[] = "0123456789abcdef";
-	char str[68];
-	size_t i;
-
-	if (!function || !len)
-		return;
-
-	str[0] = dir;
-
-	for (i = 0; i < len; i++) {
-		str[((i % 16) * 3) + 1] = ' ';
-		str[((i % 16) * 3) + 2] = hexdigits[buf[i] >> 4];
-		str[((i % 16) * 3) + 3] = hexdigits[buf[i] & 0xf];
-		str[(i % 16) + 51] = isprint(buf[i]) ? buf[i] : '.';
-
-		if ((i + 1) % 16 == 0) {
-			str[49] = ' ';
-			str[50] = ' ';
-			str[67] = '\0';
-			function(str, user_data);
-			str[0] = ' ';
-		}
-	}
-
-	if (i % 16 > 0) {
-		size_t j;
-
-		for (j = (i % 16); j < 16; j++) {
-			str[(j * 3) + 1] = ' ';
-			str[(j * 3) + 2] = ' ';
-			str[(j * 3) + 3] = ' ';
-			str[j + 51] = ' ';
-		}
-		str[49] = ' ';
-		str[50] = ' ';
-		str[67] = '\0';
-		function(str, user_data);
-	}
-}
-
 static const char *__service_type_to_string(uint8_t type)
 {
 	switch (type) {
@@ -665,8 +622,8 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 	if (bytes_written < 0)
 		return FALSE;
 
-	__hexdump('>', req->buf, bytes_written,
-				device->debug_func, device->debug_data);
+	l_util_hexdump(false, req->buf, bytes_written,
+			device->debug_func, device->debug_data);
 
 	__debug_msg(' ', req->buf, bytes_written,
 				device->debug_func, device->debug_data);
@@ -883,8 +840,8 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	if (bytes_read < 0)
 		return TRUE;
 
-	__hexdump('<', buf, bytes_read,
-				device->debug_func, device->debug_data);
+	l_util_hexdump(true, buf, bytes_read,
+			device->debug_func, device->debug_data);
 
 	offset = 0;
 
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
