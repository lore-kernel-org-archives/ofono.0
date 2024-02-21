Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4B127B40
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550613; cv=none; b=p15OZxipXR7ldddAc1Yg7udDw7r4jlZfRS/apfMXla90bcqOr7HmdXTekhL81PAPBNbJwHjPLXp+XCjup1bv+PFKtioeFdjXdNx/ALOx5uZ7IzWspD3RL3/s3n2UERpzuf/xWPG4WnGRHyIsenEx/+SGkpbZlelrPua/hgTrumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550613; c=relaxed/simple;
	bh=eaNxKsskYzRAojtR6WaTxgx7bBipa3Q3nIGXaWh482c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuK77PfhK05KNRr5c6r5PS3Et1ikruQfVoGHLhg3yM/hoeemudsKBmLFP7wTfqewMk9nmhV2eVADGjGlgc9MXLzHiH5IaEXPFN2LNM5cinKjjlF6MazJYCtcB9BbquDrmSvRtXvyBVN6MI/lur4yAD1AIAieRYh6sEJ8fue3j+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=FDRwM+iQ; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lvSaDek/; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="FDRwM+iQ";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lvSaDek/"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDLfqg008503
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=+jkFU4CPOL9gXqUUldK/2c
	sDbrDYut4XoKncxGKTOw8=; b=FDRwM+iQC5y+1LAL9Bl1lDiHq+/oVcEEynvyyV
	5bT6gL/sSdd04kYdEPtUx2ghZ6e7xX6ccTwiKyXLW3bffM2YwmTsDO1MYCN4ffCb
	Im7tsftLWsfRFGuxxn5yqWX+3irVbf1wq0DLows8KfZZ427d/+5852iVXuEQ0cpt
	InWPhy6BByUDVbke0HjnTK0ewZSJ6zhGF+DZWhsBVStFtYUYpOsNPtDtfdnGJ5eb
	O3oX6n2M7vJsYXC+aFhfxrwzBLHm8Xl/wAKBi+kuP0i0aZ5+y1nhTova70jgQ7Fv
	wCs8GpzZOYwh0rq+PNSYWlNDDV/qxmGaMsoYe5z2mEMOt+5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd565h0d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:31 -0800 (PST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78794e4b140so35244985a.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 13:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708550609; x=1709155409; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jkFU4CPOL9gXqUUldK/2csDbrDYut4XoKncxGKTOw8=;
        b=lvSaDek/zAHNj1bDiVgFW+cdMJC2dhmGxvW83HSg68XioAimyFwz2MhD88GCaT9ZcT
         ExwgTXtpNa3KcUBZrT/us7JVpWm1kk++JilKJafPoafSVpatEN0G35LegPitQnaZyyF9
         6gDGy2oayxpT/tz5iZ/bTzC6cYpG3AaHDB9KFH/CP6b4tdyUV2Bf5HzQWTau1Nmm2uq/
         rUaRr6Rdnl2G4RZUmKLc3VutWxXhGppt2VhaPVNQhsPtEovJX9Qs4PyhnvcImG4CGTQi
         rYBC93rLCTa6cuG4nrlC1eEj6aZcfLMBnNViewZIOLnAIzvxyx7Nhne9++mof96bXBRi
         tryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550609; x=1709155409;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jkFU4CPOL9gXqUUldK/2csDbrDYut4XoKncxGKTOw8=;
        b=LdrS8WVihxOgD1Xoi2zpM80EqRGtJBaVuTra3Ghht4fNRY/DUMtQXbd8xSQryVVEKB
         Bc1Au8N9n2ZvtSWwOGBfOQQhEY2+NUdOeePgcaS4Jp/et7/YWv/uqAq+kAPtWKZO94vY
         tseiW3VmuMefx9UpXQGWvY06aIjiI4+3o+MuWVU/fFKbWTpg/AXe7rYu5yuvndyy25kD
         OxFYa6wXBPLamn47Zy9jwzpbbGXYJy4Sh0G0hcUrRkJBTI8zW46HuEbVM7aaXqFm3eY5
         sd8HtF9Gbu2EuYdiz1nDstkQoGCSKWC0k1QEPvAWN6++oBzWUWwY9Yx/vv/Qpa8BpGcj
         7p3w==
X-Gm-Message-State: AOJu0Yx30CkLCRk6ekFZXYsEsTVisSzmO5GYqoJRtjNlBqIeKTr3jzA3
	uKditSuYU4HqaqxDE09QLKG2a7Pwg+iTI06SULxDcFkc5yzIjYZ34NxWVDadozhRkO0DeyiDv86
	4guRRDXooTK+JXmAsxcOmVuIbMwcjHIgPEQgVuNyL/5lzuq9lWE+Ub17LZ25qc3yeNILqZISjc2
	0NH5YU+Rc0exLgq+Gwoz2k+/5xU1vv8WPVjUtKc3rCe42j+xc=
X-Received: by 2002:a05:620a:2450:b0:787:25ca:dddb with SMTP id h16-20020a05620a245000b0078725cadddbmr24001410qkn.2.1708550609694;
        Wed, 21 Feb 2024 13:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6wDWZvTNj1hk1GEqqRTr9ixdbhP3AH8HZgwrOjW0y6XHOaiGDz5uwroyVxuLn8gzuBYmlSQ==
X-Received: by 2002:a05:620a:2450:b0:787:25ca:dddb with SMTP id h16-20020a05620a245000b0078725cadddbmr24001394qkn.2.1708550609315;
        Wed, 21 Feb 2024 13:23:29 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a05620a122e00b007874e3ae338sm4486186qkj.21.2024.02.21.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:28 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 7/7] qmimodem: Use l_free in qmi_free for consistency
Date: Wed, 21 Feb 2024 21:22:12 +0000
Message-Id: <20240221212212.181401-7-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221212212.181401-1-steve.schrock@getcruise.com>
References: <20240221212212.181401-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 0UHFTh6MzQU-dMxa0HwDVN6iUqRzGNni
X-Proofpoint-ORIG-GUID: 0UHFTh6MzQU-dMxa0HwDVN6iUqRzGNni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=878 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210166

Eliminate the final gchar* as well.
---
 drivers/qmimodem/qmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ba6ae0d2..52a8e57c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -174,7 +174,7 @@ struct qmi_tlv_hdr {
 
 void qmi_free(void *ptr)
 {
-	free(ptr);
+	l_free(ptr);
 }
 
 static struct qmi_request *__request_alloc(uint8_t service,
@@ -1424,7 +1424,7 @@ static char *get_device_interface(struct qmi_device *device)
 	file_name = basename(file_path);
 
 	for (i = 0; i < L_ARRAY_SIZE(driver_names) && !interface; i++) {
-		gchar *sysfs_path;
+		char *sysfs_path;
 
 		sysfs_path = l_strdup_printf("/sys/class/%s/%s/device/net/",
 						driver_names[i], file_name);
@@ -1813,7 +1813,7 @@ char *qmi_result_get_string(struct qmi_result *result, uint8_t type)
 	if (!ptr)
 		return NULL;
 
-	return strndup(ptr, len);
+	return l_strndup(ptr, len);
 }
 
 bool qmi_result_get_uint8(struct qmi_result *result, uint8_t type,
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
