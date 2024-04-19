Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A9136678
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545190; cv=none; b=sbT1XGrtnas/49/yVrH3LYHQ6o6Gpn5s8eIfSj6pb2Z5mmqN/xJ8xaM1rKmrk8DI/iC3gOJO4xiMKwGNbud+JBZxsQ7dVmL9Hj6xVfAN75lH7x3i2lYlDpdgi5BgeLjZaDXjHyRJl3jbkUOvtQ/s1HOIU4sHxvZ/C1doSwVNsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545190; c=relaxed/simple;
	bh=WUsRo7TKjX3unJBXvFxbJnDH7geQIiVJ6pQjqpgKObM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9Y67dn+xCtLVcv1W8LBIuXB34qrqPCzwI5GnpBbSqYntYcHKF6Kw1V8MdMMbjmpmLRmbW1sQXd1Lfe3FjxhDzIqFkjCozHymAXIsQLV25G2L/dcOJvBIIT+DTfS17zosQ8bG6s7941XcGTSKYf7sAXAxtps6Coq152KPIdVQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ce5r4D81; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JB8drhcA; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ce5r4D81";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JB8drhcA"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JEUBju021794
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=howRC92sCqO08f25FZfFhZ
	Hwei9MHEfCCe9Ol9r1MoI=; b=ce5r4D81KsQeoyokIrLVmQ5e4NOwZuLqcxvjeD
	ku0/AWgD/qlZSa24Jd6HY3fbLRN1TV+p0l0qTMKuKUS5AVqfdyhppv6261QWBesh
	XhmsvFCU8bFfyu2uMg9fbeWGyYEz1O4ntHmUbuS8fN4cgHz4u+9itGn/JIJKqOK1
	zCnsjB8rLTVKbZixrQcuNCXUI7kS8AOgsz9gwQgbeaMgcOcqRa7alEK2Rt49dz+L
	V7egsufu0HlrIY2XbxklLNL9asKbeD6S1hDfEE26IpsvOcs+AICAhZs8wYdMdhn+
	T5gZ1Os9B6O3NEK1a0G/+opNGvleCz3pFelcoey5gh+KVXAQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xfp8hnep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:23 -0700 (PDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4347271f444so24528791cf.2
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545182; x=1714149982; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=howRC92sCqO08f25FZfFhZHwei9MHEfCCe9Ol9r1MoI=;
        b=JB8drhcA08LYBcc32vzI4PYtp9maw9eLTWFmmyzaa3lRbgqgT+ahqJpvwIysQ5AKCJ
         eKJpvYHYLlK/dMKCO/VJr1EMIgf87tDuFvvXSkBEUdBiLxxyp1EDP1Et8zBAh/H8boR+
         0YltyrMIlBSxlInZr84kPTZ8fgqzWjDMcvSYDBr9kYy5lM1KP1yNHdoCrFg03epCgFJ1
         jaZ+PG2FgWKdvS0Cz1z814YAq8W58MDRr87xiPqOUEVqYdKl8OYuxgsgB9/b8qKDMfSW
         rrCnw92N5z8Hyejsi3P8Yr/TjoenipTwMEL+wjGbekTjegK6A8wAKrLdnRF+B1yUtWUH
         AHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545182; x=1714149982;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=howRC92sCqO08f25FZfFhZHwei9MHEfCCe9Ol9r1MoI=;
        b=MaQy/RpQvJBqnFBmzo2qTY96XuMf273m75FvkQ+TxRDdUWafUSvQg2P1qUX6bFyPzE
         AzX4BvVfwDkbwuOrsaHHK0pXm0R2leSk+HwEWrqIlPNyevY+XSs9w8Uu5kuHvW4XDoHO
         SxmmJGkA+/uhrvtO5PYofVzwz2kC0qTs/lOk+iUPQQXi4IBUDjELRH76ZM8XUZBGxpnC
         W7ONncLpbpk1QkcRhkLGec8EKsiXzavBXJnK7rnzJFxlgx0MODpihivFRPfhVgJpN1vM
         N3MO+fMYqc8K1iogIYLLzeBFCyKUb5HF3WYsLO1mMG+TTow9S2VGjwZAo1IdUlGoSzR/
         xLZQ==
X-Gm-Message-State: AOJu0YyommkEU59SsF+1YfS2aK0UmDKQIaVo3X557thvxfDTMLaqwEMn
	m2XKGNRRJ0WqHGx0rU+8vw1aH1+Y0oX+nrdlSGVUmduMCb1Rwnt1J4+63PLIOEwVh4m7aBVFwBY
	AXBcvLPiCPxDsQtYuhPCeuJg+0u0O1rZEyKPu8TWXTS37hE5dPtbZA7zsw2hiEpMZFjh4WJiXcg
	XRzbkF/afJ6J0wN1Yn1YPfo4cAwsiyyo/LWtSWHP8IgxZfIs0=
X-Received: by 2002:a05:622a:4b17:b0:437:cc6a:87f4 with SMTP id et23-20020a05622a4b1700b00437cc6a87f4mr2667333qtb.31.1713545181711;
        Fri, 19 Apr 2024 09:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE72TVws2GnPZqhCzQM1IRR657dHrk1pfccdF70Lgtdh2ueARKNbumuqZSShoJT5Ha1qo9Vfg==
X-Received: by 2002:a05:622a:4b17:b0:437:cc6a:87f4 with SMTP id et23-20020a05622a4b1700b00437cc6a87f4mr2667306qtb.31.1713545181342;
        Fri, 19 Apr 2024 09:46:21 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 8/8] qmi unit: Validate notifications are independent
Date: Fri, 19 Apr 2024 16:44:58 +0000
Message-Id: <20240419164458.36078-8-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: 2F5KAZ8A70Lngg7a2iGUJF6AXWgtrxdV
X-Proofpoint-GUID: 2F5KAZ8A70Lngg7a2iGUJF6AXWgtrxdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=780 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190127

Destroying one service should not affect notifications for different
services of the same type.
---
 unit/test-qmimodem-qmi.c | 57 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 43e1bad082ba..7d1a33eff9b1 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -47,6 +47,13 @@ struct test_info {
 	bool notify_callback_called		: 1;
 };
 
+static void info_clear_received(struct test_info *info)
+{
+	l_free(info->received);
+	info->received = NULL;
+	info->received_len = 0;
+}
+
 static uint32_t unique_service_type(uint32_t index)
 {
 	/* Try to use a value that will not conflict with any real services. */
@@ -544,6 +551,54 @@ static void test_notifications(const void *data)
 	test_cleanup(info);
 }
 
+static void test_service_notification_independence(const void *data)
+{
+	struct test_info *info = test_setup();
+	struct l_io *io;
+	uint32_t service_type;
+	struct qmi_service *services[2];
+	size_t i;
+
+	perform_discovery(info);
+
+	service_type = unique_service_type(0); /* Use the first service */
+
+	io = l_io_new(info->service_fds[0]);
+	assert(io);
+	l_io_set_read_handler(io, received_data, info, NULL);
+
+	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
+		assert(qmi_service_create(info->device, service_type,
+						create_service_cb, info, NULL));
+		perform_all_pending_work();
+		services[i] = l_queue_pop_head(info->services);
+		assert(services[i]);
+
+		send_request_via_qmi(info, services[i]);
+		send_response_to_client(info, io);
+
+		qmi_service_register(services[i], TEST_IND_MESSAGE_ID,
+						notify_cb, info, NULL);
+
+		info_clear_received(info);
+	}
+
+	qmi_service_unref(services[0]);
+
+	send_message_to_client(&info->sender, io, QMI_MESSAGE_TYPE_IND, 0,
+						TEST_IND_MESSAGE_ID,
+						TEST_IND_DATA_VALUE);
+
+	while (!info->notify_callback_called)
+		l_main_iterate(-1);
+
+	for (i = 1; i < L_ARRAY_SIZE(services); i++)
+		qmi_service_unref(services[i]);
+
+	l_io_destroy(io);
+	test_cleanup(info);
+}
+
 static void exit_if_qrtr_not_supported(void)
 {
 	int fd;
@@ -574,6 +629,8 @@ int main(int argc, char **argv)
 	l_test_add("QRTR services may be created", test_create_services, NULL);
 	l_test_add("QRTR service sends/responses", test_send_data, NULL);
 	l_test_add("QRTR notifications", test_notifications, NULL);
+	l_test_add("QRTR service notifications are independent",
+				test_service_notification_independence, NULL);
 	result = l_test_run();
 
 	__ofono_log_cleanup();
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
