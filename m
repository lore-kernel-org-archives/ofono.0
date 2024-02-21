Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6336126F00
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550610; cv=none; b=c5sGRtsQgDj29MSnmUZzv/tmcWnOGkg0uWYoiv1o1k52e0WLohV6dD7MJwQmwLsrP1+j+G9v1b9O9btQPIkAUUUIh/+OIlH5hfuHkTkvCr5imjii5U1vUDZnnPszEyv08TA0TWXVpNp3dt/r0qALe8ObszpGkppd/HYB6rW15CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550610; c=relaxed/simple;
	bh=jr30E/c46f7AjE4GFTnA42tUXCkNMW55T6CAt+b+u94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A426jD6o87NRms0ZRXMK2NQUZ9yw05OJoX5w6QaGPLKUjajMXKQh/zMuIO0UTTgKOh8Pc/XHMzfsShdq+8XQ1yb5r5MVQ7TW/EVJCYdEWektcsNFKJf1XLk76Z5UrVMjdCbMueKlP3+0DLsrKpGMnHslZvFWt5sGjb6mF9mCSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JL/ftckd; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=mKbJs95U; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JL/ftckd";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="mKbJs95U"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LF0NBD030938
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=4x57i+ppK4O34TdFWwHcB3
	Li3d+v19z5RmetLDuwL6U=; b=JL/ftckdZmLa3wEaXH3AKVzGTYwyPw9GGkbQCb
	hneJsjiFmg0AIxixJL+ilbNLbbpLIQzPY7/HOlWbBrmv5H5W+vFHPvknHXDPYr1R
	hkwtd+yxzGYoME0RlY6wvxqkUXacPTG74+2x6i/wtXOJPsiuvTj6pctN3dwhdowE
	yJX5wHISciPclaTtXrwI6YQPkSU3ehmjqgcwzns/eJAjMD7zKrJ17CpUtH6464WN
	eCqiLSoCJUxHF2ev5zV/y315XNuO0TirqANo83aevJ3iYZjY/hMYN/SdsNsw6vX/
	pNgmDl5xm2flES80P99yrc+VOeoc2LGiL15MGMX6zD+TvOqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd58hs0bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800 (PST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7816e45f957so173040185a.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550606; x=1709155406; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4x57i+ppK4O34TdFWwHcB3Li3d+v19z5RmetLDuwL6U=;
        b=mKbJs95U9cbws1BimZ36D/sEw6nVYmXeOCsKJ6+YSlKC+7v3IUaMqvNBqxy6sDM8Qd
         CVKK84yDUWZ27BA1/bBBGjcCeKo++cNIo89oNDIN8TqjBp1yPa1NrE2+aHXaOhUI4XuL
         Fe+lcxfyc5xq/D2av7H2dL07Bilx5rSdueDfasr4KPqjQBE5+oWgFuzk7sVZJ00FuwyF
         xtTSofMwLhndIo2RkrOoYqWnyOwTQ0qJWWcVCRRdUB7GYYxvLn4/qrYv39HHcIjsWbC/
         eXJWFCRZY3j+ASlCIQtF2GYqBlE9zGJtpAcznOPrjhJzV13CbX9AnbCaFu4pwa+KcEkg
         gbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550606; x=1709155406;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x57i+ppK4O34TdFWwHcB3Li3d+v19z5RmetLDuwL6U=;
        b=Ljg1Yh6spO7ImrMU/eEcgBzdZDy8WpzC3V+CNmNcWa/oETJcZ288cJRqS5AKNQr+7o
         lj5dunN4exnjAf5m3wQW+TTmb3NEcS0cNBVhCK3oqyPQYxC+5lozROZYngXXFxVCq+vk
         tRYcs34uDaDvGdZGTnHaLFu5CdTFT9flOcqfsBQd55JXPu4vPY3jQgb5p17JJx5jkBL0
         qkGnjUkujbevhgOUJzlxVVx1xH5YWBt/c6nVL4AaV1/6hHp653tIUOGWsneM3niUFRgi
         9nX+C4wU1p7Wx7bC/nJzAQn9lMb7VLdU8z9WS6NOEMkzgAAKofCHINXfEiJVseSYqu39
         XvRg==
X-Gm-Message-State: AOJu0Ywnl2nGp1ky8bUYNXYXJP6X+Zw36//MwOC2WtrMgTGMe2gfXkEl
	E/YB++p3OsMu+ujJMiLNx5orhGYU4K1bl5wECHQ5cf3IAB9Fs4pt97+U0O+iFupULXymwbbzEzc
	va/xLi4jNnQ803k2XR1/Ir8KDaM7hUnJpdQnIMn7GRzEaesEKJR9QliiMbNqtY7wZb2Nk5DGelD
	bzLvcM0l6icPNwMBhl4Q0r60VrJX932WyWmn6DcKfVHUojmpc=
X-Received: by 2002:a05:620a:4056:b0:787:83b3:2283 with SMTP id i22-20020a05620a405600b0078783b32283mr4690539qko.23.1708550606367;
        Wed, 21 Feb 2024 13:23:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH26xAQQ4K3BEwDXzoaZi/nWHsZrDfc3IXN0ehuh+d/hn0RnQzV4MNeAITujR3QPX/u4P8PBQ==
X-Received: by 2002:a05:620a:4056:b0:787:83b3:2283 with SMTP id i22-20020a05620a405600b0078783b32283mr4690519qko.23.1708550606007;
        Wed, 21 Feb 2024 13:23:26 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:25 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/7] qmimodem: Use l_timeout for discovery
Date: Wed, 21 Feb 2024 21:22:07 +0000
Message-Id: <20240221212212.181401-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221212212.181401-1-steve.schrock@getcruise.com>
References: <20240221212212.181401-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: k0z6XUVmdkT0jaRMbozJU9GGPNxVFhw_
X-Proofpoint-ORIG-GUID: k0z6XUVmdkT0jaRMbozJU9GGPNxVFhw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210167

---
 drivers/qmimodem/qmi.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index d2d4eefa..5694b927 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1101,17 +1101,15 @@ struct discover_data {
 	void *user_data;
 	qmi_destroy_func_t destroy;
 	uint16_t tid;
-	guint timeout;
+	struct l_timeout *timeout;
 };
 
-static void discover_data_free(gpointer user_data)
+static void discover_data_free(void *user_data)
 {
 	struct discover_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->timeout)
+		l_timeout_remove(data->timeout);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1253,7 +1251,7 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 	return req;
 }
 
-static gboolean discover_reply(gpointer user_data)
+static void discover_reply(struct l_timeout *timeout, void *user_data)
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
@@ -1262,8 +1260,6 @@ static gboolean discover_reply(gpointer user_data)
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
-	data->timeout = 0;
-
 	if (data->func)
 		data->func(data->user_data);
 
@@ -1271,8 +1267,6 @@ static gboolean discover_reply(gpointer user_data)
 
 	if (req)
 		__request_free(req);
-
-	return FALSE;
 }
 
 bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
@@ -1295,7 +1289,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 	data->destroy = destroy;
 
 	if (device->version_list) {
-		data->timeout = g_timeout_add_seconds(0, discover_reply, data);
+		data->timeout = l_timeout_create(0, discover_reply, data, NULL);
 		__qmi_device_discovery_started(device, &data->super);
 		return true;
 	}
@@ -1305,7 +1299,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 			NULL, 0, discover_callback, data);
 
 	data->tid = __request_submit(device, req);
-	data->timeout = g_timeout_add_seconds(5, discover_reply, data);
+	data->timeout = l_timeout_create(5, discover_reply, data, NULL);
 
 	__qmi_device_discovery_started(device, &data->super);
 
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
