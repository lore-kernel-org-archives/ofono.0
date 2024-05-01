Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC01168AF8
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605711; cv=none; b=ft0ouXr97aBAPfqm83hx32ICEfkXOhCpbuHVdrmthQAwPnyIsIzxQBrg1M4XbNytU4sg4HfcbMpksJsnPJ6TWR/1bTPRu2nT/wo/zhj6eaAzBO7E+KhobWPESOqxaY6tUqYithBlVziAJLprN/zAOaWUMA5AOKRGF3R+Dp/qgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605711; c=relaxed/simple;
	bh=Gunr/qjMIkclvQedyJBGfjBytEGAYK6OuLgGc6JmGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCozxsr9t+2MWv+hjRxvzjoPlGSKThzu3mVo5LXe+snH9n78P5q06vV31MMLKpNqXuhcFu8WZeILlHQ2VINJLwRMRR79NmF2A7EIfBaq8RG91IDJhzvNrl31jppQTPQ8TYs9uAB+IULx5cZx7Qso6RG4v46vDW4omc2Puj/MKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNnfiXLo; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNnfiXLo"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ee135f6a21so2030902a34.2
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714605709; x=1715210509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r3pNIa4+6LSENenGG6k/WQKcRgRsvSXIdXsDs5j2ec=;
        b=TNnfiXLo222uYQafzds9FmIA0JbPV9XnIpQHPJUaIiOdcMiG9ckPOWQmdwBN/61mL4
         6zaecL4dcBOoBBzuctN4QMoYd81QR9OCZ3pxq9NhLK7McSSMFlUpHlb81YGou6IQ1be/
         lmZt7jDhd0SHbJ5KwKpbNygAImpXMYBKbio1m5tabNWUHJM+xF9SQRvO/vpwfObnE5RD
         20cTPDmoHDjz/9RsV9dVZlKWnHnUwXMTg+lRxPLKU3hG2C6Rv4PK545vYl9mC69BQriT
         dUDiRz2+FQ3LEgKbjTLhEwVLXzm+GPqFqQcuXN5gpAAR0nZ2vKsEDOS2JvFcQKWr6ZeQ
         BszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605709; x=1715210509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r3pNIa4+6LSENenGG6k/WQKcRgRsvSXIdXsDs5j2ec=;
        b=Mk6gVGjkAkZb4NFaZ8QVYTOdWFEjeCSg3GoYBIA29k0RpsDFEYhs/eagBjQFE2zs5N
         ECWKigizlgzL3Y0PVlE1yFK3cMLIBLOxlsjoyVBDxKys5J35RvSCLsGeMvgAayCuScg+
         Bw4b6hQurr/cw8vfu6FJ7/qjI63OyqI1tfT0oJULcxv74a+2GYJZ5Ih6liYyOgQh74TV
         LtfVJdqBWzBC9+cPEJT1eN9btxg+D2InwROMGxeKFjiXfRHf34Buy6NziXOHBfWm7HKN
         WrKQq6TRefjiWdoFb7R1PiS48nfZA+rJ7UVluAiOsU71zHfeSnjMxlL4j/4HH3LLI9gF
         eV8w==
X-Gm-Message-State: AOJu0YwlJbUPz2V3lI5wXQhxbPbZVW+wkByhSN93TFr87FbV/2y7Pi1p
	MNn0oLGPgnmktVchboUp4czWif06BaAmwwiEcjaw347iczOhmBtEKjUpqA==
X-Google-Smtp-Source: AGHT+IE1kw52QZ5RQqKAC/Xc3AeSZ+WYr4XUjSl7iHpi1M4a7+lOR0JYXyU6zVa6xpSutUv4orIPFQ==
X-Received: by 2002:a9d:66c8:0:b0:6eb:c398:4d2b with SMTP id t8-20020a9d66c8000000b006ebc3984d2bmr4456143otm.30.1714605709384;
        Wed, 01 May 2024 16:21:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830278b00b006ee4e216d02sm1128040otu.14.2024.05.01.16.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:21:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 5/6] qmi: wds: add utility to parse Data System Status tlv
Date: Wed,  1 May 2024 18:21:32 -0500
Message-ID: <20240501232144.14025-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501232144.14025-1-denkenz@gmail.com>
References: <20240501232144.14025-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/wds.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/wds.h | 17 +++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/qmimodem/wds.c b/drivers/qmimodem/wds.c
index d126f4712921..77e22f443db0 100644
--- a/drivers/qmimodem/wds.c
+++ b/drivers/qmimodem/wds.c
@@ -5,6 +5,11 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
+#include <stdint.h>
+#include <stddef.h>
+
+#include <ell/ell.h>
+
 #include "src/common.h"
 
 #include "wds.h"
@@ -37,3 +42,36 @@ int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto)
 
 	return -ENOENT;
 }
+
+int qmi_wds_parse_data_system_status(const void *dss, uint16_t len)
+{
+	const size_t network_info_size = sizeof(uint8_t) + 2 * sizeof(uint32_t);
+	uint8_t num_networks;
+	uint8_t network;
+	uint32_t rat_mask;
+
+	if (len < 2 * sizeof(uint8_t))
+		return -EBADMSG;
+
+	/* uint8_t preferred network type followed by number of network infos */
+	num_networks = l_get_u8(dss + 1);
+
+	len -= 2 * sizeof(uint8_t);
+	dss += 2 * sizeof(uint8_t);
+
+	if (len != num_networks * network_info_size)
+		return -EBADMSG;
+
+	while (len >= network_info_size) {
+		network = l_get_u8(dss);
+		rat_mask = l_get_le32(dss + 1);
+
+		if (network == QMI_WDS_PROFILE_TYPE_3GPP)
+			return rat_mask;
+
+		len -= network_info_size;
+		dss += network_info_size;
+	}
+
+	return -ENOENT;
+}
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index d896fd8cc535..94f1c028bd81 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -68,6 +68,21 @@ enum qmi_wds_profile_family {
 	QMI_WDS_PROFILE_FAMILY_TETHERED =	0x01,
 };
 
+enum qmi_wds_3gpp_rat {
+	QMI_WDS_3GPP_RAT_WCDMA			= 0x01,
+	QMI_WDS_RAT_3GPP_GPRS			= 0x02,
+	QMI_WDS_RAT_3GPP_HSDPA			= 0x04,
+	QMI_WDS_RAT_3GPP_HSUPA			= 0x08,
+	QMI_WDS_RAT_3GPP_EDGE			= 0x10,
+	QMI_WDS_RAT_3GPP_LTE			= 0x20,
+	QMI_WDS_RAT_3GPP_HSDPAPLUS		= 0x40,
+	QMI_WDS_RAT_3GPP_DCHSDPAPLUS		= 0x80,
+	QMI_WDS_RAT_3GPP_64QAM			= 0x100,
+	QMI_WDS_RAT_3GPP_TDSCDMA		= 0x200,
+	QMI_WDS_RAT_3GPP_5GNR			= 0x400,
+	QMI_WDS_RAT_3GPP_NULL_BEARER		= 0x8000,
+};
+
 enum qmi_wds_command {
 	QMI_WDS_RESET					= 0x00,
 	QMI_WDS_EVENT_REPORT				= 0x01,
@@ -111,3 +126,5 @@ enum qmi_wds_command {
 
 int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method);
 int qmi_wds_pdp_type_from_ofono(enum ofono_gprs_proto proto);
+
+int qmi_wds_parse_data_system_status(const void *dss, uint16_t len);
-- 
2.44.0

