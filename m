Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04B1E1C1A
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708061; cv=none; b=ona90bPgloUN3Q/X/Pi+PJgjWoxRNXR/uZUqIOWHnn3evEqTSY6p8nmWUlUodwS+QO6PfCkz/dHArLMr47mWTpnhgpLhlzIWkvOxz0KaamsrOp3/KQ4GPh+KH0HUEeh/95hKf2wZsCnPYBaXxy91G87SUHjH/G//R6GVYRBfFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708061; c=relaxed/simple;
	bh=wbcKLV/018BZ9/D+Mvk0vpozH+SVVnAbvny9zGKhZh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C68+TJY/ihHU+NN8zHryDKxiWObuwutjWrQ9BoxV+bg6g6gp4qcwXfpiM+QxQ1OZnbuqgXzBzGR/kwLOWtNDzLT/V5C+I+jS4tm5PBeIFHgz04BLYyA1rxRwTCmc9DrepRIr/iK50oGMgvx7cFRXpappSgd2uX32U8Doo2u2zYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7d/jSrz; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7d/jSrz"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e60e57a322so1279536b6e.3
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708057; x=1732312857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP6czIhnJ5P0HljULdD+C+9TEwzs31YC5RIioRSmfn0=;
        b=d7d/jSrzSord5ihXSWLWwEFtlXZ5APLqt8ZU30nqYu3C4oovU5eNMQgaDGK6/ogKW6
         c6JufYKnpqG9BNNq3rzouCgP32NhaonsimM0ICCLxT4wN2rq88u07rqp6xBwTNPLqK6G
         MBFzuvs9jc0MHLdjl31y0o6l6/AcPPNbOdrME4Xmvfexa2l5bFj6m4plAn+l2onS8CfR
         ru7qOVMh0b6jP5SPQrG+v0sLnKwA1PhWffGtGxMOJ2QA4gQnRhJEkNtaEOV+FQ7gMXoM
         FtnKDpccmE/+2O4Ri+A5rlWlfSKpnYieJ0BK56AIxJc/PqLFfE628PNa6iYqIHiXpitI
         FPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708057; x=1732312857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP6czIhnJ5P0HljULdD+C+9TEwzs31YC5RIioRSmfn0=;
        b=op5m+trfhhKJPWm4TZ8JTfpQ+6mUhz32Az/ums7mDLtNaycbxIqPcQVOPodD3PKXN7
         4Fmq/5dVOdk4hfaG7/l5xddfSF3bryuZYkMDbkYGrsh33EH/exRBa1w62xo2aYab7m9R
         c2N9pVm4xB5rJGgI0+5CZAciVMgclLDTG+BgBQOiTU27ez2yE38tbGqB16j/6VeOqAOA
         oLOYYNlqSEN9lw7+7UHpH3r8vVWPrjNcucZ7UmXET+UHFYVALSPiLkABVk0WBmwOb6/H
         O6GiUwUyoOrqjQQharWK9yMdcFtS8ooQ+gxaiP44uk6YLISc6gyZa75m05wFPXIUwTGZ
         +96A==
X-Gm-Message-State: AOJu0YwpX9vhsbApO21luUg12WJXwhmqMeGeykr5IWgEltp7lrQmFGBr
	+uK7NMHm5spWlqlHF8EO31QaxNjNgsHAjefwm62i1wh20O60XxJwtgbe0Q==
X-Google-Smtp-Source: AGHT+IFYcVEYjZKQLPHJZuzA1XREUymi4xymAehDq3hilAFj8GHX+05agb9zofImh4E8FPxWcJuCuw==
X-Received: by 2002:a05:6808:1496:b0:3e6:cdc:2288 with SMTP id 5614622812f47-3e7bc85dc56mr5600553b6e.31.1731708057521;
        Fri, 15 Nov 2024 14:00:57 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:00:57 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/8] rmnet: Add logic to dump out RMNet interfaces
Date: Fri, 15 Nov 2024 16:00:27 -0600
Message-ID: <20241115220053.49613-2-denkenz@gmail.com>
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

This logic is triggered at startup to dump RMNet only links.  This is
accomplished by using RTM_GETLINK dump with a filter based on
IFLA_LINKINFO attribute setup for IFLA_INFO_KIND being "rmnet".

For now, links are simply printed and not acted upon.
---
 src/rmnet.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 58f841a49a59..52f47a03b27c 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -14,13 +14,19 @@
 #include <unistd.h>
 #include <linux/rtnetlink.h>
 #include <net/if.h>
+#include <linux/if_link.h>
+#include <linux/if_arp.h>
 
 #include <ell/ell.h>
 
 #include "ofono.h"
 #include "rmnet.h"
 
+#define RMNET_TYPE "rmnet"
+#define MAX_MUX_IDS 254U
+
 static struct l_netlink *rtnl;
+static uint32_t dump_id;
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -40,15 +46,171 @@ int rmnet_cancel(int id)
 	return -ENOTSUP;
 }
 
+static int rmnet_parse_info_data(struct l_netlink_attr *linkinfo,
+					uint16_t *out_mux_id)
+{
+	struct l_netlink_attr info_data;
+	bool have_info_data = false;
+	uint16_t rta_type;
+	uint16_t rta_len;
+	const void *rta_data;
+	uint16_t mux_id;
+
+	while (!l_netlink_attr_next(linkinfo, &rta_type, &rta_len, &rta_data)) {
+		switch (rta_type) {
+		case IFLA_INFO_KIND:
+			if (strncmp(rta_data, RMNET_TYPE, rta_len))
+				return -EPROTOTYPE;
+
+			break;
+		case IFLA_INFO_DATA:
+			if (l_netlink_attr_recurse(linkinfo, &info_data) < 0)
+				return -EBADMSG;
+
+			have_info_data = true;
+			break;
+		}
+	}
+
+	if (!have_info_data)
+		return -ENOENT;
+
+	while (!l_netlink_attr_next(&info_data,
+					&rta_type, &rta_len, &rta_data)) {
+		if (rta_type != IFLA_RMNET_MUX_ID)
+			continue;
+
+		if (rta_len != sizeof(uint16_t))
+			return -EBADMSG;
+
+		mux_id = l_get_u16(rta_data);
+		if (mux_id > MAX_MUX_IDS || !mux_id)
+			return -ERANGE;
+
+		if (out_mux_id)
+			*out_mux_id = mux_id;
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int rmnet_parse_link(const void *data, uint32_t len,
+				char *out_ifname,
+				uint32_t *out_ifindex,
+				uint16_t *out_mux_id)
+{
+	const struct ifaddrmsg *ifa = data;
+	struct l_netlink_attr attr;
+	struct l_netlink_attr linkinfo;
+	bool have_linkinfo = false;
+	const char *ifname = NULL;
+	uint16_t ifnamelen = 0;
+	uint16_t rta_type;
+	uint16_t rta_len;
+	const void *rta_data;
+	int r;
+
+	if (l_netlink_attr_init(&attr, sizeof(struct ifinfomsg),
+							data, len) < 0)
+		return -EBADMSG;
+
+	while (!l_netlink_attr_next(&attr, &rta_type, &rta_len, &rta_data)) {
+		switch (rta_type) {
+		case IFLA_IFNAME:
+			ifname = rta_data;
+			ifnamelen = rta_len;
+			break;
+		case IFLA_LINKINFO:
+			if (l_netlink_attr_recurse(&attr, &linkinfo) < 0)
+				return -EBADMSG;
+
+			have_linkinfo = true;
+			break;
+		}
+	}
+
+	if (!have_linkinfo || !ifname || !ifnamelen)
+		return -ENOENT;
+
+	r = rmnet_parse_info_data(&linkinfo, out_mux_id);
+	if (r < 0)
+		return r;
+
+	if (out_ifname)
+		l_strlcpy(out_ifname, ifname, MIN(ifnamelen + 1, IF_NAMESIZE));
+
+	if (out_ifindex)
+		*out_ifindex = ifa->ifa_index;
+
+	return 0;
+}
+
+static void rmnet_link_dump_destroy(void *user_data)
+{
+	dump_id = 0;
+}
+
+static void rmnet_link_dump_cb(int error,
+				uint16_t type, const void *data,
+				uint32_t len, void *user_data)
+{
+	struct rmnet_ifinfo info;
+
+	/* Check conditions that can't happen on a dump */
+	if (error || type != RTM_NEWLINK)
+		return;
+
+	if (rmnet_parse_link(data, len,
+				info.ifname, &info.ifindex, &info.mux_id) < 0)
+		return;
+
+	DBG("Existing rmnet link: %s(%u) mux_id: %u",
+			info.ifname, info.ifindex, info.mux_id);
+}
+
+static int rmnet_link_dump()
+{
+	struct ifinfomsg ifi;
+	struct l_netlink_message *nlm =
+		l_netlink_message_new_sized(RTM_GETLINK, NLM_F_DUMP,
+								sizeof(ifi));
+
+	memset(&ifi, 0, sizeof(ifi));
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
+
+	l_netlink_message_enter_nested(nlm, IFLA_LINKINFO);
+	l_netlink_message_append_string(nlm, IFLA_INFO_KIND, RMNET_TYPE);
+	l_netlink_message_leave_nested(nlm);
+
+	dump_id = l_netlink_send(rtnl, nlm, rmnet_link_dump_cb, NULL,
+				rmnet_link_dump_destroy);
+	if (dump_id > 0)
+		return 0;
+
+	l_netlink_message_unref(nlm);
+	return -EIO;
+}
+
 static int rmnet_init(void)
 {
+	int r;
+
 	DBG("");
 
 	rtnl = l_netlink_new(NETLINK_ROUTE);
 	if (!rtnl)
 		return -EIO;
 
+	r = rmnet_link_dump();
+	if (r < 0)
+		goto dump_failed;
+
 	return 0;
+dump_failed:
+	l_netlink_destroy(rtnl);
+	return r;
 }
 
 static void rmnet_exit(void)
-- 
2.47.0

