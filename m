Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC31649D5
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596710; cv=none; b=N2kiT6UWInEbXSMCHjoVPI+cO62T4D/jEKPKl8aKZAjD6wqcvXcBt+B6lkLkoJu42/HV3NAYlYMIR/hLWBRBFiWvVFdaTlOur8RI0h4PSGDfhVwtpmGXNTmiQOO+7O9eqtBNmOjWMl21eNF0oL7fTNbgv14n0pChJzOvopMjE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596710; c=relaxed/simple;
	bh=Gunr/qjMIkclvQedyJBGfjBytEGAYK6OuLgGc6JmGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3MvwZQzwJVXl6yvqictyHC3NG7LnERyy9qo5UNxPvNF/5ApyJywthBRZI4VX8qrX1CcV5u5+eEirApkgfta8K80lKUhG138ltcQkylBhLnIuwIQnOz8KaxEdPcJEWZRXPigAWDbgDnZPprN5e1qITKoYc10WLQmARJb2X1SwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6erMoWm; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6erMoWm"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb55942409so3512898a34.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596708; x=1715201508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r3pNIa4+6LSENenGG6k/WQKcRgRsvSXIdXsDs5j2ec=;
        b=J6erMoWm6iBuWQuubj3yckJbw4bDxPY5xdx6QEVEbN+C9JuJDE5vIXNOkqXT4ARrE9
         gE9+AGpXjF63uQ8xvcgfF84VeWFK9OOIXNFx0KpIQv7csxnBg5P7qB6Y6lxr8BuJ6nZS
         uNTgAm74C7AjXIlUD1WlW649h8d+xPQObArfeUby2j7StgcnGhdPYQbC7IrDZhj9ZAG2
         iu1LhULmGa+abyBGOFok3FLL/a/A3RBy6jVMGA60gy4sbrEZv9k6fmIVh8OfHI9TwrpQ
         UtP+6RxjqlH96EpnRRl+Gr0jvmUZQFHNkgvsP5pRD8OcxgBxGU4wD47JWyjeMl9lD+5C
         FYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596708; x=1715201508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r3pNIa4+6LSENenGG6k/WQKcRgRsvSXIdXsDs5j2ec=;
        b=S9geVEObcFH+apNC4kQAJ1wJ++afGChAZzMZfQqG6et1w+kl2MbQ0p5NAaxnfKxu9o
         uLXHQpBsKTKyiXbPLtu1DO2fvZORzA8u2gvKhB68xSwHwelflX4ulg/8zANgSt6AY9aO
         MNkw03V+b1LZiLT6wFrIHi07cIca6jOCWM7lxa2C9ZIKSqUs5O8My6re4Mtd0XIRz4+7
         gBAO7/d/4bMx7Eihy1u1IMOh8Jb5wgYUkf3SBECouwYCp8xGRjzWvHLHcS8lN6bZhtYK
         Wm4qVrUvFnMmVxcBNQXF34JaFsrZI+YVQaAHyMUdipVgX2BqOZYigCy1VrwgItA7RkHH
         5iew==
X-Gm-Message-State: AOJu0YxaqD2qUlhlToJ2gDoH3nH3nTiGZdZAMkgT+0xMNbqfvjkaekbg
	tYSuNvIAuF1zDz4c6Z7TGFmG08CSZjW2zFh+JHIzFfoY+398hbYMl/lAxg==
X-Google-Smtp-Source: AGHT+IHHMK4B58t/KskA9ev1kzM+ZcdLC/tnIiLSW/Mke/kMUjQYsoBE4ciiEUXkJRwwRs4X7BM7Aw==
X-Received: by 2002:a05:6870:4713:b0:22e:15fd:e247 with SMTP id b19-20020a056870471300b0022e15fde247mr4201063oaq.5.1714596708229;
        Wed, 01 May 2024 13:51:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] qmi: wds: add utility to parse Data System Status tlv
Date: Wed,  1 May 2024 15:51:26 -0500
Message-ID: <20240501205142.12777-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501205142.12777-1-denkenz@gmail.com>
References: <20240501205142.12777-1-denkenz@gmail.com>
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

