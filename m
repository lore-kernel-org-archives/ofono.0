Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F881722
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532666; cv=none; b=ggoBvZzIu0U4YY3s+FE8fRaRlHIyTQbzjjKZGaqXq/d1Cg8yXOrpoFgJXc9UABCPRIQrhPK1aplerMvt40ZRRtpsePzCjGHFJ33wCGIxh3uB3weqeL6eNncVlIFCIcJ7toYqZeuV0dLBwak+lnGE4Gfdaki93/pCYgwtZ3lO7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532666; c=relaxed/simple;
	bh=MBkliumkcgaCJjDou1BxR4NIIqfMuJQvc28YXNHyy+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr6FLXCMyEWSvbSh0geqFDoahKS3sbboNxkCsA9zgbKVDXB8dX4KSktUpkNm5KEc8xYHVJ36Rqm/ntfpoyffwkbl3bZA2NmY28lthJyC/nGC0yZzHsDabtWqIY5BSt/monxDUas+oBdivAkKVHJ8S3lDIPr0W/6kvY0SGiaum9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKM6nzJ9; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKM6nzJ9"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-599f5e71d85so4278641eaf.3
        for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532664; x=1709137464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfzu3QiTwEiyjKgpyR/+rDeqO020PiZW5paEtks8JqY=;
        b=TKM6nzJ9Hr1rYBuowMLXLpf3Qb/FJlWPtlKN15lgn5OiGOgd2HMSW3YUcNwkaULsJ5
         SJFJUb4Oig6YbZ2k7cf9R5HevNhmJ0lnwTr1zImOvZ+DHxH9hz0oJXk1FO0TbZzIfkjf
         y/QGde3WyUuZL3hNntoLEaXHW+z14jHbZ6z9IvJaOSpWejBwnRwlbLvGW1NQIydHledp
         7/9hAgExvrgkwcBVR7KXfCmZPuLngiLhTZTFIyxnr9rbU0MtjwdO8rsgzJGto+mJES5f
         b/QD2ouMSGqOud1zZv4fZhOw3jhdCs3rQWAfPRyYoZTMsfqWc+GkXDrsgGUOFGYDKfw+
         FMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532664; x=1709137464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfzu3QiTwEiyjKgpyR/+rDeqO020PiZW5paEtks8JqY=;
        b=r90ovry4DKrGBJ4orwYjgRZLs3WgIIG6P3N60l2DU7X/eFLBLeWDlEC0RYvN2i/BFN
         N88vE3b/xI55Ils27w+Tc2zfYZ28SPPCHmW0QOyWrW4y73EQNy6qo15uUePRpJXtnDOF
         xNvbnnfHyUdOZPblj4Di6fykI9Isuz2ZtZ0+fFMOjdts/ILixYaR40AhGYbkSVYhBxG1
         kXoHWoZqSZ/785FgInCfQJx28k92eTKO+L7uvXB1M0JFSJhmTNm8YsUzBMeYWjCrq+tQ
         aPS8MPbmbxgJiCy8+E3/ciYjENxSl+FX1MF/ueL1+8yNFGJwgI0UwiKPpXpw2ony99+r
         DuzA==
X-Gm-Message-State: AOJu0YwpjQ+F7N20HCUFxZQXR2eEzfXbHRveSLwZcwh1D+hqCbWpXLc8
	6vxEiRjjVuFrx+0jGhi+wzFCATgR3MNEIzNtWx+OJiSAIeCZgQSeToEZ4D69
X-Google-Smtp-Source: AGHT+IET8VOgGYlZYsuGjzQaSgFcwBD90Pn5KbCDlI7D7pVQ3LDCLz0mhaBdS1pdDz5PlkqJN5srIQ==
X-Received: by 2002:a4a:e8d0:0:b0:5a0:109f:edff with SMTP id h16-20020a4ae8d0000000b005a0109fedffmr1988861ooe.4.1708532663604;
        Wed, 21 Feb 2024 08:24:23 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j25-20020a4a92d9000000b00594ee4b4339sm1905405ooh.28.2024.02.21.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:24:23 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 3/7] qmi: Remove qmi_device_set_close_on_unref
Date: Wed, 21 Feb 2024 10:23:16 -0600
Message-ID: <20240221162335.1258315-3-denkenz@gmail.com>
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

The only caller of this method always sets close_on_unref to true.
Since the underlying file descriptor is no longer exposed, it is safe to
remove this method and assume that the file descriptor should always be
closed when qmi_device is cleaned up.
---
 drivers/qmimodem/qmi.c | 13 +------------
 drivers/qmimodem/qmi.h |  2 --
 plugins/gobi.c         |  2 --
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 7bfb4bc0d74b..07af29b42b36 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,7 +63,6 @@ struct qmi_device {
 	int ref_count;
 	int fd;
 	GIOChannel *io;
-	bool close_on_unref;
 	guint read_watch;
 	guint write_watch;
 	struct l_queue *req_queue;
@@ -924,7 +923,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->ref_count = 1;
 
 	device->fd = fd;
-	device->close_on_unref = false;
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
 	if (flags < 0)
@@ -994,8 +992,7 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->read_watch > 0)
 		g_source_remove(device->read_watch);
 
-	if (device->close_on_unref)
-		close(device->fd);
+	close(device->fd);
 
 	if (device->shutdown_source)
 		g_source_remove(device->shutdown_source);
@@ -1021,14 +1018,6 @@ void qmi_device_set_debug(struct qmi_device *device,
 	device->debug_data = user_data;
 }
 
-void qmi_device_set_close_on_unref(struct qmi_device *device, bool do_close)
-{
-	if (!device)
-		return;
-
-	device->close_on_unref = do_close;
-}
-
 void qmi_result_print_tlvs(struct qmi_result *result)
 {
 	const void *ptr = result->data;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 410ada04d8d7..ab0ee479c89d 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -87,8 +87,6 @@ void qmi_device_unref(struct qmi_device *device);
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
 
-void qmi_device_set_close_on_unref(struct qmi_device *device, bool do_close);
-
 bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 07994666ded5..e22b8146cf93 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -435,8 +435,6 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
 
-	qmi_device_set_close_on_unref(data->device, true);
-
 	qmi_device_discover(data->device, discover_cb, modem, NULL);
 
 	return -EINPROGRESS;
-- 
2.43.0

