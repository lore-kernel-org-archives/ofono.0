Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533891E1C2F
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708062; cv=none; b=OJ6Jvy8EXLuRBArDI3SkK8CZQNzTa1dmuQk8V3mIt2eFahomShcBsii026PqGi+iQ8aVqUv9vnqCqQJmCSHRHOmzeRPEfb7OshDvlez6qYGdd7fY3lCwVSuY1rgKxp3mq/Zn/dHjMurcRmBtbyqwuQIfmI3JCD6ZBvcHvbysopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708062; c=relaxed/simple;
	bh=8X50KO9dgv+6wBLlul3LmCGeoxqGPpBqxrutVDFmY7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC9ggfvgnnnabQpmNe2VbQjLTGEFV6KnJlvw4zCr61T0JXroS0HF+DZSg/2LsjPRve9dH1F1zY32l3T+0z/0drhWCkkZA9nPi8CKeD9wuXlNme4csY2dbZIa4XmQ6oATrfV57M6B3wT+JwWqN5U90owBGLq/Ukmz5ehPF04C9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/GK0Lwj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/GK0Lwj"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e600ae1664so1139864b6e.2
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708059; x=1732312859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsLG7UOstf+by9gur4AzUthrycYxuv+711sgoD+Ncpo=;
        b=F/GK0Lwj9sdyCO6dJX9T5OFWlWTCyVoAuviTi+X7FhmHumft3fzGb49Ue+/BfDQzFO
         /IA48GZ9IuPG/U9p0DzbSp6dDni/OhKucAc3FLfJ14+r7lkWxBg5DoXthlBGdtVgLe/K
         cPS59dWcoAd0AIco9J+JC9yfAQFXC+4k2ENEZyrenp5T3RU1RkneOqznLn/ZN1I3coQM
         v3m3ZAKzCUO6umAxdYXS/BEEqA5j1nMHAwTrjYEZSYDaqXpZN2700LRuxX1BVhV5No5M
         h45P7b9l3krgayGKGIMkA3cF+shtYhND+/ShXciynw2RxJK28fGSpFBvFsDTu7cxoPqM
         GpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708059; x=1732312859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsLG7UOstf+by9gur4AzUthrycYxuv+711sgoD+Ncpo=;
        b=dFhy0gygGXo+r01Y193etbm27QMjjDU+pO5ZD4Qa14bb8fMbZlrJjP0vWWvfQv4PmJ
         lTa+8frVTAmBkU0ybqUuU/+/xjr8AdHu4uhPVJ4gvl5KWe4vvLqpRbu78uyBTYHebP4G
         sDHt5hcP4bu2znFA7/rmp1LXvHGmKvxoID9r5IMqmmdZnsjgSUgRWreyW7nwjnQdlch6
         /4lSY514rg0W4H2YMPRHJRLAe8MbH+K+dYCEmQMJFFrqT6VLkfJZDES34Oh06akMlaap
         vy94D1yEkvP2nIl7ZsxPa4hYL+ZrS578xOyzubB0meV8eapt11BUsiDaEeC/+7ERKikH
         QYTA==
X-Gm-Message-State: AOJu0YxJ1d3zSktcUZtuISnVGe16BlEodWcGyQQDVkQpAR0VI7mKNgmy
	Quxa6/PoJIcVnY+nnvDfgw0wiWsdEoL5AewHyeQj2zIHcwxOi3fIps4Dhw==
X-Google-Smtp-Source: AGHT+IFgZTlqslw00jUweut8wECvdF2dxNlxJKdUI+Ad2OWjGjXLqIZALMYmCShZktMk2Rr16+Xzqg==
X-Received: by 2002:a05:6808:13c6:b0:3e6:134e:3b90 with SMTP id 5614622812f47-3e7bc854642mr4579371b6e.30.1731708059334;
        Fri, 15 Nov 2024 14:00:59 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:00:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/8] rmnet: Track used mux ids
Date: Fri, 15 Nov 2024 16:00:29 -0600
Message-ID: <20241115220053.49613-4-denkenz@gmail.com>
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

Track used mux identifiers.  This uintset can later be used to allocate
unused mux identifiers.
---
 src/rmnet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 920525006e0a..f784e5cc4bb2 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -28,6 +28,7 @@
 static struct l_netlink *rtnl;
 static uint32_t dump_id;
 static uint32_t link_notify_id;
+static struct l_uintset *mux_ids;
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -169,6 +170,7 @@ static void rmnet_link_dump_cb(int error,
 
 	DBG("Existing rmnet link: %s(%u) mux_id: %u",
 			info.ifname, info.ifindex, info.mux_id);
+	l_uintset_put(mux_ids, info.mux_id);
 }
 
 static int rmnet_link_dump()
@@ -207,6 +209,11 @@ static void rmnet_link_notification(uint16_t type, const void *data,
 	if (rmnet_parse_link(data, len, ifname, &ifindex, &mux_id) < 0)
 		return;
 
+	if (type == RTM_NEWLINK)
+		l_uintset_put(mux_ids, mux_id);
+	else
+		l_uintset_take(mux_ids, mux_id);
+
 	DBG("link_notification: %s(%u) with mux_id: %u",
 			ifname, ifindex, mux_id);
 }
@@ -227,6 +234,7 @@ static int rmnet_init(void)
 
 	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
 					rmnet_link_notification, NULL, NULL);
+	mux_ids = l_uintset_new_from_range(1, MAX_MUX_IDS);
 
 	return 0;
 dump_failed:
@@ -236,6 +244,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_uintset_free(mux_ids);
 	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
 }
-- 
2.47.0

