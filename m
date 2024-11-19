Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BF1D0F49
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036723; cv=none; b=uwl5MT1DpRKc+8WHJyGwPGtIrOZMVuC8B750bhuUaOBX4rbGIukxsoT+jgPW0N5jTVQbTZqxnbjV0nJzYGT0C9NWxt12IQkvhjyguczMu2CscQ17P2AjKiHr8IkdYTxSD6pjyEyFnQjzEGEOfH6Xlbc/0opc5pyDnOCVGDAtFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036723; c=relaxed/simple;
	bh=t77tfj0vF645OCPc5XKqvZlu2OLLv4/IAiO1nhGyk8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNLvGvu4akKUEojMrRj8JtM049ZNOsEYsq+42F8D6qpfA0fyZ13YoPesbtF1Oia2bJ0H4OSycSuQxmJJmsR584X/wQPG8hNZeR9MYHRW01xS5F/ly5GRj+qWaxbORskfHuC56WftoFXxryOizUcoSj2J/Y3iMGUVAFVqP7O8fIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN+RnODT; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN+RnODT"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc349204cso1485015eaf.3
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036721; x=1732641521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBSuJJHyA06W9R05h/LSJE3p1noZng8aPB4QWbPy0Qo=;
        b=kN+RnODTGIbiOO794NLmPQCfmX1szMpN0WVgdvSwsmo2T+ONWO90jedjpvlY6jOU5z
         Bhapbk6Krg6KfvlYaH7lWLHNOMLoTikTpCuE//JUyYSiR/cZcgcyxf07wY6eRbzzwaGL
         BQEEakscSbv+BIeml6lJbfLItYFwU7/YM+U0tP5NI4H5KVDL8+Fga7Muw/21LBkkekLt
         MvWP1g9Qp3hSj6B7x/9IOk8HZOAPdKTYUabJeObEuqLoS53Gm+3QrAOWp4EBvlVvKlxI
         q3zUeCryCEgo2hlZBCtbHF1kgnGXUs+QH+3PA2BnIChDgLHihvcbeRAvarNY5uuXmAXk
         bW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036721; x=1732641521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBSuJJHyA06W9R05h/LSJE3p1noZng8aPB4QWbPy0Qo=;
        b=fOBQT2mnDraa2vGOiqTaC4hm6Uz/ITotCkDdLXS5fLWLk8BufqHrZCuPCa/LcfCa0p
         OilDXqo/tNFaa78bPCRihFxaHJM96Kd32V1iKv7DMUWVwfEajkRCWaXzFo/WiX7aa7zG
         1SDetuRLCqv6KKA5yLzZCzuO74r1wkHAC3X1Hnoff2F+DB6JTrSLfFuMSIsavTlQCmhd
         QcE818lFV0IRSD0+S8PF2B5GrZE1ANW8XRjNpZn049vSWqRX1bcM0U3pbANYupKkfNQi
         pZiMUQgMu4wO27rpdpYkjR0E7lGqHqPCr08mem4QL8JKWEpe9pZgNzMV+nc7jrP9yOCV
         50Lw==
X-Gm-Message-State: AOJu0Yy13tTbSR0jC2cJTa+Ha8pWAxeQpQOH4qHdQTditREzK7q6gbG0
	bW7X8MfzJNuOEq+asMcgtJKMvUJ5jXGdusTaelW6zybMO8MgjJditlJw1A==
X-Google-Smtp-Source: AGHT+IH+GbVpI2I0KwfSg31eIL5XbPpXhO3cQUkUksolYlXSX9AkRGLifcw0jo2j4JuSKaU8fW8e7Q==
X-Received: by 2002:a05:6820:1785:b0:5ee:d89f:1d2c with SMTP id 006d021491bc7-5eed89f2131mr4690554eaf.1.1732036721106;
        Tue, 19 Nov 2024 09:18:41 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:40 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 7/8] rmnet: Implement getting new interfaces
Date: Tue, 19 Nov 2024 11:18:18 -0600
Message-ID: <20241119171832.1119-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119171832.1119-1-denkenz@gmail.com>
References: <20241119171832.1119-1-denkenz@gmail.com>
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
 src/rmnet.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index adbe605effdb..b51ebfd18f65 100644
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
@@ -68,6 +70,19 @@ static struct rmnet_request *__rmnet_del_request_new(unsigned int n_interfaces,
 	return req;
 }
 
+static struct rmnet_request *__rmnet_cancel_request(void)
+{
+	struct rmnet_request *req = l_queue_pop_head(request_q);
+
+	if (req->current) {
+		struct rmnet_request *del_req =
+			__rmnet_del_request_new(req->current, req->infos);
+		l_queue_push_head(request_q, del_req);
+	}
+
+	return req;
+}
+
 static int rmnet_link_del(uint32_t ifindex, l_netlink_command_func_t cb,
 				void *userdata,
 				l_netlink_destroy_func_t destroy,
@@ -96,6 +111,57 @@ static int rmnet_link_del(uint32_t ifindex, l_netlink_command_func_t cb,
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
 static void rmnet_start_next_request(void);
 
 static void rmnet_del_link_cb(int error, uint16_t type, const void *data,
@@ -120,9 +186,45 @@ next_request:
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
+		__rmnet_cancel_request();
+		req->n_interfaces = 0;
+	} else {
+		if (req->current < req->n_interfaces)
+			goto next_request;
+
+		l_queue_pop_head(request_q);
+	}
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
 static void rmnet_start_next_request(void)
 {
 	struct rmnet_request *req = l_queue_peek_head(request_q);
+	uint32_t mux_id;
+	struct rmnet_ifinfo *info;
 
 	if (!req)
 		return;
@@ -137,13 +239,55 @@ static void rmnet_start_next_request(void)
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
@@ -323,6 +467,23 @@ static int rmnet_link_dump(void)
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
@@ -336,9 +497,10 @@ static void rmnet_link_notification(uint16_t type, const void *data,
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

