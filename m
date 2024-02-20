Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5069153BE6
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468929; cv=none; b=Ov7KXdDeMItxeB+Y1H0/Erwl0P7fTMbEprYODByrR8txMnbwwBXgO+GXYAdoyKqH3qdoSJlBrQOjsBongL7UIsAauXZGDzTSFpiuPAM1T2rnBCnpXLuc3pZ18rtJy1BcyesEsRs33dv7hLxz7uOnfhjVvqoQdtFKJLdHOo0Z41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468929; c=relaxed/simple;
	bh=ZZMFeD43R8zS9wJOxatOE+EHxypzPPbZFQ5e61+ytA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOzU+Tv0FocrEIsLs7ymIv6nEJJslb9+90Ro5iOFjXT+1J94dE7AVW+LhTrrCLvod7H1+1QTAq7K6VeG3VpNy/eOixx1q9AJAixG3Xv3WxgFz+kceapiMhANxVuMByGyY95Vo1YS+79qbyDlhdbSAb2i6sXQKpSD/UPVuPt+w4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfQwGAFO; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfQwGAFO"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59d78deb469so3792389eaf.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468927; x=1709073727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkdkGos4yPBFYAElfKIcxQB5NBFE1tbEEdtjMzwjAKo=;
        b=MfQwGAFOCRUP0MbWFaZ0Na6JmcXEMIhLTwGIKKUfaigI3EPelwdYOzp7XncCfLNphN
         0r3zmwLH7kdi/YYovxe8yZ23eAxyVd33MS500Aug4EiILhOSD477EZjl2hCjwq2dngvk
         IKQWedOb2pwPcSIPLcWG6JSK+mpBjMJ7J3E6RTIyVAOEUovrPi8ld4UfP7Lut9WpYB98
         WB4arrMHu0Kwkue0i1KiVJVzmkxCKYwPfuWCkV9G6Bl4XjBajuafP1Filio4HkI4XSIS
         wq/6LYfrk2cnBZ8UoTa347K1IWozy2C31LWbcuwZ7CteimPGJsATuQHDKaPNnCUg7s0D
         ortQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468927; x=1709073727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkdkGos4yPBFYAElfKIcxQB5NBFE1tbEEdtjMzwjAKo=;
        b=N1zYM7Lu00kqCPgU+gieGIirhoJHq9HQDxBMhmQH4qfTZI3Somd6OvX6WpE1KAd5sv
         uAD55i7NhE0lnhm4uLzj9lYUgCEGU87ow9us2ILO2rtaFDBBDVGkZJh5zJseWx83VNVC
         y4DdMc+8JObeh+qLeyf/CmjFC7hqhJRmJZnqHOML2A2J16RVGdYG+F89k+4UZlvPK6Uk
         DzmfMKQfY7hNMviroxlBOB/P/9UUi5dEBopOm5mqnziSwOnF6d/NMmJ31GDDQMKd3MpV
         /0i4yg4gVWe5uB3ooJSTsNuZofQ1v8o7jCG/P/ZujQwLlFXZo+srxlXricm0gsa0CQQ+
         JugA==
X-Gm-Message-State: AOJu0YxaAPR4g67Nf8i+8+hNuCjB+YV+enfOA4+GwllAEAkD7cGisFt1
	8fbXDSm9yPjIepLBqINlLWrpvHuQHnbbVcijV7e1IGXfEbo89WLCyZ7R4nDm
X-Google-Smtp-Source: AGHT+IG/sloZInGxcimUYVZGy8AeZykVRPVN7D5c6fTLtGoOr7aEo9korNqIzcV35D6564CHmgvMGw==
X-Received: by 2002:a05:6871:58a4:b0:21e:9eac:b0ae with SMTP id ok36-20020a05687158a400b0021e9eacb0aemr9288135oac.40.1708468926835;
        Tue, 20 Feb 2024 14:42:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/7] qmi: Introduce shutdown operation
Date: Tue, 20 Feb 2024 16:40:59 -0600
Message-ID: <20240220224115.1254853-6-denkenz@gmail.com>
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

On QMUX the shutdown operation waits for all low-level service handles
to be released, then calls the shutdown callback / destroy functions.
Low level service handles on QMUX protocol are released via
qmi_service_unref, which in turn sends a QMUX control message.

On the other hand, in QRTR, there is no need to explicitly release
handles.  They are released automatically when the underlying QRTR
socket is closed.

Abstract the shutdown operation behind a shutdown method in the ops
structure, and move the QMUX specific implementation there.  While here,
change the return signature of qmi_device_shutdown to return an int,
such that better error reporting can be supported.  For example, QRTR
might choose not to implement the shutdown method entirely, in which
case an -EOPNOTSUP will be returned.
---
 drivers/qmimodem/qmi.c | 129 ++++++++++++++++++++++++-----------------
 drivers/qmimodem/qmi.h |   2 +-
 2 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 47a9bbe2cb59..5543df027c15 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -56,6 +56,9 @@ struct qmi_version {
 };
 
 struct qmi_device_ops {
+	int (*shutdown)(struct qmi_device *device,
+			qmi_shutdown_func_t shutdown_func,
+			void *user, qmi_destroy_func_t destroy);
 	void (*destroy)(struct qmi_device *device);
 };
 
@@ -77,10 +80,6 @@ struct qmi_device {
 	uint8_t version_count;
 	GHashTable *service_list;
 	unsigned int release_users;
-	qmi_shutdown_func_t shutdown_func;
-	void *shutdown_user_data;
-	qmi_destroy_func_t shutdown_destroy;
-	guint shutdown_source;
 	const struct qmi_device_ops *ops;
 	bool shutting_down : 1;
 	bool destroyed : 1;
@@ -91,6 +90,10 @@ struct qmi_device_qmux {
 	uint16_t control_major;
 	uint16_t control_minor;
 	char *version_str;
+	qmi_shutdown_func_t shutdown_func;
+	void *shutdown_user_data;
+	qmi_destroy_func_t shutdown_destroy;
+	guint shutdown_source;
 };
 
 struct qmi_service {
@@ -1017,6 +1020,12 @@ struct qmi_device *qmi_device_ref(struct qmi_device *device)
 	return device;
 }
 
+static void __qmi_device_shutdown_finished(struct qmi_device *device)
+{
+	if (device->destroyed)
+		device->ops->destroy(device);
+}
+
 void qmi_device_unref(struct qmi_device *device)
 {
 	if (!device)
@@ -1047,9 +1056,6 @@ void qmi_device_unref(struct qmi_device *device)
 
 	close(device->fd);
 
-	if (device->shutdown_source)
-		g_source_remove(device->shutdown_source);
-
 	g_hash_table_destroy(device->service_list);
 
 	g_free(device->version_list);
@@ -1393,58 +1399,16 @@ static void release_client(struct qmi_device *device,
 	__request_submit(device, req);
 }
 
-static void shutdown_destroy(gpointer user_data)
-{
-	struct qmi_device *device = user_data;
-
-	if (device->shutdown_destroy)
-		device->shutdown_destroy(device->shutdown_user_data);
-
-	device->shutdown_source = 0;
-
-	if (device->destroyed)
-		g_free(device);
-}
-
-static gboolean shutdown_callback(gpointer user_data)
-{
-	struct qmi_device *device = user_data;
-
-	if (device->release_users > 0)
-		return TRUE;
-
-	device->shutting_down = true;
-
-	if (device->shutdown_func)
-		device->shutdown_func(device->shutdown_user_data);
-
-	device->shutting_down = true;
-
-	return FALSE;
-}
-
-bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
+int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	if (!device)
 		return false;
 
-	if (device->shutdown_source > 0)
-		return false;
-
-	__debug_device(device, "device %p shutdown", device);
-
-	device->shutdown_source = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
-						0, shutdown_callback, device,
-						shutdown_destroy);
-	if (device->shutdown_source == 0)
-		return false;
+	if (!device->ops->shutdown)
+		return -ENOTSUP;
 
-	device->shutdown_func = func;
-	device->shutdown_user_data = user_data;
-	device->shutdown_destroy = destroy;
-
-	return true;
+	return device->ops->shutdown(device, func, user_data, destroy);
 }
 
 static bool get_device_file_name(struct qmi_device *device,
@@ -1643,16 +1607,75 @@ done:
 	return res;
 }
 
+static void qmux_shutdown_destroy(gpointer user_data)
+{
+	struct qmi_device_qmux *qmux = user_data;
+
+	if (qmux->shutdown_destroy)
+		qmux->shutdown_destroy(qmux->shutdown_user_data);
+
+	qmux->shutdown_source = 0;
+
+	__qmi_device_shutdown_finished(&qmux->super);
+}
+
+static gboolean qmux_shutdown_callback(gpointer user_data)
+{
+	struct qmi_device_qmux *qmux = user_data;
+
+	if (qmux->super.release_users > 0)
+		return TRUE;
+
+	qmux->super.shutting_down = true;
+
+	if (qmux->shutdown_func)
+		qmux->shutdown_func(qmux->shutdown_user_data);
+
+	qmux->super.shutting_down = false;
+
+	return FALSE;
+}
+
+static int qmi_device_qmux_shutdown(struct qmi_device *device,
+					qmi_shutdown_func_t func,
+					void *user_data,
+					qmi_destroy_func_t destroy)
+{
+	struct qmi_device_qmux *qmux =
+		l_container_of(device, struct qmi_device_qmux, super);
+
+	if (qmux->shutdown_source > 0)
+		return -EALREADY;
+
+	__debug_device(&qmux->super, "device %p shutdown", &qmux->super);
+
+	qmux->shutdown_source = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
+						0, qmux_shutdown_callback,
+						qmux, qmux_shutdown_destroy);
+	if (qmux->shutdown_source == 0)
+		return -EIO;
+
+	qmux->shutdown_func = func;
+	qmux->shutdown_user_data = user_data;
+	qmux->shutdown_destroy = destroy;
+
+	return 0;
+}
+
 static void qmi_device_qmux_destroy(struct qmi_device *device)
 {
 	struct qmi_device_qmux *qmux =
 		l_container_of(device, struct qmi_device_qmux, super);
 
+	if (qmux->shutdown_source)
+		g_source_remove(qmux->shutdown_source);
+
 	l_free(qmux->version_str);
 	l_free(qmux);
 }
 
 static const struct qmi_device_ops qmux_ops = {
+	.shutdown = qmi_device_qmux_shutdown,
 	.destroy = qmi_device_qmux_destroy,
 };
 
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index ab0ee479c89d..df4bc39644a2 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -89,7 +89,7 @@ void qmi_device_set_debug(struct qmi_device *device,
 
 bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
+int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
 bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
-- 
2.43.0

