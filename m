Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137815530F
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622128; cv=none; b=VOfsVjMoFmZ7spf8TVRk20O4NMW+yl/8nlJFO9qJIQ2evWJnhHS1C0f28Fqpr4sBtuslHwc+gNi7WR+rjuiIHwnMLvT8edOp8o71hLDf1YP5ljXpfklP8LjgNgaLyctL/y0BdhvqNGCmyjOTWvNLg1mfYqTli95OppBiFCzyB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622128; c=relaxed/simple;
	bh=229YxpFa+dzGCJCVcgZvN0sJCAsvMauC1K8EO6Ioxbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGWGWCUa8R8RgPBPTZd4kdTBneLL0GLXu+k43Ne705DmZazWCYsKVm22tGRQGOr2TL1I33wvvawrcFIPL7nNKkrXo6frr5uqgJmXue1cov7YGuBMzpukwu1tG1SHTfkUWi7TDkUJVY+gUF/+1Vz/InvaAPzdGnX3kzwUC5COwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DusomVnz; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DusomVnz"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c02b993a5aso4946723b6e.1
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622126; x=1709226926; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wiTNtc8DZaAnMbfsMLShOYB5fWSND5C3ZuWcKva8EA=;
        b=DusomVnzzgOYSTX+L8tV/zj2F5Z+ON2V6KtxHdGqw5dqTK0Jf0hnInNm2avd+R3kUv
         pRqZw2JxCofqGGUNJEn3TlsmMeEd9rBctF6Bcp9x1DwL/6E9rzfETIVPkJeb7XIXYCPw
         KvNhCtFQ2G8n9GtUJWAIVXJqwL+sjXRBV24Y+RY1Hz5txXBI4NV/pbdkgHvC9YQPS88/
         9FiYsVmxD7oPPwnFshsNsr5KmGiOrJfkl5UoWd9df+aJfer8PTVaVR1y7kJjniDgH5lo
         FWEapTDdZFy2C3jK/vp7cjeOJWg7xikaCOV6477b/n1IHxL35tfGexm1tOmAUMI3d5h4
         HrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622126; x=1709226926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wiTNtc8DZaAnMbfsMLShOYB5fWSND5C3ZuWcKva8EA=;
        b=lKT3nKJRqpGGgecj/QDUUDWaobokhC2fTRWaRh5+//YWClcVNLDE/wY48Ylr2tg12j
         nei7nZpctSdLNi6hMkqTcLqS7MaDbZGbDnP36c+6bn0ABPemXS/RIvgGTmkysV0EnqhO
         9FgvtTks7ULcH42xbYZ28td8BAZzzzodxn0lnQAsjJZ7+UDzz3sHSzj8yGEXwm5PI6nf
         n1tgUkkwYiPkk+5O9kdSf0klRkLiAoC+3AJ1NR9Zf4CSKvuBBeZdP4CsekVPStp4vc7q
         jNASPft9LC7Fbb6NZhaF2DGwGdWOcGE6S1BrjmLQ+kDW65K//eD1UbW86tbzCwYO+FeH
         voyA==
X-Gm-Message-State: AOJu0Yz0rsMBGR3RPnHNidkJAoT96PpMftllfz79Trk77Dvy1lwOA2/a
	s2IZqY4vElK58tCe9i91f6izyVMOrVXlL6fnJGNnppDz4bZZPCFDkZK8N6me
X-Google-Smtp-Source: AGHT+IEaBUSh14BIczjjdffrmP1uPALBHAF3RMKYfzqdGUZb7kkCah67ivqiknlpYfznXVURNXeRKw==
X-Received: by 2002:a05:6808:656:b0:3c0:a25:bb4e with SMTP id z22-20020a056808065600b003c00a25bb4emr20200013oih.35.1708622126308;
        Thu, 22 Feb 2024 09:15:26 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cc7-20020a056808324700b003c178f6a504sm355898oib.14.2024.02.22.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:15:26 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] qmi: Rename qmi_device_unref to qmi_device_free
Date: Thu, 22 Feb 2024 11:14:18 -0600
Message-ID: <20240222171438.1291553-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222171438.1291553-1-denkenz@gmail.com>
References: <20240222171438.1291553-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since reference counting wasn't used, rename qmi_device_unref to
qmi_device_free.
---
 drivers/qmimodem/qmi.c | 8 +-------
 drivers/qmimodem/qmi.h | 2 +-
 plugins/gobi.c         | 4 ++--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2dde31b11c7c..8587766efe1f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -63,7 +63,6 @@ struct qmi_device_ops {
 };
 
 struct qmi_device {
-	int ref_count;
 	int fd;
 	GIOChannel *io;
 	guint read_watch;
@@ -920,8 +919,6 @@ static int qmi_device_init(struct qmi_device *device, int fd,
 
 	__debug_device(device, "device %p new", device);
 
-	device->ref_count = 1;
-
 	device->fd = fd;
 
 	flags = fcntl(device->fd, F_GETFL, NULL);
@@ -967,14 +964,11 @@ static void __qmi_device_shutdown_finished(struct qmi_device *device)
 		device->ops->destroy(device);
 }
 
-void qmi_device_unref(struct qmi_device *device)
+void qmi_device_free(struct qmi_device *device)
 {
 	if (!device)
 		return;
 
-	if (__sync_sub_and_fetch(&device->ref_count, 1))
-		return;
-
 	__debug_device(device, "device %p free", device);
 
 	l_queue_destroy(device->control_queue, __request_free);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 14ad84e5006a..ef2140faad9c 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -81,7 +81,7 @@ typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 
-void qmi_device_unref(struct qmi_device *device);
+void qmi_device_free(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 4134c62d398e..2b29afbefdbe 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -147,7 +147,7 @@ static void gobi_remove(struct ofono_modem *modem)
 
 	cleanup_services(data);
 
-	qmi_device_unref(data->device);
+	qmi_device_free(data->device);
 
 	g_free(data);
 }
@@ -161,7 +161,7 @@ static void shutdown_cb(void *user_data)
 
 	data->discover_attempts = 0;
 
-	qmi_device_unref(data->device);
+	qmi_device_free(data->device);
 	data->device = NULL;
 
 	ofono_modem_set_powered(modem, FALSE);
-- 
2.43.0

