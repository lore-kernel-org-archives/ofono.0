Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34111A00FC
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257603; cv=none; b=e1ewixOED3OMiSqbQanT5VnvyR0/R/OuUXxyQ7l1Z5ya7zT3Sf4gLBP2SHGenDP6NnleHtMqyiJNMJmPCZO8pFMMVIEUfU4+Pm+pd7E2cyAReiy24Hps/V6eBJ7YQu4BLCtiSgm4jmKjLGLqj/tKI198YVLg0Gq4e3u69B0V0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257603; c=relaxed/simple;
	bh=x3lulOVynjNZfS6qC1lx4Kq8eCSVP0h4tOyBr2qglqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnmTUPt4Gx9LA995S1of5nCH315p5VhNt9fjzF0B3uPrB6xPVZhTtDwU784WW0epvTH4ZPvXpdvZ1ugNnSTNzkOixwmdI6Y4SFb6CfSh0xKpBeoVxbT6+ZWhOkgfT8MRBNYrDpjxMFG1kZxZE9JiLWW7yq8qsKJbDZMhPE4LP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdMW1y/K; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdMW1y/K"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c1b734383cso2196688eaf.3
        for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257600; x=1719862400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMFARyTsy6XXkj+xUBaXbSXxxujjadb8XkGI0ICr1Z8=;
        b=gdMW1y/KXAjLC0MdGQ2NwQY8EeblIAfmgCYBltbyKTZBIxsFcgsd2tHAPMqAP36Cax
         wzk/1e5eJTZwJqxrwNQmtrBPMBb4hog2x1RZli0cN9pnINgC05q65t5eyz97/vjOOj2d
         h2hJiWI6NnJNp7lLGXwkxBsgAYd/VuoOXduFFC4XCKZ0R/DDbjd4cPN+oZRtn9HSAIJ6
         oPLtyruSvyk5CW4Xueon9tG2VH1qGKhGueMyFRbrpu09E738fSipy25aqCIC94kOwUoe
         Yteknyu1hNJh6zTA3fojYxuAyCWvrTU4/Ijr+SUfPTkoHrXLE6H4lWxnyhNEKHJrhjY2
         O6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257600; x=1719862400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMFARyTsy6XXkj+xUBaXbSXxxujjadb8XkGI0ICr1Z8=;
        b=j7tZ1fc3hzCrB05gJFjfIaBziv6/qj6rSkcE+fck2McAEV1OJcvCnKQYtdUs6LPkB5
         vfrA7uYKv+6sdMfCWyAV0Vs3y9VV7RdZHNOWrtBnCjvGTzWr9RkNgacRJa9Ra4yDG++3
         qW8PU6si3xr8ZGm9yAg54BRV5TwyhClKrMXZDPLlHpu/zNeaGRaD1/J+PZakvAf8Edjh
         ki1pv0Og44dmngJlT016QgsgK4t5O7d/u98ASJxnupxTu9dDYX/1wcVrVfxq68gxIwrA
         0mUHZ1cw6LhGOrdPznltIXtdv5wq+CW8oBvZfih1QQyyDdGCdrLTojBUPXNzpE8RxuKX
         3RJQ==
X-Gm-Message-State: AOJu0Yw/U1uio88l6rwaidwFWPv/OIt12nUlEgkYbqi5zqk9dUgT4ST/
	y8/NNly35cOlKMMAL18IL6Ia3RG5G+9i//fJPGx0s90vwD9fK/qgTzuISg==
X-Google-Smtp-Source: AGHT+IHRwj+UPJjSJLxOPVtT7ku7DYPN+AJn4E4oDaTQAvqqbpgHvAHOOz2VIeXk3x6b2h6QV3avzw==
X-Received: by 2002:a4a:85c1:0:b0:5c1:bdf5:df22 with SMTP id 006d021491bc7-5c1eecf1addmr5338805eaf.4.1719257600562;
        Mon, 24 Jun 2024 12:33:20 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d54c2d44sm1480831eaf.8.2024.06.24.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:33:20 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/13] qmi: Move group id allocation out of qmi_device
Date: Mon, 24 Jun 2024 14:32:47 -0500
Message-ID: <20240624193315.1164943-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624193315.1164943-1-denkenz@gmail.com>
References: <20240624193315.1164943-1-denkenz@gmail.com>
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

