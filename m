Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A3126F00
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550612; cv=none; b=uVQJcWhYsg+nWuXvhmW+gLJeZnhzkkdlLPMRi5YBkCKycjbj0/SOQLrs0cbqR9B7ydA+E1uzCD5Vze50aqMY2RGe/GSSIVtn81Wa2Nw+XkGes5TuMqcygv5VItYK1pdPiPv2x4uNY3vDegvmMLDzsd5PZjZejsfzKUHjAcAaCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550612; c=relaxed/simple;
	bh=+ypoEyGoDUGht3YEWxu3nv7msC2bD4DiWgSKpA7/r/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC34grMxZMNpixRZNoSynMg1CTYpNb5l9223eihzZI7CyvSocEDN2GxBR5M1Blcb1feukjUFlKaMzwxPD9fX24lOD3ielpLQGZDz2ln2Z+X6qzTBBfI6+155i2sC6c74QCxVGdvqfCu/wztiYPxctCl7AeYaTws40ftYI4V2ZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Y6e9nWMb; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=owcRzvhU; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Y6e9nWMb";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="owcRzvhU"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFjO2Y009797
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=GMqOZMHN/Ksu/N1TkKtrYW
	jBHhq8OBbpFZFw1OFzGa4=; b=Y6e9nWMbDN+DqEv5pfH0QJkQbfJhuqzHRoRY4Y
	EFS4QRhc2K8hrqLZ3+Sf7HUic1OIquJlN0Jtu4Xt80woGFi3AR3HGI7+nVqXdzyL
	Yng7G12kczVx3Jrlf5iBqcCUhkbAGVF4kfFqGpUrW04er5Abme4nRXubpRUAhRSf
	6EQnJ25sMz+gWFtgCjUT8e2W3Q+YMrc9N0E4AdVi4+9EZYsSFXwq8WkVDhoKxOA+
	EU/vKAMLiVLH/UjxgLdJDfuvXFG7Bs0V55b1Sm30TbVcGl7L88gQqCwElpFEm1pX
	RdOJ+xpMTqb0OA6BaRSiug5uxLjtXZKizQB70xBEsj0fCEiw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd56490fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:30 -0800 (PST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78771ee4ca4so147998985a.0
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550608; x=1709155408; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMqOZMHN/Ksu/N1TkKtrYWjBHhq8OBbpFZFw1OFzGa4=;
        b=owcRzvhUFre41lAhm9FVO1WQPGQueumQy92XJcH4AwYPNOOTBNYgW3mCF5E9QzZG4O
         8w+sotdE3+/YKwF4+5gGAPBTEw9dIyUtQLwC2f4g3Es0veaLvFmYsc+qz2flrFu2Qfsf
         +jGxynzw18yThbRwPfSdT6VNeMVYq3v4Viu3c45BS3I0iAuTwgoUThTTggDuy2GhI1co
         YTtJiaolRGWfUb13AJ2z1Rx7StRu0OUbjQkDewh+Kpwyh9WNJgodtn3CDzHaAi+sEVlA
         ebN+JivZVJwFLRI9rGjYRZdZmuJybQ/fBLX0sHC6ZHAZZxS/58MJGTrAVGceAt80/UT/
         SArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550608; x=1709155408;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMqOZMHN/Ksu/N1TkKtrYWjBHhq8OBbpFZFw1OFzGa4=;
        b=ecDVgmLvunmprVmWvZI/s+rmyIj9DhKM7yjxcAGiJMbV/XUoGp5TdeJ5tnlR2OEAPN
         0kbGWKFFz8Fh9uLPax4sWCJ0mesUg/zEwcM2jVr/tiU8OmfXCkWk3uhj7EwbPZJXXwpL
         FvAoubYuhdhEP2nxB9WU5G1el23I1/P0b+fTP7jQACeDQnC+mh1Tab9Hda1WLy7M8dk5
         U92QBBo7BUgEF3GHyIpTG3acjUDDRKkWLb/dRoT8fHDIs0P6glR7WNBM8WigQ6Q4B91g
         nUGCkwwfRhKQGP6L0TrN2SIt8VlCUbZ7uh5lNCC31dKUet+DqiAu1jDa1+odeoBM0jEg
         r6cQ==
X-Gm-Message-State: AOJu0YzVGAalaz9qmxQ804ZOAdKhRvWVLY73ZDQDCb9SgedBF2UYBpEE
	cLynBbymm8JgbyH/fZmbX2do50I++lJ10Mlp4u56ViFtTt5caGsSNtvOMHtjAOM06ghjvFjWPcU
	ciminWgXHrgviYcoi8myVmC13mpG3HMF3kNR9y4+odNErcNKS31xn0T7znMRVdKyN+O7QipgeaN
	HJEXvSo2Q/xxSeocB0Rx5plwKj2wGJQTdsK2kQ7l4q1M5TZYY=
X-Received: by 2002:ae9:e509:0:b0:787:425a:cdf1 with SMTP id w9-20020ae9e509000000b00787425acdf1mr16370969qkf.65.1708550608389;
        Wed, 21 Feb 2024 13:23:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVA/07kk4hyp+hq1cuFaLbV4yp66zG+89kIguIUWtDKAc/PbbU5jA9KR0hevLSPhc0rKuSDA==
X-Received: by 2002:ae9:e509:0:b0:787:425a:cdf1 with SMTP id w9-20020ae9e509000000b00787425acdf1mr16370955qkf.65.1708550607972;
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 5/7] qmimodem: Use l_idle for discovery when timeout is 0
Date: Wed, 21 Feb 2024 21:22:10 +0000
Message-Id: <20240221212212.181401-5-steve.schrock@getcruise.com>
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
X-Proofpoint-GUID: -QzqrIkooFUPrtEKwSJZrxcxtosPhyVB
X-Proofpoint-ORIG-GUID: -QzqrIkooFUPrtEKwSJZrxcxtosPhyVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_08,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

l_timeout_create does not call the callback when the timeout is set to 0 seconds.
The Idle API must be used in this case.
---
 drivers/qmimodem/qmi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5f050742..150fd343 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1102,6 +1102,7 @@ struct discover_data {
 	qmi_destroy_func_t destroy;
 	uint16_t tid;
 	struct l_timeout *timeout;
+	struct l_idle *idle;
 };
 
 static void discover_data_free(void *user_data)
@@ -1111,6 +1112,9 @@ static void discover_data_free(void *user_data)
 	if (data->timeout)
 		l_timeout_remove(data->timeout);
 
+	if (data->idle)
+		l_idle_remove(data->idle);
+
 	if (data->destroy)
 		data->destroy(data->user_data);
 
@@ -1251,12 +1255,30 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 	return req;
 }
 
-static void discover_reply(struct l_timeout *timeout, void *user_data)
+
+static void discover_reply_idle(struct l_idle *idle, void *user_data)
+{
+	struct discover_data *data = user_data;
+	struct qmi_device *device = data->device;
+
+	l_idle_remove(data->idle);
+	data->idle = NULL;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	__qmi_device_discovery_complete(device, &data->super);
+}
+
+static void discover_reply_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct discover_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_request *req;
 
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
+
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
@@ -1289,7 +1311,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 	data->destroy = destroy;
 
 	if (device->version_list) {
-		data->timeout = l_timeout_create(0, discover_reply, data, NULL);
+		data->idle = l_idle_create(discover_reply_idle, data, NULL);
 		__qmi_device_discovery_started(device, &data->super);
 		return true;
 	}
@@ -1299,7 +1321,7 @@ bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 			NULL, 0, discover_callback, data);
 
 	data->tid = __request_submit(device, req);
-	data->timeout = l_timeout_create(5, discover_reply, data, NULL);
+	data->timeout = l_timeout_create(5, discover_reply_timeout, data, NULL);
 
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
