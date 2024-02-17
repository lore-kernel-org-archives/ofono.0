Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0072D2FA
	for <ofono@lists.linux.dev>; Sat, 17 Feb 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129935; cv=none; b=t0+Yr/SxGbHoBM/4ogxmJmavNBHa/O3smBnN1ykQ1/YZyc01pFhuAOOBp2OA35GnwKONicOWiktYV9uUSlQ0iMRVyrPch/YeL8Gvs0SEM5mNvnbCqS97y3u1sDUhVWjQF2cPbArwIt53g9V8JRO1sadebuNwLovdbSSmPdAQah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129935; c=relaxed/simple;
	bh=mulejdpJzC35GRiNBHhdoqWd+iidSB0nPA40zPn97tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xgmf6w4UgKWD4TNlABfuKycHqeBUYNczf7tf4GKe3trvA+LCbjQkbOZMUgIDTEkoAxWAGQ7a5ubrlbgCFX+BAa9u3R1sdlPmGP0n163upAPM6g8KB45mEUKY79Ulqg+CZdWmWKgST/fAVVuLXZgEB8EqFPn0IqOJRBYtagy0TjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=LGHkLeDj; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=IgeKgMNT; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="LGHkLeDj";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="IgeKgMNT"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GFkm2l006691
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=sP//DawenCm9Q9Idqm9VLY
	53yi34Bi5tG/3ybyVmS0Y=; b=LGHkLeDjRg9Xtvj6Kj25Ruu7nN5OILlWRBbZ9J
	L6Hh9rPcRkldBeYiR1G4/aYUmxDMtMJHpQQhM9C6mh47vMVYLSUzxKbr7O25XSBp
	KihjxpiyzacMei0G1hsZBVBqKh/R5ZPJtMKNE7qag01xp8X195hS5rxr8WaiBSwk
	macxd6c9ZsDtez756BtxCoDtty+nbShKeII0oAK5pCYvjcgUXB516jxD6gETuP2C
	Ae873KDDR4UBr+ygaQlIxwPFz8DDrKPyEJVx0yJm8Dz1BsOh5mBZWSg72bww31CC
	jrTGP5Mx6p2bHhKbpFivmaA33dBGbG/vA462iGAdSIb5+vhQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3w715mwmsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:10 -0800 (PST)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-608080f8e2eso11475017b3.0
        for <ofono@lists.linux.dev>; Fri, 16 Feb 2024 16:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708129929; x=1708734729; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sP//DawenCm9Q9Idqm9VLY53yi34Bi5tG/3ybyVmS0Y=;
        b=IgeKgMNTtyntzg1hiepGL0N9kS0KfV/o3ofDb1STaG3EYnUdXdlfMwK2ci6UwGSfRD
         6WoKSxnKWXy6OWEfR62M1+hGIekrsUZ6//oxOj/MDbPR0b93EkkHXca4dnuFFZ8Rzf7Y
         V5utn/ywTgZivslZxvtGvXppCcBZhJmHE/UQS4Rlo56h4q3lA7lJQ7JpY7+Cchz2EdZQ
         FQMqqfDjv3PmOTLOczi0RAhCwLrZNYvI1p7Tkp03k7EjR3NCkY+55ScCT7HAzH4KX8cf
         j81pUqIDkDjUxAj4X5w3Nq2PBMUtqNu5vHlmZMQ6sctjNTHHs8gjk2YUTIhAIVqrqPjo
         fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708129929; x=1708734729;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sP//DawenCm9Q9Idqm9VLY53yi34Bi5tG/3ybyVmS0Y=;
        b=k/yz3RqK7pn6+xUVmNgNB/Ss3PP3EZLKM3BEzWAwnKKh4ForRmMT4fAMj4bk62Eh99
         gsnbesAULSRbdF1YK2A1hR3z6SGpxuKT/mvLpBPS+Z3ddP6WEZXcFsjc/TWTa+gT02pR
         S6nlQ87RzNs53zDOsYrqWcOt3lmqkc0ku9344aKwPHBhaDvooSUwcnTDHe6U+JTA8Z4N
         zFXF44Rju8oa0vvCo55bLPZBAtl6SASXub7mIMDA0IPDKyOUMIopNO1+wgf/VeD3GDxp
         GpIaJyvaOqun6utvAkrQQJLXH8q3iKw906zrFMCkqL+0BnC/uM+Dbdvxo8kroSvFhKQi
         EmQQ==
X-Gm-Message-State: AOJu0Yz78gtbXc+6sB2ur4yoYPK6JHz+ZmBZsQIDLCDZ1twlq+GEsmQL
	MvCBNw17H62s6tDLAGbC+27mx17I9b4F17LUN+L7Yxc26i8oDK5zAOuMMHbk+wgx2QDlRcngORf
	u1VcteaZe2H3tY7rmMIcVPymQEeaBEVXk85L3VxAKsrbA6T6sOaAzNFBBb7AG0DGkIc/9cf6xGB
	iyV/swOmUg+qP3iaMIfTYr83tsWNbc7zLJPsftkPepme6eKWY=
X-Received: by 2002:a25:d80a:0:b0:dca:c369:face with SMTP id p10-20020a25d80a000000b00dcac369facemr6601224ybg.18.1708129929633;
        Fri, 16 Feb 2024 16:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMg2wj1oeDtcdR6uptm8MjJc+/a6hr0GJPkejp8joUet+ZnNYO/dm6gJQGAb+11+08rdKo7w==
X-Received: by 2002:a25:d80a:0:b0:dca:c369:face with SMTP id p10-20020a25d80a000000b00dcac369facemr6601211ybg.18.1708129929277;
        Fri, 16 Feb 2024 16:32:09 -0800 (PST)
Received: from localhost.localdomain ([140.177.143.152])
        by smtp.gmail.com with ESMTPSA id e3-20020a05620a12c300b0078606e85a8esm400312qkl.107.2024.02.16.16.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:32:09 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/2] qmimodem: Fix checkpatch.pl warnings and errors
Date: Sat, 17 Feb 2024 00:30:32 +0000
Message-Id: <20240217003032.76366-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240217003032.76366-1-steve.schrock@getcruise.com>
References: <20240217003032.76366-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: 013WRQ5jOJ0hj7isbeX-dwTlrZ0NZVQQ
X-Proofpoint-ORIG-GUID: 013WRQ5jOJ0hj7isbeX-dwTlrZ0NZVQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_24,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170001

---
 drivers/qmimodem/qmi.c |  7 ++++---
 drivers/qmimodem/qmi.h | 12 ++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3c8c00a6..c9c80975 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -299,6 +299,7 @@ static void __hexdump(const char dir, const unsigned char *buf, size_t len,
 
 	if (i % 16 > 0) {
 		size_t j;
+
 		for (j = (i % 16); j < 16; j++) {
 			str[(j * 3) + 1] = ' ';
 			str[(j * 3) + 2] = ' ';
@@ -720,6 +721,7 @@ static uint16_t __request_submit(struct qmi_device *device,
 		req->tid = hdr->transaction;
 	} else {
 		struct qmi_service_hdr *hdr;
+
 		hdr = req->buf + QMI_MUX_HDR_SIZE;
 		hdr->type = 0x00;
 		hdr->transaction = device->next_service_tid++;
@@ -1142,9 +1144,8 @@ bool qmi_device_has_service(struct qmi_device *device, uint16_t type)
 	for (i = 0, info = device->version_list;
 			i < device->version_count;
 			i++, info++) {
-		if (info->type == type) {
+		if (info->type == type)
 			return true;
-		}
 	}
 
 	return false;
@@ -2260,7 +2261,7 @@ void qmi_service_unref(struct qmi_service *service)
 	unsigned int hash_id;
 
 	if (!service)
-                return;
+		return;
 
 	if (__sync_sub_and_fetch(&service->ref_count, 1))
 		return;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 3fdf960b..21537a76 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -62,12 +62,12 @@ enum qmi_device_expected_data_format {
 };
 
 enum qmi_data_endpoint_type {
-    QMI_DATA_ENDPOINT_TYPE_UNKNOWN   = 0x00,
-    QMI_DATA_ENDPOINT_TYPE_HSIC      = 0x01,
-    QMI_DATA_ENDPOINT_TYPE_HSUSB     = 0x02,
-    QMI_DATA_ENDPOINT_TYPE_PCIE      = 0x03,
-    QMI_DATA_ENDPOINT_TYPE_EMBEDDED  = 0x04,
-    QMI_DATA_ENDPOINT_TYPE_BAM_DMUX  = 0x05,
+	QMI_DATA_ENDPOINT_TYPE_UNKNOWN   = 0x00,
+	QMI_DATA_ENDPOINT_TYPE_HSIC      = 0x01,
+	QMI_DATA_ENDPOINT_TYPE_HSUSB     = 0x02,
+	QMI_DATA_ENDPOINT_TYPE_PCIE      = 0x03,
+	QMI_DATA_ENDPOINT_TYPE_EMBEDDED  = 0x04,
+	QMI_DATA_ENDPOINT_TYPE_BAM_DMUX  = 0x05,
 };
 
 void qmi_free(void *ptr);
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
