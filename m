Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0A149C70
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612112; cv=none; b=JYJ0Snqi1bejb24z1XvtL6crbndY5qbvjs6aZ5qt3b92jR2fOZB9OJCeGoEw4rl3LxglGH9DdSHC92G/yDNDaDtZ8MODTBgkTjhvZanIttdU7J6E1RzxOoPCTcT8ebq3xC2Mx2YSXJ/cyys279xO9hFlb8lddUxfwexpwa2ZtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612112; c=relaxed/simple;
	bh=Rmr9T8cd5WgF+6+bvdTX6AmjTmxp5LSaD7ykJ8XVW3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOx6tAI97ERZqgzno7b1HSjeI0/7v9eIsX0CU3bT45I3huzuX0ZVfdKRxSaFeU/TW5a3fVdpZcOzbbl9Rg2QH1V36ym9kl8WYJNrz/jVm8VFrGjYs+ovq+sD+mUyv9Be7FJl+o90LV12xnaxg/VwUOyc/S7EEOffkdB8MLLQ/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=aFVhfOE4; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PSn76pCW; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="aFVhfOE4";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PSn76pCW"
Received: from pps.filterd (m0286614.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438D1b6F022626
	for <ofono@lists.linux.dev>; Mon, 8 Apr 2024 14:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=P2QNPnD9cI1ODiMWwHo3Wk
	omX6FSFp5UfgN9zekorHQ=; b=aFVhfOE4fJXxXUJbZ4l6b40cYBWCN4XORS1zRd
	6uYD0632iBjIIPbe5bTUY1O6cI4nPlT2/PJ5gQzeh/EvqEoduRTDZj7pNHnS3jaw
	Po5gHi9MtDbCrzRa1+sC8StEcAJAASxWrMK9iMy8GP/gq2NQ3nDn4TZjZ97Peh2U
	eBrAPTtNYPuNhhAV0aluF3+iklz9Tbvww8yyY1Gi+D2cyA9UiOw7OancbFMuhsmS
	zOY0ccmvHM0EK/WXduQmRk6dx5W9qmyWozjymCCcU0G/MhnQC4h+62lnVCjdSsPu
	xrhQ8tEbJKJkLUuS5K9iBVL6kH6yuZV4b+XcmKXCoPEkpPeA==
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xb3dbhh2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:35:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso475305039f.0
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1712612107; x=1713216907; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2QNPnD9cI1ODiMWwHo3WkomX6FSFp5UfgN9zekorHQ=;
        b=PSn76pCWW1f9we9lcBof0CLHs5j+JyD+9fRcbZd3oQ1XLIFBrm6eLHD+mFZFFlJ80b
         W/A3fxHNLyn3TUH6n/w1QTbI8bbqFqczc0tliOL9t7H7VsKFiPEJkxrHDhDzzFqHoJvY
         dSToF1CwWE7p6enqmKw8Y49KTqbHqqU/IgmRubgfILXiEuwsicvKv7QVZxpIyo0nSOSH
         VqRLNtxnBW1vcJiadlwX4jQ9znhV3Oc3KWNSKVlUJyOqLvgqpf8C9o0ORbuUvTVHWfdh
         vh/pZvmhszSvoeIQq/fMDSzdBX2dt33W0jh04C6+G6tz3Jov1CWj1OJMsfkwz2spA+ia
         13Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612107; x=1713216907;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2QNPnD9cI1ODiMWwHo3WkomX6FSFp5UfgN9zekorHQ=;
        b=Af8vLgajNBkj4pGHlRHtOY6UlOe0os2qEF/hfOg6fVMb8IpD3tyuhob7gY08iGjRbv
         W+lhMRcF86X6QYolutotHkWt2sofzKMtixB6hQox9yFzRXGicqGV9+aogRpfc4cYZbFM
         LqJwmhvYJ4IdyvAzr4bizzfPLUljiun7sksWW5Q3gTENGpey2f8H4lBerXIrD5PIKZbb
         8vtYzzfVi5b6gKVllXPRsZflrXVOrghzax5pEtITpnmPpHokDRzbOYD7DF7Xffz8KgIb
         PDrFRsAlKMYNtao0APUnunzqM5PPUjCZzA7mHxBDuV5gXHQS5abhF7mPN0XlXMwQXIaC
         X/CQ==
X-Gm-Message-State: AOJu0YzCd1Jd+GYjkVDSUsAuYgGHQKZFeLJTzVHsx0Jz4mGymU5niHTD
	nOw4IPFV6MROpJZFk8NDuuXg4lGTmgbutoy6DS0v3Qqr3VMRLF0gWNMEC3fE94Jg2iH2lvfmF8T
	mxYS1d6ttUhmTrAzqbqcZeOkybSaldb/vobh+whWxdlVJoF0Nygk/jmlFCLPEYH6EWfP/8W52qZ
	TNDOaoO3Ov4k8XIx3+/504MgGyOAlO0aHOvHR3SGj2tP5uiY8=
X-Received: by 2002:a5d:9658:0:b0:7d3:4b31:7ecf with SMTP id d24-20020a5d9658000000b007d34b317ecfmr9599175ios.15.1712612107166;
        Mon, 08 Apr 2024 14:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYYhaWv4hIm78uHLCbBLfQj1HWS8Eg0osb7EzuykH4m38BOarCAtZvzJNSAF496kdvhcIEAA==
X-Received: by 2002:a5d:9658:0:b0:7d3:4b31:7ecf with SMTP id d24-20020a5d9658000000b007d34b317ecfmr9599160ios.15.1712612106775;
        Mon, 08 Apr 2024 14:35:06 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-583422.corp.robot.car (105.32.128.34.bc.googleusercontent.com. [34.128.32.105])
        by smtp.gmail.com with ESMTPSA id ca17-20020a0566381c1100b0048281ab15a7sm1813440jab.46.2024.04.08.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:35:06 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v2 2/2] qmimodem: Default embedded modems endpoint ID
Date: Mon,  8 Apr 2024 16:34:39 -0500
Message-ID: <20240408213453.53910-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408213453.53910-1-steve.schrock@getcruise.com>
References: <20240408213453.53910-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: mneQJFTN4fm4BE5XKMudVeXfK_cJ5QAJ
X-Proofpoint-GUID: mneQJFTN4fm4BE5XKMudVeXfK_cJ5QAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_17,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080164

Embedded QMI QRTR modems use an endpoint ID of 1. This will not be set
by udevng, so gprs-context must handle this case.
---
 drivers/qmimodem/gprs-context.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index fb2069020833..33565252028c 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -376,21 +376,6 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 	} __attribute__((packed)) endpoint_info;
 	uint8_t u8;
 
-	interface_number = ofono_modem_get_string(modem, "InterfaceNumber");
-	if (!interface_number) {
-		ofono_error("%s: Missing 'InterfaceNumber'",
-					ofono_modem_get_path(modem));
-		goto error;
-	}
-
-	if (l_safe_atox8(interface_number, &u8) < 0) {
-		ofono_error("%s: Invalid InterfaceNumber",
-					ofono_modem_get_path(modem));
-		goto error;
-	}
-
-	endpoint_info.interface_number = u8;
-
 	bus = ofono_modem_get_string(modem, "Bus");
 	if (!bus) {
 		ofono_error("%s: Missing 'Bus'", ofono_modem_get_path(modem));
@@ -409,6 +394,23 @@ static void qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc)
 		goto error;
 	}
 
+	interface_number = ofono_modem_get_string(modem, "InterfaceNumber");
+	if (!interface_number && endpoint_info.endpoint_type !=
+					QMI_DATA_ENDPOINT_TYPE_EMBEDDED) {
+		ofono_error("%s: Missing 'InterfaceNumber'",
+					ofono_modem_get_path(modem));
+		goto error;
+	} else if (!interface_number)
+		u8 = 1;	/* Default for embedded modems */
+	else if (l_safe_atox8(interface_number, &u8) < 0) {
+		ofono_error("%s: Invalid InterfaceNumber",
+					ofono_modem_get_path(modem));
+		goto error;
+	}
+
+	endpoint_info.interface_number = u8;
+
+	DBG("interface_number: %d", u8);
 	DBG("mux_id: %hhx", data->mux_id);
 
 	param = qmi_param_new();
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
