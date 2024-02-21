Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDF3A1A2
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532665; cv=none; b=VgHquHxQeiEtPISEuDPpxbQVm20UUcywrrlSivrD/EVMEBhc5lTDoe7AIbN0Z5XST0wYJf3PRDZV3keotmD99BU7WRWinknmUp3WMYRgCOp24DEGp65fqjEVPNz+x3Zv06xxkijgzcEnRNIlLtIPE3zkM129Q6Kb473rXyDEX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532665; c=relaxed/simple;
	bh=nKbCdK/sLbcVYWBi2M5RIdupRi1WKxTke6PudO1NT3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eg0neFWvOhYpmfjJ42p0SUNCNjjzzvT5g8n3q5QJJS+Fnvu+Uxu/+QUovgw4Ls+C7CW6ZESnRv89p8myxrdhD8toWpqNbGzLwseilBhQvr72EjgJVBMjobfqNdXFNsWBwuHHpdY40ltsK3zg12SH4XJ/ij74mvKYZBCAuGyVp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk6kjJW2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk6kjJW2"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c15cbc6568so687326b6e.1
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532663; x=1709137463; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOCHv5jYofHMeLmXNtBpYgUPZAL7CHr8cS7c8BpqDIU=;
        b=Uk6kjJW2+CCGE7RJq3LZXiDnvqmLN/bQLbi5rHyTu3sdu+wmOpVyXiN4/cfgJ4QVE3
         2IVv1BcT+j7JVuPlWeh2ViE54qOYlR14ErBZT8T8PJeGpeP+T8JP6zft6eO70ZHHajYY
         HF47kFNDqu/5QHpFQBFp9oHpYOgF+HbwSKNQJdoSGVXBn26JqApIHePUI/IIRDJAbRP+
         VYDskgpNF4aULUtveJ3ee5d7RTxllrx0X+GKrfde692T2By/9b/hX1NPj+T3Ncy8mcIh
         3Cnq/NxbB+Y66INrSyQEDpZU3ccpGVnKs3udzrfazBCDWF4/t+GjUpcfX6kwprHm9LY+
         QZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532663; x=1709137463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOCHv5jYofHMeLmXNtBpYgUPZAL7CHr8cS7c8BpqDIU=;
        b=wss2BPFKID+mPwjV4TpjD/bdxrG1X/KbN0exOj9m6XhvX76UKROpx0uvBlE0dC96dS
         jI9ozGHg8Uqw+o3bg8/3rKjq5De6jUanXAJ7OCdLBUHWyNfvynooduuOEP88a5j5ESLo
         p7nmpe7DAr/sncF0ewEzdTX5q0afzb/O/TJi/nY8dDqTJqk3/kOHr2ZKzoIg0mUdHUF4
         4qDpQuIm8XAHxSIV9/a5OGtrm7CswovHbRlo9Gh31AwSb1sC2fxiJFQHmo7km9T+FVjJ
         HjC4UVmdBlc1Z/CF7521HinOfUGGwoxODd2pPLgZEicjFBSRZdnYdcvfBxaX8M2VqcXn
         goVA==
X-Gm-Message-State: AOJu0YzubsqMTnJQ+1/+OV0t0ll0fBQ6JJNlrx16QA5jYSqXK3JCMSuk
	ZbUWjyipzc0k35TkJy2ohiXG+fJynSYKit9aVbPoI67LT/Z2bC2HbBERMcHr
X-Google-Smtp-Source: AGHT+IGHZ1I5BxoBlzA+Q9NT0cuDX6BdWWDZE0wb8AV5ZAnmZk4QXPuJJEeUGG3MkY9G10zKctwkDw==
X-Received: by 2002:a05:6808:495:b0:3bf:d9fd:d030 with SMTP id z21-20020a056808049500b003bfd9fdd030mr9563330oid.15.1708532662938;
        Wed, 21 Feb 2024 08:24:22 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:22 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/7] qmi: Introduce qmi_device_new_qmux
Date: Wed, 21 Feb 2024 10:23:15 -0600
Message-ID: <20240221162335.1258315-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221162335.1258315-1-denkenz@gmail.com>
References: <20240221162335.1258315-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for QRTR support, remove the existing qmi_device_new API
and rename it to qmi_device_new_qmux.  Since QMUX usually runs on top of
a character device, have the constructor take in the character device
path, instead of having the caller open it manually.

As part of this refactoring, introduce the initial qmi_device_ops
structure which will be used to abstract qmi operation over QMUX and
QRTR.
---
 drivers/qmimodem/qmi.c | 67 +++++++++++++++++++++++++++++++++---------
 drivers/qmimodem/qmi.h |  4 +--
 plugins/gobi.c         | 11 +------
 3 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 768fcf12f1eb..7bfb4bc0d74b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -55,6 +55,10 @@ struct qmi_version {
 	const char *name;
 };
 
+struct qmi_device_ops {
+	void (*destroy)(struct qmi_device *device);
+};
+
 struct qmi_device {
 	int ref_count;
 	int fd;
@@ -81,10 +85,15 @@ struct qmi_device {
 	void *shutdown_user_data;
 	qmi_destroy_func_t shutdown_destroy;
 	guint shutdown_source;
+	const struct qmi_device_ops *ops;
 	bool shutting_down : 1;
 	bool destroyed : 1;
 };
 
+struct qmi_device_qmux {
+	struct qmi_device super;
+};
+
 struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
@@ -905,13 +914,11 @@ static void service_destroy(void *data)
 	service->device = NULL;
 }
 
-struct qmi_device *qmi_device_new(int fd)
+static int qmi_device_init(struct qmi_device *device, int fd,
+					const struct qmi_device_ops *ops)
 {
-	struct qmi_device *device;
 	long flags;
 
-	device = l_new(struct qmi_device, 1);
-
 	__debug_device(device, "device %p new", device);
 
 	device->ref_count = 1;
@@ -920,16 +927,14 @@ struct qmi_device *qmi_device_new(int fd)
 	device->close_on_unref = false;
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
-	if (flags < 0) {
-		l_free(device);
-		return NULL;
-	}
+	if (flags < 0)
+		return -EIO;
 
 	if (!(flags & O_NONBLOCK)) {
-		if (fcntl(device->fd, F_SETFL, flags | O_NONBLOCK) < 0) {
-			l_free(device);
-			return NULL;
-		}
+		int r = fcntl(device->fd, F_SETFL, flags | O_NONBLOCK);
+
+		if (r < 0)
+			return -errno;
 	}
 
 	device->io = g_io_channel_unix_new(device->fd);
@@ -953,7 +958,9 @@ struct qmi_device *qmi_device_new(int fd)
 	device->next_control_tid = 1;
 	device->next_service_tid = 256;
 
-	return device;
+	device->ops = ops;
+
+	return 0;
 }
 
 struct qmi_device *qmi_device_ref(struct qmi_device *device)
@@ -1001,7 +1008,7 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->shutting_down)
 		device->destroyed = true;
 	else
-		l_free(device);
+		device->ops->destroy(device);
 }
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -1583,6 +1590,38 @@ done:
 	return res;
 }
 
+static void qmi_device_qmux_destroy(struct qmi_device *device)
+{
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
+
+	l_free(qmux);
+}
+
+static const struct qmi_device_ops qmux_ops = {
+	.destroy = qmi_device_qmux_destroy,
+};
+
+struct qmi_device *qmi_device_new_qmux(const char *device)
+{
+	struct qmi_device_qmux *qmux;
+	int fd;
+
+	fd = open(device, O_RDWR | O_NONBLOCK | O_CLOEXEC);
+	if (fd < 0)
+		return NULL;
+
+	qmux = l_new(struct qmi_device_qmux, 1);
+
+	if (qmi_device_init(&qmux->super, fd, &qmux_ops) < 0) {
+		close(fd);
+		l_free(qmux);
+		return NULL;
+	}
+
+	return &qmux->super;
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	struct qmi_param *param;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index fc2a309578c4..410ada04d8d7 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -81,8 +81,6 @@ typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 
-struct qmi_device *qmi_device_new(int fd);
-
 struct qmi_device *qmi_device_ref(struct qmi_device *device);
 void qmi_device_unref(struct qmi_device *device);
 
@@ -105,6 +103,8 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
+struct qmi_device *qmi_device_new_qmux(const char *device);
+
 struct qmi_param;
 
 struct qmi_param *qmi_param_new(void);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 020d6ba2685e..07994666ded5 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -423,7 +423,6 @@ static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	const char *device;
-	int fd;
 
 	DBG("%p", modem);
 
@@ -431,15 +430,7 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	fd = open(device, O_RDWR | O_NONBLOCK | O_CLOEXEC);
-	if (fd < 0)
-		return -EIO;
-
-	data->device = qmi_device_new(fd);
-	if (!data->device) {
-		close(fd);
-		return -ENOMEM;
-	}
+	data->device = qmi_device_new_qmux(device);
 
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
-- 
2.43.0

