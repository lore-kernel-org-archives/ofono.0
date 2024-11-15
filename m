Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA61E0E0C
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708062; cv=none; b=jAeTrzL/weCaaUYeRToVE5bktjxwPoi2hfuUThFdxXHA5vR4WMDWs+LqeSEiyWDmrKZVmS15faryDaNR5QT33o3oI4qVaBwBEpeIVDoBFE+LTq2+xpymhhTL0ZVc0WPPpDRslTrqzeOQIhs33EQzh/7ouqldauInARWH4WFteqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708062; c=relaxed/simple;
	bh=x9VBbmJBxjMr69p1fANWE89ficpFFP7PaAODDhjBeWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slkBCz2iK5rG1+r4Nm1qRKCy/swOc4LfgrHWickpdAPdwnI7P8/XtISpxwg4OSVdYPAPk5Jh5tb7sl9OQNoY3IuUPXuj/Vjwpnofw7v1yXd2uUnBhgyKcaPSmp/0sR4ZmMEbUeZPw3ud0NF/wro1KlqVxXufzhb2lF9RaEPphUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIht1lCb; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIht1lCb"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e602a73ba1so710691b6e.2
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708060; x=1732312860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUL0Kx++Pj9Tfylq5J60SQMHiOefPlFV+N1FQtLLg+s=;
        b=iIht1lCbj4cyUzhL+T27QEQYMGcxBXtyF58H78Qoqm6GorMDcP05W/HoakYH3swTbl
         zJHi6/bSDEs0Xxs6i+e9bFeWlLA+/Pb6OEsX28vPdGCwtH4lCZAHIrRtoywq1CrzWlqJ
         gL8qdTIErYTVmUQTHMounT2oxt6A9IyZBKInSg1PblHJKgC3V0pQwod4Uqb3sB6pJVFg
         fSsJ0rGdJITiPCv1oGNwsX5U1WxR82PGGPeNQq2qqqYxXbreVMfUn4LD95Icgk+o4jq6
         hHMS6j15XWNIDIuIrh2OsCCm27jd09X/ZFpblfffNxNkXVl3M4RpxKDZ7RkXp7OJAKUJ
         E+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708060; x=1732312860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUL0Kx++Pj9Tfylq5J60SQMHiOefPlFV+N1FQtLLg+s=;
        b=KR/HO9o9+SGRgXdlYqucveNeo75QsvrJ3vukZi9a//fVdvSYKYmOKsJm1Il9rACHH3
         cxN1hTyxj3WcXGsG6hrR0yTT346xiZpPfByMiSp8rk1cTU+KRe2i3fruNDN4FAjgtvfB
         mcQ3OtKkuDcbanFmOFOFIUx4xqasrTsd81LIRqRcz0Eo1Wl/6T1XU4K6+eNVk0jRX9uv
         mCoKGpTCvFleSWtVUddSgcXO9QFasJzDL3wcIzSnF25DSqx1r3j1ogyFYrqmXajbO9qu
         n9mI0edwf2vZ9Dy2nERI54qGBbSE65ZatXN0UzNDd5UXGBcVKIfuFy0MfbCHfWD7l3oi
         O4GA==
X-Gm-Message-State: AOJu0Yztoyqx+IWbvdCm34LyHIODrZNfL3MFsQ4di7Ri5sqo070KdWw1
	2uZFjQ60ffG+ajlCMDssl8zQwjs8BhGbA1R2EYGSYD/lssloxdR6wa/axg==
X-Google-Smtp-Source: AGHT+IFgffhKxbaONWidKgGV5qf5Fl32tVqSLnJKjLb2JWrqXj+3QRUdQKRjB+/IbfbuLMHVNyC4PA==
X-Received: by 2002:a54:4602:0:b0:3e7:bcab:8f0b with SMTP id 5614622812f47-3e7bcab8f8cmr3872788b6e.24.1731708060234;
        Fri, 15 Nov 2024 14:01:00 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:00:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/8] rmnet: Delete stale RMnet links at startup
Date: Fri, 15 Nov 2024 16:00:30 -0600
Message-ID: <20241115220053.49613-5-denkenz@gmail.com>
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

Most likely such links could be left over from ofono not exiting
cleanly.  There's unfortunately no easy way to mark links as belonging
to a particular process, so remove all of them.
---
 src/rmnet.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index f784e5cc4bb2..bb5a2ed1805b 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -25,10 +25,118 @@
 #define RMNET_TYPE "rmnet"
 #define MAX_MUX_IDS 254U
 
+struct rmnet_request {
+	uint32_t parent_ifindex;
+	rmnet_new_interfaces_func_t new_cb;
+	void *user_data;
+	rmnet_destroy_func_t destroy;
+	int id;
+	uint32_t netlink_id;
+	uint16_t request_type;
+	uint8_t current;
+	uint8_t n_interfaces;
+	struct rmnet_ifinfo infos[];
+};
+
 static struct l_netlink *rtnl;
 static uint32_t dump_id;
 static uint32_t link_notify_id;
 static struct l_uintset *mux_ids;
+struct l_queue *request_q;
+
+static void rmnet_request_free(struct rmnet_request *req)
+{
+	if (req->destroy)
+		req->destroy(req->user_data);
+
+	l_free(req);
+}
+
+static struct rmnet_request *__rmnet_del_request_new(unsigned int n_interfaces,
+					const struct rmnet_ifinfo *interfaces)
+{
+	struct rmnet_request *req;
+
+	req = l_malloc(sizeof(struct rmnet_request) +
+				sizeof(struct rmnet_ifinfo) * n_interfaces);
+	memset(req, 0, sizeof(struct rmnet_request));
+	req->request_type = RTM_DELLINK;
+	req->n_interfaces = n_interfaces;
+	memcpy(req->infos, interfaces,
+			sizeof(struct rmnet_ifinfo) * n_interfaces);
+
+	return req;
+}
+
+static int rmnet_link_del(uint32_t ifindex, l_netlink_command_func_t cb,
+				void *userdata, l_netlink_destroy_func_t destroy,
+				uint32_t *out_command_id)
+{
+	struct l_netlink_message *nlm =
+		l_netlink_message_new(RTM_DELLINK, 0);
+	struct ifinfomsg ifi;
+	uint32_t id;
+
+	memset(&ifi, 0, sizeof(ifi));
+	ifi.ifi_family = AF_UNSPEC;
+	ifi.ifi_index = ifindex;
+
+	l_netlink_message_add_header(nlm, &ifi, sizeof(ifi));
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
+static void rmnet_start_next_request();
+
+static void rmnet_del_link_cb(int error, uint16_t type, const void *data,
+					uint32_t len, void *user_data)
+{
+	struct rmnet_request *req = l_queue_peek_head(request_q);
+
+	DBG("DELLINK %u (%u/%u) complete, error: %d",
+		req->netlink_id, req->current, req->n_interfaces, error);
+
+	req->netlink_id = 0;
+	req->current += 1;
+
+	if (req->current < req->n_interfaces)
+		goto next_request;
+
+	l_queue_pop_head(request_q);
+	rmnet_request_free(req);
+
+next_request:
+	if (l_queue_length(request_q) > 0)
+		rmnet_start_next_request();
+}
+
+static void rmnet_start_next_request()
+{
+	struct rmnet_request *req = l_queue_peek_head(request_q);
+
+	if (!req)
+		return;
+
+	if (req->request_type == RTM_DELLINK) {
+		uint32_t ifindex = req->infos[req->current].ifindex;
+
+		L_WARN_ON(rmnet_link_del(ifindex, rmnet_del_link_cb, NULL, NULL,
+					&req->netlink_id) < 0);
+		DBG("Start DELLINK: ifindex: %u, interface: %u/%u, request: %u",
+				ifindex, req->current,
+				req->n_interfaces, req->netlink_id);
+		return;
+	}
+}
 
 int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 				rmnet_new_interfaces_func_t cb,
@@ -152,6 +260,9 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 static void rmnet_link_dump_destroy(void *user_data)
 {
 	dump_id = 0;
+
+	if (l_queue_length(request_q) > 0)
+		rmnet_start_next_request();
 }
 
 static void rmnet_link_dump_cb(int error,
@@ -159,6 +270,7 @@ static void rmnet_link_dump_cb(int error,
 				uint32_t len, void *user_data)
 {
 	struct rmnet_ifinfo info;
+	struct rmnet_request *req;
 
 	/* Check conditions that can't happen on a dump */
 	if (error || type != RTM_NEWLINK)
@@ -168,9 +280,12 @@ static void rmnet_link_dump_cb(int error,
 				info.ifname, &info.ifindex, &info.mux_id) < 0)
 		return;
 
-	DBG("Existing rmnet link: %s(%u) mux_id: %u",
+	DBG("Removing existing rmnet link: %s(%u) mux_id: %u",
 			info.ifname, info.ifindex, info.mux_id);
 	l_uintset_put(mux_ids, info.mux_id);
+
+	req = __rmnet_del_request_new(1, &info);
+	l_queue_push_tail(request_q, req);
 }
 
 static int rmnet_link_dump()
@@ -235,6 +350,7 @@ static int rmnet_init(void)
 	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
 					rmnet_link_notification, NULL, NULL);
 	mux_ids = l_uintset_new_from_range(1, MAX_MUX_IDS);
+	request_q = l_queue_new();
 
 	return 0;
 dump_failed:
@@ -244,6 +360,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_queue_destroy(request_q, (l_queue_destroy_func_t) rmnet_request_free);
 	l_uintset_free(mux_ids);
 	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
-- 
2.47.0

