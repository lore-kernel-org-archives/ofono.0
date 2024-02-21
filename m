Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9341272DF
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550610; cv=none; b=hobK9ocvuqM+kd7Bu0wng1PX/7KFq4vXTc5OcLqgU+r7aOAXVM7MTG6V6UcmXesw6jtIDUUzLF1oSRbnF3vocOa3GGIGzrDoU+1oBnCPcdhSldQylOsasz1RnsCr9LGDjYIUFHjEeLjHwoACJKzu7LsMX9aJzyWLSalQoKVMaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550610; c=relaxed/simple;
	bh=qYtF0+IosNPOvoPqI2SorHakXCCvrp24hoOnYoaxGUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WuXxJGv1goFIRvyT5yBN0oNNyiraFsOBAVBO1tb7zaphCc9W+jCvthJFaUUnfR0rBuImzH3rP+cghwnUr0f7zyrxAE6qk+rUayr/oAxz5kSfCqQWkrX0YBx9uJVO4dG/Rc26Pgvgmp9cXHLxN/9OGSMDZsjHqCedxAXIQH//w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=DAZ4Ck4h; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=kxuInYSb; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="DAZ4Ck4h";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="kxuInYSb"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFwIaI025536
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=; b=D
	AZ4Ck4h5uUn/glMNez0F6YYIKXfD4YGxZepPW4/aOVimEf5us0BeK/bHJ5ojzr44
	nsm3BwwU2Btipk7nd9HXCw1EQN4gqkLSXy7LU3hG/3k8G4lshMnFG52MqAoYXvlm
	Jl5CfJbxtBOrf9jis9vbDwjhn0BNpw6yzNW3jrPo2StpcX0i/AkzQ223yUNwZXR0
	PxtRMX8rwkFqKkOtFe10LKoMnH5X75veDf6wpyg8512BRzh5om68ndSQe91U7LVm
	MR4VcAjYOoS+wwldHynQhspj/xaIhk5dySbdywVai9qd/VpQV4fQJ5Aa/TGMN5s/
	oIzVLupc2ueItLSQCpS9w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563s0gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800 (PST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78771ee4ca4so147996285a.0
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550606; x=1709155406; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=;
        b=kxuInYSbZybjLTdPopH+PV+g3+7+vm64tzSldyfIHwCxjJZtEmkWe/Be4xBScYWKaE
         4V2mZDLeThhYJbu3v9cbH1rRBeMKC/o6HI6jpcyk03pmZHLVdu9X8tpfYfQE8GWEB+hU
         VvOiXaoV9P/8i/h80N1t+DN6pJFn8ZHYXKqXySsR+JEfckh8+yUkBtpHR/fS0BxUeODr
         7Qf7R+Cn14jpa1jJIQyKboV79n+E2T+BLb7qoK6UOZQ/pU3bYMUlXEivvYMp6a3p7D7U
         lJMK+77HreASWGrb8dHrjt4CdvdX7rhxDzCxJj6fygLBkw7aeHI/2cwzyEZck1yZ3x1r
         jVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550606; x=1709155406;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=;
        b=RGQRVp4y8Bwm/EFJIuKbA/jHBQUTUfkWC9q9V1TprnsuUhVBZSF6ZfBPL41kKO/lO/
         FXrlkHs3f4PtFqWcm9mi95kbflKZw9ykL1DBkE0jTbZYAfTf7gvPMScSlc8f/k35Nk9+
         XDP6/UIqBMm7gJDRIuYCa5fmGlajsOl6W9kTOvg9+ZdD9RkjBbM0cOROI3zw+dzZQQno
         dZSnYgoNv8PuayjNUZNkq4QnOQ4ezcHtxmcS7p4pgctDL22moA2HuBC0tvV5cyyuH3+Y
         jNdf7cJdBH76M3A6XLOeYJGbC3kbJ2SHeIGDE/USxb1N0E3/IUcmhiqc2RvenP8XPazX
         +ZVA==
X-Gm-Message-State: AOJu0Yzngq5yasNVUle/51nUDEaDI9vUsZ7r95kQ3yk8Znc6fu/cYQ1O
	mg8Uz+h2iGo6ZSShcl/jXYKutUfuYRA0tijz2jTvPOi9f3Ot6HulVnXOKoyhSrvA56XkFPidazl
	ZmGCU93CCADtNhq5HfaRWF5jvFgyWqyrGkofrTULsaEpDRTV+LBSi5ih0VvlWU1QNciu6dpDo9u
	VApN63V8Rxbqc4apk7aqvNKDIiyhuRq8f7KJC7bgYaIRI2eVM=
X-Received: by 2002:a05:620a:55a3:b0:787:240f:f438 with SMTP id vr3-20020a05620a55a300b00787240ff438mr19289280qkn.22.1708550605905;
        Wed, 21 Feb 2024 13:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFldhPXXTLYbUi/TZxK09RJj3kC/UEGfmtoZvMMtCsJSfONUnZo89z0m+VdJHSsOlUnL5KVGA==
X-Received: by 2002:a05:620a:55a3:b0:787:240f:f438 with SMTP id vr3-20020a05620a55a300b00787240ff438mr19289268qkn.22.1708550605527;
        Wed, 21 Feb 2024 13:23:25 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:25 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/7] qmimodem: Use l_queue_remove_if to eliminate double lookup
Date: Wed, 21 Feb 2024 21:22:06 +0000
Message-Id: <20240221212212.181401-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: NDCUGXsCLLJ6kMMMdpoXUUwXTlP4eAB-
X-Proofpoint-ORIG-GUID: NDCUGXsCLLJ6kMMMdpoXUUwXTlP4eAB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_08,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=938
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

---
 drivers/qmimodem/qmi.c | 50 ++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a2f5902f..d2d4eefa 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -793,12 +793,9 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 
-		req = l_queue_find(device->control_queue, __request_compare,
-					GUINT_TO_POINTER(tid));
-		if (!req)
-			return;
-
-		l_queue_remove(device->control_queue, req);
+		req = l_queue_remove_if(device->control_queue,
+						__request_compare,
+						GUINT_TO_POINTER(tid));
 	} else {
 		const struct qmi_service_hdr *service = buf;
 		const struct qmi_message_hdr *msg;
@@ -819,14 +816,14 @@ static void handle_packet(struct qmi_device *device,
 			return;
 		}
 
-		req = l_queue_find(device->service_queue, __request_compare,
-					GUINT_TO_POINTER(tid));
-		if (!req)
-			return;
-
-		l_queue_remove(device->service_queue, req);
+		req = l_queue_remove_if(device->service_queue,
+						__request_compare,
+						GUINT_TO_POINTER(tid));
 	}
 
+	if (!req)
+		return;
+
 	if (req->callback)
 		req->callback(message, length, data, req->user_data);
 
@@ -1244,19 +1241,13 @@ static struct qmi_request *find_control_request(struct qmi_device *device,
 	unsigned int _tid = tid;
 
 	if (_tid != 0) {
-		req = l_queue_find(device->req_queue, __request_compare,
-					GUINT_TO_POINTER(_tid));
-
-		if (req)
-			l_queue_remove(device->req_queue, req);
-		else {
-			req = l_queue_find(device->control_queue,
-						__request_compare,
+		req = l_queue_remove_if(device->req_queue, __request_compare,
 						GUINT_TO_POINTER(_tid));
 
-			if (req)
-				l_queue_remove(device->control_queue, req);
-		}
+		if (!req)
+			req = l_queue_remove_if(device->control_queue,
+							__request_compare,
+							GUINT_TO_POINTER(_tid));
 	}
 
 	return req;
@@ -2375,17 +2366,14 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 	if (!device)
 		return false;
 
-	req = l_queue_find(device->req_queue, __request_compare,
-				GUINT_TO_POINTER(tid));
-	if (req)
-		l_queue_remove(device->req_queue, req);
-	else {
-		req = l_queue_find(device->service_queue, __request_compare,
+	req = l_queue_remove_if(device->req_queue, __request_compare,
 					GUINT_TO_POINTER(tid));
+	if (!req) {
+		req = l_queue_remove_if(device->service_queue,
+						__request_compare,
+						GUINT_TO_POINTER(tid));
 		if (!req)
 			return false;
-
-		l_queue_remove(device->service_queue, req);
 	}
 
 	service_send_free(req->user_data);
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
