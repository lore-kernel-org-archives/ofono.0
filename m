Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652F13699C
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880716; cv=none; b=aDkK6OI5aA7W7T/VyuB2ckl8Zs8zAYJ9PZhJBdKHvA/X+4VyMEiDyoQByLIqN9+/BK+GU0U4g0PB3dGwPM2uQ327O/xDxa1MusYCtgpulOHbylckLgi3WeV/BnMHVejQEbyUbXVdswmpDSrgAbAFAl3UBLATYog/oUta1RF5EoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880716; c=relaxed/simple;
	bh=7jmQug9g/u/vIwfDVeBt8dg+vZmZY2p/ZCvbn4X5tRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nIuN87HOwduY6Yr6pYvocVdXbyCdf8Y+FMg38QKuvgF9dXEYAeNlrpixrpQQr08b/ubgkHIZlU0NI9SHD2TSQ2LIFM41vNxINrdc6hdElNLQ5DE36gtrrUPHL1DI3gQDAIltZSo7EfXABFQxr/0HZZYmQih/rcf9FEdCpKsG8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=IU7C2NHV; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UDwYlo09; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="IU7C2NHV";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UDwYlo09"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NDO4ft027288
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=; b=I
	U7C2NHVdsIucBN8bgSkt98B2UARm2oIRI3qROW208pWTZUvrAHM7N6B7MuwfM/OH
	pWQyKbP5HXK+wA0zLC2il/BlfqPVauDOBRNHA2w6JgSOgpgDUxcm39+c4LB0FGie
	W/peBYBa/6QHVgyn5E2SD5JHV7VsBozdrAxoZetXPUcldIhV7HcqHZOwJAxvYIZz
	1kSSbTXLXGWIp6ZsYVOWvxmt4Ku0VcaTrggc68IntYirkpEINjJUilxrvTvqLyQm
	rqY1sbq6xxjXueUMjI6y4N38RhC0GVu73M7fNCSzyPSYdhTkE+N3BJsVJ93Nrdxd
	Sxg71Wccdz/Q+OPRMEYnA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xmcsd1y6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:28 -0700 (PDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78edb34cf1fso744272285a.3
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713880707; x=1714485507; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=;
        b=UDwYlo09g1zl+dAvAwTiYN/TEF32OQy1Si9Yc/mp49i8YXyO6GDFJokUbsmyFOfYeE
         0jy/HIk/KtUbiVJNldDOM74L3d+Wha/pS+6HQ8Bf8qSw/hwfWq+T/pwrXJWr1czLFsaj
         4SxGBJUY1DRzDJzJhaJS0ea9hP3O6IQxZO9Hz8t2IqF7Ne1H2xyW4X9KDsdDsTF64fMv
         xCO/PvnOsOuPT3lLDgyGAkjVHTZMOyH8MCP4KerB+jzmzPuoCgLlFkPliv/TDPqyC3da
         2/o9oSbuxmEX0NObVvmIZ0RMjisGg0Jcjb3fGN7c+BEhXAjhmqRkxLxwzspn6on7JWqw
         +nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880707; x=1714485507;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=;
        b=m8S3PeDzYVMhtU+S5EpDNo1ijik8ZvsKynfRfNGx74d30dnQ82ca+NM9tV4YbuahFn
         cu+pl2TwTHAvpAsF1DJDzrsTDjxKIysm89evdZ+AzHRjROnBhUevpa/ejIaSpuv4CpUN
         zdO9PwOKi2kVfMCo+QyIrq9iARirRX2jGkN59oWiZtT0KQ5Ro0rKfwtE4Qq8YH8sRtYC
         FPYmIFUDyAA7nVp4JbhOtwaFsDV4EMRU5SsIG/YcQkQMSUl+1a1UV698tWvnsZv9/mVW
         RpOsjrSWnnkkygtIPjHWu0l5Kdvk9lW5ExloByw4QmP7mlDNlnKiShznRiosyaspowgF
         CV2A==
X-Gm-Message-State: AOJu0Yy5dJxxBCLjcjZmKMMtIYOMQZC9LzGdbLAvOi8B6IF3lcCEHfFi
	cjGQerf1HmNmxuVBTtuTIL9GfKE0ke4/ZKR39ih5jV7gePXdiykVMA5eqcuS7nCogMGvOYsJ33T
	lcDeS76sjRvOI37ytr9kSuzeKxNn8vQ4qWN0uIy2sWp0HA2UL2qUcNolXIvAWlWK4sudwCySc5N
	Nw2+0ut6+TVOWMS/MYvfuYsjKxvACJ45sErOonq2GBt25qkGQ=
X-Received: by 2002:a05:620a:5e52:b0:78e:df32:52b0 with SMTP id ya18-20020a05620a5e5200b0078edf3252b0mr15650119qkn.5.1713880707489;
        Tue, 23 Apr 2024 06:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZh49CE5tkGgPnt4AjZWdlHYhhAhP2/1j2CniXvR/embcNqLdyT+Pr+2Sv3E84AV9AHhbdww==
X-Received: by 2002:a05:620a:5e52:b0:78e:df32:52b0 with SMTP id ya18-20020a05620a5e5200b0078edf3252b0mr15650091qkn.5.1713880707040;
        Tue, 23 Apr 2024 06:58:27 -0700 (PDT)
Received: from localhost.localdomain ([140.141.152.103])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a084a00b0078a04882ac2sm5220454qku.53.2024.04.23.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:58:26 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/2] qmimodem: Remove redundant unregister all calls
Date: Tue, 23 Apr 2024 13:57:10 +0000
Message-Id: <20240423135711.272881-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: yvb4uI2NDO_1KkjBeyih4qq4zo35NI-0
X-Proofpoint-ORIG-GUID: yvb4uI2NDO_1KkjBeyih4qq4zo35NI-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230035

Some of the qmimodem drivers were calling qmi_service_unregister_all
before decrementing the reference count to 0. This is unnecessary
because the service will unregister all as it is being destroyed.
---
 drivers/qmimodem/gprs-context.c       | 4 +---
 drivers/qmimodem/location-reporting.c | 2 --
 drivers/qmimodem/sms.c                | 2 --
 drivers/qmimodem/voicecall.c          | 2 --
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 6104cc82e76a..d248761f92d6 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -503,10 +503,8 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 
 	ofono_gprs_context_set_data(gc, NULL);
 
-	if (data->wds) {
-		qmi_service_unregister_all(data->wds);
+	if (data->wds)
 		qmi_service_unref(data->wds);
-	}
 
 	l_free(data);
 }
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/location-reporting.c
index a32d18245c4f..549bd5740613 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -257,8 +257,6 @@ static void qmi_location_reporting_remove(struct ofono_location_reporting *lr)
 
 	ofono_location_reporting_set_data(lr, NULL);
 
-	qmi_service_unregister_all(data->pds);
-
 	qmi_service_unref(data->pds);
 
 	l_free(data);
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index b9fe963520d6..12f5d6726d48 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -801,8 +801,6 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 
 	ofono_sms_set_data(sms, NULL);
 
-	qmi_service_unregister_all(data->wms);
-
 	qmi_service_unref(data->wms);
 
 	if (data->msg_list)
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index b66f1ae7d56d..02376c3df447 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -653,8 +653,6 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 
 	ofono_voicecall_set_data(vc, NULL);
 
-	qmi_service_unregister_all(data->voice);
-
 	qmi_service_unref(data->voice);
 
 	l_queue_destroy(data->call_list, l_free);
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
