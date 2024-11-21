Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A71369B4
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202994; cv=none; b=ltB38FXqQ7h5O16bltTf80EE6bAztlymuB9QwTRwJIOldgSFmoC5FheRtRHyN5mLb4umn5EPtLS+qmbysd4YMcEXsYtKZ+4BZ2ppwAmwF/fsZCIPJ25zjEVaGHwk6SbhgCQGsvagwUR8N6wLDN7v3tSFAhtFGxy+ZHIUgxQ3M/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202994; c=relaxed/simple;
	bh=cOXjnlud4QKvzsTQ4OznMq8o9Vx9AcDQ5rCN6r1aqhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVXwS7BjotusIZsv2q12sQan45UorP20/E2YXurMcx/cELQx9aUnSbK//pB2U1V0ZddBE49wvtbEAmaDAMubYmCSC/tS2mqMRd6Z4Qn4unw4Fqe39qSRcxOm875i1M5F7bGXOqXJgfNaDoi48a3GVSpN17roT+3T7WlPyhz8zr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzcrJep2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzcrJep2"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2965e10da1bso573367fac.0
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202992; x=1732807792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UGQrXToXTTTC19kbDwKCetW1cXwDHGKCfCEl17ztIg=;
        b=lzcrJep2yKgt+qLW2vuavMX7lbYfxbHj2J9XKtJX0gupN/WaZ3aTM78QhoJRazUeGG
         GDqWcdmaT2LlaG6P7ai+VDcplFzzhkUeSQlpD60pJcMgb524GLX0TEcpDDvav8ehpKVU
         cMQmeVWW9pRdq+dBdf/O9euGmNekZMb0Ybw+PcmmjnNlQQ81UEpJV5fxgjQPJenEQHEZ
         hY86pd2iYkSdjHgQEEBCMf+IBaW9X6EmMDEuSoKFCu5YNXOgeEsLnh4NTC2jUAkoqYc4
         BjPQ3oNJXxgHy9Ca5SH+RLonSdx8nXCl2GLA8OkeJAYTwtkCC3nLWBtq/y+vqGJJP7o3
         Jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202992; x=1732807792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UGQrXToXTTTC19kbDwKCetW1cXwDHGKCfCEl17ztIg=;
        b=qaHBkwbaqz1LVL28CvNxwwWb5bO+rDdOcCsHztiJrOUYh6igJPZMitKCPDVBVcb63R
         i2QpwA7jXFTpoVGqtnAPrvQ15ywMH4zjJshFzdbuBIdD3uzd3RL2VxTBTzYcH92Qrxvl
         +1bT2U6k4RZ5GWV+SVIeRpTnm7Ll0ZiQ5H2f+iI7qam5MwNpkKSjGYEwWM+z7beFsr0u
         5C3KZbJxztVc6uBo2O2gTfVcQY/tHF8MD2lL0hcBliQrVoRVDvWi3Zg8ti38yyG0rjm5
         dhJfrA8M0d+JkumRHLGzvWDn4C8ICHzTnExEICVM+dGSGLlUTtSKBZ3KOjvsZrYRN2Ct
         1pHQ==
X-Gm-Message-State: AOJu0YzJcyu4r8igqr7TGkZLbJrhXwnI+U/sftlt+9BXXAKgySODHnj1
	u9htrVF1vIN4c/2snnynuk6TiGksrzxZC+xdpqT7ZogR59fK01zjNSpF8w==
X-Gm-Gg: ASbGncvXYhUzYmV7ir3NJkf5rU32JzuCmBXaL88VG4lui1OvQ9mVAwIMsL5+azKlv8J
	Ae9d4dgF8pEZ4qDpTPCvN6hGjdRLzC7OJ5yukgZ6tp0Ip7N8XtDBEMBukRAEP3566gQjcjnp+F/
	8Il/Xo02fQymc0mZ8IFcE8evjJ17XbZEoo/baMVF+XxVW3mrXXdPKygvx94JD6kasPNjWqqSBJn
	ZJyKWkvHUPQQ4qExY+OwXEguPLi5JlKQejHhd8elIS81RNFPzb8jJtOGn9/vAa+diPDXHXbrveG
	QZGd3k7I0SpXxIn48NWPG3ZG
X-Google-Smtp-Source: AGHT+IGwgMguNYjE5M0s0oI2WpvmCV8hvmtqnOj9ZpWRKyHsQYc40O8DXvMfIseqwcumqyjfzw81dQ==
X-Received: by 2002:a05:6870:b507:b0:296:80aa:a9b7 with SMTP id 586e51a60fabf-296d9bf04f9mr7114432fac.21.1732202991661;
        Thu, 21 Nov 2024 07:29:51 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:51 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/10] qmi: wda: Add qmi_wda_set_data_format utility
Date: Thu, 21 Nov 2024 09:29:29 -0600
Message-ID: <20241121152949.56962-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This utility function builds a WDA Set Data Format message and sends it
to the desired wda service handle.
---
 Makefile.am                     |  1 +
 drivers/qmimodem/common.h       |  5 ++++
 drivers/qmimodem/gprs-context.c |  6 ++--
 drivers/qmimodem/wda.c          | 51 +++++++++++++++++++++++++++++++++
 drivers/qmimodem/wda.h          | 23 +++++++++++++++
 5 files changed, 82 insertions(+), 4 deletions(-)
 create mode 100644 drivers/qmimodem/wda.c

diff --git a/Makefile.am b/Makefile.am
index d107dc410fd2..2d198f52a4a0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,6 +366,7 @@ qmi_sources = drivers/qmimodem/qmi.h drivers/qmimodem/qmi.c \
 					drivers/qmimodem/pds.h \
 					drivers/qmimodem/common.h \
 					drivers/qmimodem/wda.h \
+					drivers/qmimodem/wda.c \
 					drivers/qmimodem/wds.c \
 					drivers/qmimodem/voice.h
 
diff --git a/drivers/qmimodem/common.h b/drivers/qmimodem/common.h
index b0788285b5e7..1610f1da9e45 100644
--- a/drivers/qmimodem/common.h
+++ b/drivers/qmimodem/common.h
@@ -76,3 +76,8 @@
 #define QMI_LTE_BAND_MASK_EUTRA_41	0x0000010000000000
 #define QMI_LTE_BAND_MASK_EUTRA_42	0x0000020000000000
 #define QMI_LTE_BAND_MASK_EUTRA_43	0x0000040000000000
+
+struct qmi_endpoint_info {
+	uint32_t endpoint_type;
+	uint32_t interface_number;
+} __attribute__((packed));
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 89d68d154ed8..a8ac3cb18c80 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -17,6 +17,7 @@
 #include <ofono/gprs-context.h>
 
 #include "qmi.h"
+#include "common.h"
 #include "wds.h"
 #include "util.h"
 
@@ -715,10 +716,7 @@ static int qmi_gprs_context_bind_mux(struct ofono_gprs_context *gc,
 	struct qmi_param *param;
 	const char *interface_number;
 	const char *bus;
-	struct {
-		uint32_t endpoint_type;
-		uint32_t interface_number;
-	} __attribute__((packed)) endpoint_info;
+	struct qmi_endpoint_info endpoint_info;
 	uint8_t u8;
 
 	bus = ofono_modem_get_string(modem, "Bus");
diff --git a/drivers/qmimodem/wda.c b/drivers/qmimodem/wda.c
new file mode 100644
index 000000000000..cf32aa094d69
--- /dev/null
+++ b/drivers/qmimodem/wda.c
@@ -0,0 +1,51 @@
+/*
+ * oFono - Open Source Telephony
+ * Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include <stdint.h>
+#include <stddef.h>
+
+#include <ell/ell.h>
+
+#include "src/common.h"
+
+#include "qmi.h"
+#include "common.h"
+#include "wda.h"
+
+uint16_t qmi_wda_set_data_format(struct qmi_service *wda,
+				const struct qmi_endpoint_info *endpoint_info,
+				const struct qmi_wda_data_format *format,
+				qmi_service_result_func_t func,
+				void *user_data, qmi_destroy_func_t destroy)
+{
+	static const uint8_t PARAM_LL_PROTO = 0x11;
+	static const uint8_t PARAM_UL_AGGREGATION_PROTOCOL = 0x12;
+	static const uint8_t PARAM_DL_AGGREGATION_PROTOCOL = 0x13;
+	static const uint8_t PARAM_DL_MAX_DATAGRAMS = 0x15;
+	static const uint8_t PARAM_DL_MAX_SIZE = 0x16;
+	static const uint8_t PARAM_EP_INFO = 0x17;
+	struct qmi_param *param = qmi_param_new();
+	uint32_t req_id;
+
+	qmi_param_append_uint32(param, PARAM_LL_PROTO, format->ll_protocol);
+	qmi_param_append_uint32(param, PARAM_UL_AGGREGATION_PROTOCOL,
+					format->ul_aggregation_protocol);
+	qmi_param_append_uint32(param, PARAM_DL_AGGREGATION_PROTOCOL,
+					format->dl_aggregation_protocol);
+	qmi_param_append_uint32(param, PARAM_DL_MAX_DATAGRAMS,
+					format->dl_max_datagrams);
+	qmi_param_append_uint32(param, PARAM_DL_MAX_SIZE, format->dl_max_size);
+	qmi_param_append(param, PARAM_EP_INFO,
+				sizeof(*endpoint_info), endpoint_info);
+
+	req_id = qmi_service_send(wda, QMI_WDA_SET_DATA_FORMAT,
+					param, func, user_data, destroy);
+	if (!req_id)
+		qmi_param_free(param);
+
+	return req_id;
+}
diff --git a/drivers/qmimodem/wda.h b/drivers/qmimodem/wda.h
index fd1e1f63ab1e..4facc0cb6677 100644
--- a/drivers/qmimodem/wda.h
+++ b/drivers/qmimodem/wda.h
@@ -5,6 +5,8 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+struct qmi_endpoint_info;
+
 #define QMI_WDA_SET_DATA_FORMAT	32	/* Set data format */
 #define QMI_WDA_GET_DATA_FORMAT	33	/* Get data format */
 
@@ -16,3 +18,24 @@ enum qmi_wda_data_link_protocol {
 	QMI_WDA_DATA_LINK_PROTOCOL_802_3 =			0x01,
 	QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP =			0x02,
 };
+
+enum qmi_wda_aggregation_protocol {
+	QMI_WDA_AGGREGATION_PROTOCOL_DISABLED =			0x00,
+	QMI_WDA_AGGREGATION_PROTOCOL_QMAP =			0x05,
+	QMI_WDA_AGGREGATION_PROTOCOL_QMAPV4 =			0x08,
+	QMI_WDA_AGGREGATION_PROTOCOL_QMAPV5 =			0x09,
+};
+
+struct qmi_wda_data_format {
+	uint32_t ll_protocol;
+	uint32_t ul_aggregation_protocol;
+	uint32_t dl_aggregation_protocol;
+	uint32_t dl_max_datagrams;
+	uint32_t dl_max_size;
+};
+
+uint16_t qmi_wda_set_data_format(struct qmi_service *wda,
+				const struct qmi_endpoint_info *endpoint_info,
+				const struct qmi_wda_data_format *format,
+				qmi_service_result_func_t func,
+				void *user_data, qmi_destroy_func_t destroy);
-- 
2.47.0

