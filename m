Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4A13B5B7
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884498; cv=none; b=twJ6nyCnPlPriGQ07FUo5Eiqv+GuoCAGV+aq1LN1HBU1WbTMCyH3oqWz25HZ/EH5JagSgvc2DtLHmFy71NADg62F72k1o7WIpr1/Ai+z6uXGc6RzLDPdYWNtHXkrRW7meBF0e4YLib52ZZbhVakMBOMxGoGmdqtvEOfHxbKsT/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884498; c=relaxed/simple;
	bh=cy63BOfiNJcasMHebPiOWkqlN9KCusuCrocquY0DE7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzZJ5PyrCuYuxQp1PpgDaxNLBdNkzRJPg5k25ipf2hq3GW63taYHNp7hjh5XEd8HPRpG1OUcOWCEUfahOUGPrz32KhU4PuzbTOIqxrhzGglHywPurKj/VCR7/AqNJf5Ea5oPioF2bmS5CbJyHDAasyEzml/v4eXk0RhnsFGIyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Ephg8LV+; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=FFBHicg4; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Ephg8LV+";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="FFBHicg4"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCqcni013140
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=a2uIHmQg0nLBh+OOS1zkwT
	BPJMeP/U2l/91PtRZJNo0=; b=Ephg8LV+QR3ujlHyov7zs3XpkkDcvhmSt6482y
	vnsnBmMdcv9RzcXQRSjQ27ehuxji46xjj+VHg78P8fSNVts9cC68wPEoQ3yTPa4V
	mFYMNFIr4d6sJVj67g7OyOkkUqlxejl7VkNHOG8QLK8PVKt9XkTr5xyCQi9lCo+V
	VpG0rUuHyyeWY1ndxZsk6bw19a/VqieruNqqyuB67bndOs3tGrsmN44Cm/Z3KU0o
	hHvpOIJ5Z4MrlBGSY2XnO8dTUOQUIzeZ4OCi3MgbZ53eBqoVNuLL/lGTQ7NL0+lK
	kj9QdOeB3ZWTLCDVTKX7j4q85Lgj+n4kyBGW2Hl/W6gOiApg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xm9wha42t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:25 -0700 (PDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a087bba1c9so17890826d6.3
        for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713884484; x=1714489284; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2uIHmQg0nLBh+OOS1zkwTBPJMeP/U2l/91PtRZJNo0=;
        b=FFBHicg4AhjcJXwpLcxthlNzyJqwfaunj9oEk6c7wmfqkHCYhhNrDPr0BoRE02bjDj
         0VhcUzpC6D7qT2Ci3nj8yQ9Lu8hHmk9B0SMzqIDL1HZehPh1iOZQs0vv3IdYOP2KlKMp
         kTlrB4d/YbbnRc/pRv1+9hnMIq9U4fdfjDfmMLeZMSDc6RtlBKVzJHpibDznYr870LKs
         LnjtD/QTKXWJVhpzMl6EKjnxgnyTXQOjGuCx3JmwK2J6OBZBN3mUsOWeoOuQQpP8ex5a
         N4PTn09GAdmNdBMv17lTJpJPiY2nywFo1O9V6LW12BYbNReVJFkHSabuTJ8Vf0EGNBos
         OX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884484; x=1714489284;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2uIHmQg0nLBh+OOS1zkwTBPJMeP/U2l/91PtRZJNo0=;
        b=Ziu1FzW4ULmMZhxD9wUAnXYdFOU/trwq29q0dDSAhYc7UUpBVGwofTSLerdL/Llme4
         2M9upuVWJ5y+Xii6WrZLg2wNHZxlTFRup3D5GAccoJCb5Zm2YDbID0DxD+wVs2UQ0NPx
         BY2g/rjYYbmG5mhERCPRmnvib7Addd9VBk/efnTV5d/kzPxRPmdTjPtLGd3WY73QxNvn
         Elbmk/vqUIZ9iCVI+kA4TlXq9oiik7NkyCEZIMzQx9DOwo+6RDmELwGZRlyU1rBldVUy
         VoyPe6xH1FdwPiIdzh7UfmhnsEbFTdNeeocHbm1NHLRwtSbKWfjqkzyjSMBK+JhDbXeU
         6aBA==
X-Gm-Message-State: AOJu0Ywkzm8xW+9KO+RPAW8yKBBNavViNy5VYN8zVM4vWeKeoKjM4AHt
	COmmWOHMoUIyKLDId1h6Anpk18xpsVBZnTvVGgTMGX+qE8jv9WCfrPgCOdr34Y2xbbZ4Eo8cgi0
	xj8qZlJg4BXLZ8XchgH+nZMi5UiZ2a6XlE6sAwyt/PehmN/4sNstu2x9+1QdBNSjBXY6xPKgUuS
	O1tXYkyHRhU1+jjMqlRtja2UcSIuDPR2xa1NSRGa3soPQqnw8=
X-Received: by 2002:a0c:cc90:0:b0:69b:7c92:d880 with SMTP id f16-20020a0ccc90000000b0069b7c92d880mr13418660qvl.52.1713884484069;
        Tue, 23 Apr 2024 08:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqB5TKLfW5pCFsCZBNmvhr7MwkHSyaRdKRMb6DiwymH8AlLmbffFc1aeBG3i2/eWkrP1eWbA==
X-Received: by 2002:a0c:cc90:0:b0:69b:7c92:d880 with SMTP id f16-20020a0ccc90000000b0069b7c92d880mr13418626qvl.52.1713884483637;
        Tue, 23 Apr 2024 08:01:23 -0700 (PDT)
Received: from localhost.localdomain ([140.141.152.103])
        by smtp.gmail.com with ESMTPSA id b10-20020a0cf04a000000b006986c3f3d21sm5183393qvl.116.2024.04.23.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:01:23 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 3/3] qmimodem: Remove unregister/cancel_all functions
Date: Tue, 23 Apr 2024 14:59:36 +0000
Message-Id: <20240423145936.276945-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423145936.276945-1-steve.schrock@getcruise.com>
References: <20240423145936.276945-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: mMk5Z8NeYhp-69OO1GJKIct7ULap0ecg
X-Proofpoint-GUID: mMk5Z8NeYhp-69OO1GJKIct7ULap0ecg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230036

gobi was the final user of these functions in its disable function. It
would perform this cleanup before sending a final message. This is not
necessary because gobi does not register for any notifications and the
only sends that might be in progress should only occur during
initialization. If a client actually needs this functionality it should
free the service and create a new one.

These functions are still used internally in qmi.
---
 drivers/qmimodem/qmi.c | 30 +++++++++++++++---------------
 drivers/qmimodem/qmi.h |  2 --
 plugins/gobi.c         |  3 ---
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 74fcf3c8927e..69a0e535f689 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2720,19 +2720,6 @@ bool qmi_service_create(struct qmi_device *device,
 						user_data, destroy);
 }
 
-void qmi_service_free(struct qmi_service *service)
-{
-	if (!service)
-		return;
-
-	qmi_service_cancel_all(service);
-	qmi_service_unregister_all(service);
-
-	service_family_unref(service->family);
-
-	l_free(service);
-}
-
 const char *qmi_service_get_identifier(struct qmi_service *service)
 {
 	if (!service)
@@ -2896,7 +2883,7 @@ static void remove_client(struct l_queue *queue, unsigned int service_handle)
 				L_UINT_TO_PTR(service_handle));
 }
 
-bool qmi_service_cancel_all(struct qmi_service *service)
+static bool qmi_service_cancel_all(struct qmi_service *service)
 {
 	struct qmi_device *device;
 
@@ -2980,7 +2967,7 @@ static bool remove_notify_if_handle_match(void *data, void *user_data)
 	return true;
 }
 
-bool qmi_service_unregister_all(struct qmi_service *service)
+static bool qmi_service_unregister_all(struct qmi_service *service)
 {
 	if (!service)
 		return false;
@@ -2991,3 +2978,16 @@ bool qmi_service_unregister_all(struct qmi_service *service)
 
 	return true;
 }
+
+void qmi_service_free(struct qmi_service *service)
+{
+	if (!service)
+		return;
+
+	qmi_service_cancel_all(service);
+	qmi_service_unregister_all(service);
+
+	service_family_unref(service->family);
+
+	l_free(service);
+}
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 921136f384db..0075f73803cc 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -167,10 +167,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 				qmi_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_cancel(struct qmi_service *service, uint16_t id);
-bool qmi_service_cancel_all(struct qmi_service *service);
 
 uint16_t qmi_service_register(struct qmi_service *service,
 				uint16_t message, qmi_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_unregister(struct qmi_service *service, uint16_t id);
-bool qmi_service_unregister_all(struct qmi_service *service);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 76507cd7f299..550ce78733f5 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -471,9 +471,6 @@ static int gobi_disable(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	qmi_service_cancel_all(data->dms);
-	qmi_service_unregister_all(data->dms);
-
 	/*
 	 * Telit QMI modem must remain online. If powered down, it also
 	 * powers down the sim card, and QMI interface has no way to bring
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
