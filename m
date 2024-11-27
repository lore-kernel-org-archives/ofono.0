Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F238BE5
	for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743127; cv=none; b=CDROfgKUd9Ak/rQWWnW3oXMRAaAVCCcmPBgm7GY4l0w830psRDeP+cEWQ3fF4dShKVcWtTPspe+SReusg/7MlgLFV0VEc50sMOSIXW9n0sMMMB1B4TmjdfGvXBLCJYa0eqY6Ikgm+dFiv8b57OQwEoGLultPg0NNJ0vvhMdOOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743127; c=relaxed/simple;
	bh=5TaHO7DrN1vKwslXkZu7hs3eb0pA1dfqLzuVJFX9bcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYufi/sbmwDrEoGQEsZZPkPacTukxcYESo1EwloJSwj2q63ghOMSyUh8l9BISobNn83nmPj/LPFctuesedeXF01xQ/SdD/kccqqfSZIqUx5oVwJfG0UhdqocdVdwkmiunqAXeVxPSg5aheZ03q48FKYeU3eSCHlGSMtVamqAEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC/BGq5u; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC/BGq5u"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-296994dd3bfso177369fac.0
        for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 13:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743124; x=1733347924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MJpG/OKdJoR9MoyJHu2RKxjCDf02nOlXZGUlqsczIQ=;
        b=HC/BGq5uLynMA+e9wdjMwED93cXXyUTf66pNQKOB6PeDjCpXMT+CB5n3b3X9N3BBlA
         oMchEydsBZMplONA/yBHNAI60zbw2I3Y/yV5hyhrNHtehnHT+qTkohrpiBmsqIDOfN0z
         C3Ye0mmLUrG9QcV9aopOHIvRvvQ62MKjDxA+1Edk7/NSiSMDIm2sfhNSsyctxARdyzrb
         XaG5dJGz7CpG5cxR0ylWo6Vnd/k49U6reIh2S4qysM5i/2lmAcXPe9EHMJGmjLXRrojv
         Amj/PRBPZHoUgTfK3VO8ujz05wOQ+eZG/a2e80fytD8pPcdV92r+Hq03lBJAEGnD+gdt
         EU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743124; x=1733347924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MJpG/OKdJoR9MoyJHu2RKxjCDf02nOlXZGUlqsczIQ=;
        b=mvtvv/PkkRfSQ680a5cFqgwAjfACmrgLRltRiouDaStMZRS+rH3p9/iXljRhgBu6bP
         cQOI4G/pfsFortkrhly87a3smyUusZhI/Q5eiYWYfxSI8sXjsQVXLVJwU8HxVKp6P/YT
         H5PUgh1Pbe6eKSull8Dtym7femFYghistks2AFFoxQ+sxhG7bZkjYOnWCFkiPoDLme6W
         tJ7nigTNn/0JS4UK1gHrOHqaa5hEzzEOnidFlxxtU2lmshAz0TmTyS9XWD7frXKcUGSn
         8OIr1TpGNCL7Mj73nFU3B32aFfeC7ySEtHZXsjeqPvxKVV2OyUNhI21HAtvDGQT+4062
         zvJQ==
X-Gm-Message-State: AOJu0Yy+7uj3nuQr6rdsNvhHKFRZs6HQKqgLxZqVYxPcJE0l2gHmpkn4
	KmsCgus9ccgWM0JpxLCrxpdQD+Oo//xjY9lalXsMboWDIi7W1z1aqdUHPg==
X-Gm-Gg: ASbGncv6mp9cRjR6kY+Gl5iGap89FD6u9BGKIDMRClisisv8bQk40FCEHdjlV+W2w9O
	kq6Xo4V8nyjD6d3O+QVWjxFCiq/nR8F5KCWXyepi/WnWHGLLTqQnNpJvZLtz/2vi+EQHhiBv93X
	9fi7IipSZbkhnZAmeOiFN9hljiTmOLu91Z3x13GwjpxoPkqAqgbfCGGRfESb3v5yn5x+yllNs6y
	+HulwrV9T14IQIfEUWZ2eRltvUIPm8fXLJtE7l/GIfTEYEntVFpSgfUjfgHjNkJSucGupA+cMew
	9HjTV9k3lglMWCBw+bBYoCbk
X-Google-Smtp-Source: AGHT+IFbxoD/frltrOOgGpOZBf5RopIOZ3oBNT6Q1eyjYE216/jupX0MGG8fiy/vExRgp14Y1MOuvg==
X-Received: by 2002:a05:6870:ab0b:b0:288:57fa:961d with SMTP id 586e51a60fabf-29dc438652bmr4139463fac.38.1732743124622;
        Wed, 27 Nov 2024 13:32:04 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9ba6bbfsm29114fac.48.2024.11.27.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:32:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/4] rmnet: Default created interfaces to MTU of 1400
Date: Wed, 27 Nov 2024 15:31:49 -0600
Message-ID: <20241127213200.202536-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127213200.202536-1-denkenz@gmail.com>
References: <20241127213200.202536-1-denkenz@gmail.com>
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

The logic in update_new_link_ifindex() is updated to make it more
defensive.  Since two rtnl messages are sent (RTM_NEWLINK to create the
device followed by RTM_SETLINK to set the MTU), there are now two
RTM_NEWLINK events that are triggered for each item in the rmnet
request.  Since 'current' is incremented after RTM_NEWLINK request
succeeds, there is a possibility of buffer overflow.
---
 src/rmnet.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index 83110c33a980..42b03249da54 100644
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
@@ -229,6 +227,48 @@ next_request:
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
@@ -429,6 +469,7 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 	bool have_linkinfo = false;
 	const char *ifname = NULL;
 	uint16_t ifnamelen = 0;
+	uint32_t mtu = 0;
 	uint16_t rta_type;
 	uint16_t rta_len;
 	const void *rta_data;
@@ -450,10 +491,16 @@ static int rmnet_parse_link(const void *data, uint32_t len,
 
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
@@ -530,14 +577,23 @@ static void update_new_link_ifindex(uint16_t mux_id,
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

