Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B6128802
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553923; cv=none; b=SSc2MSu3PwXIUsgDCOM6knis/aaTExI//tsonZRM3IilrbcBuTANAwhW0WmxkWYSZu80JE01l92mztLU0zniunyJjBhiuAGEtKZ4h+2v6TQsOgEKaJqJvBY0vrjmg3q5sy/XIMZaj1jGf/a6pmmu+B+eM8f03ghnSZP/V8oJKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553923; c=relaxed/simple;
	bh=qYtF0+IosNPOvoPqI2SorHakXCCvrp24hoOnYoaxGUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JPsJAt8tiMDGAi2dKKVs1/RfmkKonbfKSx3VsFeDIn2VFfFT25FEG5sgi9MtVo7klpfj+7lIu4AJck7MaxaH2EPXOiqT4r/sXBVOQccsMOQ6RUuiPYm2Sj6DGUOZMnDFTJkqIfeLxPpWICJ59lp/KhiZV8Jqk+BGb7oUjalM0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=GzLw3htZ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=I6+BPPFb; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="GzLw3htZ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="I6+BPPFb"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LExnJJ025791
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=; b=G
	zLw3htZBwC+uNgTUc0GgDcDSjcq6pr2R0TvSXK41lX1Ana7sLRKn00O5F6Z+cV3A
	gm7HsaFPR//US/3NyqVZcBJectojjZQ5xL1kzbMmSPTTDr3vXXuJXpNexx3wuIRH
	0LCJ0UWtUHh0n0JEdq3RFnKJWtCAX5A1ggVBk9+/usAsdXwzDqpnYVvvRqlONHni
	KM6JvR1OY6/htHW3kBfXsmSU4aeitfIo0g/8F2at7vJZQSjqkMC8IRIBDURyRtHA
	1gDpPKSXeEgqafLaVN4Ht8cglvbABGqPAOuDUOVUdezcUp0pdRwDR90oUSxihH7O
	18JzYuyM5DjJMWm4a3tDA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd563h2tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:40 -0800 (PST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68f75cca6aaso37657506d6.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553919; x=1709158719; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=;
        b=I6+BPPFbLUbWXArdqOqzXArtIV85MPUORmOWQAm/YRQMPEQkNakwB8XMWtemzVvkwc
         0ICoU/4VUC/82SviE9DiRd3WJm16yDSrcH8ZgvhSAGjxuTpNoNrYhdoFRcHe1/zDHlog
         d6eHmXuuRzD85pIm4bQZ7O2OVqK+OfGUHHXIqK001RcJQhMxpXnYl41haC4vQw9LB7+W
         KUTu+V00t8VHBqHT1ChX7dATfoxOJMQDFYHFh/N2hwCnoNaDbvR+0/UOr2W0u9dJ/+I0
         KssnBQc/MwlYpyIkWBa5H/mdyGgcdTDtW0Ufr8pTtHsZDVh/TnOTzXSktyAYnrSxEl9R
         gs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553919; x=1709158719;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XJqQ9AJQ+tf5XeyCQVo1hDFkBJCXmQFNo+r5XxF3fo=;
        b=wn2XS+9QUOeoRSsf5UuyGsv8Ftyd6R5MFRIf4Y37+lYkMOws68vMv6dOKL/Tll2i9o
         dD03kTfpt5WK9UAoo4ovOwgccjxjTPozpOMHrgrBDSKesSqjTTqKTF3IwpvYMh54Avdq
         dhPxh2rkeT0tK6O2KVSVs4Uayn13MmteG04MvAnQzN8yhWeSN9O9m8HBGKFD0aBX++/A
         SuvcR+1ioVcGTFATKzZPAtd2upA8y0fuVq0mUrgGC6gHGKrt7VIfm3QoYP1BNrgBFf98
         9RfNzpgSwuSQZrp0QRL6pn8vVQYzGuiuMr2Cm52G389DPeQqdo2pNYGCcVcEmDR33aGJ
         hcRA==
X-Gm-Message-State: AOJu0Yz40rU2BXk7bUkPDldtlPJvXPeRmrZIq0M4/k4z3/uoR5X7mKkK
	o/jL2Mmq4+Vbirk9oqsHGglY1ibARHYAsGvI3j+Yaw7lvGwyx7wPtUZYfW5rI3m7Ru22B5hOi+y
	QHKG2eHNfCeWkqxs6iGim6XObGwzgGYerq5/2fY/1R3CnfAhy9rNUuubkILy9DYiPQ4ia8cU9CI
	U3h4xOpt5mnylau9u+/MVCYGYr1QNyCixh0a+7CKv8AMorPvc=
X-Received: by 2002:a0c:aa1e:0:b0:68f:a76c:1e0c with SMTP id d30-20020a0caa1e000000b0068fa76c1e0cmr2654983qvb.48.1708553919666;
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl96xBm1+e5XT5cVkLvehu8k3NfR0o57H+Yf3YI1f3OjN2WS2Kg32tAMvfaelqzgddLkMfAw==
X-Received: by 2002:a0c:aa1e:0:b0:68f:a76c:1e0c with SMTP id d30-20020a0caa1e000000b0068fa76c1e0cmr2654964qvb.48.1708553919312;
        Wed, 21 Feb 2024 14:18:39 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:38 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 1/6] qmimodem: Use l_queue_remove_if to eliminate double lookup
Date: Wed, 21 Feb 2024 22:17:20 +0000
Message-Id: <20240221221725.185480-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 1R8kSIVYD2SBCNCieCaNTpJp7gzojGdj
X-Proofpoint-GUID: 1R8kSIVYD2SBCNCieCaNTpJp7gzojGdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=938 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210175

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
