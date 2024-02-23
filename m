Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD3137C2B
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709832; cv=none; b=NREiO9hi7Zcoej+JE6XBHG2KYCz2033AAGJEvShak7Q+zCrVnrljqcUAANXQalOBqJ7EjK4DvwdO8ThJ9iGdh5LMoZrlyE1d1CMTFgOvgOp3q55L6YQCZxg6bpT83egugiLHyvfIL0i/9pdQyFVos95OVXYB/yHOZdhFTAhY/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709832; c=relaxed/simple;
	bh=c+pwdfMEI317po0/Ugscd8DEikf9F0kbKQN4Ea82o0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k74Xx4K+tveIq7yC4XygpA9n/VC8035LwFfKIXLCJCRD9UdJ3RsH6MyRjqmHod3/WPaoukNPgh+C+qAv2yPeCySdW0jFfyAVf/i48hNfA1sj1OfZj9cT6aLEf389mjkC80LBuFsfNLb+j9Wgq1vqv6ZcgE4rXHuA205n2R8+8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Dd3S8oK3; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=TBjDFCS+; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Dd3S8oK3";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="TBjDFCS+"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NFRb2f029072
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=541UnwcwY7NlXIyYZlETqU
	cQ0hxCVhbBA4zEXM3z/H8=; b=Dd3S8oK3Ilye4LpQP2shkVKguWvKRAhgZakeFa
	gJrxJJtPqSZS4okjjSlwaVmIDbTYKN2V3IEcnl9POtNRwemWzcOoloZJDlsV8wPy
	FBRBO53VLMZDUcRjni0eH+Fa7JSfFs4aH2fmyhwH2/vqZDQCeJpZ2UtgieDTOvkv
	/FiyFVS/U4vsufSAA7GDAjhrApBidd2wogjR3zAu+3nJQIpLofmLcQfe+85KqxOg
	6BWJiTxjT8mbElSn4yyC2kPtgTjIxK9JPNltfzg7ls+mO98lGENSYnhd0wpZ47ag
	KPosBawIT4plKD63UTQkjJ/Ak3mVwbvaHMb36OQ9XdEkaE9Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563tnk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800 (PST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-787bd91c5feso1163785a.0
        for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708709828; x=1709314628; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=541UnwcwY7NlXIyYZlETqUcQ0hxCVhbBA4zEXM3z/H8=;
        b=TBjDFCS+2ICpUwngzNubFRpzjCdtMNf4yVkUsleHh6n9hEdsFzVfDODRmSCXYq9dQx
         YG/4q9w7OVuIRK+rqj9qHgiKXdIBu5sOFYe9ia//05+u+daDeRi6hFzM4lbzAjYWp+Qn
         pG2rRcusgaz4YC6f/okOYZy3or77bYgT3rD9gK1GunQVvYmMa9ljL5wyRcR45jyKyDkL
         ddH53D0rgz2K/lTRgubqaWmRp8csxB4Hw/MdRafRNVUSnIfvj50pv0pByQe0ZlTHFVZi
         BpvL6DBTX4qrHORoXjhewstnYteBiN/skr2TzRbnHweXlTQ5bVTrlb0DHRSE3UcZwu/E
         GNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709828; x=1709314628;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=541UnwcwY7NlXIyYZlETqUcQ0hxCVhbBA4zEXM3z/H8=;
        b=gnInmdJtV5Cr/pT5F4k0L7WQuSFbJNosIVl2ONbCbSHWM+STqCif2OohDowQ2NbqXW
         iskdmT583Bum9bsbq7rhCBHLpJJIWOYhhZFgHBiJaQqH/6MYzSWKMJc3PsjqPPcvFdHk
         DNX/p6ruZr9KoD08UfO4yeDFR9tjNoqvmnlzBeTYyehlTRhD0BW/9UcVx0vqNNJWsB/O
         M/9/CqaycYYD+7Q58gMwtNnn1YclzyDt1/adSsqgYjVpFxM2qtYrqXWypzF/ZRENVD3h
         G3jbt6q6JqsN9hUBmtEY+zX9hmAUOHqIu/zeO+ggAhnsrtHz2aYzxcT7ZGiZzdRPiMGC
         KwzQ==
X-Gm-Message-State: AOJu0Ywe59qahF+8ckBuZEKFy+oThTRUKhaswF7djTJhviTua8sYWYID
	err4Q8ZKhSHOnKS2lnm3lfh30lEN+tRZighCs+2/Tr77irlUuKs1GSm2M9MqnpthQMcG6xQwmx6
	HNkl2TZZ1Epet695kuvLeGW31N8K9Ijc2BYwYVW5+v8GGnW2YeQVOSQ7Ys1TaK+l1KtYk4NYg/9
	4c1MzOWa5a9ui6ubiJZXIQdKCFcFvEgA9u4QHrAmJ8thIAMEU=
X-Received: by 2002:a05:620a:1124:b0:787:a11b:4f2b with SMTP id p4-20020a05620a112400b00787a11b4f2bmr539160qkk.50.1708709828669;
        Fri, 23 Feb 2024 09:37:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/XaTWki+w3I8I5YsygecBTJN8NA60mF4sKFGcbImw3Z3zAA51Y1bDoo7ChKbjX7i5CAERYw==
X-Received: by 2002:a05:620a:1124:b0:787:a11b:4f2b with SMTP id p4-20020a05620a112400b00787a11b4f2bmr539139qkk.50.1708709828283;
        Fri, 23 Feb 2024 09:37:08 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id t25-20020a05620a035900b00785d4d5768bsm1577140qkm.11.2024.02.23.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:37:08 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmimodem: Remove the final bits of glib
Date: Fri, 23 Feb 2024 17:35:52 +0000
Message-Id: <20240223173552.31622-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223173552.31622-1-steve.schrock@getcruise.com>
References: <20240223173552.31622-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: HKbc9rEnx_-1C675j9DIzWLL0V-Qvt0A
X-Proofpoint-GUID: HKbc9rEnx_-1C675j9DIzWLL0V-Qvt0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402230129

---
 drivers/qmimodem/qmi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 27615275..910e27d3 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -34,7 +34,6 @@
 #include <string.h>
 
 #include <ell/ell.h>
-#include <glib.h>
 
 #include <ofono/log.h>
 
@@ -663,7 +662,7 @@ static bool can_write_data(struct l_io *io, void *user_data)
 	return false;
 }
 
-static void write_watch_destroy(gpointer user_data)
+static void write_watch_destroy(void *user_data)
 {
 	struct qmi_device *device = user_data;
 
@@ -895,7 +894,7 @@ static void __qmi_device_discovery_started(struct qmi_device *device,
 static void __qmi_device_discovery_complete(struct qmi_device *device,
 						struct discovery *d)
 {
-	if (l_queue_remove(device->discovery_queue, d) != TRUE)
+	if (!l_queue_remove(device->discovery_queue, d))
 		return;
 
 	__discovery_free(d);
@@ -1374,7 +1373,7 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 	l_queue_destroy(shared, NULL);
 }
 
-static void service_create_shared_data_free(gpointer user_data)
+static void service_create_shared_data_free(void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
 
@@ -1564,7 +1563,7 @@ struct qmux_client_create_data {
 	uint16_t tid;
 };
 
-static void qmux_client_create_data_free(gpointer user_data)
+static void qmux_client_create_data_free(void *user_data)
 {
 	struct qmux_client_create_data *data = user_data;
 
@@ -1743,7 +1742,7 @@ static void qmi_device_qmux_client_release(struct qmi_device *device,
 	__request_submit(device, req);
 }
 
-static void qmux_shutdown_destroy(gpointer user_data)
+static void qmux_shutdown_destroy(void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
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
