Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF9153BDD
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468926; cv=none; b=ddNwm62cmeZdsSh8U+JX7dIfxDJ47NZjD5KbuGwU9eftek47fvUXgeMxyaeU0P2Fsy8QHEpq2OqGBGzD8n5QSNCOrcnVkEoy7i9yuaD50HSoK6NwCXViJATnCQjLFoorlTVxUWnk0jvgTnprIaxpxlxKq+xoG8YOxfkk6Vij1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468926; c=relaxed/simple;
	bh=8eDo5PSpDRPvjhgGVqf3JdM9PduMbxEPuwiAs+KRiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+jJKGTqng9cIvGaVIvRV2B6BqVTQ3Kj/FIkml9DTESWw6pnWl6bKU+Ze0Sh8s+c/QyloB2FGGi/vnTak0S6Nz31e+K5YqVpjsMYnBYuxtAZG4HHachOkm6acLznEGeMR+2iat8TtiCI0fn9sfXbkUQ+3RS37UO0lqP7ThdOaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYG6oNRS; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYG6oNRS"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21e6be74db4so2713648fac.2
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468924; x=1709073724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lunPUoDCNCZkBDcXsOpMZQFsd6MlY7UAu7A2KFNl9Gg=;
        b=LYG6oNRS4lqACA9pqqOeKMx0E9WZFdwbaSDnotncdYKGISHsTthOeHLmSGQTEIU6r2
         YuYjRsqyi+C2Jk8ALgynRwd+WY/24dKsxjcabWjuWbS0/9pH0gma7k1oNcMF+owe6+x1
         hmZ6a/UGgppOo964abPnsXyQNoI5Smfv/7tTzlOQ4pJqtebwu1vlxzIIOtWcBTZn82n+
         dA6oxJ0JxwTXpwTxRtNuvQd4gIHA+LPuy7GDJC0V8NzB7Hk5qDMtn9ax7zAxRbRGd+qZ
         zQiwPUM072jCPV3qnqYDza7dXRx1tglC3OfPbvEoflqxQrjDYvzgwymV6eShXsRnwASA
         zl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468924; x=1709073724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lunPUoDCNCZkBDcXsOpMZQFsd6MlY7UAu7A2KFNl9Gg=;
        b=Ied+QNNTXHYRUsekQ8v7GbsZgs0SirYmqhN3A+tmWF+apPjV4wU7Wa+Zjc+kCUCDXj
         0eicQSkZDfQByh+qfwKhuz98B8gb3OEzuP+7/Uv5jc3XZqCh/8jroWTAs1VbtC+YExXv
         7AzQTOvtY2Yr/+BXwoBi9nY9SqGaQPNb/f42Y667Gb+ueKy042J1MOEw/XFsJuYz4RSq
         V0fMLwQpxnJd3KWB6odH3EDoFZ5+Re6xM6/1vrs/RwwPLodjlt24rcaoy3JI07NK9d3s
         ge25IQp9dMSg1On2E9hhqfg5Xaq7ED3xWH2x73+o5aX0d4r6hvpK1sYBx1mrD6jaA7ek
         vvUw==
X-Gm-Message-State: AOJu0Yy7OypWOCGTz3I5dbKWNW5IL4Rf03kvrgJELedC33wLl/2eCNnX
	9H2NSbpv14fu2KBX46xoPU0NgIJTI9QApgPzXsH+4hUBwva/PLPNvPcuoHEq
X-Google-Smtp-Source: AGHT+IF6MO40Zoi0DghBmN1z1+kWFtnnLF/4LvOuCEpP3RqzfSTwFOUuWu5quacXKem3YI+YiwwNAQ==
X-Received: by 2002:a05:6870:610f:b0:21e:7a1d:b783 with SMTP id s15-20020a056870610f00b0021e7a1db783mr11664412oae.33.1708468924007;
        Tue, 20 Feb 2024 14:42:04 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:03 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/7] qmi: Introduce qmi_device_new_qmux
Date: Tue, 20 Feb 2024 16:40:55 -0600
Message-ID: <20240220224115.1254853-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220224115.1254853-1-denkenz@gmail.com>
References: <20240220224115.1254853-1-denkenz@gmail.com>
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
 drivers/qmimodem/qmi.c | 70 ++++++++++++++++++++++++++++++++----------
 drivers/qmimodem/qmi.h |  4 +--
 plugins/gobi.c         | 11 +------
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index ee51a7db2368..89e1f8f40381 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -34,6 +34,7 @@
 #include <string.h>
 
 #include <glib.h>
+#include <ell/ell.h>
 
 #include <ofono/log.h>
 
@@ -54,6 +55,10 @@ struct qmi_version {
 	const char *name;
 };
 
+struct qmi_device_ops {
+	void (*destroy)(struct qmi_device *device);
+};
+
 struct qmi_device {
 	int ref_count;
 	int fd;
@@ -80,10 +85,15 @@ struct qmi_device {
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
@@ -949,15 +959,11 @@ static void service_destroy(gpointer data)
 	service->device = NULL;
 }
 
-struct qmi_device *qmi_device_new(int fd)
+static int qmi_device_init(struct qmi_device *device, int fd,
+					const struct qmi_device_ops *ops)
 {
-	struct qmi_device *device;
 	long flags;
 
-	device = g_try_new0(struct qmi_device, 1);
-	if (!device)
-		return NULL;
-
 	__debug_device(device, "device %p new", device);
 
 	device->ref_count = 1;
@@ -966,16 +972,14 @@ struct qmi_device *qmi_device_new(int fd)
 	device->close_on_unref = false;
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
-	if (flags < 0) {
-		g_free(device);
-		return NULL;
-	}
+	if (flags < 0)
+		return -EIO;
 
 	if (!(flags & O_NONBLOCK)) {
-		if (fcntl(device->fd, F_SETFL, flags | O_NONBLOCK) < 0) {
-			g_free(device);
-			return NULL;
-		}
+		int r = fcntl(device->fd, F_SETFL, flags | O_NONBLOCK);
+
+		if (r < 0)
+			return -errno;
 	}
 
 	device->io = g_io_channel_unix_new(device->fd);
@@ -1000,7 +1004,9 @@ struct qmi_device *qmi_device_new(int fd)
 	device->next_control_tid = 1;
 	device->next_service_tid = 256;
 
-	return device;
+	device->ops = ops;
+
+	return 0;
 }
 
 struct qmi_device *qmi_device_ref(struct qmi_device *device)
@@ -1055,7 +1061,7 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->shutting_down)
 		device->destroyed = true;
 	else
-		g_free(device);
+		device->ops->destroy(device);
 }
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -1646,6 +1652,38 @@ done:
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

