Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BD1E0E0C
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708061; cv=none; b=u4woBLOhb5bnvOQUGLKkGTjnEsjy9y1FS8YDM0oJwQsKxh5RX+b/1QIu30ZLN5EBYS8WRMYmrZMzb5hntBpOXrWo0QVOJUvDZmqEWYxZ7dqfGdTZgrJOUE7J79EmKr8u/naQJKevLmyvBxXZ+OJaeN98hRKRYm7Z/+SRsNEtueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708061; c=relaxed/simple;
	bh=nyhI5sQ0RPl/B5rbF0HJ/gy3SZNMo9HzP6gx0KzpX5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8oVMIhjtho7aqtY92XjlN6vvusulmzTq3SJ/dpd7/zDaxSqA6Wy24budG2fHgDgUfDNwb03sL6OUPOjvbtZUN+3wFPY54EHLod3YcWUQI0L1K9oUH0pRgL7a95hgqPywp7ZS4fRs9wzmmMNzJczQK3HwQWPi27tFtk6f+uN1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRnPpuhm; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRnPpuhm"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f533e1c2so1235353b6e.3
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708058; x=1732312858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biw1u32cDJnxKZA/EHCGpJKcvcrOQqu+ff0P0WJZsEg=;
        b=IRnPpuhmbj/lEqGw5CqcfHCcZx7rBHMi3adPqrGcfYbAJjMeuAJsh3PkilxeLWyhDP
         Ua6Lbi4CfO5dfmsDwUgVDgxIYFaPQzdx845zaqlQBIYoJQNMdUvpnHUbfSGWUjXQle+m
         eTqQ5fh5GfluL+UO49pNSpfLPrWn/Sm2Agoi00X8VGZ84vylvlD1wNxyiYav43g3Git8
         7du/UYBP4c4i1JC7q5iC5R46shGDV4nMcWfFzP+INUiYQawE1RHJSwH7M/s68GH224nD
         h8pX/9Egl9WumiivIojtqCFVgYdd82xo1KTNCus1jfZ9zV+0lmk60HHVhyQxKIdZzTYC
         zR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708058; x=1732312858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biw1u32cDJnxKZA/EHCGpJKcvcrOQqu+ff0P0WJZsEg=;
        b=AoZXVewDthy95gGsly4y7DVxPj69JEjgPUF+R4/Z6rGNVII3Rx2jQ5SO5xzXKadDyR
         ngIxfG9BS6JMzuslXL9V6OElJ6ZRV1LEueyikHe3yZTapeFF2e+gHRIcgxTIJu7bCJLo
         ReujB/Kn5LJfJWifQ0zcpLHo++XZ/J86zmNjnuaPZtG1Bgav/2+wgl/6MXtY3a+wxQ+v
         IuQRpZvKv+3lL24X5glNU31qGURyQUsdVH4XBkuGk6I5nXfBbV/aVdojxhDmnvqPJTKi
         wHkOUXi228gC12jGTtAv0yHmr80HFCU1u4sK2/NZlycWy4mC7MG7JOksQT7HgR7a/HL+
         Z2zw==
X-Gm-Message-State: AOJu0YyOoaasNqX4e0s++PRvs/nlGXs/7CakOjmIPfbqIP3q3fazppu4
	DkjwfH186Z6nvWrA274bIbxV+Wxy2lYeuzCTieJ30bZ5fsdNfS84nSqjsw==
X-Google-Smtp-Source: AGHT+IGCrVtK4L7PTDirdTYJXvfxtKn9rohQ4Tk4LMv0qFVHHzlJem3sttI9iHQ9UAEHLTVL5/A5jQ==
X-Received: by 2002:a05:6808:1520:b0:3e3:e713:b293 with SMTP id 5614622812f47-3e7bc7c6a4cmr4167628b6e.16.1731708058501;
        Fri, 15 Nov 2024 14:00:58 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:00:58 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/8] rmnet: Track link notifications
Date: Fri, 15 Nov 2024 16:00:28 -0600
Message-ID: <20241115220053.49613-3-denkenz@gmail.com>
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

Track link notifications that arrive via RTM_NEWLINK and RTM_DELLINK.
This will be used in the future to try to de-conflict use of RMNet
mux_ids that might have been (unlikely) created by other processes.
---
 src/rmnet.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 52f47a03b27c..920525006e0a 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -27,6 +27,7 @@
 
 static struct l_netlink *rtnl;
 static uint32_t dump_id;
+static uint32_t link_notify_id;
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -193,6 +194,23 @@ static int rmnet_link_dump()
 	return -EIO;
 }
 
+static void rmnet_link_notification(uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	char ifname[IF_NAMESIZE];
+	uint16_t mux_id;
+	uint32_t ifindex;
+
+	if (type != RTM_NEWLINK && type != RTM_DELLINK)
+		return;
+
+	if (rmnet_parse_link(data, len, ifname, &ifindex, &mux_id) < 0)
+		return;
+
+	DBG("link_notification: %s(%u) with mux_id: %u",
+			ifname, ifindex, mux_id);
+}
+
 static int rmnet_init(void)
 {
 	int r;
@@ -207,6 +225,9 @@ static int rmnet_init(void)
 	if (r < 0)
 		goto dump_failed;
 
+	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
+					rmnet_link_notification, NULL, NULL);
+
 	return 0;
 dump_failed:
 	l_netlink_destroy(rtnl);
@@ -215,6 +236,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
 }
 
-- 
2.47.0

