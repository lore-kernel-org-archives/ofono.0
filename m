Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA01D0F49
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036721; cv=none; b=lupSUvk4GtgWv68mbQGl5mywBYTQ0WSBasxXdI4Cavy766jEK+easp+doYAaxl41H5C41OB4rnAuCnhbQM+MR5n7LUxH6usrLCE0ya1W1l7lB0DhOqLkc3Nl7l3tnOF8L+HdXq2Ei507b88lm3zlJwUP4dxH+SdMzDefCkCFoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036721; c=relaxed/simple;
	bh=tIRExgsTCug/FAficn+ug9Kg+M4pNyQKEQk06YsZ+QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFL+QcPpjTU6QW3H/9p03e4GoMyQD5Aj2ZahDgnBiBoqb56Z+eutCmY5/GaF8jTRJ69JYCkPbWAUtJt9xeD2QsZXAAxutK4jpZcUYlP+k51MU4p3DDfhQomlvWsxOtiZmgmUYxQRh5yG+XagCXkBAmPMVOg1JQZX9N1srVUZcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2VawLAK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2VawLAK"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee645cf763so2874024eaf.2
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036719; x=1732641519; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmU66ukH50aNpB1cchpPwP74sAdwXN/lSZlAzR2W+LM=;
        b=i2VawLAKh5ZhrqYeDOTxNWr3MFyB1W5hFSy8aDdu110PpLNZVzwCCo+PsFB1QCjLOb
         JGE/Z+2F8hbTOm5UnTN9kodfZ/xTYOrFAAYTz2Co593bthFpBnpPXTkrCd4fNUZ3tunV
         tBTfg3CCKNQB2fPU/9TYrf6TR+qcg1uPoibxnha7XltdzftAyYDw33IWE9ShL+apJTAC
         hOySuZSUzfKnytd6o3gJ/fO5zOSZ91S1/I0eSz3b9dSK0udE6ltKh7sHOXPsnv9ERFub
         bYyR1AgsC3Qwgdrs4VqdH+W/3puXJ9sIziU2pp4poaQUc0ybWheucMzbqhx7V1aOygaq
         DrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036719; x=1732641519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmU66ukH50aNpB1cchpPwP74sAdwXN/lSZlAzR2W+LM=;
        b=M5fDsXx0anJWxzaN+CJZPzYDHH7PZMSxiB7BXcEUliNaLRZ91yvle2JJTyO1eKOvNO
         PrA+MdUb3fN+kSWLc3NzVkVtd6AvqfUu1W1eqfsau+Q5APsxhe38PSY+1JKrjB7cDulK
         YYldrgkjX2FRROw7+ZoM8qR9lYOgnuCvIdJ/aXeMVZknu7WH6Fvqk0LT9BFJ6f8tmZQL
         L6fT5GdHAcvMvSKYFJi8iL3bQ9t6R7K7oJ77DSxsR2NvDf8i2glNkvyMfzn0pFLgHjP1
         olerqvXRDIn7tONYfzUmLqnnqFeHgV11EBFCUV+8SfwOYmX0WBRWCtn+aUz1RYKV8oeH
         rPwg==
X-Gm-Message-State: AOJu0Ywf7km3SypjinTneRFBn4lhZ0reoFzFbsc/wepWXvrvg6PCWBeJ
	QUXx4ax5gCqOxRsNRkHG9pPoex3mjrRNQzsi+Wq1jEEQKIGw8Kp+AnOl9w==
X-Google-Smtp-Source: AGHT+IHsqQz6hcqIKo3kyo5ZzTXTkR0InyDmT0uQlm47TEGc2za4CTq/+KgzYqqigyKn7EuXiT6V5A==
X-Received: by 2002:a05:6820:1a0a:b0:5ec:c22c:72db with SMTP id 006d021491bc7-5eeab29e337mr15342999eaf.2.1732036719227;
        Tue, 19 Nov 2024 09:18:39 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:38 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 5/8] rmnet: Delete stale RMnet links at startup
Date: Tue, 19 Nov 2024 11:18:16 -0600
Message-ID: <20241119171832.1119-5-denkenz@gmail.com>
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

Most likely such links could be left over from ofono not exiting
cleanly.  There's unfortunately no easy way to mark links as belonging
to a particular process, so remove all of them.
---
 src/rmnet.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index 350f0bf844a2..4309f8e61ccc 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -25,10 +25,119 @@
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
+				void *userdata,
+				l_netlink_destroy_func_t destroy,
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
+static void rmnet_start_next_request(void);
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
+static void rmnet_start_next_request(void)
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
@@ -152,6 +261,9 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 static void rmnet_link_dump_destroy(void *user_data)
 {
 	dump_id = 0;
+
+	if (l_queue_length(request_q) > 0)
+		rmnet_start_next_request();
 }
 
 static void rmnet_link_dump_cb(int error,
@@ -159,6 +271,7 @@ static void rmnet_link_dump_cb(int error,
 				uint32_t len, void *user_data)
 {
 	struct rmnet_ifinfo info;
+	struct rmnet_request *req;
 
 	/* Check conditions that can't happen on a dump */
 	if (error || type != RTM_NEWLINK)
@@ -168,9 +281,12 @@ static void rmnet_link_dump_cb(int error,
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
 
 static int rmnet_link_dump(void)
@@ -235,6 +351,7 @@ static int rmnet_init(void)
 	link_notify_id = l_netlink_register(rtnl, RTNLGRP_LINK,
 					rmnet_link_notification, NULL, NULL);
 	mux_ids = l_uintset_new_from_range(1, MAX_MUX_IDS);
+	request_q = l_queue_new();
 
 	return 0;
 dump_failed:
@@ -244,6 +361,7 @@ dump_failed:
 
 static void rmnet_exit(void)
 {
+	l_queue_destroy(request_q, (l_queue_destroy_func_t) rmnet_request_free);
 	l_uintset_free(mux_ids);
 	l_netlink_unregister(rtnl, link_notify_id);
 	l_netlink_destroy(rtnl);
-- 
2.47.0

