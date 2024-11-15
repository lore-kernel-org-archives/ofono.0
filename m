Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD571FAC57
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708064; cv=none; b=f5YLCu+4uWvKUlJL/o1EOvFyBIeNnxYLBMg02VB1keql7AIuNrWvvEBK4oj6e2RqHhWxPAjIljA7W3WGADIQ+SMNZd977bpmGNzNSzQrXicg3eaX+VGa71MNapFNrgBxTlYc/29CrUhopdreyMuagOYfuWxYHwPYSCyDAhXufd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708064; c=relaxed/simple;
	bh=kSdoFCvRzXJbMLUgkuK4dyuuiNLeT7O23qGOYDVpynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxBN2q3wwnV3JwzhpfcsKJRxQ8hb5QVlwDrKeC9gg35LmxvQAOKoeyFX6pR+DpCxXofAtIsNaHt8A9bmQGhLPXdZM6uDwEhTaafkXAMVhfm6GNpf2iBECUT36tuSjkQPcHNtHnBmDeQ5+I2FTGivkFQZ2LItCpXLLX+Fr6QURVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+kDg4nB; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+kDg4nB"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e6005781c0so1259193b6e.3
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708062; x=1732312862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=355cQRWSPtDUmYLFtUtJsbcKqU4be5VTXENQGfFIUYA=;
        b=b+kDg4nBMdIJni9GoBx0ZvRIuxWAVzQNInGtLAyzjFc7EwQ/OtVYc6SWnP9aRa75qX
         4lLqztvojlLXBEd9XBrxNt8MQow5qfiZeJbpf8NNBNG0bVO7e/cGSOgAumeEO39vAQ75
         /dw83AfzwMuJQV1HOowwT5SeSLYKfegc39ZRAT6JAFzTG+DZ7WNAMxEYTKdEoq1/5PJL
         H0u4DnaZIrh/F5j3WEfZbC00AdBFoXSRjMzr5CjkkWhYYaUMqirpo0nnLF3+hrhY2542
         LPLefi4quhqH7qA9jicb5H/aRcRW1pSuh5L9sbOz7dfO78N7MwjoPnhZzrNugLx/fzPy
         DRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708062; x=1732312862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=355cQRWSPtDUmYLFtUtJsbcKqU4be5VTXENQGfFIUYA=;
        b=hhkE/EsVMOLVJIGDVu6ZS8eIFgXqxshfbcDZykfklzyALXE96OObSXA+7agZU+xIUK
         9VnTL9dtms8WBAuQmsbwJroXPaSu+QO8iz84lQ343L+zJAw7K3Ic5mGIvidxNwUjvVRO
         n+WxvqJ/RNgHDr4svLuWCfBSYzaLdt6uq8dzNGV+ZH5/oTN1IGZIS7b+gy4ve6uKo9mi
         vDwD3hJBm69ZO4XXGtVusv9uCh4sojJARs2k5JhjiuZMqaZy5Ln+Nm9np5ToMFjK0vE0
         fWvZ02MY9AfjegUVzLnz+4emOEQmQrTTG4FxWljxCqptzjxWlXrZVWQZYOaNTGDf1ooJ
         yl9g==
X-Gm-Message-State: AOJu0YyJDeQVxwX1RgpRRLq7RkP/X8Z3JjvY/Ab6wKuAdD8iYwk7H81Z
	8XmGppomksoCyn5k2mPv+Rx1lsoOuA7hvOZpajSNCZ74CQvIUJxjmtgKoQ==
X-Google-Smtp-Source: AGHT+IGrLIqF3Dpy97cdyQIJOqntz11ozlmYF7JmEPHi3r9MdAh0R4yrAMbRMsx+OdEllyzytprR0g==
X-Received: by 2002:a05:6808:14cc:b0:3e6:6203:fb5e with SMTP id 5614622812f47-3e7bc79ceb3mr4765878b6e.2.1731708062093;
        Fri, 15 Nov 2024 14:01:02 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:01:01 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/8] rmnet: Implement getting new interfaces
Date: Fri, 15 Nov 2024 16:00:32 -0600
Message-ID: <20241115220053.49613-7-denkenz@gmail.com>
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

Add method to create N rmnet interfaces for use by the gobi driver.  The
rmnet interfaces are created in sequence, which should result in
sequential mux ids and interface names to be created (assuming no other
process creates rmnet interfaces in the background).

For now we hardcode the use of QMAPv5 as the aggregation protocol using
EGRESS_MAP_CHKSUMV5 and INGRESS_MAP_CHKSUMV5.  Support for QMAPv4 or
QMAP is also possible in the future, but no devices are currently
available for testing.
---
 src/rmnet.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 3 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index ed2fc6bcfdfd..4a921b330b72 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -12,6 +12,7 @@
 #include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
+#include <stdio.h>
 #include <linux/rtnetlink.h>
 #include <net/if.h>
 #include <linux/if_link.h>
@@ -43,6 +44,7 @@ static uint32_t dump_id;
 static uint32_t link_notify_id;
 static struct l_uintset *mux_ids;
 struct l_queue *request_q;
+static int next_request_id = 1;
 
 static void rmnet_request_free(struct rmnet_request *req)
 {
@@ -95,6 +97,57 @@ static int rmnet_link_del(uint32_t ifindex, l_netlink_command_func_t cb,
 	return 0;
 }
 
+static int rmnet_link_new(uint32_t parent_ifindex, uint8_t mux_id,
+				const char ifname[static IF_NAMESIZE],
+				l_netlink_command_func_t cb,
+				void *userdata,
+				l_netlink_destroy_func_t destroy,
+				uint32_t *out_command_id)
+{
+	struct ifinfomsg ifi;
+	struct l_netlink_message *nlm =
+		l_netlink_message_new(RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE);
+	struct ifla_rmnet_flags flags;
+	uint32_t id;
+
+	memset(&ifi, 0, sizeof(ifi));
+	ifi.ifi_family = AF_UNSPEC;
+	ifi.ifi_type = ARPHRD_RAWIP;
+	ifi.ifi_flags = 0;
+	ifi.ifi_change = 0xFFFFFFFF;
+
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
+	l_netlink_message_append_u32(nlm, IFLA_LINK, parent_ifindex);
+	l_netlink_message_append_string(nlm, IFLA_IFNAME, ifname);
+
+	l_netlink_message_enter_nested(nlm, IFLA_LINKINFO);
+	l_netlink_message_append_string(nlm, IFLA_INFO_KIND, RMNET_TYPE);
+	l_netlink_message_enter_nested(nlm, IFLA_INFO_DATA);
+	l_netlink_message_append_u16(nlm, IFLA_RMNET_MUX_ID, mux_id);
+	flags.flags = RMNET_FLAGS_INGRESS_DEAGGREGATION |
+			RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
+			RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
+	flags.mask = RMNET_FLAGS_EGRESS_MAP_CKSUMV4 |
+			RMNET_FLAGS_INGRESS_MAP_CKSUMV4 |
+			RMNET_FLAGS_EGRESS_MAP_CKSUMV5 |
+			RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
+			RMNET_FLAGS_INGRESS_DEAGGREGATION;
+	l_netlink_message_append(nlm, IFLA_RMNET_FLAGS, &flags, sizeof(flags));
+	l_netlink_message_leave_nested(nlm);
+	l_netlink_message_leave_nested(nlm);
+
+	id = l_netlink_send(rtnl, nlm, cb, userdata, destroy);
+	if (!id) {
+		l_netlink_message_unref(nlm);
+		return -EIO;
+	}
+
+	if (out_command_id)
+		*out_command_id = id;
+
+	return 0;
+}
+
 static void rmnet_start_next_request();
 
 static void rmnet_del_link_cb(int error, uint16_t type, const void *data,
@@ -119,9 +172,54 @@ next_request:
 		rmnet_start_next_request();
 }
 
+static void rmnet_new_link_cb(int error, uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	struct rmnet_request *req = l_queue_peek_head(request_q);
+
+	DBG("NEWLINK %u (%u/%u) complete, error: %d",
+		req->netlink_id, req->current + 1, req->n_interfaces, error);
+
+	req->netlink_id = 0;
+
+	if (!error)
+		req->current += 1;
+
+	if (error) {
+		if (req->current > 0) {
+			struct rmnet_request *del_req =
+				__rmnet_del_request_new(req->current,
+								req->infos);
+
+			l_queue_push_head(request_q, del_req);
+		}
+
+		req->n_interfaces = 0;
+		goto finish_request;
+	}
+
+	if (req->current < req->n_interfaces)
+		goto next_request;
+
+finish_request:
+	l_queue_pop_head(request_q);
+
+	if (req->new_cb)
+		req->new_cb(error, req->n_interfaces,
+				req->n_interfaces ? req->infos : NULL,
+				req->user_data);
+
+	rmnet_request_free(req);
+next_request:
+	if (l_queue_length(request_q) > 0)
+		rmnet_start_next_request();
+}
+
 static void rmnet_start_next_request()
 {
 	struct rmnet_request *req = l_queue_peek_head(request_q);
+	uint32_t mux_id;
+	struct rmnet_ifinfo *info;
 
 	if (!req)
 		return;
@@ -136,13 +234,55 @@ static void rmnet_start_next_request()
 				req->n_interfaces, req->netlink_id);
 		return;
 	}
+
+	info = req->infos + req->current;
+	mux_id = l_uintset_find_unused_min(mux_ids);
+	info->mux_id = mux_id;
+	sprintf(info->ifname, RMNET_TYPE"%u", mux_id - 1);
+
+	L_WARN_ON(rmnet_link_new(req->parent_ifindex, mux_id, info->ifname,
+					rmnet_new_link_cb, NULL, NULL,
+					&req->netlink_id) < 0);
+
+	DBG("Start NEWLINK: parent: %u, interface: %u/%u, request: %u",
+			req->parent_ifindex, req->current + 1,
+			req->n_interfaces, req->netlink_id);
 }
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
 				void *user_data, rmnet_destroy_func_t destroy)
 {
-	return -ENOTSUP;
+	struct rmnet_request *req;
+
+	if (!n_interfaces || n_interfaces > MAX_MUX_IDS)
+		return -EINVAL;
+
+	if (l_uintset_size(mux_ids) > MAX_MUX_IDS - n_interfaces)
+		return -ENOSPC;
+
+	req = l_malloc(sizeof(struct rmnet_request) +
+				sizeof(struct rmnet_ifinfo) * n_interfaces);
+	req->parent_ifindex = parent_ifindex;
+	req->new_cb = cb;
+	req->user_data = user_data;
+	req->destroy = destroy;
+	req->id = next_request_id++;
+	req->request_type = RTM_NEWLINK;
+	req->netlink_id = 0;
+	req->current = 0;
+	req->n_interfaces = n_interfaces;
+	memset(req->infos, 0, sizeof(struct rmnet_ifinfo) * n_interfaces);
+
+	if (next_request_id < 0)
+		next_request_id = 1;
+
+	l_queue_push_tail(request_q, req);
+
+	if (l_queue_length(request_q) == 1 && !dump_id)
+		rmnet_start_next_request();
+
+	return req->id;
 }
 
 int rmnet_del_interfaces(unsigned int n_interfaces,
@@ -322,6 +462,23 @@ static int rmnet_link_dump()
 	return -EIO;
 }
 
+/* For NEW_LINK requests, the ifindex comes in the multicast message */
+static void update_new_link_ifindex(uint16_t mux_id,
+					const char ifname[static IF_NAMESIZE],
+					uint32_t ifindex)
+{
+	struct rmnet_request *req;
+	struct rmnet_ifinfo *info;
+
+	req = l_queue_peek_head(request_q);
+	if (!req || req->request_type != RTM_NEWLINK)
+		return;
+
+	info = req->infos + req->current;
+	if (info->mux_id == mux_id && !strcmp(info->ifname, ifname))
+		info->ifindex = ifindex;
+}
+
 static void rmnet_link_notification(uint16_t type, const void *data,
 					uint32_t len, void *user_data)
 {
@@ -335,9 +492,10 @@ static void rmnet_link_notification(uint16_t type, const void *data,
 	if (rmnet_parse_link(data, len, ifname, &ifindex, &mux_id) < 0)
 		return;
 
-	if (type == RTM_NEWLINK)
+	if (type == RTM_NEWLINK) {
 		l_uintset_put(mux_ids, mux_id);
-	else
+		update_new_link_ifindex(mux_id, ifname, ifindex);
+	} else
 		l_uintset_take(mux_ids, mux_id);
 
 	DBG("link_notification: %s(%u) with mux_id: %u",
-- 
2.47.0

