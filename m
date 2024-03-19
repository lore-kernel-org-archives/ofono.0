Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC35915E
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864510; cv=none; b=bXajfHOfMe3XHi5v6RxDoSSPHUYR2oYn4Ijz0hGipM6xMZn7TyGV2dWVgx3B9rzHfF9RIbzAjNbZ9rtE0pPXvKVOIM7zdaugkFEgN2MeWdY2qDjVoQIXgv0nJ6/cH8iU0rBqHgT5lttApSv5hlGNF/oLQpUuxAHF/6jp45D26MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864510; c=relaxed/simple;
	bh=qRGr6bmVkl0QQtwTNWblBUByh979cSrsqEv6lSfxq+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hIF3se9OKCkvH4pzLo5Lr5he0tFjm0Kg5aEQPHBQVfj7iKcmBym/yA1Ce5tfurBPOEtHWOiXxWaMG+HZ8Ylrzd5suAlG7ZnGgjTkoLfVYFo3SwdszYGyJZytMMFOrxeNxyIBb736K2rgbVHlTW8+NvkQEcS848Bc6PcF/MkOBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=HushRiGQ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Yqp+hCeq; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="HushRiGQ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Yqp+hCeq"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JEeDV0021032
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 09:08:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=ibMiwnx2y8dBsLp0bwVMp/SFg/2oQ5Zsx8YN+kp14xs=; b=H
	ushRiGQ9F5Eltkw6bp6b1e5lOC65JWLNyz4fWx4bU1LE223K1hYisN0yXNCqcKx+
	5Ef2VWAQ8YA7xkOfTuprfoaXRgt0XTaALCbAq/9DfhC2Dc3bXZrXLwujhtQOeBrj
	EmEr+fVoADO7MGhlJOR9XMjfeqWEppjJcP9C2gEYRFzxiZIcNsk1Gz/d9yOhwDAr
	B6AtcPRhbmoHCo7AjTGeUpPh6zjZ15Me9/61UY8GveMEWE1WsgXdaUeGB9rMR3Xa
	F/McK9TY7eZ/qoZJVdOue0i8icQVbKa6hGEg+hbgWxcJVIClryrTSnsXpf6RlZ61
	MGvSabiQ7ubmYKuind08A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wwagda9y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 09:08:22 -0700 (PDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69181af8ceaso70927876d6.2
        for <ofono@lists.linux.dev>; Tue, 19 Mar 2024 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710864501; x=1711469301; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibMiwnx2y8dBsLp0bwVMp/SFg/2oQ5Zsx8YN+kp14xs=;
        b=Yqp+hCeqUiGa3DxCa08XywmT/7nb9qitocUAd0VJFobvsm8gMbYDC6ML9baNtnLl/s
         m+DXIFNFRlfgn5QPTZDEXzZ4/JdL4nruAWJcyxsiJEEIv2Pr5rIx0rq4Q7mc+PuKQOQh
         XMZ+uTsKWlfEorry+Ztcq2eF3LFse7SKZp44NHh/1IJlyxy1jQk7HJbj4dHIt9CW7XA0
         r8kj8OXpoGiD/YUpZKsnkqYp4aSEq8xKvcPBBTlZRAwxYtbpTD9jsIMmnBZfJ8qSoi8o
         VpxN7cN+FlldrkFS5H5OeFLOn4s3aEXEnWusYorrJ6pPW/Jv4eo0B/Y2uIIzAPVW11qc
         qoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864501; x=1711469301;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibMiwnx2y8dBsLp0bwVMp/SFg/2oQ5Zsx8YN+kp14xs=;
        b=iRSFY/CFm78E5XV7dPHIZ6b/TXWnscsKZ5dDJyyDGoHE1E/Phi0+tEJdWwidJAlWJe
         ayqNgjR+pzozZ1Nqmune69zigX+/g5LxPkAX4xu+hbosFwSEzs7nFQfgl0Z/0zBloRX6
         m/lVb8NpvvaV7yfrbdzdcflJYJYbAM1d5fSxTm1+EFbswZsEe21ADSqid3ygP1hmfxe5
         zYPEMnE/V8zDIxv00g0zKVM7gKvSCbROeevt365V4f3XlO/SFkK6oRZ0EKL3II2qbzrm
         bl8/YrZE9rEIrHYHaOUDp6VUfQkVB6uaKW1QGKeGIDStoTtnBokmN2MT6eFrPBfHa6iZ
         OmCA==
X-Gm-Message-State: AOJu0YyZ+mxF8qwCP4oWte5Ctc2EO0NuJxO5K9HKJDb+Ip7edD3Faxqx
	qMWae/1OK8Iqv4d5o1hpiRMtW+K1wjcplX8f/myNOB7nll1qTowTb31Anbx07UyPVjRI+AdxZfD
	8Z03+7UBON5PIunZ9+S2MZkcjj2Jzq5eASGfTLPBTtPsLeU13N8tcPK7ajXvcfQPePXVfJ6duE3
	dPlXh1gNWMocRIKxYXAr6ow0jLW4uGm9HcAuZaJHH582aZfXs=
X-Received: by 2002:a0c:d6c3:0:b0:691:176:faa2 with SMTP id l3-20020a0cd6c3000000b006910176faa2mr16594801qvi.38.1710864501581;
        Tue, 19 Mar 2024 09:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1NasgDF5dZ/Z6+OS5y4GEe72GKTISejT8PclForz+JiCX9kl3qln0n3zo6DjaAgPTZdHkpw==
X-Received: by 2002:a0c:d6c3:0:b0:691:176:faa2 with SMTP id l3-20020a0cd6c3000000b006910176faa2mr16594767qvi.38.1710864501025;
        Tue, 19 Mar 2024 09:08:21 -0700 (PDT)
Received: from localhost.localdomain ([140.177.175.154])
        by smtp.gmail.com with ESMTPSA id q13-20020ad4574d000000b00692bd4905c9sm3904130qvx.15.2024.03.19.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:08:20 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmi: Initialize group_id for control requests
Date: Tue, 19 Mar 2024 16:06:39 +0000
Message-Id: <20240319160639.42456-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: nbH72vBHBGyVYnHdeNYNc5l-QhvBCge6
X-Proofpoint-ORIG-GUID: nbH72vBHBGyVYnHdeNYNc5l-QhvBCge6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190123

valgrind found that for control requests, the group_id was not being
set. The requests are being allocated using l_malloc which does not
initialize memory to 0, unlike l_new. The impact is that cleanup of
the requests during service closure or modem shutdown might
incorrectly remove a control request from the queue. The fix is to
always initialize this field to 0.

Fixes: 0a4591e439ba ("qmi: Add an abstract group id to services and requests")
---
 drivers/qmimodem/qmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b92bcfa0368e..7f91b57d15be 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -238,6 +238,7 @@ static struct qmi_request *__request_alloc(uint32_t service_type,
 	msglen = hdrlen + QMI_MESSAGE_HDR_SIZE + length;
 	req = l_malloc(sizeof(struct qmi_request) + msglen);
 	req->tid = 0;
+	req->group_id = 0;
 	req->len = msglen;
 	req->client = client;
 
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
