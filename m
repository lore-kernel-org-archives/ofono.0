Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA331E1A27
	for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708067; cv=none; b=qPP/WU8Uc6uD0fQgXLZiyGXLc91b9W0HE8xQ6Cu89oeag2CDjU3z8SjaU6mw1RbrqXumAohrVrZ05GAAst6H6W5VJhU60I2CofL49jH0ZJWFKPDeUXUcn5KxkrXRQ6rBXagiQnoJfPlgcsQ/cOSWL4qwbyaDE920huYeOK7fktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708067; c=relaxed/simple;
	bh=P4V8J/afc4mb7yTWlu/NxnbQvNxFO13GUri1u0xgqZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3LNSQZoIq1BWXlxuF+996sLV1lT9g+8RPEKxEokcNR8Xw831jj7rgSSPXuXL8VbIZdM4EUtDtbMWS+z0ExkNgzixjUzIgYg/a5cXAkQoTo5T/CnA6BgXFFd4BN169c8EfQQ9veFTJDtTMpk1SIu5f7gkWPdJYxYqkv9YVvi3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5xmrOMK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5xmrOMK"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5f835c024so1371065b6e.2
        for <ofono@lists.linux.dev>; Fri, 15 Nov 2024 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708064; x=1732312864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlSi7CskR4nIYpDQBuXZ8YEmhG4MKcXP/QM3vrlefF4=;
        b=m5xmrOMK2K94SVejjvo33aqnv1P+0nKLcECxjUICf+/EDB7K2pK+o7Kbr6qxYr9w7J
         NMUFvTDqcG0UP42w5VRW3JupXTjUa+/WmTsCLzN8f4NZjug2gShukgEiGpngrOTyocz3
         8Pg0G/6h5CjNzdJfJVOiXJP7grEQ78Q84Je48xvv9is9MFTH2qinP3BqX2UOFjBYO3jS
         xZAdHBhVCEuhWm/Z7us3MVPcMrGKi9YH9r0wh65RviPtj3Qa1RHeDZivn4WZrllYJ369
         bIpilH6wW4+P3DldmBrlxq4cEFC/z6LJ5INdxEVbu5ynh8ylSAm+Zf+Iwl1Pa8mS+1Vy
         KRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708064; x=1732312864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlSi7CskR4nIYpDQBuXZ8YEmhG4MKcXP/QM3vrlefF4=;
        b=nyjTfwrUCh+1dQ9QfB5IOTuE2h6pP4tjdipatlyYyR0aVr6ecJWDdOw3zIa5YZ0ykn
         lmvE1YmLtQ0wEZHwNPLYTPU+GfV/xG9FilnasbmUSF8YSHssvLwHU6cPqXh8Us+aNHpE
         p94r3Mc3//9haxHsaYjo+m2yi7FQQb9uBLpg684nJwsfRyE0dir3UmMMGO2gcU+Vfbge
         H5yZDN1qro6kMQ4OwRUZywsZKeqKvvN3Wvd74AqTFSsB9FXSameOy7uC3stiQJAf9hXX
         0sUpEjTt4RfRUL2IYSAqCSJhfyOqSJfwRkSJbRDv2/03kdemGrWXul+se/DG3cFgQxFa
         kQOA==
X-Gm-Message-State: AOJu0YymyCGm116ABXiubHfLwzK0k+s3wbStRbvHxGKJwCyIFAuHaax6
	+AA+CH+9YYkLpaO7lJm37yQ8FJCFR+0zfYqh7mbcosDgiLOQtfj/g5tP0Q==
X-Google-Smtp-Source: AGHT+IFXO20KhqoZqsfIUedOx4RZtQp/BwcNXDbDMVfXQCZRxwe8kM0oPQ1sPiUWNMjzKBe3Czu1ZQ==
X-Received: by 2002:a05:6808:1204:b0:3e5:f4f9:3280 with SMTP id 5614622812f47-3e7bc7bfa12mr4170692b6e.10.1731708063011;
        Fri, 15 Nov 2024 14:01:03 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82997sm879003b6e.34.2024.11.15.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:01:02 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 8/8] rmnet: Implement cancel
Date: Fri, 15 Nov 2024 16:00:33 -0600
Message-ID: <20241115220053.49613-8-denkenz@gmail.com>
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

Implement cancelation of an ongoing rmnet request.  Any links that have
already been created are deleted by putting another request to the head
of the queue.
---
 src/rmnet.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index 4a921b330b72..07dada9178ad 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -32,6 +32,7 @@ struct rmnet_request {
 	void *user_data;
 	rmnet_destroy_func_t destroy;
 	int id;
+	bool canceled;
 	uint32_t netlink_id;
 	uint16_t request_type;
 	uint8_t current;
@@ -54,6 +55,14 @@ static void rmnet_request_free(struct rmnet_request *req)
 	l_free(req);
 }
 
+static bool rmnet_request_id_matches(const void *a, const void *b)
+{
+	const struct rmnet_request *req = a;
+	int id = L_PTR_TO_INT(b);
+
+	return req->id == id;
+}
+
 static struct rmnet_request *__rmnet_del_request_new(unsigned int n_interfaces,
 					const struct rmnet_ifinfo *interfaces)
 {
@@ -185,7 +194,7 @@ static void rmnet_new_link_cb(int error, uint16_t type, const void *data,
 	if (!error)
 		req->current += 1;
 
-	if (error) {
+	if (error || req->canceled) {
 		if (req->current > 0) {
 			struct rmnet_request *del_req =
 				__rmnet_del_request_new(req->current,
@@ -268,6 +277,7 @@ int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 	req->user_data = user_data;
 	req->destroy = destroy;
 	req->id = next_request_id++;
+	req->canceled = false;
 	req->request_type = RTM_NEWLINK;
 	req->netlink_id = 0;
 	req->current = 0;
@@ -304,7 +314,62 @@ int rmnet_del_interfaces(unsigned int n_interfaces,
 
 int rmnet_cancel(int id)
 {
-	return -ENOTSUP;
+	struct rmnet_request *req;
+
+	req = l_queue_peek_head(request_q);
+	if (!req)
+		return -ENOENT;
+
+	/* Simple Case: Request not yet started (not queue head) */
+	if (req->id != id) {
+		req = l_queue_remove_if(request_q, rmnet_request_id_matches,
+						L_INT_TO_PTR(id));
+		if (!req)
+			return -ENOENT;
+
+		DBG("Removing non-head of queue request %u", id);
+		rmnet_request_free(req);
+		return 0;
+	}
+
+	/* Harder Case: In progress, but the next request not in flight */
+	if (!l_netlink_request_sent(rtnl, req->netlink_id)) {
+		DBG("Removing in-progress request (not in flight) %u", id);
+		req = l_queue_pop_head(request_q);
+		l_netlink_cancel(rtnl, req->netlink_id);
+
+		if (req->current > 0) {
+			struct rmnet_request *del_req =
+				__rmnet_del_request_new(req->current,
+								req->infos);
+
+			l_queue_push_head(request_q, del_req);
+		}
+
+		rmnet_request_free(req);
+
+		if (l_queue_length(request_q))
+			rmnet_start_next_request();
+
+		return 0;
+	}
+
+	/*
+	 * Hardest Case: In progress, next request in flight
+	 * We have to wait until the next callback since the ifindex won't be
+	 * known until then.
+	 */
+	if (req->destroy)
+		req->destroy(req->user_data);
+
+	req->new_cb = NULL;
+	req->destroy = NULL;
+	req->user_data = NULL;
+
+	DBG("Setting canceled on in-progress request %u", id);
+	req->canceled = true;
+
+	return 0;
 }
 
 static int rmnet_parse_info_data(struct l_netlink_attr *linkinfo,
-- 
2.47.0

