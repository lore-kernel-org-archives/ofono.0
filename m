Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C214038C
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709832; cv=none; b=rQMDugd3GiRPAuGRm/fxVKsX1D5XeVKr/sILQ4xup0MmzHtvKJuKZYJ54O+3IiK2ZAW6nprBZTO71z4Hn6CAUEhdhNxVDMoJ5vZvvtcF2hvtz+BQ/RdlGW64tjx2+X77U+BvvkBh+ArJaqRO+W8iAIOegJrxqpBLSuH7WrJ9mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709832; c=relaxed/simple;
	bh=65v4pWvKQtRUuZw+7j5VuOG9KqdrZb3yP/X5ZocQ4jc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UZJggcYes7NIZm0cndJI/PN5vGaX87RJsz4RkfGIlAmZE+KYk0io8zesvsgCw/yYOE+7ao8xQyKP1/hQOMKiz+ZFj9mSdjT3b1m2irxZHxqxC//XKNqK1ZdZKQwRSY5ssBMAm5/zTYXS1G/8RsAtklaoSgfXHPnFzoCCCpDS3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Af/x2WMp; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=bHc0+Xic; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Af/x2WMp";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="bHc0+Xic"
Received: from pps.filterd (m0286620.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NDs6Md013511
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version:content-type;
	 s=ppemail; bh=8+MQF/mR/Sar0oJUCwFenEiIHjnNcnfDVfnedQ3y4Vo=; b=A
	f/x2WMpBJblPXN1CsM3GSFrTyaM5vJgIoJObS8Z1pmhYRWW4kmCVJ6vrIaI6uAKM
	Sxniq6gH2in9sqkgZw+BtIe197e0kDm/2mKGpcu8fLY7FlG/kL2WOEe/fKj7ll2Z
	dy7gbH78leLa0YkKqqmuzH31OVGfQrVvXiZaj5f/I0pjACgW7Ze1F1cBVWjLK1AB
	48n+mGEB2dsj+WBF3GmvqMgifCD8XW3QsImMb1xtaRD5T7BELmnR0L+npbh3qpl3
	7DASw8lscfwMl+eePUrErWcRKOfCYO/X0GzEO1DzuMUS9zUZHFgEnOI9SAQS8hLj
	c5p8v4qP93vr28NnpXt3Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3weeq28rnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800 (PST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78732274d13so116085985a.1
        for <ofono@lists.linux.dev>; Fri, 23 Feb 2024 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1708709828; x=1709314628; darn=lists.linux.dev;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+MQF/mR/Sar0oJUCwFenEiIHjnNcnfDVfnedQ3y4Vo=;
        b=bHc0+XicaKSV2PLJQIfBfG4lp+ts1P1ixkWSURQEYSq54ev0hEMXFC3LETCgOVMyXA
         d+Hqg6fOwYcBW3Fqifce+mSNkBPUZBUn35G0cak913unRboXSAA8kBjAAgXAHPCyCnYI
         U2GueqsaqpZukKm1/7i4YKgSRDj9ElLM+8zfg/EMiOasIL6+0//1l8SmZrbuheDjIz8K
         7hkzPS1xr48GZGJKmcqdcrNzt3TBT/h6nAulsZsnG4mZ4SnAPV4J7UZUil/xgoVa+YkH
         hvajYWZwiPJJdQKRoBoO979UrW5JHwk30ooyKtApzF4aZyCLKw9Ms22lJcevj2Q1Eebx
         S4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709828; x=1709314628;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+MQF/mR/Sar0oJUCwFenEiIHjnNcnfDVfnedQ3y4Vo=;
        b=L/9pmfdZyjgwXJHhavy8ULrHYul70bbdsftqBDMQD1hbUDhkcnBa/TeZmprXWd+S81
         +ywHiToRhmVXOLtVn5kWrzw3gaBCwUDTjMASmgLTXvOh/97summy+WQCMmcZoRqz7ESL
         2KIWEx3wzOUoPNA78ivIJ8zUCCLhjQnJvhKeqfgr3OuUQFW+K5b8BU32ZnK0lyhqADmY
         P1nuAmc+BNvQGAKdb9N4DKhT64YX3EVikSrpSnWynCNofZOn7hIwkV8Y4vTbUGohLETK
         qaHUa41R0UPGO/SV4nZm76aM5ccij+cc8qcSoQNbOHMxAwlqAJMiEv8DZdSmgPboPcuy
         MZZg==
X-Gm-Message-State: AOJu0YxnzMjjRt2wZcHFSRmJRA8CmCbGYftbU2j8oiCb4gEDaC2INQoW
	KOE3Hz8hBkIUWfK5Vt9baXjaFgLAId6aiWewdGBfwh4qoK4YGR8jgmndCMi8dT3UjIanfIwcps4
	6ihDDZfOeJdUXhozE7VKlD9FWykV6h0Hi/7Gxsgo+WvzJCtnAgQcPBvXxJnkjLaIPJnCdEVtC9S
	Gn6VzNYDDBGqM+YWrcUjEis+KbjwLQeCxRfchClzYxsGZY3QI=
X-Received: by 2002:a05:620a:12cd:b0:787:a5ba:d58d with SMTP id e13-20020a05620a12cd00b00787a5bad58dmr571108qkl.38.1708709828171;
        Fri, 23 Feb 2024 09:37:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH46dMSgo/UWvTnigld/k5bGJlnIKBB75AYipJUyAey7NP6B8CqdCSE5U9SBwNG5bSqAdIjtA==
X-Received: by 2002:a05:620a:12cd:b0:787:a5ba:d58d with SMTP id e13-20020a05620a12cd00b00787a5bad58dmr571091qkl.38.1708709827848;
        Fri, 23 Feb 2024 09:37:07 -0800 (PST)
Received: from localhost.localdomain ([140.177.180.84])
        by smtp.gmail.com with ESMTPSA id t25-20020a05620a035900b00785d4d5768bsm1577140qkm.11.2024.02.23.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:37:07 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 1/2] qmimodem: Use l_io instead of GIOChannel
Date: Fri, 23 Feb 2024 17:35:51 +0000
Message-Id: <20240223173552.31622-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: 6b4EnwFQZalOa-ALGwEWUgNhu79xEYuc
X-Proofpoint-GUID: 6b4EnwFQZalOa-ALGwEWUgNhu79xEYuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402230129

---
 drivers/qmimodem/qmi.c | 79 ++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 93e4991e..27615275 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -72,10 +72,7 @@ struct qmi_device_ops {
 };
 
 struct qmi_device {
-	int fd;
-	GIOChannel *io;
-	guint read_watch;
-	guint write_watch;
+	struct l_io *io;
 	struct l_queue *req_queue;
 	struct l_queue *control_queue;
 	struct l_queue *service_queue;
@@ -88,6 +85,7 @@ struct qmi_device {
 	uint8_t version_count;
 	struct l_hashmap *service_list;
 	const struct qmi_device_ops *ops;
+	bool writer_active : 1;
 	bool shutting_down : 1;
 	bool destroyed : 1;
 };
@@ -628,8 +626,7 @@ static void __debug_device(struct qmi_device *device,
 	device->debug_func(strbuf, device->debug_data);
 }
 
-static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static bool can_write_data(struct l_io *io, void *user_data)
 {
 	struct qmi_device *device = user_data;
 	struct qmi_mux_hdr *hdr;
@@ -638,11 +635,11 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 
 	req = l_queue_pop_head(device->req_queue);
 	if (!req)
-		return FALSE;
+		return false;
 
-	bytes_written = write(device->fd, req->buf, req->len);
+	bytes_written = write(l_io_get_fd(device->io), req->buf, req->len);
 	if (bytes_written < 0)
-		return FALSE;
+		return false;
 
 	l_util_hexdump(false, req->buf, bytes_written,
 			device->debug_func, device->debug_data);
@@ -661,26 +658,27 @@ static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 	req->buf = NULL;
 
 	if (l_queue_length(device->req_queue) > 0)
-		return TRUE;
+		return true;
 
-	return FALSE;
+	return false;
 }
 
 static void write_watch_destroy(gpointer user_data)
 {
 	struct qmi_device *device = user_data;
 
-	device->write_watch = 0;
+	device->writer_active = false;
 }
 
 static void wakeup_writer(struct qmi_device *device)
 {
-	if (device->write_watch > 0)
+	if (device->writer_active)
 		return;
 
-	device->write_watch = g_io_add_watch_full(device->io, G_PRIORITY_HIGH,
-				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				can_write_data, device, write_watch_destroy);
+	l_io_set_write_handler(device->io, can_write_data, device,
+				write_watch_destroy);
+
+	device->writer_active = true;
 }
 
 static uint16_t __request_submit(struct qmi_device *device,
@@ -841,8 +839,7 @@ static void handle_packet(struct qmi_device *device,
 	__request_free(req);
 }
 
-static gboolean received_data(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static bool received_data(struct l_io *io, void *user_data)
 {
 	struct qmi_device *device = user_data;
 	struct qmi_mux_hdr *hdr;
@@ -850,12 +847,9 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	ssize_t bytes_read;
 	uint16_t offset;
 
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	bytes_read = read(device->fd, buf, sizeof(buf));
+	bytes_read = read(l_io_get_fd(device->io), buf, sizeof(buf));
 	if (bytes_read < 0)
-		return TRUE;
+		return true;
 
 	l_util_hexdump(true, buf, bytes_read,
 			device->debug_func, device->debug_data);
@@ -889,14 +883,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		offset += len;
 	}
 
-	return TRUE;
-}
-
-static void read_watch_destroy(gpointer user_data)
-{
-	struct qmi_device *device = user_data;
-
-	device->read_watch = 0;
+	return true;
 }
 
 static void __qmi_device_discovery_started(struct qmi_device *device,
@@ -931,29 +918,20 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	__debug_device(device, "device %p new", device);
 
-	device->fd = fd;
-
-	flags = fcntl(device->fd, F_GETFL, NULL);
+	flags = fcntl(fd, F_GETFL, NULL);
 	if (flags < 0)
 		return -EIO;
 
 	if (!(flags & O_NONBLOCK)) {
-		int r = fcntl(device->fd, F_SETFL, flags | O_NONBLOCK);
+		int r = fcntl(fd, F_SETFL, flags | O_NONBLOCK);
 
 		if (r < 0)
 			return -errno;
 	}
 
-	device->io = g_io_channel_unix_new(device->fd);
-
-	g_io_channel_set_encoding(device->io, NULL, NULL);
-	g_io_channel_set_buffered(device->io, FALSE);
-
-	device->read_watch = g_io_add_watch_full(device->io, G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				received_data, device, read_watch_destroy);
-
-	g_io_channel_unref(device->io);
+	device->io = l_io_new(fd);
+	l_io_set_close_on_destroy(device->io, true);
+	l_io_set_read_handler(device->io, received_data, device, NULL);
 
 	device->req_queue = l_queue_new();
 	device->control_queue = l_queue_new();
@@ -988,13 +966,7 @@ void qmi_device_free(struct qmi_device *device)
 	l_queue_destroy(device->req_queue, __request_free);
 	l_queue_destroy(device->discovery_queue, __discovery_free);
 
-	if (device->write_watch > 0)
-		g_source_remove(device->write_watch);
-
-	if (device->read_watch > 0)
-		g_source_remove(device->read_watch);
-
-	close(device->fd);
+	l_io_destroy(device->io);
 
 	l_hashmap_destroy(device->service_list, service_destroy);
 
@@ -1171,13 +1143,14 @@ static bool get_device_file_name(struct qmi_device *device,
 	pid_t pid;
 	char temp[100];
 	ssize_t result;
+	int fd = l_io_get_fd(device->io);
 
 	if (size <= 0)
 		return false;
 
 	pid = getpid();
 
-	snprintf(temp, 100, "/proc/%d/fd/%d", (int) pid, device->fd);
+	snprintf(temp, 100, "/proc/%d/fd/%d", (int) pid, fd);
 	temp[99] = 0;
 
 	result = readlink(temp, file_name, size - 1);
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
