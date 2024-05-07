Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14B160862
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096084; cv=none; b=b/ZlHWzwF6SPBwK7HKZSurgq5wy/8gSeKl6vNxnQRlPcWrMMA1uaoGkQMVzbvAhvgdI0McG6f86i36HkFLJQCfmT+1iy9dPKzcYQT354OlteHEzPR4UE+VlQxkMxc44O5wZ9pHmFHAIQAQiIe/smB6BJwgNiwD4CPg6qZ60c2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096084; c=relaxed/simple;
	bh=2yzCfYiLHWjJHrcpG8CRJVxP7o+u6IRFzWy+WCHgHZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwbXf+fmctBh0X688k17naf8gglZ1VAfP4HruJThNLoc8Sy+hMlhot8avU56BUnnVp/nZbj4SKYmjZLB0hsjZllYPVOKCDSrJGOcleHSNPM276O9dBWiW+Y2WvYkJaDsgECY4mS3tPeYKgWv/+rcwFIt530Af+Z0KbwUzGnZ1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=RUlQaeic; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Ts7Yztpp; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="RUlQaeic";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Ts7Yztpp"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447CU3AY015678
	for <ofono@lists.linux.dev>; Tue, 7 May 2024 08:34:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=kuTwr9xyU+/2W9sdPYmVSg0ulVab06GxAIEVyQlbxNc=; b=R
	UlQaeicU99tW/IHlfEnGySrTCE8Hp4+LdNDDYWGlEGXIlAo73HjC/TB5Q6//vC0R
	GZ9cQYbdZoP6WP+zDN7Pe6p3D/JT9SVIEOF/GqUpbElBHTVcdwR4VMnGlDsqYj0K
	eU3tSMh05nycNyzD0u1e9sJMXYcraYgT+1suoTScEtSPgJGjtxAETRa3XaccGYSp
	OeQNq2X2Gq65fcuhCgmtEluGuBf4M3AiKUwMGSMivPIpaUh9ETeNm1wyz42TUdpm
	Xf10UrQsUGSIbl4m7KQkGkyJdU1g7p3Yv63+FGG8h4bKkkz2JB+rQegMbmyTaQ/4
	s67W6wLrLeKdt4Vm11Jsg==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xwmjwt4mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 07 May 2024 08:34:35 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso37248455ab.0
        for <ofono@lists.linux.dev>; Tue, 07 May 2024 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1715096074; x=1715700874; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kuTwr9xyU+/2W9sdPYmVSg0ulVab06GxAIEVyQlbxNc=;
        b=Ts7YztpprEmyc90sOpgfXJJCYLH6arNGAbkb4T8doimz/pFcGqc+UEOPCo1zlTAeGT
         O0QzMWr0VEnKp4q2rYxZopqRNvWOZu6Hq5JSa7le29GgS5R4V7uUq1C1blS5ltc04mF8
         OgZO42OgW2YIWRoggytRC7h7NXZoz4bz0KOY/x80cFj44BaPI41NKiwwdPLFaNyV1xZA
         dg5hx2D89Vj7PE4c/GEUIviIQscAOpzgkln+6naCCWYo3WJQW4vbjleztLzvecsJCb+W
         0MXZM/g3rNhyKXvZpJDavYMcXCUqYDCQcNzIzb4EbusG1WADZuccysi3cepcZER1kaGH
         spSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096074; x=1715700874;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuTwr9xyU+/2W9sdPYmVSg0ulVab06GxAIEVyQlbxNc=;
        b=k4QO6jFTbP+KaetRn53oCKKEqG33HlUMFphMiZ5Fl3M47RrmZPKkZqBIj0yNhT6rN/
         O/YKBsDSuhMVJkEea94pjKwB+52CTG8UBuJRpo0K3tSuOthBe5UDRfp8Wuy+wL7DYFV7
         +OVriHZb/gLYMGVAdVhLr5M108FSznuvPkIVGaqJoGVtGUBI7IX4ViWdEPuFsG69IKEm
         xDtq5+ViL8zLvp7NF9vu5863rkYsHIQ4AUuqaruRW+vCx3Oz6ZnGvn4e64QgZy/CwzRR
         xoW5Y8KQdUMpetPf9k4SBP1OUtAoJR4ybRDLe3TSWHuUam/mNXlvDFRwTIWnL8yuVQ9t
         ydMA==
X-Gm-Message-State: AOJu0YyQSwA2pI05agMSLu0Y7cxngkGYob0IoYojOY11X7D8I3c2tVlm
	gM8/kSF5LqTw5yg1HxlneukVnm3pRW8OrnIX5mQ0VbhHqlhuoHapNthRMqlRjpxv8cfrEmIyoFP
	88SkdeH0cBE9OVzmb6d3xhu/jOjX+Dn/E+P1bP0mHlI0455ajw07bo+YJqojB/QKUPN5YflIKVg
	EIlVT37TNcaQ4x47AQXldtMdGLiF2HjEDCljsdaeY2ATXp73M=
X-Received: by 2002:a05:6e02:1a26:b0:36c:2b26:5ac4 with SMTP id g6-20020a056e021a2600b0036c2b265ac4mr17412355ile.0.1715096074218;
        Tue, 07 May 2024 08:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgX2viClAl4yrjweJCJVJUpAmGA91t1DDIVB/sssMuyrzj1eqHJ/80X03+hS/0s908J7IkvQ==
X-Received: by 2002:a05:6e02:1a26:b0:36c:2b26:5ac4 with SMTP id g6-20020a056e021a2600b0036c2b265ac4mr17412312ile.0.1715096073810;
        Tue, 07 May 2024 08:34:33 -0700 (PDT)
Received: from cs-1zgl0npt-heavy-homedir-2429.corp.robot.car (135.199.192.35.bc.googleusercontent.com. [35.192.199.135])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021ca300b0036b3735d22dsm2738285ill.82.2024.05.07.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:34:33 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] qmimodem: Fix error path memory leak in gobi
Date: Tue,  7 May 2024 10:33:58 -0500
Message-ID: <20240507153408.681340-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: oVi8-Wlux-bttU8NlbAMIIKN0vSHTuQl
X-Proofpoint-GUID: oVi8-Wlux-bttU8NlbAMIIKN0vSHTuQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=927
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405070108

I noticed this leak when I terminated ofonod while gobi was retrying
discovery on an unresponsive QMUX device.

==8257== 20 (16 direct, 4 indirect) bytes in 1 blocks are definitely lost in loss record 31 of 154
==8257==    at 0x4885118: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-arm64-linux.so)
==8257==    by 0x5A4737: l_malloc (util.c:49)
==8257==    by 0x4669E3: qmi_param_new (qmi.c:2374)
==8257==    by 0x466D73: qmi_param_new_uint8 (qmi.c:2449)
==8257==    by 0x47D717: gobi_disable (gobi.c:482)
==8257==    by 0x51BAD7: set_powered (modem.c:986)
==8257==    by 0x51E8FB: __ofono_modem_shutdown (modem.c:2279)
==8257==    by 0x518233: signal_handler (main.c:85)
==8257==    by 0x496D14F: ??? (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
==8257==    by 0x49CDE47: ??? (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
==8257==    by 0x496DBFF: g_main_loop_run (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
==8257==    by 0x518A23: main (main.c:314)
---
 plugins/gobi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 39c1ab81fa56..8bd2c4060446 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -488,6 +488,7 @@ static int gobi_disable(struct ofono_modem *modem)
 					power_disable_cb, modem, NULL) > 0)
 		return -EINPROGRESS;
 
+	qmi_param_free(param);
 out:
 	shutdown_device(modem);
 
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
