Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30212880F
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553925; cv=none; b=Ykt9MsPOQAb7j/ZtZ5qAfdbm3It2ewBh2BZ/oIf430jW+hLH+ACK6g1m+y39YHx8FQvZJFSLwB29IwsqLdgdgKzVI1HLkd5fn7tSnaU9euX846yhyATOn4LywvrsVP4CAgVPvxzc4loEQf8v4hn+nWs3GjGC4F4cxx1tEqjaSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553925; c=relaxed/simple;
	bh=IPYn7tKZNBiKSvD3dVbg0eKSuqb8jx2973Qhp7/jG3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuoPh1Wcp77MG/DPNJLREadA8En6p3szkcAHgInzhr7Ml2QgQ1HDlWJA71jCrQgPPZxV6KRtawzLMpH9Hjooz/f7DxC7q6+i4DMi6TecdicvhAWizcxK4XgxYfLx04SMqWcQnE1cGJf/U31HZp/GLFKW6kaWgHa1N5ecdE9vjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=GenciCs1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PoidFLPR; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="GenciCs1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PoidFLPR"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LEjNAb018898
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=6uaf5HP/wTsxJA2qe3SmsV
	Px7DQ0neloAV4r1k0s10s=; b=GenciCs1KbpWfp9FEyZDBduUj1HLKhlg1ErQLl
	HPTMV3pc36G1bPARoRzgVBknke+h6HxUbkAR/eWsfJeOUz48wM91GeU3+kylBRhy
	WVUaZJJ8OKVFOX6gaPQ6NBXuQUuserPcwm6lgseVxb3AuKc2qN1A0/eC9i6gADji
	+mjzS0zvOryC9ZoJU15BtlaCnOTR+L7a7FUPdtlE5E43QTfBSW0jZpHv/zlodvh7
	2ang1oKOvs/+m4mkmB7k0AuLi3ptvgf78MN889XfhWYRkjEjSiNFkA1fOfKvgtu8
	pPJrp1xK/rEwkIAv0TCyvkwwseCRyIzsBdIV8yInnAasDjhw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563s2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:42 -0800 (PST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68fb5db2c3cso4873666d6.3
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553921; x=1709158721; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uaf5HP/wTsxJA2qe3SmsVPx7DQ0neloAV4r1k0s10s=;
        b=PoidFLPR2UJWueDTgnubAuthkci0bjeJ0ZUpEhN1BiPd5eRT2N+2q5khPpsmfg+TTm
         0TisACm9bMfj0aZo00YLV6aanSR1r3/x+bOWNZH7yMjID3OG8elUo8tsgmyu1HosgaWF
         71U0foWboKi6tTLFRGVjBbnfNNqnT2L0C2ZekKC2bKdorWJua4v8y4AJ/6PbMCjFU70e
         cVyqlwxdo2SoQ27J+gZirF+MlkqwnqlKX2OLafEtGAz1FMznOuKzmnW3VIdJR24zWljt
         9a3vcIAqZ7cYPJYZGNtk+kNqxQH/k8v9y/JFMgtqsbfJMIcHzp76U1KHntKbR0wVPcFl
         fYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553921; x=1709158721;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uaf5HP/wTsxJA2qe3SmsVPx7DQ0neloAV4r1k0s10s=;
        b=SS4oA4fVnDcpDnjrtdyMHjHR+2k1xv/hsiuRqvjeLpNu5gKKLngp9J1jBFVPUqfkc7
         jKP4CfYtt3/mJ0cbJWQ+lXG+6zDvdsTr4ymUEKLzizN8+xD7Rg6Y9tu2cxCs9K96Y93A
         G4NE1uhXv16POOI63NladsI86DtMQN0fMZSYQcqvitkFj4UH5l8CzM5WcR4iday9H/Ja
         uRn6Wb4HOvsEXErwGLiX1j2dU3W6pncpfIc+x0JnAEZTyxpjd6V10FfzW0v/9g6wOcVv
         KkWRibM6dpH0+NptEHsm0/ttYH83Ao/pRwG+WLz9d1VuV15fl69veOs3hT9xSF9UM/BG
         B+JQ==
X-Gm-Message-State: AOJu0Yw2vI+ytc9R8TL3XWoWRdeFTB+iuwiD35WewjhtjJ5ewnJTiXjV
	1mXydZcsSZJ7S5vjc/pvNvGAAMNHsxbLgU9yVRpqno4ctZXvC4XxrN/qr6mfMKYx4uGC1ej8aLQ
	D3rVAAYNC0CreMnnaox3S6ZW72nRQu0M0wMc4j+OQEsQDVRuFrZTNX9pgN68lP1OIZbdt+1IacB
	PYPNg5CV8WOBq3EeqfPnX1RUshFRX85waPyQWDvczGNhXBDAk=
X-Received: by 2002:a0c:f54d:0:b0:68f:a73a:11ae with SMTP id p13-20020a0cf54d000000b0068fa73a11aemr2318976qvm.20.1708553921307;
        Wed, 21 Feb 2024 14:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI8RnhfFeWMW2fB8edaHaKZzP3kWAGzcXs/S+wtv6YNHozMMnMlOjJ0w0Ecuago5p6bpPBUw==
X-Received: by 2002:a0c:f54d:0:b0:68f:a73a:11ae with SMTP id p13-20020a0cf54d000000b0068fa73a11aemr2318964qvm.20.1708553920961;
        Wed, 21 Feb 2024 14:18:40 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:40 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 3/6] qmimodem: Use l_idle for shutdown instead of g_timeout
Date: Wed, 21 Feb 2024 22:17:22 +0000
Message-Id: <20240221221725.185480-3-steve.schrock@getcruise.com>
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
X-Proofpoint-ORIG-GUID: PNSOXqypdZkbKjsFVMZNhFWBnuZFVOoL
X-Proofpoint-GUID: PNSOXqypdZkbKjsFVMZNhFWBnuZFVOoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210175

---
 drivers/qmimodem/qmi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 6880dc45..1e127d60 100644
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
@@ -1551,24 +1551,24 @@ done:
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
 
@@ -1577,7 +1577,7 @@ static gboolean qmux_shutdown_callback(gpointer user_data)
 
 	qmux->super.shutting_down = false;
 
-	return FALSE;
+	l_idle_remove(qmux->shutdown_idle);
 }
 
 static int qmi_device_qmux_shutdown(struct qmi_device *device,
@@ -1588,15 +1588,15 @@ static int qmi_device_qmux_shutdown(struct qmi_device *device,
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
@@ -1611,8 +1611,8 @@ static void qmi_device_qmux_destroy(struct qmi_device *device)
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
