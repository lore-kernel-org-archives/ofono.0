Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823201350EC
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545179; cv=none; b=oIYba81UjybSo/+QiwwbrpGO39OZr4il5B6Tm01FnDsKruynjUUFbzMC91ae2nIZ1/sNVApTsd/+v2vpibeNCvXrByHi2n7YFpD+gGy6VGURghQel/v4PfO0W2CYdZ/tX/wTl2F6B4Z+1IWSTD9f1NmI5wNDjMzF1GCi9iL1NM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545179; c=relaxed/simple;
	bh=wlVkHWGLEtxqZzBPmqg44lC5wAPkE0Tt7i/3XZ6Jb7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uJ7KvNq/mR86y+anGIokSn7fbYVQ8dMWfslAoDSazHqvJKlEGk8lIokx+Yyj/urUeehvu0b4QOg0r+jZF8+4e6Oi4g40Wj3vK8McQ7TcLv235oxcxNa3mr9QpL6BGi/Wnn1LHtAftW3QV4LVO7f4LCmSz36ACOs9IBz3d3G6VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ji8Zdcbg; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=jtwWBuTS; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ji8Zdcbg";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="jtwWBuTS"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JDTFiI025477
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=4opvaRce2wLYJ2GoG9XQDF4S4f8hRIBeW9vC5rJABCo=; b=j
	i8ZdcbgOSnH+qCvCUybMcBA6AD8qpWtErCM1YtqBVcaCTG1L4T/6BSTiAHdA1ZMA
	XN1FPpBUWy5q70LK7u8Lg/OXIHbO0GxdfjrOwLO5DV/lRD74PO1ZBw/782XWTwFf
	q0ypRuzGmV5JQO9MEbR+j7akV7BPNhe3dsQuacJzuoPkeNA0FCnjjYf2D//9THSd
	CGguS3VXB2DAJGetSf8Laz1zwOjHki8AeW5nthIUjsTXTSl0Ee3vGWDXXsbUjs7G
	DF9uVQ0xpLtoAmEpnLtGajYEOWQBrN9tfjdN9GiZi2l413joG9mP2SlZL5Wf8456
	BVTngjZ+66bz3ECDRCPnA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xhyq9twn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:15 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb7f9e9482so2893049a34.1
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545174; x=1714149974; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4opvaRce2wLYJ2GoG9XQDF4S4f8hRIBeW9vC5rJABCo=;
        b=jtwWBuTS80rXPvgttr7Xei7Xw6A7uP9ZOoRBdXNgAFUFIHZKJ9Cq6lLXxOvdbUtiSE
         lVpycDdxmj805Z/mFEBcBVtBLdLpdWb5OfEE/MCU/w9OW812babuzFBUXHF6FLjGDgJ8
         nspEmFuNpq1ZiHiUONJMDEadWeeTRstAzpIkdrXxcUeZ+WN+Zd0Q5YSc18m9XaH1dEkm
         RrhotCacjDzP0rFHKiFyTFFXvfcbM5p0J230t9+wD0M1t92v7JK06QFIVnuaeT0pLVBe
         1N8SDmo6ehlvWikR6WKYbroVUgDTMBIV2Wuktn49PHWmioUPFpU/oXKg+Vf7irihD//0
         PNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545174; x=1714149974;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4opvaRce2wLYJ2GoG9XQDF4S4f8hRIBeW9vC5rJABCo=;
        b=pFSfUvStI8GRctwrDVuZiaThTpDp6l/9cFjKhz9/tcpjWMROmXjP1w0tOJmy1otUsJ
         g7YyvgyvJFERCpyQhtz9WdDSMyEX8uOPcxp0QY81NJ26NXRq1IoNCs9hPthO7BBrVGED
         W/2v+7dldG3TOnFEY05fquV0+3BC5SSCC2mL8LU4dkcf7oqhPlDIykvtTKbkQ3DvHMTH
         rLLHhoY9lEsP8cBaWBv8XpJxU9P2QzUwPZXE+qo1T2cpOPWycQBONCM8hwQGEgOELpGO
         oEXTEzugMtZHW7FPvwNK8jbs7Dx2l0trEpFi/z+a3WvL1/kufV+lylv4p+4JzgA5MRyn
         KGhQ==
X-Gm-Message-State: AOJu0Yyovq5g3v7n9F28w0Q5aVXzjnuMUl4wXLva6Dupq/Ve3/zKqfdV
	GO5p4E9dCeiHYG115G6t832m+uPUwrskzJcArEKzWYWg2f/QGAomiI2Tin6LeV/452hbvXSwTDA
	I0Xs5pmGg8VTNiPkj8EjSdvwy9kgm7pRmN63P/0HSUk7ihtAiIWYYP/4MJiJRaYEiZdew1IBIJH
	CrP4QkMnDvtQTCCzPuMb5XpNx3qTiA6nVbwdniLWkb4zx5WRE=
X-Received: by 2002:a05:6808:6297:b0:3c7:4876:b527 with SMTP id du23-20020a056808629700b003c74876b527mr2611669oib.45.1713545174770;
        Fri, 19 Apr 2024 09:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDXC5ZSCEDnI2ba+0ecDWFWcZdRyKrDXOzR43w4+MnNtpUonxnLTzAX7J64gOOUFLrRVcNGA==
X-Received: by 2002:a05:6808:6297:b0:3c7:4876:b527 with SMTP id du23-20020a056808629700b003c74876b527mr2611650oib.45.1713545174472;
        Fri, 19 Apr 2024 09:46:14 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:14 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/8] qmi unit: Link to dl
Date: Fri, 19 Apr 2024 16:44:51 +0000
Message-Id: <20240419164458.36078-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: vRncCoFJC7FeIAGOVwQwSw2cP-3GwvjX
X-Proofpoint-ORIG-GUID: vRncCoFJC7FeIAGOVwQwSw2cP-3GwvjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404190127

One of my VMs was getting a linker error when building
test-qmimodem-qmi in maintainer mode:
undefined reference to `dladdr'

Add -ldl to fix this.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 9a6f82c39552..a4880036eaf5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -932,7 +932,7 @@ unit_objects += $(unit_test_mbim_OBJECTS)
 unit_test_qmimodem_qmi_SOURCES = unit/test-qmimodem-qmi.c src/common.c \
 			src/util.c src/log.c \
 			drivers/qmimodem/qmi.c
-unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd)
+unit_test_qmimodem_qmi_LDADD = @GLIB_LIBS@ $(ell_ldadd) -ldl
 unit_objects += $(unit_test_qmimodem_qmi_OBJECTS)
 
 unit/test-provision.db: unit/test-provision.json
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
