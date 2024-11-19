Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD301C07D5
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036718; cv=none; b=ljWv1Q2SoMis7CZCWlDT1Ohq7ugaET8GQ75N/Cdr631X7RHAxc6A1a9/ScSwZVa7hmPTbQF8L6ODajryXpIkMlDgzSv8fqLLf/Z215vfz+ipqLpqXgFjywLQ/GvRY1brxVl3SJUzwLjb5t8WD6KxhQqz2rgwYGIbjq9pHQjzw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036718; c=relaxed/simple;
	bh=KjaDqxLZ2kvnLENy9drZVByCv7QBo9FFKux8gvxHbCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZnxrVr+IhTDAJQJNU4vHxgp1k3vpP3x6Wr8RadCfOf/SDvkOQt8BeBrxQK3G2aLO5RmIuzpBz9sCNA/wIJpfItJn51aCyPfsxjKEohdIdl9F9wh0wcTVCuA29RqsOmHjUs3IYcyyZq2kEq/uFf+FCyS05yP4Lra1ZKVWePvnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gekpZBOF; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gekpZBOF"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ee354637b4so698948eaf.3
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036716; x=1732641516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=290KuaM5lStngyLx8qiGP5QT8XuAX4O1/xM7gxJwH6I=;
        b=gekpZBOFxgC0yFnRyp4pUD/q4Q1vc5XhplJNUVRcWl9Ya6btP3dYrbakqstmYIANCv
         4GmaMHWRjaJfLEcl548bv4SwPfxoECw5vdZJYIFwNwwuN7mEiUYzn2XUqzmS7r9Fk34g
         9IkYfZRvdHrqq6C5pO/ampdbvfVD8fHI7rtIhzTjLAcf8eqtWeeA4F+jYXT95OnkF0Jq
         kSEhHSuc/obLeO9nAH7UVxx/zvjngQPwz/j0BaLrb3wvqVsJsa+DKRmrEMg+hF1gfV8X
         bbNKsKRENbDjWPFDtp2l/P4ZIXvQFUYwdvh/WTguglAuyiYiH/J6Xfb/k02tIPEPL+vZ
         5otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036716; x=1732641516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=290KuaM5lStngyLx8qiGP5QT8XuAX4O1/xM7gxJwH6I=;
        b=U6+Ym/YXz+yBziW62nFF5MeJcR9pMqKeMILujgIXPhBD2fEIXo9YoEG3RJ1IbRn6SQ
         0lW8Y5Iui7191T6ggeIBF9IjxGmoz9hRddSx6inzhdCSTGZT+/O+cL27vruw5Jca1fpR
         Z1giUNmU/P++KFn56UW0sSHzkO/gKEbXDNcYeXl7TcYuXRqqZZeuGFEM4I8nKK1sXui6
         R5HujbdvVt64XyC6KcR3aDvRoCSfw9r153sZSqeimTGdO9nuuVDu3Wj+zYgj1TC4A5uQ
         BPvT5VS6CLMxc1+aSiTEogEwcCAXihMs8e1utlq99EZJ6j25SKY/dhL/tT1Cq2VYjhXh
         XEPA==
X-Gm-Message-State: AOJu0YyGjj7fDb0mN5WYXoGaS3/HrsE1iPsGEJHffWpUD8YY8NK57LNS
	dvDrXkUPkAJUc4lKMSmlVj8HNz0L6f9M0nCOn17DUlmLbT84Q7+cPduEOg==
X-Google-Smtp-Source: AGHT+IF5lxe6ORULg+NLNkiuhzjZABZjD1jeyaD3EeDoTwfSzmamMIumEh6HSbmkZ1qKwQPsgR8Mzw==
X-Received: by 2002:a05:6820:4c09:b0:5ec:72be:25e0 with SMTP id 006d021491bc7-5eeab422193mr13852490eaf.5.1732036716124;
        Tue, 19 Nov 2024 09:18:36 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:35 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/8] rmnet: Add logic to dump out RMNet interfaces
Date: Tue, 19 Nov 2024 11:18:13 -0600
Message-ID: <20241119171832.1119-2-denkenz@gmail.com>
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

This logic is triggered at startup to dump RMNet only links.  This is
accomplished by using RTM_GETLINK dump with a filter based on
IFLA_LINKINFO attribute setup for IFLA_INFO_KIND being "rmnet".

For now, links are simply printed and not acted upon.
---
 src/rmnet.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/src/rmnet.c b/src/rmnet.c
index 58f841a49a59..325f1c503ca9 100644
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
+static int rmnet_link_dump(void)
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

