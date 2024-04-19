Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F27136678
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545183; cv=none; b=Qq61PpRhRZIK8MH0ZqW1SiSYQ4SdGEcW9yuLfPUArfnFfdh1gInsqzONnC2WPPVH1AN5FUh2mfmYDNUbroqqJmGz1jo/uBLegqQJVsSoU5pnBZYCzKlU52OjY+LIgJ5fMM1pRd2KrsZJNvR5S1zV/maHgKlP7Pa8QvC9uA4l0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545183; c=relaxed/simple;
	bh=pY2RHgEAYStuKYj5SYMptpDmo6H9GaMi25zFw+RI2ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvlAboTDI1pvGy/qCv1pUnnoFDm/yg6rVlAcwSGNgmRjLsOTdvniDReaxxu3ezOdxp6Nkid0YLfjKQHuyeh0xOq6CaTGdK6ITkoRbCabi0bcQn7xuDQhTlprONGaxVXWtkaTS/JaIm2LVmCt/eBNQmQUWfS3CTDPSuREkNbCKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Qig+Qjsl; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=hVjEYZUk; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Qig+Qjsl";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="hVjEYZUk"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JERU8J006646
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=RerN13Hqk/0T7Bajp7gm2t
	sqmFn4jSI4JXvtwhlDpAQ=; b=Qig+QjslE5a8p9e3Rg/dzc04v6aIv6s1VvgyCI
	fhGDneXYkBOCQ0zhafyoqaw08YGYHRIyK6ixsSd2T2YvYXL7v8eELnaFYiz/PBMG
	LgCcF5Iwfd9KoUHY205EoTehwJG4pjqkHSfEvA+ArEcynnWfMlRmZvHWWN2/uelV
	xI3cpv4eSOx9tSYWfDnDk7kgsmsop0nIScG0X/+wDG4wQdk5a/o5k7Mjxq/TYxsZ
	avcYvGruDN9fRAnRP8kfGRphtmF3yInVmP8GwMhgy2Oh1T7nXL377FaGilYIe1QR
	LnxqRkf+mK8MJZVsGYhtnpG0f3XECxIpBjQoI7R0xxciwgzQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xk8m70wk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c613c1c51eso2566992b6e.3
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545179; x=1714149979; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RerN13Hqk/0T7Bajp7gm2tsqmFn4jSI4JXvtwhlDpAQ=;
        b=hVjEYZUkEE7nPml9Yhx1+SgaDFwJu7FhY0G5K0UfE7Zjn3nA04ZLbgVQvz8g3bXI5X
         eI69pNUC69nwL9D4QCxFyKmZVgR7ZmeNS3CUISrUmvKWWzNdDx6ZzLLCQsNY8hfy7QQr
         Z4qABMRdg3tDzAik/d64zVCUif/13g5GUGdBixR51JdZyJaqLiYHnTJiJvZy8R+3HFkQ
         tOg19JWt0/D6GlCzW2fbEgYQiF80ppQIluwVfAdlY8G8yxBrxtdEvY/GCexnvugr0Lj3
         XPZzuDuYdzfytGi+fKVqe3JinPz/qHHcI2gP3qth23j94MjMAuhmfYrHiy2CBfy0hO4e
         Viog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545179; x=1714149979;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RerN13Hqk/0T7Bajp7gm2tsqmFn4jSI4JXvtwhlDpAQ=;
        b=F1hh9hSCcx2lUfNjfJt8UZm77tTMj38+z46xxN2XWAvrgYvj5asynvwyC7Ak06v4ho
         tGn2Hxm9mpz7q0rVtKJS67pok3Pofrp0pptQs09h8g/olSLH3iz0XokybqWvPsOTBjwM
         GcMz5IwgnOORZoNX1rOXJFWQaYEAV5cNKcz0we4oAqTFgq0LU+wlz8AOJGgNZzRGnz8o
         HUYyENLnbXWOnIl+dRJxO5MUhXSBfXFi6KqxJ0gOLkKeMOUdhP/RicE/GrOm6EuvgPK1
         20pAhGooA/gxg1RwB0wwQv9YHykqToxWiYRX0yhAROasS6ZjkMNjKbR8VNXW+qL9WOJr
         cNeQ==
X-Gm-Message-State: AOJu0YzFzC43jSLUxjRdF+zaPtzRze+SvupRd6s1ORgZDG3HNEo/RJ7r
	Nzh2IGgnxjULWZKCKzobls3BarVKWO1EKun+SHS8w53ZAM/GIauaFthDLZph0XkKMx6yIj264Da
	TLRF1H3nQsW0eB6MbXmqOZYzCrgZLBTSPuMGoXN6/ryPmSRiTvC1dgorfnZHCrFUrsNPL1ovRtP
	y24Q+PVlLPm3mZXHVNWOI0lv8ZG4d7mPvUvQctWigcZyGg/8U=
X-Received: by 2002:aca:f12:0:b0:3c7:4e3c:8dcc with SMTP id 18-20020aca0f12000000b003c74e3c8dccmr1186398oip.9.1713545179571;
        Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHEwklmOUjTrRMSf3Yn0VIUIsJBePB1xj76gm8zzvbx3MgIds73t8TV9VZCLWXjH9DT/j+ZQ==
X-Received: by 2002:aca:f12:0:b0:3c7:4e3c:8dcc with SMTP id 18-20020aca0f12000000b003c74e3c8dccmr1186381oip.9.1713545179240;
        Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 7/8] qmi unit: Validate destroyed services do not notify
Date: Fri, 19 Apr 2024 16:44:57 +0000
Message-Id: <20240419164458.36078-7-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: wCxNd5EjSYOmEIeBlV6C4Rze9KAAuP_a
X-Proofpoint-GUID: wCxNd5EjSYOmEIeBlV6C4Rze9KAAuP_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190127

Confirm that client notifications do occur after unref'ing (destroying)
the service.
---
 unit/test-qmimodem-qmi.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 8df8b56a79eb..43e1bad082ba 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -23,6 +23,13 @@
 #define TEST_SERVICE_COUNT	2
 #define TEST_TIMEOUT		5
 
+/*
+ * The amount of time to wait to validate that something did NOT occur. The
+ * value is fairly arbitrary -- the longer it is, the longer the tests will take
+ * to complete.
+ */
+#define ALLOWED_QRTR_TRANSFER_TIME 100 /* ms */
+
 struct test_info {
 	int service_fds[TEST_SERVICE_COUNT];
 	struct qmi_device *device;
@@ -36,6 +43,7 @@ struct test_info {
 
 	bool discovery_callback_called		: 1;
 	bool service_send_callback_called	: 1;
+	bool internal_timeout_callback_called	: 1;
 	bool notify_callback_called		: 1;
 };
 
@@ -473,12 +481,20 @@ static void notify_cb(struct qmi_result *result, void *user_data)
 	info->notify_callback_called = true;
 }
 
+static void internal_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct test_info *info = user_data;
+
+	info->internal_timeout_callback_called = true;
+}
+
 static void test_notifications(const void *data)
 {
 	struct test_info *info = test_setup();
 	struct l_io *io;
 	uint32_t service_type;
 	struct qmi_service *service;
+	struct l_timeout *receive_timeout;
 
 	perform_discovery(info);
 
@@ -505,9 +521,26 @@ static void test_notifications(const void *data)
 	while (!info->notify_callback_called)
 		l_main_iterate(-1);
 
-	l_io_destroy(io);
 	qmi_service_unref(service);
 
+	/* Confirm no notifications received after the service is destroyed */
+	info->notify_callback_called = false;
+	send_message_to_client(&info->sender, io, QMI_MESSAGE_TYPE_IND, 0,
+						TEST_IND_MESSAGE_ID,
+						TEST_IND_DATA_VALUE);
+
+	receive_timeout = l_timeout_create_ms(ALLOWED_QRTR_TRANSFER_TIME,
+						internal_timeout_cb, info,
+						NULL);
+
+	while (!info->internal_timeout_callback_called)
+		perform_all_pending_work();
+
+	assert(!info->notify_callback_called);
+
+	l_timeout_remove(receive_timeout);
+
+	l_io_destroy(io);
 	test_cleanup(info);
 }
 
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
