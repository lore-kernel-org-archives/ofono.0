Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EA12880F
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553926; cv=none; b=LCfsjXxW7x+d+3lY6hsJykHjLHlOCAVv/7M++CB6DScDq0KXR11d/zTEcBXKQg4FJJTLCyz23S9Q8QrNT04VGqN/92VPU7OmfId0k3PhCeieWkC9znz0SgUsG9FT7NBCQnnBtBoRKAclT/G0hDcFOAqO1pw4aRTSQSfD8pQL40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553926; c=relaxed/simple;
	bh=eaNxKsskYzRAojtR6WaTxgx7bBipa3Q3nIGXaWh482c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrZdoIGn62vRDbtADsXuiiEfqRmE0ULugGy8E2L/BITHPXa93NfogPycQMiw41LwZxslUVvpWuDXeKcYYTP6UP8QQM1CtDhVtUyF3tNyBTP9CSnjlEFGBT8AamDJh0fq+j/ys1quX3HWsfOu/JQq0YmWsRiHsmN9VgAqXK2qFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=nTGJvu9v; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bo1Zn34M; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="nTGJvu9v";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bo1Zn34M"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LFBwOB031935
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=+jkFU4CPOL9gXqUUldK/2c
	sDbrDYut4XoKncxGKTOw8=; b=nTGJvu9vr17N6bDWG90gZcPGkwPHnK3Zqqm8Bx
	HG11fcTKvwdqXJ3dsFXbyk2vr4SnRd+s4PhZSTsxPej59vLJuFeMXXZDzFXlXqJj
	DSDwT66b0xEkTDYpuUYFNmJDNWDLPQr/R+65fxdAHax7karrA2qIZtqBDajV0FVX
	DBivWUDlB8g/tAIZskfS8s35or+WphM5I/D/vt59S+hpXjTuJSpIGJZCwV6tTa0C
	3uQCTVh8TS45f/3+5v/0PgHVaLgSEJ8ybyuYAaH6FnTPYVyG64vHcmCHyLgGDSL6
	alNaVoLbMtSFqkDN4tDrzlX7/syX+Nd/JgN2W//iRPmwf/+A==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wd56492hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:44 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c13e65b3c1so1374931b6e.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708553923; x=1709158723; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jkFU4CPOL9gXqUUldK/2csDbrDYut4XoKncxGKTOw8=;
        b=bo1Zn34MhfZvuclaC0h+i419coYK76KeqcNJj5SLAZ4FcXlRONEFEomFZbHut6XKtv
         3UtF1158/Nd1YGon0FK3woYADSuFtS94BByHgwMx1o4hC6lDHhdjRcsZSmoeqqQMJmuQ
         P42DVpto0qUd584YU4X/p6tQzlgehg+wmFLZNO21AEik/fB358YBO9EGjVjK6Z0n28us
         ktEJ9k3o4GosMjhDBlC8M28SXS+aL/xMLtIS4/vijcNLCilRR+AIW8ajnm/FxGGXDopk
         tu0ku8s2pwO9Mo2mllYumxJL5/QNLxuGVm37Vqt8lGyIwQxibkkGGlfuwGLIDNKtvde7
         xhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553923; x=1709158723;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jkFU4CPOL9gXqUUldK/2csDbrDYut4XoKncxGKTOw8=;
        b=aWE6aJ3FFWSpnuPHznSlNzjJmqVHQv7LuTJe43UECkTxPAK0JRWYCNk5NFebBktsF/
         31bF67/+DfMIa7NmU1QN5dcjdsQC64f5Bc2+75Q8CDEsg8F2U4H8cazwr/Vp7DmAhy5P
         JOkY1RL+sJHtmClp/k5uAx9QT/Q6A2hPdVvPaU+xsqwzTQSBMULeL0cH/DTmMmj12M+e
         p5j737ROLBT3YCkCizeyn6G/2Gdh0ZLQkCtKEbl3YpK957vpvYpEoGWqtZBJECwQP2gH
         yRsVkK8n3UwI3qcx+FW3D7Oi5bm4zKxz/hSyDGFsr5pT2sfCiHZ003bpSoMiKbdAHpDN
         oo5w==
X-Gm-Message-State: AOJu0Yy88b7QLYYLmCuYYiHghvE7FjAAZ00L/eTk6g5xc7B6XC4d9GeR
	RVBX5r9IQOVjSQgDmx7sJLejKvnS89CIJ8dJsjtXCGqmXdsXl7+O5mGfQADHWUKNoAW3dmdNrdZ
	2ZjyZ6PPuEGcZZyr5oQsN2e03RRsR5tH8EtPZ0SFTAxapSrE/1FBmZM1sfbb3BAu/jJ7CmY8HT/
	SqgSn8D68tJ8+ip3cAFkPlUZ5Ff/knvGzUmVbsAFM1b8Iqi90=
X-Received: by 2002:a05:6808:144c:b0:3c1:5bf8:a66a with SMTP id x12-20020a056808144c00b003c15bf8a66amr10914747oiv.47.1708553923472;
        Wed, 21 Feb 2024 14:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5zSSw2m9dOvIaEJlIPHMW8lbEXYVFhGPKzDXByt3VRZyWVA4e63q+NdZR0lT6bIMhyXhqjQ==
X-Received: by 2002:a05:6808:144c:b0:3c1:5bf8:a66a with SMTP id x12-20020a056808144c00b003c15bf8a66amr10914731oiv.47.1708553923033;
        Wed, 21 Feb 2024 14:18:43 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f719ed978sm3841446qvb.33.2024.02.21.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:18:42 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 6/6] qmimodem: Use l_free in qmi_free for consistency
Date: Wed, 21 Feb 2024 22:17:25 +0000
Message-Id: <20240221221725.185480-6-steve.schrock@getcruise.com>
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
X-Proofpoint-GUID: OOASp4fy6UZORApApXDU1r1QkX3XjW8n
X-Proofpoint-ORIG-GUID: OOASp4fy6UZORApApXDU1r1QkX3XjW8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=878 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210175

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
