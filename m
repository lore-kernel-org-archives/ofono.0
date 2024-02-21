Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59C127B40
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550611; cv=none; b=GocXsk10ItES+e7fzy5jJKQn6E6pUcoKAWdM8RX5NnOA2Jl3ePjwwL3ds60IjDFS+Z4krHzKo1sccjbzLTL56bIYMg60VqH+pfoGEh88/CNSDWi0rDbhGB/5iLxBDVSlgwZE73ALPX2Td10dW2z2IuYO8p2H4ZXXqgku0e93Znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550611; c=relaxed/simple;
	bh=Z8MaP/hf52AjK17eiXi0tTi7CRO2UH/rx1DP6UEQ2Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMBTSoYpCx6XviTfT1zeujjLK6snT9YnbcUhJlReKpMhzTpybkY/pZyLPwRJ7Za0WWWM6zPbClptFd6xsOl1oVfU9ZmOk33/bxnEBRfq00RDPrA+OcmvjitA/OjLFLs/mBCUhYPYhd0v0RouQ5ACnuTlVUBe1BuviyI6nxUNncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=cSWcwEvf; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=TddQiF4Z; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="cSWcwEvf";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="TddQiF4Z"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LF1OJM001528
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=3J+RqhC2Hlg8tfAZGBBwOp
	zUlme1I5rntBeRjuBGBVw=; b=cSWcwEvf/IvlKTKolumeQU1upWic9dScpU/2eU
	BM0w+dmLUAxq/ewCsBaMBFBxwIUmDtTWecqIVzs+UPj3BHvXOB4mgc3LizAGEg+Z
	zmOEpSE7KgD3nl9hszvarH/zynxQio/aSLUXZkS5k8sktLkvfIOqT3YIH9zMIENW
	J4ykDvbVYQItIUBro+oUmRami0CZ3pcaaL0DvPOsq6Ful/DO9fsiscerb/6RGCPi
	mX4hsB6n8zl2Un07KjurTam2yxIsd/mM/pOW1Fz7xozulq3lqZROQJyMMgueOb/9
	7m38WGep3Tk0wO6a3xLB+UnbiYEqfr/WnplvRwAmjWEtv14Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565h0d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:28 -0800 (PST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7876620c02aso413075585a.3
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550607; x=1709155407; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3J+RqhC2Hlg8tfAZGBBwOpzUlme1I5rntBeRjuBGBVw=;
        b=TddQiF4ZDNPqty8ReNgPFPiOuvL3+39j1MeNBs9G8uBgt4z6CeuHtCc6gYgTzqWonz
         s8U0C3AZPA40s5hXmCklc68UlNJPkgUDdNay2X+ffguNEozpGLdKWq+31ynFG8n1SGEw
         N68IAMQgxr87F/yPCCW5BkbTzTqdcscMGga5clUrrDqz7d6xITMMYltS7sAoRfzn3Mgg
         aFn+fi5WryvFNVjJhj1SJOan/q8bhwiP1ZPCdyybJodnzQNENM/xpqA+K4sTpkCRg0Sx
         eIrCHDchFtmLYdgtf8FlqF1X4X6YrzhD4vC1I6cCahBRlk7/PmXAKZsYZPCrOMcnoB3a
         BaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550607; x=1709155407;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3J+RqhC2Hlg8tfAZGBBwOpzUlme1I5rntBeRjuBGBVw=;
        b=BNcG8wCQH0rGnvPu3Hsb2nivik6uJ2YybcFKlKLBj5ftqqO12/r4xR3w2qSqpIomst
         o7u77FFep9I4U1xGjvyJWXhG5ta66Bd6HgQSL2w4nuXaJrBFivctEX59c3IO7VZ4HEoc
         F17rPEhvHAsEU8x+Tvlw3QmDU2VzvKUDKMjcHj1AuhFns/J7JxtPMIXh0iNXf2Rpm1xL
         y65n4fJz5FJvgm3xqa6sZslCk/1RqLYntc9YCFPpHabpagGXi35cOSiW08upKcWm4/p4
         zPyixDJhMsz3V6tgfgmLnTy1NLd2fORVkfhJ1aJpzw9t82AYaC03YwCvF/3JRViPxxK4
         AEdA==
X-Gm-Message-State: AOJu0Yxiu4HW06b1A8UJ+nU6bZtKM6n4C3m3/yvzMgE2zHmnU5wrdHut
	bgGyaa2orZILzvSAoy0SzZv/pihZvU+UYi6rwzQo1uLGvyURMaO6OQz91HsYP6ldm10aUkQOsEm
	CbvIRJD2nxx+zVJ0CFDgjcMZaZoyzsHHeIwPlElFqLURN9VktFOUoz54mBIdCej3+sVHtvfzw4S
	Q3qcrUhfI6D4R0QV2JFryMn8K4XpzVwu61rS6son9sfbEWxz8=
X-Received: by 2002:a05:620a:14b1:b0:787:6a71:56e4 with SMTP id x17-20020a05620a14b100b007876a7156e4mr9562033qkj.55.1708550607161;
        Wed, 21 Feb 2024 13:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6ZYMy4XykDvdCZJUmhk8oaNEhIzpatuSsjzi1BD5ksWT6TgwRZqvMbQaaF+Ilt1C9jzFfiQ==
X-Received: by 2002:a05:620a:14b1:b0:787:6a71:56e4 with SMTP id x17-20020a05620a14b100b007876a7156e4mr9562015qkj.55.1708550606803;
        Wed, 21 Feb 2024 13:23:26 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:26 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 3/7] qmimodem: Use l_idle for shutdown instead of g_timeout
Date: Wed, 21 Feb 2024 21:22:08 +0000
Message-Id: <20240221212212.181401-3-steve.schrock@getcruise.com>
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
X-Proofpoint-GUID: 9ukW-rFlbT-zocewFguM12HTxjPVm7fB
X-Proofpoint-ORIG-GUID: 9ukW-rFlbT-zocewFguM12HTxjPVm7fB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

---
 drivers/qmimodem/qmi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5694b927..eed69178 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -93,7 +93,7 @@ struct qmi_device_qmux {
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
 	qmi_destroy_func_t shutdown_destroy;
-	guint shutdown_source;
+	struct l_idle *shutdown_idle;
 };
 
 struct qmi_service {
@@ -1529,24 +1529,24 @@ done:
 	return res;
 }
 
-static void qmux_shutdown_destroy(gpointer user_data)
+static void qmux_shutdown_destroy(void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
 	if (qmux->shutdown_destroy)
 		qmux->shutdown_destroy(qmux->shutdown_user_data);
 
-	qmux->shutdown_source = 0;
+	qmux->shutdown_idle = NULL;
 
 	__qmi_device_shutdown_finished(&qmux->super);
 }
 
-static gboolean qmux_shutdown_callback(gpointer user_data)
+static void qmux_shutdown_callback(struct l_idle *idle, void *user_data)
 {
 	struct qmi_device_qmux *qmux = user_data;
 
 	if (qmux->super.release_users > 0)
-		return TRUE;
+		return;
 
 	qmux->super.shutting_down = true;
 
@@ -1555,7 +1555,7 @@ static gboolean qmux_shutdown_callback(gpointer user_data)
 
 	qmux->super.shutting_down = false;
 
-	return FALSE;
+	l_idle_remove(qmux->shutdown_idle);
 }
 
 static int qmi_device_qmux_shutdown(struct qmi_device *device,
@@ -1566,15 +1566,15 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
-	if (qmux->shutdown_source > 0)
+	if (qmux->shutdown_idle)
 		return -EALREADY;
 
 	__debug_device(&qmux->super, "device %p shutdown", &qmux->super);
 
-	qmux->shutdown_source = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
-						0, qmux_shutdown_callback,
-						qmux, qmux_shutdown_destroy);
-	if (qmux->shutdown_source == 0)
+	qmux->shutdown_idle = l_idle_create(qmux_shutdown_callback, qmux,
+						qmux_shutdown_destroy);
+
+	if (!qmux->shutdown_idle)
 		return -EIO;
 
 	qmux->shutdown_func = func;
@@ -1589,8 +1589,8 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
-	if (qmux->shutdown_source)
-		g_source_remove(qmux->shutdown_source);
+	if (qmux->shutdown_idle)
+		l_idle_remove(qmux->shutdown_idle);
 
 	l_free(qmux->version_str);
 	l_free(qmux);
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
