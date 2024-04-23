Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2DC13BACF
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884494; cv=none; b=aP7w1Zv63OKGZqExqkoFrhCf6aqHOIQMQybrclVcviSn6/R3qe3sFXngEKaJH62H0ZH2BAcDSZjVKkELoFc4xBwsYayiO0u2YWj+8xf41oFV8glyO4DfUilXcEchgbrEL7qMJs7wEc2l1dZsPXb6M4wHlEA5jAwfV1s3l0jUWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884494; c=relaxed/simple;
	bh=7jmQug9g/u/vIwfDVeBt8dg+vZmZY2p/ZCvbn4X5tRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FscnlQ1a2W7Yr2s6qIpIjYA1cW7GMJ7hsitgm3mJHguucfwHQA4taXo8ZxdfsJI5Xwv1QmK8ky4A7/3SPqlcCSBvSdxqDSpOQC6bVKyRpKHOA5v3gBjpDcvs09u0jG3tg9u9uhWnOSFNEiSI3M/UfSBTfAe9JBpgm+k8howt5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=mFEbNvDo; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=nGFzuwHV; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="mFEbNvDo";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="nGFzuwHV"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NDO5Pj003082
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=; b=m
	FEbNvDori5xZ31rePh0HPwrJn1b9YV6MPBJR8gWZ/WOJ81OcG4Vneat637o6yzba
	wth7thhkKKvfOTcstHlg8+Ch0qjsUX4/1s9IrDNyhPuEKjsKvtSM9kRDtmWYwl2L
	OiH3vBDUM1wWGkfivhiJiDxElmZTUKPUQu8n3p1bLvNa0nqKaPGR/f2RqkrUqw/I
	cg96POS+HNENn++akKVZSwUyGlTWYlfdppood1wJLZjB5VNFC3Q6X/OmEf1meXiU
	Lt0NBVtI9gaviLLp2aEXP39W85PkpqH8hQmmEgON67zH41NsnSZcOOp5GjksXmvn
	ndOh7c5CrvPupYc3vC2Sg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xmb94a36r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:24 -0700 (PDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69942c6d975so71898176d6.1
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713884483; x=1714489283; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=;
        b=nGFzuwHVUooLKUzQkr+m4M/6cUNZNRviE72jQr6sh07bC7UngAfg80FLQJuANia4oB
         HYSTo21PiKgk2YJazhTbZd7FP0dDhN9Q591EpS4RcUMP/uU51uxnYFjfTUrl8u0TBvmH
         nwuGwbGEBhjLQZEopNoKNlq55qNhql2Qnn8oHy9cmRH6znpAT7anLdvN8bE7yyZLQeti
         QM48SMzmHCGeuAdkLccTUfGqcLQm8STWxTSCen9ZHrXHOyLxmzNlL0JCTWO3LrsSiWjg
         FmCl92MADG2t2vGf1byyoAmULwTfKk5kF7u+9RrSWQ+tZ6K8QV/v29Lyr0BYex9GHqMC
         JH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884483; x=1714489283;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkuvmAuM69A/UbT0E0U4GWTdPOQSxjMoOclAzEbaUtg=;
        b=OJY4H4tAT8Kl8yPdl0mlmO51BPQw8V7Go6CIVDNjPjjmXQsQ1vw3s1lpd1FVs8vbTe
         9yG1dtD+mUbz8n1PY2UZuasMknqPR54oABVFgnqEe6O6P2mqfXYWj9Nb9akxk1JTE0N6
         S9y2Vj6qoOAe5O2zIZGo1fID5pEoOqBMhElyqLiayZEwr8OzYcz31PssmEg6MxA8JYnz
         s//09MyJtFPyEsmAwmXpsrqedLsaz3BLpH0uSPNdgqsfsR9KVRvuItzTFtxx9YkFYifJ
         Hmze3eU7S32IXvr/vV8L+tevQ+3+a1Rz/JiI/mCFD2oibAVt3F//EAGVj+ITZ8HaeomF
         2vdA==
X-Gm-Message-State: AOJu0YwLCkGiMJTf/LYW3oZQUvQp2z+hzSP/KmMxuc7hcnyNgq56wEXD
	FqW1yvXOlc3NSBuz42cPHoO2rwMSkpdKz/44pIfjwPhDlNwQG4qeMkYGLM3GmSA0P/WnHIbePPd
	C7IbkqkQzHfD+q6j++qPsB6m8wOl6oDj2YBgm7KMsEA2a+HvCtl3bmbvVTcsV6gNolbJEOb1IAM
	TcjVZ1037Jpf41Z5OaNDeBfNV4SmU3BU6dCXpYrUmqnGtSLag=
X-Received: by 2002:ad4:4b73:0:b0:6a0:424c:6eab with SMTP id m19-20020ad44b73000000b006a0424c6eabmr14033055qvx.47.1713884483009;
        Tue, 23 Apr 2024 08:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2VBY+WqFGmJ4dPjhqrK3hcBCj51VQl08JZqMeBILgcYbymWmz58NPj2IN/2kfS8DWsVCZhw==
X-Received: by 2002:ad4:4b73:0:b0:6a0:424c:6eab with SMTP id m19-20020ad44b73000000b006a0424c6eabmr14033017qvx.47.1713884482571;
        Tue, 23 Apr 2024 08:01:22 -0700 (PDT)
Received: from localhost.localdomain ([140.141.152.103])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cf04a000000b006986c3f3d21sm5183393qvl.116.2024.04.23.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:01:22 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/3] qmimodem: Remove redundant unregister all calls
Date: Tue, 23 Apr 2024 14:59:34 +0000
Message-Id: <20240423145936.276945-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 4HIVaeRKhHb3MWFt7LWb6Jtdb5ayfhqA
X-Proofpoint-ORIG-GUID: 4HIVaeRKhHb3MWFt7LWb6Jtdb5ayfhqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=937 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230036

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
