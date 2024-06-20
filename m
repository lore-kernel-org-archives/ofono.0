Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B71AE84C
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895124; cv=none; b=WEyaX1wpnelOvEcZ4vCr34emnyRI3QDS+N3kCweDH9+xctMRZWB1mb8BWm7TYnMe/4AAZ1sUmIzOgKt6JCSics4F/cL+JWBaAydzOj3rjKCAO/KEqszHwRCT3/dMVzNgMts99yyoqY2XHI2CqxZOe/LBOYF412Mlmzez7Rq2pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895124; c=relaxed/simple;
	bh=ckvNClCkY8uqwNMkaBkcQ/Dv+40u6hUo0a6BgUt+mCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWm+k7uqJ8INIEu2rYw8RNyOn8UUws3pEDtLYQJ8ThrIUqCIJGmZPbOOmtdl5EfcNw/JEB9XPC32JVN1C7nLui/eVvlDeytJug5/frnjGSKEAWg3N2WPHHByUMChx3V9ASOvMkYLKraezGDw2P6pRXqu1ak2sweelXUK46PZCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnwfrdCe; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnwfrdCe"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d2255f84e9so816649b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895122; x=1719499922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0LW8jWwDVbJfyz4Pq2lQKVb+OW0QTh8Ef+fpjZXzDw=;
        b=gnwfrdCeFI8qw1UvCa338EF0bGy/X5ov5FLNc57DnY7CTnFo8+YNfk1dxOXirHiCMi
         Busuk2y0+65rpTPgUNKmLA2Bl+JAApBE5CgWJe5D74SuVmOHYlaJYed7/eR1GqXKGvtg
         pNAgn5agk7O5gPhvjm0HFOAhMbwzxVGtpz+ZKmCHzDEFC73l3d0eFYGUKmtwyroYNTRZ
         Dp/WYnwdnD+lzd+tS74P4qocyKq0TGcMogcWLluq+AFzqzlRE3FNShWy0ht+wzs6NVei
         AGPre3RghX49resl0wrwSlS1xY4QE5op8Pj2JKm1kHklgvZWAF9tUQKbwOt6SRAOxf08
         kwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895122; x=1719499922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0LW8jWwDVbJfyz4Pq2lQKVb+OW0QTh8Ef+fpjZXzDw=;
        b=HEoFcnvtS60oqUf6RydQjlZGN1lLpLq66qQpVbpChMTjpczwVtIHfOOsr9M7rd2mQr
         g0OxAMebX/oOCho2yoGZLwJznV4nUpbMcqVmVWCiV48VqkbnjbeJO0QqbADKbW51d/3w
         VXMaXsnWaKEUvCEtUNylMRisz1nkqQRxzAVwo+xO4/plnurmP7zx+Hu61+gUt3m97h10
         CzKh4eVLn+Xut+2r9UKsUsXbCRFFPqbU5i6qddxkfMKqWpeMjkDpw8AfPuM6YAMaMwUH
         9S+8J5GxQBXxTJl6YF7dQs5p/+IbCdkeyxtF4YScMSxxElZHlAMy7Pfiu22UdChA1R11
         spBA==
X-Gm-Message-State: AOJu0YwVrKadSB5xS6VZyk6w9/z6vxN8KWd/gQwyRTlF9bTPyZQVoLLn
	BKaRjQLhDGcqvS/ld0z+wvMM6JCbkcLtO3yEARxOLvQ/ZoPmEi4aBWVngQ==
X-Google-Smtp-Source: AGHT+IFbuQ8feFz/ImZOC081Kq4ICwdtHTKSE5oj3NbgVP8oaCd86Q3XLmzkCr1shatxxjQB2ASHdQ==
X-Received: by 2002:a05:6808:190a:b0:3d2:2995:f92b with SMTP id 5614622812f47-3d50f11c625mr4401512b6e.23.1718895121314;
        Thu, 20 Jun 2024 07:52:01 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 12/33] qmi: Rename qmi_device_new_qmux to qmi_qmux_device_new
Date: Thu, 20 Jun 2024 09:50:59 -0500
Message-ID: <20240620145139.1135899-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620145139.1135899-1-denkenz@gmail.com>
References: <20240620145139.1135899-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/qmi.c | 2 +-
 drivers/qmimodem/qmi.h | 3 +--
 plugins/gobi.c         | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a845e3809090..9fdc209edf7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1991,7 +1991,7 @@ static const struct qmi_device_ops qmux_ops = {
 	.destroy = qmi_device_qmux_destroy,
 };
 
-struct qmi_device *qmi_device_new_qmux(const char *device)
+struct qmi_device *qmi_qmux_device_new(const char *device)
 {
 	struct qmi_device_qmux *qmux;
 	int fd;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 10202fba6128..966d4f354d6e 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -68,6 +68,7 @@ typedef void (*qmi_discover_func_t)(void *user_data);
 
 typedef void (*qmi_service_result_func_t)(struct qmi_result *, void *);
 
+struct qmi_device *qmi_qmux_device_new(const char *device);
 void qmi_device_free(struct qmi_device *device);
 
 void qmi_device_set_debug(struct qmi_device *device,
@@ -87,8 +88,6 @@ enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
 			enum qmi_device_expected_data_format format);
 
-struct qmi_device *qmi_device_new_qmux(const char *device);
-
 struct qmi_device *qmi_qrtr_node_new(uint32_t node);
 struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
 						uint32_t type);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index d1da5fbc366b..5463a46edecb 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -501,7 +501,7 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (!device)
 		return -EINVAL;
 
-	data->device = qmi_device_new_qmux(device);
+	data->device = qmi_qmux_device_new(device);
 	if (!data->device)
 		return -EIO;
 
-- 
2.45.0

