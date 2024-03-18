Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599E38DD6
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787107; cv=none; b=dmJHZ/xRkPjpizfXTUDWq7sG5D/bWJQNMb6Il72EbkR9TLfbVOQ9DZkXuc0ujVMsffEviAkHIemtx+PNg/1zeSPs9mDjgs+Vx31qleiFSc/UpDBQqaaIst2CB3poGC1CpFVJleMB/DfGYnIhJvnatYYa/2DgsQGYeVE015OfKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787107; c=relaxed/simple;
	bh=cdWcAxoga41Qfm/38PFPOvQSXxSvy5vpGsDs4zdglYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3tcUs68N8nSisT1QtbWOS4+fY2Zpb+fZFn5CqufYRILHL2qn+7rEITDU11KPscrbnys5ordW6KCskIkjNbhRv4IhV3bnY+gwwQmC2nPxsRE5px3AS2FsNvWKegP7cvR8lUxeORX63BTBV/LyXd3mYZP9/UtykqHJapfi6hN2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=NIc38AJV; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=j6sKrSPn; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="NIc38AJV";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="j6sKrSPn"
Received: from pps.filterd (m0286616.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IC02Jk017552
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=vDzy2964f10ccf8CmLTNPt
	mGOPyQA2loK+Bn0xdfvQM=; b=NIc38AJVRppwQx2zsrwPwKt/yt7cKUQLVPttmX
	NmlT3pjWD5rHWVm/9hUrkuSi6NdCWcY39YqA3qas2ze4WDdq2dkjbk7JPPpw1bgq
	ML1C+tH2jVQFIpZdYT+ya9jpokCHjudikNdYlcSjPcIuXHXRowCVFbd563rG7E7l
	ejnCNtec+j7DafzCIAEMBe6hC5PIqsY3CzjngjR9yoq6IMpNjTrHvEY5wZCIDvP5
	GyM/PmLAYyGGELiDvTFCVopVtEaXqZgUtWuRnYjs8qKNMAV4CUEb5kvdwvKII4Li
	Wf7S1ezgGm7dHKyDGXflaDTrYGGMOnzpkoTnIMpxRiQ/PHgA==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3ww9059cdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:17 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so343060739f.1
        for <ofono@lists.linux.dev>; Mon, 18 Mar 2024 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710787097; x=1711391897; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDzy2964f10ccf8CmLTNPtmGOPyQA2loK+Bn0xdfvQM=;
        b=j6sKrSPnZJbauDkWajTVODuzK+8FEZL1Mlal2DNHJ0gMMejZnCdH+TvlGAKM4ymLe3
         B2q9egcmA1LDUlxsW2oEV0BXXQ2Qrl/+qSwIQ7lQqw1mksyPHG0l+1ezYsCtDE6dkq92
         /ZpYDmsTwvECYMgBtrOFhsA3Fz7uSrEGNmtosk+YFrK0Rr9iHXaNWdmu/RGy3AOzLKwh
         6C5odF6UTZxxTnuvsbiuKTPqPgfUmvSaiM+fRCLE1dVfX3r8fX52uc7UnzfuajuFgDjy
         MJv6qfvSyTYycUC8rNrwlIOe4PiqU7ljBGMPrq/0Y8nRF8sVCJre8AtstiFRV9HCdd9e
         bJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787097; x=1711391897;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDzy2964f10ccf8CmLTNPtmGOPyQA2loK+Bn0xdfvQM=;
        b=iuraAosqh4ZT4oO3VyDwkdNOudSvxbwBfNgEs4nvYh3mfvCDF0FHk208WIB532sLcr
         SbONhJd05NtOBCh4SpdAxDBcJ7kBV87UGb4HTzclY0gttnMD+wguWWmdrfGP6l4vwePI
         Gag+Lg0oO0XK8nj56RIdQ7WT5jFbIC7dLwnOKoPDooz/imJnDh3hD+ibAGLWOcyLjBYk
         2D1tbP5bbf+uiwhe4PFkyNGUe+MXbdubitIyrIAXsnRWT8L8qR/kPct5P3POtw+HxSZR
         JBAQSDxC40qtwi+P+xyEI+tXvRD0wodRIXvCyKp1Bm+ioA8kS5np2k2SeVdZ0Mrrv+yp
         4dMw==
X-Gm-Message-State: AOJu0YxptMEhDFh83PltWCNSqeOY7Y1qwGK5JEkiP8L94AO0DqAv/2FC
	lVTlUl+J3E8ncI3ZqMdK9PEKPTOFRLS+wK8GY58pH7IvEbJEqfAEjFCG6YB08pBaXVutAE5Si7w
	/kylbS6e1O9fZogXrZNhKUwNLh5efc0xu3iFBzTuKGSNHI36cT6B1Zpvs4G5BGhAfW2JNPFr5nW
	ISxLktyEbLBGIIYAl93ZEHKlSeyWo5S6St+Nt1BQ6Qt3qTm3Q=
X-Received: by 2002:a6b:f704:0:b0:7cb:fc25:4ac8 with SMTP id k4-20020a6bf704000000b007cbfc254ac8mr549318iog.7.1710787096727;
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT4lhAGmJdrxpsjKZK7gZYzffH5gZhnAxsmbQZMK8Bp6ePo9zBtZb25OvL70d0F7ozsLZetg==
X-Received: by 2002:a6b:f704:0:b0:7cb:fc25:4ac8 with SMTP id k4-20020a6bf704000000b007cbfc254ac8mr549298iog.7.1710787096374;
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-768618.corp.robot.car (133.199.192.35.bc.googleusercontent.com. [35.192.199.133])
        by smtp.gmail.com with ESMTPSA id q6-20020a5d9f06000000b007cc6af6686esm873477iot.30.2024.03.18.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:38:16 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/3] qmi: Fix printing the wrong type for services
Date: Mon, 18 Mar 2024 13:37:47 -0500
Message-ID: <20240318183754.71578-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318183754.71578-1-steve.schrock@getcruise.com>
References: <20240318183754.71578-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: _duT151oyWJ8BwgycPSY93IBF4w3yuy0
X-Proofpoint-ORIG-GUID: _duT151oyWJ8BwgycPSY93IBF4w3yuy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403180141

The __debug_msg refactoring introduced a bug where the service
transactions would not display the correct type in the log. The service
transaction type is shifted to the left by one bit compared to the
control transaction type so we need to perform a shift to be able to
share a common debug logging function.

Fixes: afa96ae4fa99 ("qmi: Clean up the __debug_msg function")
---
 drivers/qmimodem/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 6eda68d7a571..555a4afe562e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -648,7 +648,7 @@ static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
 		srv = buf + QMI_MUX_HDR_SIZE;
 		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
 
-		transaction_type = srv->type;
+		transaction_type = srv->type >> 1;
 		tid = L_LE16_TO_CPU(srv->transaction);
 	}
 
@@ -672,7 +672,7 @@ static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
 
 	tid = L_LE16_TO_CPU(srv->transaction);
 
-	__debug_msg(dir, msg, service_type, srv->type, tid, 0, len,
+	__debug_msg(dir, msg, service_type, srv->type >> 1, tid, 0, len,
 						function, user_data);
 }
 
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
