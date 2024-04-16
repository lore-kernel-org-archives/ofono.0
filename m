Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B178C7F
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305843; cv=none; b=TTR/hPmsVPBY3KNb9JRsh/cMdTQhzTOoLPa6c46FUmQEslOBdbnx6ipesuvlguZ8U55LQXiyH7Nc1x65Elt7VR/Os1NjXBYG0SuoSrV0EoLANgRdafNwq00iaYoD9RgNF19RP+fA78S57NzAwXpzskXDymQpRmmKOoj1i1GCQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305843; c=relaxed/simple;
	bh=MhrtDgpd1+EJdqX1O2FIQI0UzRmLlLwnVp0ArCw7d58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LvY6aSQBdkMUgf1uq15NPkBToigiTVizaIcX2pwmiKmicI6a0LXIlnGM3LeIaH/YwEH2R/qCFFoVOZvpjiL33iAEf/K+0pJqCqiH8sppFitSxPVPl3z8PjbPH65EXlB1b9q88scVA2XZxY8x6gXc85tAOsWlHGHZXtG0h4RPQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YkHKljk3; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=ry9LfmTb; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YkHKljk3";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="ry9LfmTb"
Received: from pps.filterd (m0286621.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GDC3pW014242
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=5eVeN6jH8ksnb0mEnVpH/v9ZiS2ZariNA7Uiwa3ybsw=; b=Y
	kHKljk3YJtY/CJH2N6wngEIT8ynsD3rO00hezXv5c2pZrpENbznq8au6JEWNN0Fs
	KbKEhzbIck4b6/qNsQ3cuvcqmsdhSKKu1iVbiSqgmamKcpnZOMiGcEcDUt3g9BX3
	Popmksv6TihAgIFD+zMmpz3nNb9Mk5E1XF1yscxcARRZ5Un5lSW46LYX5vshKsTF
	ZO1NRIXMUFrBFNeuzo56f38LZVLao8jR0WI+OeiZolfAiRP7aSrwPGpVdLroYLoE
	wNbWpBrd+Je5GPFyLsDj3cfp4fbSwePF8SIlnGCHmzg3+5SfCZfe6yoRtY40lkZk
	+rKBij5dtOzypKorDZBKQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xfs4dtjp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7e7b784d6b2so2763393241.0
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713305626; x=1713910426; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5eVeN6jH8ksnb0mEnVpH/v9ZiS2ZariNA7Uiwa3ybsw=;
        b=ry9LfmTbtIlK7B5txZNtFbyv0ereTSe3oyBe4yRmEGfLtlXAJ6Hah2Fr22jwGIx2sA
         Eg9QMRdeVJBWSep98UtbvXycXu3+uBPR0xXYFxDPq2P2SXqwKGSDCjuaC4DPQaYZKlVn
         xTBkkuslZSu18HdAzaadmOmOW/kYa3t5HhCtFXFf9YiVxQpuPaB+gFpalUAbzJvRp7dV
         oEbBj9fk0bMvXOcLBHp4PkY4w1OwL3lg9CaqXnGVxRvlXAQmZ+kcAHWPHHrsaWpotRZN
         094YVdrMqPMd9G8t5OBDL/tmi9c88jswnlM1ZZU+AYcUHail4U3IZE3+5AFX5LUTB7mB
         Wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305626; x=1713910426;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eVeN6jH8ksnb0mEnVpH/v9ZiS2ZariNA7Uiwa3ybsw=;
        b=dkxazZMC77W4nacdjqcB5sVaohygSqsf7P07PiIKj1Dd7qH2QqKdSJI//s2VTxFqLd
         +PzOIACOvyvISxQhAbypuLH5NTnPojOpzxl/BIih3Lr3Wwg1aLSePoiiRcvn2Rx3euDR
         4hoS58g0WEtca4EGL9fOqfEs5wskCSBm4+rIdmGr2Gru0xUEndNhs1ugbPAx37+nHYh0
         IdQfecO47wF1vT5WEfRsvdM3VUuqfkdYi80KatbS5jsahbdGo0xnKJmp1Ttx+Ry5XsLx
         B8BiVuamilWBZdMqpv+IS53TkYJfU3t3G72TqjjU8dYNo6JKqy+Mlr7aWpXBR43nBypk
         Ismg==
X-Gm-Message-State: AOJu0Ywm9pW70SerlC6x1dgfSSM0s6aAXpgaody8OwTBBhhSrNEqYLX3
	5JdVLP2Vibh27ty6fTBtDFEWWSocuIuzzAUCcvnnw0lv727lpASlNLezSSE32JKet6aH5qkO2rY
	L7cHBYaqTCVQP0afKaM2fcHwbNZUu61q15PVvPjlzgQBek/hOT6HNzrmZ2RRfrF4xeMxiWw+XR5
	zbY2izV6S4meUnv3wzVWkRY7OAPVVGwDMc2EYQE3lMkcJ0Dow=
X-Received: by 2002:a05:6102:3f15:b0:47a:9436:2b76 with SMTP id k21-20020a0561023f1500b0047a94362b76mr14411321vsv.31.1713305626539;
        Tue, 16 Apr 2024 15:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr3ucK+EKvcTF+Nlr32daoiELU3FwQF6t3N/EQsdzZYEeoYllE/8ddfafusY5PUx1fThP2RA==
X-Received: by 2002:a05:6102:3f15:b0:47a:9436:2b76 with SMTP id k21-20020a0561023f1500b0047a94362b76mr14411299vsv.31.1713305626138;
        Tue, 16 Apr 2024 15:13:46 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b0069b10d78445sm7654028qvw.142.2024.04.16.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:13:45 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/3] gobi: Do not wait for timeout to shutdown
Date: Tue, 16 Apr 2024 22:12:31 +0000
Message-Id: <20240416221233.404872-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: _vXUKYsmCkYtWrL3I6wGo74czb4xmmin
X-Proofpoint-ORIG-GUID: _vXUKYsmCkYtWrL3I6wGo74czb4xmmin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160143

Now the qmi_device_shutdown() function can return a failure. It will
do this if the qmi_device type does not support shutdown. When this
happens gobi should immediately proceed with shutdown instead of
waiting until the timeout occurs.
---
 plugins/gobi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 431df17e2332..9ab561010912 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -174,7 +174,8 @@ static void shutdown_device(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
-	qmi_device_shutdown(data->device, shutdown_cb, modem, NULL);
+	if (qmi_device_shutdown(data->device, shutdown_cb, modem, NULL) < 0)
+		shutdown_cb(modem);
 }
 
 static void power_reset_cb(struct qmi_result *result, void *user_data)
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
