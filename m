Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586D17334B
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333726; cv=none; b=N7/qpqzs5R4j7qzi+XnrI8IIAEZxoXlcjkzV+v/pk1qwNhV7Lw7XS+vs2WDusJmMbNpk8DjKSUD/2X39gpSK3r162crejXXoz8OaV7NqT+RtGEjNfDaBxTECOMQ00aAQ9GGLJbe+t4lF5xJyFk2qDt7QC88St0Cc0hJGQv4mzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333726; c=relaxed/simple;
	bh=x3lulOVynjNZfS6qC1lx4Kq8eCSVP0h4tOyBr2qglqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubd27E1oYfuCy7pd5RO2HUPPOZYLhIrrj6U0KJyLIRVuKDQ6m93ffnzXp/dUd1WhtlukAZFx/R0coUZCxZ9bi19T8Orej9QLdoXSxlG4dFvOr/yfMWnnQE2YbrPkS7drT5hu3m0csek19JzVqkVYjFv+NOSkCZsSEzg0CMoQBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWJgoaCY; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWJgoaCY"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9776123a3so2577827eaf.0
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333723; x=1719938523; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMFARyTsy6XXkj+xUBaXbSXxxujjadb8XkGI0ICr1Z8=;
        b=RWJgoaCYwTQpFW+rvrUCcnlse9XEsu935uPAh7GFVJLBbOfbH/IwWIG81Uv1HZoBfB
         ZL5AAHGzYj3epJIRRw/zeiQQJ/WpyDYeDxJqSYRYmEjAoYyTbF0kK2YUex8P4Tre+zIq
         YzJVjaQ6pU52C1O3jwOl9d7A/IrAB48cFyTadcoAcGOQdxoXFo87McXNrYlVqrofH5xM
         5Ew3vTWvn+0/aHpUNngiDMJZal9EOXcS49DJ2nRp70H0g8VrpwvvIPrB922Y7LnUybeQ
         0V3rF4hNFpV+8J+x1Lxv4ScqHFpxI0CbKybpkrkZ2UTkkcK3jdkg2ZR/zQfh9TwVnJw5
         ItvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333723; x=1719938523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMFARyTsy6XXkj+xUBaXbSXxxujjadb8XkGI0ICr1Z8=;
        b=lKZjTD51uLRAlTeb0bx35MD5sQoKXzZlI5hHW6N5ubHw5nPt4Gx9cXPESKg16sH7YW
         IE8O1lKV+MFs4xnV2s0RDJucvc1n/s3dO+eEEBV+dMnAceygu9FVYoi/cn2Nv3YL3C0Q
         JiNtMLKyCb//pfUsGIsAzDmGDbE6Fm6wv2gpENxTLaDFCNw34ohUbh+ZoFaXtk9T08nb
         mPyG7CrsHFT/r2Neesn+6jfqKELmEyw+pi/TC7026eIjQHppc2R+ti8/S2OqbHUz1Av5
         zEOUj0jjKa4wqJStVqWRmaW+CChzZc3qnmSwiZwQKb1ulpPp/OKfqY0qTTKPtWfMy+LK
         ZFZA==
X-Gm-Message-State: AOJu0YyFqnOgL2GgaQI/rb/BvC+rxFfIBIok30vzKSwK+XCvoY1kZlqC
	HevkzQOufNPc6x9zmj34izg9m9nIqyEn3ZNiUt6+wkEjLM1/qYVKMIgayw==
X-Google-Smtp-Source: AGHT+IEgpUOH7AYuD2vX4S6r0x2jJHWi8qWsArXY/qyWWdTjM20cQb26qW4v3c1WxXKpxZMP79cCDg==
X-Received: by 2002:a4a:85c1:0:b0:5c1:bdf5:df22 with SMTP id 006d021491bc7-5c1eecf1addmr7654882eaf.4.1719333723450;
        Tue, 25 Jun 2024 09:42:03 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/14] qmi: Move group id allocation out of qmi_device
Date: Tue, 25 Jun 2024 11:41:40 -0500
Message-ID: <20240625164158.1170937-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As another step of removing qmi_device vestiges, move group_id
allocation into qmi_qrtr_node and qmi_qmux_device classes.
---
 drivers/qmimodem/qmi.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 828f62584ea0..2095a952fffd 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -89,7 +89,6 @@ struct qmi_device {
 	struct l_io *io;
 	struct l_queue *req_queue;
 	struct l_queue *service_queue;
-	unsigned int next_group_id;	/* Matches requests with services */
 	uint16_t next_service_tid;
 	struct l_queue *service_infos;
 	struct l_hashmap *family_list;
@@ -116,6 +115,7 @@ struct qmi_qmux_device {
 		unsigned int release_users;
 	} shutdown;
 	uint8_t next_control_tid;
+	unsigned int next_group_id;	/* Matches requests with services */
 	struct l_queue *control_queue;
 	bool shutting_down : 1;
 	bool destroyed : 1;
@@ -194,6 +194,14 @@ struct qmi_tlv_hdr {
 } __attribute__ ((packed));
 #define QMI_TLV_HDR_SIZE 3
 
+static unsigned int next_id(unsigned int *id)
+{
+	if (*id == 0) /* 0 is reserved for control */
+		*id = 1;
+
+	return *id++;
+}
+
 static bool qmi_service_info_matches(const void *data, const void *user)
 {
 	const struct qmi_service_info *info = data;
@@ -1119,6 +1127,7 @@ static uint8_t __ctl_request_submit(struct qmi_qmux_device *qmux,
 }
 
 static struct service_family *service_family_create(struct qmi_device *device,
+			unsigned int group_id,
 			const struct qmi_service_info *info, uint8_t client_id)
 {
 	struct service_family *family = l_new(struct service_family, 1);
@@ -1127,12 +1136,7 @@ static struct service_family *service_family_create(struct qmi_device *device,
 	family->device = device;
 	family->client_id = client_id;
 	family->notify_list = l_queue_new();
-
-	if (device->next_group_id == 0) /* 0 is reserved for control */
-		device->next_group_id = 1;
-
-	family->group_id = device->next_group_id++;
-
+	family->group_id = group_id;
 	memcpy(&family->info, info, sizeof(family->info));
 
 	return family;
@@ -1397,7 +1401,9 @@ static void qmux_create_client_callback(struct qmi_request *r,
 	info.major = req->major;
 	info.minor = req->minor;
 
-	family = service_family_create(&qmux->super, &info, client_id->client);
+	family = service_family_create(&qmux->super,
+					next_id(&qmux->next_group_id),
+					&info, client_id->client);
 	DEBUG(&qmux->debug, "service family created [client=%d,type=%d]",
 			family->client_id, family->info.service_type);
 
@@ -1614,6 +1620,7 @@ void qmi_qmux_device_set_debug(struct qmi_qmux_device *qmux,
 
 struct qmi_qrtr_node {
 	struct qmi_device super;
+	unsigned int next_group_id;	/* Matches requests with services */
 	struct debug_data debug;
 	struct {
 		qmi_qrtr_node_lookup_done_func_t func;
@@ -1954,7 +1961,8 @@ struct qmi_service *qmi_qrtr_node_get_service(struct qmi_qrtr_node *node,
 	if (!info)
 		return NULL;
 
-	family = service_family_create(device, info, 0);
+	family = service_family_create(device, next_id(&node->next_group_id),
+					info, 0);
 	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(type), family);
 done:
 	return service_create(family);
-- 
2.45.0

