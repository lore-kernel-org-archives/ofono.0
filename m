Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC11DDD6
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605649; cv=none; b=l65ei7NrDxme9ugmix4T2FVga4BL3U3sDD0fbRIc79v5rvv4/5c8A6vjOHjCJTse741GzPq85TE6h1AQpMRAWG94DpP4uGHIuCM1T4RXCOCBXIZvcMYDtny4ejilAjPf5UHRROWUUMghNCGR3ngAPh7cj9iUQgRDeXhGA5Zvt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605649; c=relaxed/simple;
	bh=wU0BYimMaCIHzBeZ9GWygFrEOsIcPkG6oRapIo202J0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tJNXFFkup175hlDU1d7ns45eLDBEHkMYTU3GSeeVYfpxIuXPpNjE6Z0oV5EqhnuC2k3hntxiurDhgFQ9z/k5V4jyf5TwJkqsZRo7q3PnjcgrGjjqlbsQMIWw5wiO4/C5eC5znzbiu1HYk6XXuFGNDQ5yRNraNTlb7MlzPFaHnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=DHCIp2mF; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=oPJOgIPD; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="DHCIp2mF";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="oPJOgIPD"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438ChsC9012402
	for <ofono@lists.linux.dev>; Mon, 8 Apr 2024 12:47:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=BO3y4Ivvb5Qdk+zY6KTnt0Dv3By0JnXfbnjg3/fsOdM=; b=D
	HCIp2mFbsxJSFK7eVFbY2kyOIyNCaQqCMrTdda7ce9ypgfsQ0H6NDrRoiks7mU3Q
	6qPk/q8sKeMhWMEaxkfKULdwyl1fQwIrCEbsGNCTu/oZ9/zOTSFsskq9gmStYj2n
	mBqutLvdGjb79YrBzUqdQjOCODzxe4sB3eUsnfEuj6oqXC4rto/irdzUfSoRZPsw
	AJvIWVdnj0qBtbjjn0xcZzi1QsZKtFH80PwUiFabG0DYfPY8Zo9eu/ISzmO3AnvB
	77WfivVNeMdRvqJjvF0cWA55WnNt/Ej0JOj2PQ3g6NT8kY/Eb3SuMRMkeaZJ1AEV
	ZQHY+w+yyelHVt2DBJX8w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xb2khse8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 12:47:21 -0700 (PDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d6005b2d0so249507685a.3
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712605639; x=1713210439; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BO3y4Ivvb5Qdk+zY6KTnt0Dv3By0JnXfbnjg3/fsOdM=;
        b=oPJOgIPDNuO65qgHBMXNY23C793Tr0FvoG/KRIuNouSFvSOQhMEwRr+SiYUdJyqBhr
         Ft7M8wgPsYVGhmiWuAHR/4tA6O63CjiT8WqTqA9QTyANdZxuXETqmV788T1Of6DcjhcR
         B6V1TJ4yJJx9kTv1hv1lhIxAhZ5vpnnRiz81OwjiRDyvb99o+x4s3XepAsldXJcYq9Q3
         sXOppD4ynv/voR6sUgs7HRMuijwg6UktDBeiMHYCGOFz4r8MZwA1JNisCGxkz+Xq57Hw
         fr3wpavbJIM0yid0LoXkumHXXVxHII9IZVNEfNQq1nYXQkBTPpjJRhn1Fy3yRc7+F5mM
         sgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605639; x=1713210439;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO3y4Ivvb5Qdk+zY6KTnt0Dv3By0JnXfbnjg3/fsOdM=;
        b=xQBH4hqxHdlYaHUw5BaVZVFj497xegBOXj0MYYkaGPE6PP29b+IXm+eHdPU8inMbTJ
         xmgX8X9H/Q2te5f871Zyz4c5+oRDK/1GCPRJ51diq0qm98Vb86vHTDDfNjVgFRHI4iX6
         IWr8W6J3kDqfoZIqV12VPHxniskGtz/KYqPLqiWXqDCiTD2ih4ckpsgMY1rCpYGdpOGn
         3gyHggKEP0kL/0Sl47Ptfjg1yvrVkXabOV8K3wP8MXPtp7eagHYWKj8b7kZSwlrnJ7R4
         cXoiLITd52vwxqLnNQ7C8uXkBqfotxwqzEIfi7RFuIfzgoXLzy3xEWbO0OmeEkmL9Iuw
         myxQ==
X-Gm-Message-State: AOJu0YxpOoFBPPAur0tEJPdITTlOHEdOO28bZqgChknTjeJltnoOw6U4
	gMY3P3fRdb1gNJbwD+IvAp0XDFOg55UTp7ZnNlX7YwQJ3ig2/s6Fic0SxGXGUb5IcHtVUme2yvp
	XAlyK0sjL+3w/a9Y0YhZNjVxyXlWjXFBQobPr3yRa6BSvNIyUaTlII6+ucBaUhBS9WAvYyred7d
	fTnhleDzyy5Ms3HFZGaH582ooO9CFDV4TOx9xzt0LuFf6RZl8=
X-Received: by 2002:a05:620a:5d91:b0:78d:5d87:348e with SMTP id xx17-20020a05620a5d9100b0078d5d87348emr6787697qkn.21.1712605639197;
        Mon, 08 Apr 2024 12:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwVRrjBMt/gFNJgKcQk9IFtQak+X8xDuo9Se7D4Y7ZAwNWIxp3xL51njm6CXF9ieXGQBdkYA==
X-Received: by 2002:a05:620a:5d91:b0:78d:5d87:348e with SMTP id xx17-20020a05620a5d9100b0078d5d87348emr6787682qkn.21.1712605638813;
        Mon, 08 Apr 2024 12:47:18 -0700 (PDT)
Received: from localhost.localdomain ([140.141.155.47])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a14ae00b0078d63e01fa5sm1513928qkj.54.2024.04.08.12.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 12:47:18 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmi unit: Ignore QRTR control packets
Date: Mon,  8 Apr 2024 19:46:05 +0000
Message-Id: <20240408194605.11666-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: SNNX2CiqhSHGweWaAmxkekwpf91n3W9x
X-Proofpoint-ORIG-GUID: SNNX2CiqhSHGweWaAmxkekwpf91n3W9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080152

Sometimes the test server will receive a QRTR_TYPE_DEL_CLIENT control
packet which is broadcast when the prior test client is destroyed. It
is entirely schdeduler-dependent as to whether this broadcast will
occur before or after the subsequent test's servers are created. If
the test server receives a control packet, then test_send_data will
fail. There is no need for the tests to be aware of any control
packets at this time so it should simply ignore them.

Fixes: 728db12daa68 ("qmi: Add unit test for QRTR qmi_service_send")
---
 unit/test-qmimodem-qmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 3c5418be2e60..d04f50041c51 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -269,6 +269,11 @@ static bool received_data(struct l_io *io, void *user_data)
 	addr_size = sizeof(addr);
 	bytes_read = recvfrom(l_io_get_fd(io), buf, sizeof(buf), 0,
 				(struct sockaddr *) &addr, &addr_size);
+
+	/* Ignore control messages */
+	if (addr.sq_port == QRTR_PORT_CTRL)
+		return true;
+
 	memcpy(&info->sender, &addr, sizeof(addr));
 
 	assert(!info->received); /* Only expect one message */
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
