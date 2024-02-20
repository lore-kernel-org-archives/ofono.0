Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397A153BE6
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468927; cv=none; b=e2WB6Sqr1z9k8riYzpV2qf8s7kaPwRgZZH7OygNDQSVEqK73gX7Bq2mSZNpsk4GX33AZh+mdWzlb1sC1iJwtbAyoUzTfVNll65hI6bu7/VKFs9Q4KddvxAPBK+ZX+IB+32T6jIcQSRBzxHirvuxJhYZi769mB/XjSyI/nIIalfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468927; c=relaxed/simple;
	bh=qvDZmHmEZTId2QSMfa1f9fQMjNM1/rS6esU64eFhnzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht+bwmkxEkfVRk7D7kdA7Emm7JPfUgpbeVTzUawVoKvKwti6gqZIfhqXQhYKeqWsBO8/mGEIPzTlugdKHfOZfubclm6MpzQ8MtaemK3sgXyOrQUBOmj/sXaAOuVmHVus1P43BX7Enz390Py5Z5+0YCPI/CpRxxSwhY3yuPLmoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkzjLiVK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkzjLiVK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e28bd74883so3387878a34.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468925; x=1709073725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDfOnIP1F+LKQjT2c7FZmbYnZMm10x7fHbhEec8jENY=;
        b=AkzjLiVKNgLQcI4ZJLO+IMKhIvCxIfDOgQWME7Mlut3g6KIN6uWbsqRi3+WfF1o8js
         zVyKdLxmJIxiImhBu4lbrSxvl6NCrKSq7Eozl51r33NYYL78sbJ1tL3YIJl6s5EowjGP
         6FnBDI54N0bWDOZW2RNuLds2uXaM4lYODdP2GSzL5Tw6G9t2XLUBqLmwXfVGRkSKTz5R
         +5AEDFRC2xZbXMo/l1uXkBS9rfv434jhxvAivjvixhUwCnsJ1eX5NTRYiMAL2N8movcL
         cUyLNfJPMgdn/VXrNp+lk9LBxiy++gbxQWrSU7gh/V1e8e2DEkcD610730J/mZ848Byc
         Odpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468925; x=1709073725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDfOnIP1F+LKQjT2c7FZmbYnZMm10x7fHbhEec8jENY=;
        b=gLQjskTLnuIihwCCfnX1GNvWQ9kn3K2hY2Ton2rIzLP1exsTUUsV28U3kd7CbNBzsj
         bDj40Nk85wnxvQ2FyhLzPDPsaKIiLxL2hHpeOvJYBqPJgQllF159AZPKnq0fpS9hWDIt
         B+Bv7Sz0japEkE+mjTG8riqRobYL1qvjd/J5JIyB0v8u2KXUJOMPR0eVi39uoOKILku+
         u5zYuNh6FriPEhZgqz794qwWf0NwnEcnPsh6kZilWAZkR6g7ol33/huSLTHk+wacnvCs
         gasAV0W4G1AYaFYMylAeDQ404pOkgvONS6bvC+SYgMwAquMEgaNxasqrBNSeEswSaEf/
         ShRA==
X-Gm-Message-State: AOJu0YzDG7fV2g0swf+W0B6JhFrVUryR7M0YM2swCzTaEZoM9XxsDpFC
	rvUUYbsD0fS70WIELVCaTwV4skJjq1Mu4KKMGs5AeD0e/AUzJsCIKKJnhQqE
X-Google-Smtp-Source: AGHT+IFRfAcZJUOCiP0h6KtPJH1qzJVxVUiluSkpialj+yHq8Sk3RrqOwUwHQ0dYfuVCmReaqTwL4g==
X-Received: by 2002:a05:6871:73aa:b0:21e:74d8:8f49 with SMTP id na42-20020a05687173aa00b0021e74d88f49mr5233505oac.24.1708468924790;
        Tue, 20 Feb 2024 14:42:04 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:04 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/7] qmi: Remove qmi_device_set_close_on_unref
Date: Tue, 20 Feb 2024 16:40:56 -0600
Message-ID: <20240220224115.1254853-3-denkenz@gmail.com>
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
index 89e1f8f40381..8de5170674f8 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,7 +63,6 @@ struct qmi_device {
 	int ref_count;
 	int fd;
 	GIOChannel *io;
-	bool close_on_unref;
 	guint read_watch;
 	guint write_watch;
 	GQueue *req_queue;
@@ -969,7 +968,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 	device->ref_count = 1;
 
 	device->fd = fd;
-	device->close_on_unref = false;
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
 	if (flags < 0)
@@ -1047,8 +1045,7 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->read_watch > 0)
 		g_source_remove(device->read_watch);
 
-	if (device->close_on_unref)
-		close(device->fd);
+	close(device->fd);
 
 	if (device->shutdown_source)
 		g_source_remove(device->shutdown_source);
@@ -1074,14 +1071,6 @@ void qmi_device_set_debug(struct qmi_device *device,
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

