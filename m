Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664712B75
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709004518; cv=none; b=PpHFVdeCEUNmDrq1KReIHy+1ScAXnYwWR87jtnD9bMvfIeChQdxPJZiOcznNKxeOAVZ+2vtorZPVtQFmjubgokVcqfh7KVHsRjsePRm1Jh2oM09BaUOAKzTAIgIBIgb5FQ1HSaHael3BhIlkMZnatJZr7YQ1GdmtfLzI04H3f+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709004518; c=relaxed/simple;
	bh=NPIJ6inwccXRnNfJveFBmW8gOEjzaDkaZANBNEv2Exg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iH1u4feXeUOjp+nd5KY39G4P5mlwJfus3ly7eWXddSSudxUjKWbInX1r/C35Sws5u6G9SKYkG0D8FeYA5vmU9Z3goyAlm6LVk/ty1SEfhthdxjql/5Mcx6tmElCHG3gYCc88/BZKsfKA77NqLeho5bEr2WcKcVprQT6N3JNvfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=GvkfyWI1; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=W0vW935i; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="GvkfyWI1";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="W0vW935i"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QDv2Bi028765
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=1+cCKct/S9PUy9ZdYIKBI7Q3M2AbbjDaBNc7MkiFF7o=; b=G
	vkfyWI1x5acIGJEBU0422k6Z3f464zDUn9ZMMYC4MnsylE19m2HXrrm8aOItXElH
	SaClcNXOYjy2Jfm7IlUthJY/Niu43Cuj+BUdaRhlCU4ksRK26gPXXUnJJJcdCF+Y
	SgqZ9+jJos2lklBiBzpjyDrLnyvdLGLvmbyDYZ/hFh4MUKr1kn6twnmXtqhDt8v6
	bIQVQmOGqLDkfX1moEkz839Z3zrlaHSKAQqUDrl4DCFd8xLtpx2H38BMXJqhVB9J
	YTTH6MNyBrOaoBKOdBOqJuwS1lqT29B0+GqU3BpN7K+vLI/CArD6XHUdm5mK3ONg
	qGukY63K3iuum9z477t9Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wfdr89wy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:28:29 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c1a496d3d1so1503954b6e.1
        for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709004508; x=1709609308; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+cCKct/S9PUy9ZdYIKBI7Q3M2AbbjDaBNc7MkiFF7o=;
        b=W0vW935i1ZnOrvVqStNkfT74/DljNWHhC/dXtIKcD+PhSyzvcULc4nIx89cyWe8ohk
         COXI5T1AV3ko2bkolUuWROt6ovYUXpqUcu0vk/IOYSiuLaUebhMIS0p2pEysYIWQnfdg
         DnRkivFTMXL4v0LM6F6ObELDCZsgss1pNfK+gbziB8+X8c3HiIs15TB2uOAGe9P81IeD
         HHCe92H20LvnZKmAWGCNWkrjRBiLXddSiY82cCNufc1Hy6RSYGIPCwGATxWiNY7ez5y0
         yeFRIRH/3hZp+j9RtWTQxpAUvdvecOuhaFocfZUd3f1vVnngM9ab9WH+Yx4VygDnMkfM
         AgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709004508; x=1709609308;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+cCKct/S9PUy9ZdYIKBI7Q3M2AbbjDaBNc7MkiFF7o=;
        b=kEkCQ4FzsCCGVwgbX578IT/aiPDNoP2SSTeaJtcMz9QPF4YBPAusluwd5NT0QeJmxP
         vuNHRvlWahWqQOWqjqvXgaPvbKF0B+zS9e/Avnpv4PU3zMa+ho/2kA7a3kY+t7C/RpCP
         1duJ54sg3w49TeXIX896suKzgJ+fq3qhWXmCh+aaIaPzE6DTRl4GQ11nQ1HkJgd0xZn6
         fXat+TPfNOsoIpNmsRM6c8NKkYbRJyeyIAxrpcfifhE9O8dHGffFK7zjXMEBna+3yzrG
         whCgEk7kbQ8eHmMxTl5FzUEZT4K3WbQFT8C6wRdB8btRcRgzmmMxwLr3tDhxFY4E+IdM
         NCCQ==
X-Gm-Message-State: AOJu0Yyt0FIQohunbpwzCURbfcGrruJqQy6bqJZa6yqRPg31/QlgRFD2
	dZbTxVbnBpRPtezTJpU9eOhuAtRdTELhiCBgXd6AP7rxpPX0Zqim4KS3UXk1Oelo7BtYjyeVHTd
	OyLOTos6yFdmR8RptC/pSiZhzzX9VpCMQUzy0p0xDvGIEjevzDwslbQm8Abf874autfe8ldkqu6
	2ZuG+oZqm/zZHoJbCHDJMmbrnJp4OdOv/Fy3CMmdrVXxB810U=
X-Received: by 2002:a05:6808:1507:b0:3c1:aa84:6c21 with SMTP id u7-20020a056808150700b003c1aa846c21mr1214350oiw.36.1709004508451;
        Mon, 26 Feb 2024 19:28:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4MD8cyj/vw7fUrwrjufK+QgOFWjeCt5TzzFdfHL2iFlsn5FHUuCL4b8JtKJrFDk5lb6jqbg==
X-Received: by 2002:a05:6808:1507:b0:3c1:aa84:6c21 with SMTP id u7-20020a056808150700b003c1aa846c21mr1214336oiw.36.1709004508142;
        Mon, 26 Feb 2024 19:28:28 -0800 (PST)
Received: from localhost.localdomain ([140.177.178.112])
        by smtp.gmail.com with ESMTPSA id p8-20020a05620a22e800b00787ada1ebafsm3197089qki.21.2024.02.26.19.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:28:27 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmi: Make sure to set transaction id as LE16
Date: Tue, 27 Feb 2024 03:25:52 +0000
Message-Id: <20240227032552.123044-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 3fT9MGgZnzXXYWRkt_-YcQfEuUMHOebB
X-Proofpoint-ORIG-GUID: 3fT9MGgZnzXXYWRkt_-YcQfEuUMHOebB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270027

From: Denis Kenzior <denkenz@gmail.com>

Transaction identifier for QMI service messages was always read in as
LE16 value, however when allocating a request it was set in host byte
order.  Fix that.
---
 drivers/qmimodem/qmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2371f178..35751d7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -670,13 +670,13 @@ static uint16_t __request_submit(struct qmi_device *device,
 	struct qmi_service_hdr *hdr =
 		(struct qmi_service_hdr *) &req->data[QMI_MUX_HDR_SIZE];
 
-	hdr->type = 0x00;
-	hdr->transaction = device->next_service_tid++;
+	req->tid = device->next_service_tid++;
 
 	if (device->next_service_tid < 256)
 		device->next_service_tid = 256;
 
-	req->tid = hdr->transaction;
+	hdr->type = 0x00;
+	hdr->transaction = L_CPU_TO_LE16(req->tid);
 
 	l_queue_push_tail(device->req_queue, req);
 	wakeup_writer(device);
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
