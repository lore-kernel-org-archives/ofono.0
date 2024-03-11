Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02C58AB2
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199533; cv=none; b=qWywmgV5/pK5gRRqOvaMdK/movRwemwumYI8RnD8jinYQfvw+eCDYRS7+Q4v7/V4T7T+K2cCTr5kaEf9s+zcevkpsTVEKdT53HY3bOsEb8moRSH0hazivCrD0N4TDg1+VFez2YlG9NJC9/rqQPTJohEVyWqqbu9SO5ORrPp5nA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199533; c=relaxed/simple;
	bh=JVgPkGD4cPomm4cY01kZWpQZKJTzaqs21X24ZJKNO2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRZtuiRiD8nAkLHH3gGWDpIy+SqnhpYOygUlB9Ppq6i+er6DdqDBCHF23bbUZ9rjTVbEOKvXN+NjrnX7c1HSLCzgYQMdveb8LyHCi5kCH2xVdhoWVDHTGEyGiapLLwfnSSXI+/koOOEffJGLrVqIK/Ht9FoQwPz1jPSnl2P6aDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=hFMXECpa; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lh+2R+XR; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="hFMXECpa";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lh+2R+XR"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BHcK0p019834
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=rbaEFQA9Y1uAdlwb+Q96v1
	/qhaTyrfAcGZfUegPcHs4=; b=hFMXECpa7pJWPzIClJmrmym8eHes4dvdQybbNa
	oZZ5OuBKmoU52jXhjEQeEDZPIqEvCH5W9oY6w6Xy/ztVKQGC2Ghp0KE7u8CLBIYg
	5H2TCjJ+/00+7C3KXLIQtMZ4DFiyaHgcGEXmGLEK8aTAvOJSAFWXPtModwfE/AL2
	v3dgF3PIZI+zkMYx8V7k9wSUGhmTvzhoF5pQJa0jH4N19MDbOsUN+RKbCkoPFc3i
	neUdfSaB2BjZr91RG/UnjG4Jpw5+YTC5iL9OmjJ0MHorW92mQIJtbNVpB9/fAkfu
	05VNlAq695fk7ZCNPTIm/XpNyHIstdaTN5JqEekFFeoNATSw==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wrnnf1jcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:00 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c85f86e4c7so343082439f.3
        for <ofono@lists.linux.dev>; Mon, 11 Mar 2024 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1710199259; x=1710804059; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbaEFQA9Y1uAdlwb+Q96v1/qhaTyrfAcGZfUegPcHs4=;
        b=lh+2R+XRsHHpz3G6tWFDtH1/8sUNfy7M0TjMkG4bacZ9PI+d+fmGV/KEfheDu047Bq
         vAyuFDebEyMwmBasy4nu+jTucgKjuya+BxCBgPdlDhnp9GSx5jWFLi0OQkl7g/JUFwq2
         CY8dr/d0Cic0S5++4An7wUJz50CS7wB1mmWVHxsIVK4cvRQ0FXEHMwqMQsFaskTtsEnZ
         qemzjQ1GZhW/o8fcF/UM+aT2+hIDPgdQ12eVPelZEBaXuxudkzIjPfVVuzPIJrS20LVi
         xe5A++fml+d3IB6nPx8ZXK42XXeyVJ6bP/MaD8xwZc2IAHezjdkF2CUXcAPDIXoLPQfm
         5lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199259; x=1710804059;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbaEFQA9Y1uAdlwb+Q96v1/qhaTyrfAcGZfUegPcHs4=;
        b=xCOcq3o7L65wXNpRuX41EzhPr0SuvYj4BZ5ydckoZgh1NEy0DUSTalYJXPcGsxBrsB
         v0dWWhhAH5qNFWL43N3CwXtQVttkVbC3RgtcMnx77bGlOUA76UoKD5fNfBbdv8ZSUdsg
         Jx8oPIETNeCOPmpG1wSvQKz8YjW5/e6Z7wR4cZdqd7XhCEpQgLp7fWOFmp61yIqTDnwl
         acoBgPSBgCMTeyEuUhiQ96c7WQ98uhzIw/gAMY975z/5tQ5Ospogroogwcgdw1QmoC5w
         nAI0GMFyqsSUmgZFYyEd0aBLEKiCDojD61l+XdLDYOAg6GubSh6p1R5+mbEXCwTt2mz3
         UbCA==
X-Gm-Message-State: AOJu0YzyA2dD3pdmu0Za0dsUt3m8x6O89AASl+JU9YI+R9Moa8s+cyvQ
	RoXWOd1FaF10OR7PqhMl/By8C/N3ejwYWzyZNlB8ONEKY62Vz8acql4c7jYnSMc32XH3FffuNY2
	rNY0pOfBYVSCq0ldfAWCInMpaF3684mqeYiovA1d9P05pT8z3V+NOaHXz3b+mx7T7CntzC4eN7H
	6ewvbLdOA3LQYO47wCHGv4tieKbfg3w1AiDCQLcIQjuUP42L8=
X-Received: by 2002:a05:6e02:19ca:b0:365:1209:16e2 with SMTP id r10-20020a056e0219ca00b00365120916e2mr10551586ill.10.1710199258959;
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhPIkaNpxm8FS/P8lvPzN6q1gJHw+sfrxh57tgwEVim2n50E/Vr6jgwgV0HTrOhTI79ylZEQ==
X-Received: by 2002:a05:6e02:19ca:b0:365:1209:16e2 with SMTP id r10-20020a056e0219ca00b00365120916e2mr10551573ill.10.1710199258642;
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-164157.corp.robot.car (98.32.128.34.bc.googleusercontent.com. [34.128.32.98])
        by smtp.gmail.com with ESMTPSA id n14-20020a056e0208ee00b003660537d47asm1975643ilt.69.2024.03.11.16.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:20:58 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/3] qmi: Fix printing the wrong type for services
Date: Mon, 11 Mar 2024 18:20:33 -0500
Message-ID: <20240311232036.49381-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311232036.49381-1-steve.schrock@getcruise.com>
References: <20240311232036.49381-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: XoCjIvMcQifl_pG3WytVKOqLfqI6LGmN
X-Proofpoint-ORIG-GUID: XoCjIvMcQifl_pG3WytVKOqLfqI6LGmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403110180

The __debug_msg refactoring introduced a bug where the service
transactions would not display the correct type in the log. The service
transaction type is shifted to the left by one bit compared to the
control transaction type so we need to perform a shift to be able to
share a common debug logging function.
---
 drivers/qmimodem/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 31f88114..15324e6a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -652,7 +652,7 @@ static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
 		srv = buf + QMI_MUX_HDR_SIZE;
 		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
 
-		transaction_type = srv->type;
+		transaction_type = srv->type >> 1;
 		tid = L_LE16_TO_CPU(srv->transaction);
 	}
 
@@ -676,7 +676,7 @@ static void __qrtr_debug_msg(const char dir, const void *buf, size_t len,
 
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
