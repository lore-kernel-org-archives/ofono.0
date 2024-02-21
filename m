Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B36128824
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553925; cv=none; b=WX1SW/ASO5PXfUuGQbMZG1Y0mGVLSFd6DSw19P3wwcu14hgVgFH07/nttyk6lXWN0HFz+sz0leQZO4E6kt3J1kXh7Rl3dIVC0CgemYPMHg2oHmn3W6sOcLCMIeHALGMinkosEs2gLLtimgUEH+RZWScWaNytdU1EO6N5ctQWYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553925; c=relaxed/simple;
	bh=7rMupqbjZo2smrVp9Ieq2o2Ks9e7fK7Ras6JrlA35bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUHw+w+rAdM3euPNe6rVk8B4QTz08Ax4LCxHB5cNKgXCLdIEFhwOlukrSvUEoxAX7bM56aOBx/6jRHMniFksUkWQt5M+pRr87Yz9jOEpNBS8B+MSXXJPhp9zozSb+gv/ojxGiEfCMC074M494BJ8ejmmIa1asc6kwNHlen6ZRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=s3jdxMz2; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=HgEPSyq9; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="s3jdxMz2";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="HgEPSyq9"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDYESv012239
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=Z+mNW3XGjgcu9JVNKyEBni
	VJePhCanYiC3UkKoT5Lyg=; b=s3jdxMz2k+zWnyGMmNI65YsGDGXyRomkqMslzF
	cJflMeRhLWrmudFFnX7qHdga4N4OfsySX7JefKMVmx/BP9Y9YeNtgbLzt7nC1OD7
	3ITyUKK/Zs/p+W6hsRpnsAmr3OuyRwG2gH7j0fF/HI6F1XIfV8VjRgNA3RsiaJez
	kTrzGwjaRLtuhNXxU86KHGoYSlV7KJ+WqTMBoPTL8lxuibLACKML0xfYBYRKxbKq
	dSnm4tvz6Lur3RAxGONyfI9GqvNisFh5hdcmo2y13hMOQfVwGdhdut1NwdTO+vRI
	165ifTlTEZH2Jw0NbrngaTllnzyFPWhpKARfYG7baNMpE59A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd56392tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:42 -0800 (PST)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f9e713a1cso16096746d6.3
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553922; x=1709158722; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+mNW3XGjgcu9JVNKyEBniVJePhCanYiC3UkKoT5Lyg=;
        b=HgEPSyq9Yxg3L1tJLj1XirzRBi44Q1kC3ccAdTO/Mhxy3mzh2wPzzK8UtyDubBkgXR
         JdwkXwsuNxSgaG3B90KvAl0otaGjd+55iJxtMSP77x5Ta2lqcyHMBJ+HE39V8MwskauM
         jD6JBSuGFnAZeo6OI3XDIlIhDHFMsTnQjOnnTryc8q9UuWO30XQtivLy1zWovINgiMO8
         RLlf+jJaFd+EVf/L7JhXVtclSIA/5nTKC7L5TywckST0y2OotscnhZXPxkLN76r7IeoW
         b3dqk8XHI559pAPpUgPPAdmP3AZk0wV8407as5vFzYic8kbqUXdDtzYam6M9eK8R3TLt
         /XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553922; x=1709158722;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+mNW3XGjgcu9JVNKyEBniVJePhCanYiC3UkKoT5Lyg=;
        b=OE3PChlVrNKn8qUeAJXME92KDCCk5KqxFibVvWmV/RdG2Ru36ZLIkyUJq9N2Zc9phN
         Ua/7sDR/PZDEW9OJm8NrmX3Sx4hOQX+5nuobH6SHLoO2fAj1ippZfaCe1X/4PRMYJ09p
         wn7VTivc//xoM3O3QmbFxW9UDLOJfb4ZITxkajqaDkCMwtffvylx4+zfv6zsMSvrdJ8b
         jfr0eLngHTrgWZ+KlPX/T+KSzD2/fN/w5WKbJgyjLZxt34hPw/RhDUR2YbZwpI9PoX5S
         oEIKYBkMp6vDSjlUXAx77BVuTvYy4XKvD2AID3AtwEXVEMSbWos6C8FeaHAEwx224A1e
         0eOg==
X-Gm-Message-State: AOJu0YxU/7Jy4ZBGqwNPOFGhR7fERKRsUgNERG04nZow6U5PxDvSKoUF
	E6APc5SvmioGa9OeGYKNcwgJR8pFkDXoQgYuVYNm8X181kC5nptnErvZAHO4POOkYkAlCelNqwx
	0YWoymByQioENsz4uFOsvGBZr1F6PlhoCRiooKqnQqlqKl0rGaj6Bg0fPUrTQwPD4SVWydDxQoY
	EI9iu59H15ErwMM6zHB0W7Nz+BGgpWCGub/zHXQkAJDIjFzrs=
X-Received: by 2002:ad4:5cae:0:b0:68f:501c:ea3e with SMTP id q14-20020ad45cae000000b0068f501cea3emr19988230qvh.28.1708553921897;
        Wed, 21 Feb 2024 14:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4y8L+7Kf+XZY7X+6QbCCEg8XNwDPd/NfRTobn4+AQRTFgzVWLYQHri5Noksppk2MbNks+ng==
X-Received: by 2002:ad4:5cae:0:b0:68f:501c:ea3e with SMTP id q14-20020ad45cae000000b0068f501cea3emr19988213qvh.28.1708553921539;
        Wed, 21 Feb 2024 14:18:41 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:41 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 4/6] qmimodem: Use l_idle and l_timeout for service creation
Date: Wed, 21 Feb 2024 22:17:23 +0000
Message-Id: <20240221221725.185480-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221221725.185480-1-steve.schrock@getcruise.com>
References: <20240221221725.185480-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: fmuM6u3s_17-FipbxPp-nZKN_R0EUTLI
X-Proofpoint-GUID: fmuM6u3s_17-FipbxPp-nZKN_R0EUTLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=930 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210175

---
 drivers/qmimodem/qmi.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 1e127d60..150fd343 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1930,7 +1930,7 @@ struct service_create_data {
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	guint timeout;
+	struct l_timeout *timeout;
 	uint16_t tid;
 };
 
@@ -1938,10 +1938,8 @@ static void service_create_data_free(gpointer user_data)
 {
 	struct service_create_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->timeout)
+		l_timeout_remove(data->timeout);
 
 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1956,19 +1954,18 @@ struct service_create_shared_data {
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	guint timeout;
+	struct l_idle *idle;
 };
 
-static gboolean service_create_shared_reply(gpointer user_data)
+static void service_create_shared_reply(struct l_idle *idle, void *user_data)
 {
 	struct service_create_shared_data *data = user_data;
 
-	data->timeout = 0;
+	l_idle_remove(data->idle);
+	data->idle = NULL;
 	data->func(data->service, data->user_data);
 
 	__qmi_device_discovery_complete(data->device, &data->super);
-
-	return FALSE;
 }
 
 static void service_create_shared_pending_reply(struct qmi_device *device,
@@ -1983,26 +1980,29 @@ static void service_create_shared_pending_reply(struct qmi_device *device,
 		struct service_create_shared_data *shared_data = l->data;
 
 		shared_data->service = qmi_service_ref(service);
-		shared_data->timeout = g_timeout_add(
-				0, service_create_shared_reply, shared_data);
+		shared_data->idle = l_idle_create(service_create_shared_reply,
+							shared_data, NULL);
 	}
 
 	g_list_free(*shared);
 	l_free(shared);
 }
 
-static gboolean service_create_reply(gpointer user_data)
+static void service_create_reply(struct l_timeout *timeout, void *user_data)
 {
 	struct service_create_data *data = user_data;
 	struct qmi_device *device = data->device;
 	struct qmi_request *req;
 
+	DBG("");
+
 	service_create_shared_pending_reply(device, data->type, NULL);
 
 	/* remove request from queues */
 	req = find_control_request(device, data->tid);
 
-	data->timeout = 0;
+	l_timeout_remove(data->timeout);
+	data->timeout = NULL;
 
 	if (data->func)
 		data->func(NULL, data->user_data);
@@ -2011,8 +2011,6 @@ static gboolean service_create_reply(gpointer user_data)
 
 	if (req)
 		__request_free(req);
-
-	return FALSE;
 }
 
 static void service_create_callback(uint16_t message, uint16_t length,
@@ -2115,7 +2113,7 @@ static bool service_create(struct qmi_device *device,
 			service_create_callback, data);
 
 	data->tid = __request_submit(device, req);
-	data->timeout = g_timeout_add_seconds(8, service_create_reply, data);
+	data->timeout = l_timeout_create(8, service_create_reply, data, NULL);
 
 	__qmi_device_discovery_started(device, &data->super);
 
@@ -2130,10 +2128,8 @@ static void service_create_shared_data_free(gpointer user_data)
 {
 	struct service_create_shared_data *data = user_data;
 
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout = 0;
-	}
+	if (data->idle)
+		l_idle_remove(data->idle);
 
 	qmi_service_unref(data->service);
 
@@ -2190,8 +2186,8 @@ bool qmi_service_create_shared(struct qmi_device *device, uint16_t type,
 
 		if (!(type_val & 0x80000000)) {
 			data->service = qmi_service_ref(service);
-			data->timeout = g_timeout_add(
-					0, service_create_shared_reply, data);
+			data->idle = l_idle_create(service_create_shared_reply,
+							data, NULL);
 		} else
 			*l = g_list_prepend(*l, data);
 
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
