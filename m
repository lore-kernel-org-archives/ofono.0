Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE321AE858
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895126; cv=none; b=CN+uZjs1Alq087bikn6QLwY9n1tTZL5jr4GBHyF0lTnvamqSm52LGoVe8YtJpXm/at3uaH48vvv3S7QzR41kcUaP5+6Ct2z2DvSfKCDN9+SMXeorHnQuCeZCyZrXwcMETdyyK1EFav368Ym5FFrOMoSRS/ox+42gaj8o8Pu/3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895126; c=relaxed/simple;
	bh=GAqRu0UuVLiqGXJEiwY1oyEPTDDwCivuH3oQ7lf4cMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8l9ZK1QVM1hCzr91w53Afoc3COOnVr7OAkfyV2gLv6LjttXM+24icufAZtvLUm8U1cNayKmd/J82N0weP3KccDQnPEl70Nts9GFH/KeRqDMFzKa1H/BVbuEEgpG7SjAwQDAM4gYHZ0PHRE0kThIVJ8NVwuLEM1ww9oQ2pXvnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFFBEQZo; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFFBEQZo"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d24724514eso540311b6e.0
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895124; x=1719499924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdvBzpreMqSB4QFmQSbJhuOcwt1m+b92CFyWwcvJqak=;
        b=nFFBEQZofO3AQ8/otbGaMIB0o+c3FDRUSxxPd01XtftOhCAmvNCkvik5+4ry6S6fQV
         r41l6wMrxH6YzVflMxTPbPcQ4u7jJ3UJljVxrGExFEfyWzXO2Bcbm/mrcalXSBNJatl9
         6LfLmkbA2K0CFvEIteDuF5JGCn6o58O6hC8wwmep+A85FsIFsARHI62jloGhj6Om5RKN
         9wi7XjxnC9QUi77uJpo8hUuzRoxMV/1EETXfajCVQ7WY5ekItOPCH7Td8PS1LJEVjc5O
         8LIEkO4Ujs0MeI4iAfdXJOOGWvxciTL0uO8Dv8RO2Ka+ebPTjORSvco1E9qVDJAqg9aR
         XBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895124; x=1719499924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdvBzpreMqSB4QFmQSbJhuOcwt1m+b92CFyWwcvJqak=;
        b=MxhBvhlxcvKwbZjF/oj6xk7OaHrOPjyd4oxEbY/yWqjbnXcN5WJHMlrJABNsc828EW
         0IYmwI9dyMAWb8EIwkhEB78pGrbEMY4sBpq2nDu3GjP5bJ0SKBGlR8TdYG5ZOGNFB+h2
         FM7oOkvn+y0R434/fyn1DXUXFD0laNrvK4gRyMHOOyyKfnYc6JLxhqKH8WqFw3MNQj19
         e/6AHCLsJvrx6dGs8tvPphszGjO0szfQlV3jQjaGSs8FzpNY/sh5bvwsJPjp7xPSN0KQ
         vHyNazvo4GbLdk3D7KB5NjmTpf+p5SkkNCjAkjapt1MrMJpU5LdH817u/qDo4o09/VpT
         rulw==
X-Gm-Message-State: AOJu0YzzK63Hwhais+JJSXoe1kEJSuEPoVCZQH3Q6HHE/d7ur5WF20UG
	EVBYvtjJFptXjehTl/Au3RaRl8zxjFCS/MC6hr4sidgmCIFwGBKzhQ3AHg==
X-Google-Smtp-Source: AGHT+IGBk/NSSWbb5w9r1ZjRRfBWbpUdnt43fteDKEsPXSX/tq6ZJEfCE79JOalKIhTGYO7IE4cY6g==
X-Received: by 2002:a05:6808:1592:b0:3d2:4edc:1ffd with SMTP id 5614622812f47-3d51b96c223mr6689584b6e.12.1718895124334;
        Thu, 20 Jun 2024 07:52:04 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:52:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 15/33] qmi: Rename qmi_device_get_service_version
Date: Thu, 20 Jun 2024 09:51:02 -0500
Message-ID: <20240620145139.1135899-15-denkenz@gmail.com>
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

This makes it more explicit that major/minor attributes are only
supported by QMUX.
---
 drivers/qmimodem/qmi.c | 3 ++-
 drivers/qmimodem/qmi.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 89645c1d6704..a56e5588c698 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -988,7 +988,8 @@ static const struct qmi_service_info *__find_service_info_by_type(
 	return info;
 }
 
-bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
+bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+					uint16_t type,
 					uint16_t *major, uint16_t *minor)
 {
 	const struct qmi_service_info *info;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 90e83a4dbebd..da245e50ea50 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -77,6 +77,9 @@ bool qmi_qmux_device_create_client(struct qmi_device *device,
 				uint16_t service_type,
 				qmi_qmux_device_create_client_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
+bool qmi_qmux_device_get_service_version(struct qmi_device *device,
+					uint16_t type,
+					uint16_t *major, uint16_t *minor);
 
 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
@@ -87,8 +90,6 @@ int qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 
 bool qmi_device_has_service(struct qmi_device *device, uint16_t type);
-bool qmi_device_get_service_version(struct qmi_device *device, uint16_t type,
-					uint16_t *major, uint16_t *minor);
 
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
-- 
2.45.0

