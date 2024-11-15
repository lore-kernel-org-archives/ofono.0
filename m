Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925A1E1C1A
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708063; cv=none; b=e1lfDlacmJRLiLjQsq4t/vddlHX9fH+irp3vQ7WszErD2RH2XBFgYqEAkjfXlJ/s3Ox/FuDW8UwyA8V+EfGJTMkAzo0Rl1L8UeQUJUvOiSryNq57n8dIpgLT1Alb1UemRlcWZf4cz09IjLzDSbRozlmG5Tn1sFciaYs3gXABruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708063; c=relaxed/simple;
	bh=XLkDfsX54R83PpWwRmQtTiozCKyGizqRYHOx9bAu3jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG9+tUuCEn1CSgJ+vF2e2NpLfecaR937WcYisMD1X26ZW8PCdfAq1SE0wthSyrqEqZRkuSiWgbncqo4hEmRB5fj0n46NjXVTLjAtVyrJ7auyp2UOkTxWx/qEHWP/j5gSB4MR8pSnglX8tNsHKAOqfRpfE0fQYT0ojbMdqsMM5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw8XP6eN; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw8XP6eN"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5f9712991so24150b6e.2
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708061; x=1732312861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyzOvrgRQIhS+tgoHq5dG+t4fKGIbjJdAWECxCkHaDU=;
        b=fw8XP6eNurDnKLYeqLDpas4OIyYyhdq51qsZV+YhLePbAawOWACBUQiUza7B/biJXC
         qHspsawYa3D/XlbQ8plCYlRLRT+yWEPW6aW1RVvJgzYkLI/jh1w7ticlRy/hUCan2OmA
         EZdaSwuMtAAa0BYYd0ZGHmfLdWgVVYfUTI6ndhisPkRAQo2CbidwjMOirRzoSapE4y8K
         BWj/7wvrlfjzq14USyYBY/LkuY8ewqk9+YX9eHgN9SownvxMihKEiEQ1lcfJB122AOYC
         o+rN5o9wxJHgZuOXqssVFF41jD7U5T/6IxW8KZDaoiHCDRTtPKxKNTXT55HBIumN7InK
         Yc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708061; x=1732312861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyzOvrgRQIhS+tgoHq5dG+t4fKGIbjJdAWECxCkHaDU=;
        b=hmgm8HK54S5tGYjcqLC7dxtiXYDOlMnDnPKJUgUsh2rUElgynlufGLilnpDdCfS2mV
         56xlWJTBpxAoym/f9wXvny55P63QGXl1dVIrGR7wCULqojRKeHf4uRLmZ7ahZuAmKhXw
         tg9ITXJo4tn9iNPEwoPO+HQH2+4Uh7w9nttreJRclsasX10OeyCRTck8Qa771fa56emQ
         pFF7Gv348fSD1FBI9mQQ0VIodNuOMUFJwVgvXM0DcUGXOZGoS7c5Axl1e/xt1AMIhl1G
         15aAEjQr5fNIzloRFL0F2HobaU5Wcn8eXPlrA6ykaxn8fmIJDaGmGHoqCzlCJ8DYGVly
         L9pQ==
X-Gm-Message-State: AOJu0Yywn4bjNQuHAV9OISxEWvdhF5WP0/71/JOcRflaRxj/i80dobLv
	12HawaHMWDNDGMeRlNAo04MeOc0zE2Uxkx4B8I3gxJTdKZGi9pvFo70sTA==
X-Google-Smtp-Source: AGHT+IF5A6zNxUv+A0httsijLNGPm1ttZFFWB4LxdMDu4hb2Hu6eTGA4ExOKg/UKKFKR53VV5vsSng==
X-Received: by 2002:a05:6808:3094:b0:3e6:5f1d:411a with SMTP id 5614622812f47-3e7bc865a3bmr5918484b6e.31.1731708061223;
        Fri, 15 Nov 2024 14:01:01 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:01:00 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/8] rmnet: Implement rmnet_del_interfaces
Date: Fri, 15 Nov 2024 16:00:31 -0600
Message-ID: <20241115220053.49613-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115220053.49613-1-denkenz@gmail.com>
References: <20241115220053.49613-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation for rmnet_del_interfaces.  This method will remove
the interfaces based on the passed in struct rmnet_ifinfo array.
---
 src/rmnet.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index bb5a2ed1805b..ed2fc6bcfdfd 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -148,7 +148,18 @@ int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 int rmnet_del_interfaces(unsigned int n_interfaces,
 					const struct rmnet_ifinfo *interfaces)
 {
-	return -ENOTSUP;
+	struct rmnet_request *req;
+
+	if (!n_interfaces || n_interfaces > MAX_MUX_IDS)
+		return -EINVAL;
+
+	req = __rmnet_del_request_new(n_interfaces, interfaces);
+	l_queue_push_tail(request_q, req);
+
+	if (l_queue_length(request_q) == 1 && !dump_id)
+		rmnet_start_next_request();
+
+	return 0;
 }
 
 int rmnet_cancel(int id)
-- 
2.47.0

