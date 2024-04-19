Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7F1350EC
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545182; cv=none; b=tZGfF3RjlQxOEejvPLy/GqLk1ftmvM8/yWY1Gntnp5bvLrftoUTXDHUrE4AZlbAgpHTJyjtEMMgKp3IQVV8JkvXI+R5rmoWVwVVjIeiARx6R0HJOQKYsbRqOGbcU+Sgy4EbshB3Y29W4ayDNG/avNi6/K+ns7NU+ncs9+4/CWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545182; c=relaxed/simple;
	bh=76YmmnsCUQiQWksFWddTRNyjM2s2Ve1a9NpcAvRe3UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/Kpj7Tqr+wNyA2MkZ7sQ1QbEr6OloiWnDhpg1l5cFD18tuunYi2rf3lBVqOSI5U3Qk8YEMPVi0nNMoXwPlmYTpRyQy0YZdnCV0Rb4f1vknkanUFkQvgr9+SGeP/w/XsjHCwUSIMNb+UBDCgHnXxjpPGofcfK/ktzqSXc2GEBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=KHGFtzqt; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=NDa9OfSA; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="KHGFtzqt";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="NDa9OfSA"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDroco009445
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=bICY7zvH1uo1MuqT8Dj3zN
	LD46bL+0GDxMy++ORIzWE=; b=KHGFtzqtdquZAQ1+mmz7Vca1vbMIVr2TDnzZ/J
	emzLROLuj1bbl+Rh+0arIu0k38b+hvEGAz7FNuqmj6vZ8GVOjAdtqv+ZOuoZDVvV
	J8pdsmjINQZemnJ7Jkzo5PF4zdTyZl17mYzrtl5OEx5jd+4y6KZ77YT5Q0l+GcoX
	0C5SR1G0RWGytA7w4A8gtbVN2z669qzHLOzoYyuH/mYYotBl2cqSX/+3Iv8yX2Fb
	QKsuvMWsKhpbYvbeL5BFh6Ykg/PRQS/0kM3sDunqPQT1UuODe+PNB1bn19KV5a+2
	CFiAFBqGXNltBIArnBc+kB1mDiBBVSk/kR1xO9WxWLZI1HeA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xhyq9twn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700 (PDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4377949a027so42224961cf.0
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545179; x=1714149979; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bICY7zvH1uo1MuqT8Dj3zNLD46bL+0GDxMy++ORIzWE=;
        b=NDa9OfSABSr0Wt4HWA2MXsKYrUyMrabjLcCVtv304KIxRWq2mvfHbbBsWXBZJ/Oyy5
         XWUXBYcPSeSc8WateaBjiM+x4t/MtdkxoG8U0mJejedMqiFuU1fNYoviTRhpscIb8xqG
         NJ4C3odaqm/g3avXaU2mQm2imP7+smd59cUGrD3HPgJMGHb0YH/fakT0yFjJC01HpI/3
         JHCzT8PpSVRH9wgZm/TA7V/JJ6yZa4K4oI0hg+Lz0Seb33eiviYaYBt/byJHJy7rMyrO
         Ju0b0DzRtG+Ea9by2hy/vjy5ce9s4C5G8IlL+CQdKdw66bFzXgU33kUPubWyjoSFTPW5
         isQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545179; x=1714149979;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bICY7zvH1uo1MuqT8Dj3zNLD46bL+0GDxMy++ORIzWE=;
        b=tX5OxB8lqmvMz2eFw/twS4ANA7pb0IapHj3xYsO+10dntWekmUtAY+oSIayGeltfFB
         4oj1hgNrHxJAEurik88mZdhtkiTYXTiz4coKZHwZK5+opSLpYmXqx65EvfKm5WoScY7q
         MB0v5X5tGqn1nCjdLs0KqaFruS3QfrBIyhWb/ICwSQ5tuSBxWC+mwB9rCQs89CNc737X
         /+kqtcEGJ6wvXrHNrtA2uMpDcbTxzAgnMBU+5R7UjWPQD2Hditk8b8HkWKN5d3aCPbya
         k/szaZBeQf47Lgn1UbbGHE//GR8yuIQc6fc9DRldhUauZTGQoT1tbAMOVJ2D3jY+dT/w
         kMMA==
X-Gm-Message-State: AOJu0YyJRz/8PWH5+ZEBwZP6EcJ65sAQwfKdw9MC6BQNtX8xnnxlV/yX
	F9BY54Q5PztKgPCKwxpVIImyfVqvS6Gz/Pq81cMT+LwNqzyAoKkmHd9Ap3sPkpZAAGI1PqAeCSY
	R8FSPgdujOw9UPsm586xAmkmJKV5uuqDw2UPeVvAoQFw+xkIdxKKgtgkXVv6dZXo6qBbvV8MK/6
	pTV4Yk7fl6Ws/77wPMzxUwSgmYnQ4o2TTSNnTEhOXOtNO4TB4=
X-Received: by 2002:ac8:7d05:0:b0:436:5a64:5a48 with SMTP id g5-20020ac87d05000000b004365a645a48mr5008398qtb.1.1713545179072;
        Fri, 19 Apr 2024 09:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWmStAgR1Q33q7ZfifwSz2/ojZIqxonHlHBHIjr9f/I1r2wAiFeHU3oXj8ui2L6nJaN1mZvA==
X-Received: by 2002:ac8:7d05:0:b0:436:5a64:5a48 with SMTP id g5-20020ac87d05000000b004365a645a48mr5008367qtb.1.1713545178704;
        Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 6/8] qmi unit: Validate creation of services of the same type
Date: Fri, 19 Apr 2024 16:44:56 +0000
Message-Id: <20240419164458.36078-6-steve.schrock@getcruise.com>
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
X-Proofpoint-GUID: u0pFUBwXIFsDOC0hzTnWhW-92QHak8Dp
X-Proofpoint-ORIG-GUID: u0pFUBwXIFsDOC0hzTnWhW-92QHak8Dp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=970 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404190127

Confirm that there are no problems when clients create services for
the same qmi type.
---
 unit/test-qmimodem-qmi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 0e15f898f845..8df8b56a79eb 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -221,8 +221,9 @@ static void perform_all_pending_work(void)
 static void test_create_services(const void *data)
 {
 	struct test_info *info = test_setup();
+	struct qmi_service *services[3];
 	uint32_t service_type;
-	int i;
+	size_t i;
 
 	perform_discovery(info);
 
@@ -256,6 +257,22 @@ static void test_create_services(const void *data)
 	perform_all_pending_work();
 	assert(l_queue_isempty(info->services));
 
+	/* Confirm that multiple services may be created for the same type */
+	service_type = unique_service_type(0);
+
+	for (i = 0; i < L_ARRAY_SIZE(services); i++) {
+		assert(qmi_service_create(info->device, service_type,
+						create_service_cb, info, NULL));
+		perform_all_pending_work();
+
+		assert(l_queue_length(info->services) == 1);
+		services[i] = l_queue_pop_head(info->services);
+		assert(services[i]);
+	}
+
+	for (i = 0; i < L_ARRAY_SIZE(services); i++)
+		qmi_service_unref(services[i]);
+
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
