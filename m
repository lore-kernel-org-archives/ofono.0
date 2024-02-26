Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393EDDDC
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918649; cv=none; b=Z4AxDYAXqGgzRWLgvxMXZM5djzGR+Asi7Kle4VFX5x4csUda3+dwCBW3oe0Jg/7ABKMG7n2eGg7bzXY5TpUaHOzPAkwkZnpAnaNcqxKZr4zuzvtse/01Vnie8VQwLfqhXw6aq1xmuncOA99O2ftm9Iq51RBLbFQbwfNB+eMbSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918649; c=relaxed/simple;
	bh=WapNS4+xuPys4Bl63wSXa6yWBikhNhDzjjeMvBni9xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlqZIv5u5Q2FkMHlEgEqIwngMnb6CW/zgeneLCvRZP+SmIwnpcNBqs0XZzOaUmaqaQEkGSIioFd4+XI/4wkby7xsleH5uybiWgSpbaQhd3ppr6TlJQJi2FPAy+XY1R6zrBgCiATgXMzpOUhtDP9Wo6gjlw+5rTw5W7C76BBXjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ9le534; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ9le534"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1a2f7e302so184833b6e.0
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918647; x=1709523447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKGaAc0B5QiXt+u4H5YuFCzcOehw4LaF83wwuGOJVHA=;
        b=hJ9le5340SLhahAlG9enMv4vdSTAVF5ZrnEIJl562zjR2tlUqqb5eTYA9CK+w8H1Wv
         JI7N2W/5xE6TOZiFDt/qTtbgdRFebDWNJ6JmJxsTibXc7NZbaQqbUwHPAUAmW7ZJcXqT
         omyhPBkLGaApJkFf5INOpHrXcqt7OStuHKKpiUZWpFBpmpPYSHvZftmFnU9W4MiIk1iz
         luyLByrDVHs3hwW8tsGOaJaMZSXqo2UxoU2qEGP3ktcLk4qYaDX6rfpAcjl4W67M+043
         opx6sOYyBreG9C2XPpUs6NSCh52fPrQE3WndK92KAcHZjUW6XPNgZNwNKS70rFyCN+Py
         puHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918647; x=1709523447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKGaAc0B5QiXt+u4H5YuFCzcOehw4LaF83wwuGOJVHA=;
        b=cMQBimE6WVltSqmN8wpLKfqM0/+5M6z24/dHpwN7cG5c4GySQcaTbDntL5N2Yqz9bD
         QYIr/Mjq5tYAb9zRxJVJH006gBHUkKSWseWAdMDgI/9tZmcTlampE+7Fc/NDoYG7A8Fy
         Wwgv37LSOBygnUL/BjSrREUFKEL+eyaJUEpvlFIYL5Bs1qo709r/zNrXgN7WRZO58GpL
         pRcfKG+9BCmJnXPjt2S2L5K1RRzjpb5og271BRHGP4MKc94TrD04iCHrDQ/6M1i0gmOx
         huRx0tjPgZxSeF0HM7QB7BwNXUQKL5NHIDatsBL1rzFPS9wWs/6YCqDrADYL6vlj4pGj
         wvCQ==
X-Gm-Message-State: AOJu0Yzqy3VtJEKnuOcYOv+UYQ3uABwhlm5Wg5PQ08SWgqK/MeYofBW2
	yrXhO/fFiHP0fYUOBR/AGwVy0yctCk2Bg7OvCoLdjQBtH/9Ww0QCL8lMXWQT
X-Google-Smtp-Source: AGHT+IHKV+mL16pfGjaMJhFspFI2faEtIYlS6pTml0g4mCSLkdxltUSyllwdF+gAaTA3zcJCQJgBsQ==
X-Received: by 2002:a05:6808:2085:b0:3c1:51c1:f4ee with SMTP id s5-20020a056808208500b003c151c1f4eemr7694631oiw.48.1708918646815;
        Sun, 25 Feb 2024 19:37:26 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/22] gprs: Remove g_strfreev and g_strdupv use
Date: Sun, 25 Feb 2024 21:36:44 -0600
Message-ID: <20240226033724.1460079-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace by l_strfreev and l_strv_copy
---
 src/gprs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index dbf9b0605b7c..67f0d7803525 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -328,7 +328,7 @@ static void context_settings_free(struct context_settings *settings)
 		g_free(settings->ipv4->ip);
 		g_free(settings->ipv4->netmask);
 		g_free(settings->ipv4->gateway);
-		g_strfreev(settings->ipv4->dns);
+		l_strfreev(settings->ipv4->dns);
 		g_free(settings->ipv4->proxy);
 
 		g_free(settings->ipv4);
@@ -338,7 +338,7 @@ static void context_settings_free(struct context_settings *settings)
 	if (settings->ipv6) {
 		g_free(settings->ipv6->ip);
 		g_free(settings->ipv6->gateway);
-		g_strfreev(settings->ipv6->dns);
+		l_strfreev(settings->ipv6->dns);
 
 		g_free(settings->ipv6);
 		settings->ipv6 = NULL;
@@ -2940,8 +2940,8 @@ void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *gc,
 	if (settings->ipv4 == NULL)
 		return;
 
-	g_strfreev(settings->ipv4->dns);
-	settings->ipv4->dns = g_strdupv((char **) dns);
+	l_strfreev(settings->ipv4->dns);
+	settings->ipv4->dns = l_strv_copy((char **) dns);
 }
 
 void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
@@ -2987,8 +2987,8 @@ void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
 	if (settings->ipv6 == NULL)
 		return;
 
-	g_strfreev(settings->ipv6->dns);
-	settings->ipv6->dns = g_strdupv((char **) dns);
+	l_strfreev(settings->ipv6->dns);
+	settings->ipv6->dns = l_strv_copy((char **) dns);
 }
 
 static void free_contexts(struct ofono_gprs *gprs)
-- 
2.43.0

