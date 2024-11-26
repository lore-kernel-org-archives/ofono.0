Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A861DFD86
	for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656429; cv=none; b=ibLyF/WClWY4O4FI6/dRu2X6kVao+JmpTU3foVXuZhqD0EbOdCbCHEdPqdC61rhSut9/Ll1CVJw3Je0cWG2o8y6rsO9yjv8sKQviV0qPx1FgftC6+cCUocuVfBqwUMUGt1mo9lqqsNq6KQN1ypkI4ES82Gwec9gLAjxZn5yUYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656429; c=relaxed/simple;
	bh=qPkMt1RJA1voyJmcc0GQrDlEJHEFPDA7zHHrJS2cbsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd4Ka9eEFPtqinhaBzJYX4i4H5J0bQ87+LjikbzVNnAAESLbwo8fPakzWuEiGq2WkAJ5XgBOBzGpyf9LgBzS8nb/R0/92Mv4dZrxUKjvuApZanb9TMpWIBqrEqzFDhP/OQeVIFXNld1dyL/Wj+KBIhcLP2YhL7IvC9i+w8xHO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsrHXqPV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsrHXqPV"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea696c4dcaso491564b6e.2
        for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656427; x=1733261227; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJVR/mMXmTf/tNKq4xATVtT4pHSGBMlppg7bWXf8cRk=;
        b=MsrHXqPVQv+YR8K7PGhjLSMiz1TKdvwv/LaAjf9+qAAcJUwyFF8BkEXXv5MTgTjmmX
         J+b+yXx1Q5P1nbpm8Kwp9qI0PyeKgEuo0RxIKDSWJi/RvlkJQkvy9NYsvBbILhheiGG6
         y0OvexNDjQCMQtANqWDHvljzMMnNGC+pUHEWZhtBhztWBr6jzHX01rV2yjfi0lxesJ4v
         RuA6Pa1plFCkW3zrC2fbAH8Y4M9XzLLxOcuY7MyCrClvCK7OwGU38eOBhvFZswk5lwpl
         QqQhzwZeXOPMhjj4mz3kFMo8dysvTT7e/YAk6R5VmX0PL67a9E0j0S22m/AccSdvppeR
         DOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656427; x=1733261227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJVR/mMXmTf/tNKq4xATVtT4pHSGBMlppg7bWXf8cRk=;
        b=qTKeQTjAZfbxcjgLNdgA2hCvzX/NJgLFKCZJDdGWSVRjBMoudTOzvFbCELUajBHdMx
         2QFpf6fDlBlyCje6i/5VTmWxdz+XfJev5ZI1IUFlOz4aHCzX3kiUKABBKhRySP4zILhu
         JM9hi+bLRk1ZBuQm42M+knLL29RP40AuVRc/H78zyZqx6PViD+pQGxhihy/5tdhiJISb
         yr8YWTgwDLWAcQaPUcejaW7EPrtQTzJre5UjDDvqS1Mq7XPWeJRtrHEIrZT0KR4CkzrV
         4cDXPB7AjK0bcf5ai7s1yQFYm2GkpYMecwyQ99PnyJA9K0cLeTy6+CwHnsni8/j8rDmn
         ISCA==
X-Gm-Message-State: AOJu0YzxsJJgJCrSh+6s48DiAFP+0pvofvfb3zne00Jm9kBnPdZ1NotV
	aU77VvSB60NBS3jMUjeQR6I3m9swZ9j5TtQCC9YTuhC3G1EtfsUeL5Svww==
X-Gm-Gg: ASbGncuAQcCd1F2csggf5crzmBN3cMzK2nuFGNp47iem4UPaHsJozwmvbzD4gMZSzK+
	bVSZmcklwkGcNiJQNmPanzqyrpeTRxHwnGglUBd7r7Y3CFdHXkS7/xF3WBLAww+QlmtlP5ZY8g2
	Lq5JDcAIudUuQJQKJdWNC99UuGaAzVZcAMrJ7C0GALumwwZdRbjrD/lmyNZ/0/uEDdVumiuiol6
	5LzpVyeJlEUyiX+s+ubTurdQtK1LbKwlZ1rokMT/CO6dDSbaMeIqyPCrbnoqyguhKHoO+15mJw6
	BsTQfvzboWCr8mrt66W6oKyT
X-Google-Smtp-Source: AGHT+IGJX6UcK605KpV909XkBY+3BP3q/NePEVvVGdM2tHEzNAGLzV37YvS8WiCVjAbv3RUE1dz7bA==
X-Received: by 2002:a05:6808:1383:b0:3ea:525c:46f8 with SMTP id 5614622812f47-3ea6dc286f1mr1006399b6e.22.1732656426967;
        Tue, 26 Nov 2024 13:27:06 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e835e2sm3177531b6e.13.2024.11.26.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:27:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] rmnet: Default created interfaces to MTU of 1400
Date: Tue, 26 Nov 2024 15:26:16 -0600
Message-ID: <20241126212703.196003-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126212703.196003-1-denkenz@gmail.com>
References: <20241126212703.196003-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the network interface is being created with 16380 byte MTU,
which is excessive for cellular links.  Typically, cellular links use a
maximum MTU of around 1430.  Set the MTU to something more reasonable by
default.

Unfortunately, the kernel does not support setting the MTU value in the
original NEWLINK message.  It must be set separately in a different
transaction.  Add support for this and make sure that cancellation logic
still works.
---
 src/rmnet.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index 83110c33a980..2c000fc33c3c 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -25,6 +25,7 @@
 
 #define RMNET_TYPE "rmnet"
 #define MAX_MUX_IDS 254U
+#define DEFAULT_MTU 1400U
 
 struct rmnet_request {
 	uint32_t parent_ifindex;
@@ -195,19 +196,16 @@ next_request:
 		rmnet_start_next_request();
 }
 
-static void rmnet_new_link_cb(int error, uint16_t type, const void *data,
+static void rmnet_set_mtu_cb(int error, uint16_t type, const void *data,
 					uint32_t len, void *user_data)
 {
 	struct rmnet_request *req = l_queue_peek_head(request_q);
 
-	DBG("NEWLINK %u (%u/%u) complete, error: %d",
-		req->netlink_id, req->current + 1, req->n_interfaces, error);
+	DBG("%u (%u/%u) complete, error: %d",
+		req->netlink_id, req->current, req->n_interfaces, error);
 
 	req->netlink_id = 0;
 
-	if (!error)
-		req->current += 1;
-
 	if (error || req->canceled) {
 		__rmnet_cancel_request();
 		req->n_interfaces = 0;
@@ -229,6 +227,49 @@ next_request:
 		rmnet_start_next_request();
 }
 
+static void rmnet_new_link_cb(int error, uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	struct rmnet_request *req = l_queue_peek_head(request_q);
+	uint32_t ifindex = req->infos[req->current].ifindex;
+
+	DBG("NEWLINK %u (%u/%u) complete, error: %d",
+		req->netlink_id, req->current + 1, req->n_interfaces, error);
+
+	req->netlink_id = 0;
+
+	if (!error)
+		req->current += 1;
+
+	if (error || req->canceled)
+		goto error;
+
+	/*
+	 * Unfortunately the kernel does not take IFLA_MTU into account
+	 * when creating new RMNet links, so this must be done as a separate
+	 * step.  Hopefully this is fixed one day
+	 */
+	error = -EIO;
+	req->netlink_id = l_rtnl_link_set_mtu(rtnl, ifindex, DEFAULT_MTU,
+						rmnet_set_mtu_cb, NULL, NULL);
+	if (req->netlink_id) {
+		DBG("Set MTU: interface: %u/%u, request: %u",
+			req->current, req->n_interfaces, req->netlink_id);
+		return;
+	}
+error:
+	__rmnet_cancel_request();
+	req->n_interfaces = 0;
+	l_queue_pop_head(request_q);
+
+	if (req->new_cb)
+		req->new_cb(error, req->n_interfaces,
+				req->n_interfaces ? req->infos : NULL,
+				req->user_data);
+
+	rmnet_request_free(req);
+}
+
 static void rmnet_start_next_request(void)
 {
 	struct rmnet_request *req = l_queue_peek_head(request_q);
@@ -429,6 +470,7 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 	bool have_linkinfo = false;
 	const char *ifname = NULL;
 	uint16_t ifnamelen = 0;
+	uint32_t mtu = 0;
 	uint16_t rta_type;
 	uint16_t rta_len;
 	const void *rta_data;
@@ -450,10 +492,16 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 
 			have_linkinfo = true;
 			break;
+		case IFLA_MTU:
+			if (rta_len != sizeof(uint32_t))
+				return -EBADMSG;
+
+			mtu = l_get_u32(rta_data);
+			break;
 		}
 	}
 
-	if (!have_linkinfo || !ifname || !ifnamelen)
+	if (!have_linkinfo || !ifname || !ifnamelen || !mtu)
 		return -ENOENT;
 
 	r = rmnet_parse_info_data(&linkinfo, out_mux_id);
@@ -466,6 +514,8 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 	if (out_ifindex)
 		*out_ifindex = ifa->ifa_index;
 
+	l_info("MTU: %u", mtu);
+
 	return 0;
 }
 
@@ -530,14 +580,23 @@ static void update_new_link_ifindex(uint16_t mux_id,
 {
 	struct rmnet_request *req;
 	struct rmnet_ifinfo *info;
+	unsigned int i;
 
 	req = l_queue_peek_head(request_q);
 	if (!req || req->request_type != RTM_NEWLINK)
 		return;
 
-	info = req->infos + req->current;
-	if (info->mux_id == mux_id && !strcmp(info->ifname, ifname))
+	for (i = 0; i < req->n_interfaces; i++) {
+		info = req->infos + i;
+
+		if (info->mux_id != mux_id)
+			continue;
+
+		if (strcmp(info->ifname, ifname))
+			continue;
+
 		info->ifindex = ifindex;
+	}
 }
 
 static void rmnet_link_notification(uint16_t type, const void *data,
-- 
2.47.0

