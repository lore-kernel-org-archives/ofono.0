Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C95176255
	for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895112; cv=none; b=hwGjxwBwUcJs53WQHoO6z/vNu6IVQZ74nNe9ZhycJfJnlHGEgYKp4+QSzAFNf9e/wdNtrp3vG9IBXeBpsBQnze8cHvMuWaA72BFV35PcIFrLfFQ1eYejYOQfvEn0uoG29famf7wjCNgUxg7lO/nkvaAkN94vagoHNbuJbi1DRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895112; c=relaxed/simple;
	bh=cvtgdm1y3G36NkEXoYKr7nrLcI+ssUA9k2ctylwZ3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFptp+LCVN97xqM11zsQI/nN3prXeM6RLPoXjGkgzvhnhx8okPKCGM0hrvLEp+X7XOyy9XGCT28yJ6FEkUA/Mr6QH87D+dG53kmtY1dTiCrj0rtVnZaBEW1gyr0W91uLCEAQhVPGUyISs8Q4FK+gt0ODzh7ETOtFjSHZhpcvE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+jLopac; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+jLopac"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d518cdb252so453116b6e.1
        for <ofono@lists.linux.dev>; Thu, 20 Jun 2024 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895109; x=1719499909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=j+jLopacvHYFPWtSpjXUcUbPL8XWCOf4pdGZLyikTiWqOqMEigMkzABMeBw7Z1vBMC
         0ej8IW6tdTmU8fispdyWSwmJXtkUD0YJa7AHIPd3/w+G0zebqzbs0kIrm9363JW8N9b3
         C96DsRYbD4qKaAYNMDelUbw/oxgDcmwr+N9xJtY9w0SmqkYUbrwkgpKmNc1ANH4XiS/i
         CpdNlu3vLtB3BMRTNaEUnUH+UQvGdkzWCF6Hu5+qPv14JKGdTiFlxjssqUKrvhkCfKFv
         0s2FY4zQcUaZ9tuUfiziycNs0szZ2eva3iGVSOq2TsCw13HcXRwnD7HiReXPClGYXc+E
         mlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895109; x=1719499909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=j69urtfFEWnNIojtkLygUPbvN8GkLXhGZYDPx1Hk694fhZotzkVbdj9FHtM2bEkQNM
         LehOPrN8bXZSDfij4OYzfLUlNP0RwU3F79/dTNf0pPgxOEYSDSWS3pztzfOLPUBUfx3J
         4e8tvjXIIJc9ClmK56O26OHl1Z79Itx4vP0bsy9EIhhSqwIo36x8rrVitjFBMkoqAubb
         5MVj+VN9ql/S2CaCZuxW5V/lCy/aijFjxlq2nqoWWJfOre4ZnOy1Xc3HRVj+0z+b99sT
         tejmEqYXTBtyrHZ8utQhtauBK8mbYCwSLIHCAO6TVH6+AbI0gkRcv4Zmkz8SjUbWpU/+
         6UIA==
X-Gm-Message-State: AOJu0Yzi3g5J3nzv7F0apd0ACFp2exvp8y4DRucHUpJPR+AW8Ie1K29x
	VwlgA7TPM26xUVabNfmMKuVUzktTrTXdMmZ9XDRwu5ei8C5Ix25DxoxAoQ==
X-Google-Smtp-Source: AGHT+IFAvWOFstPzofhc2kKxZigCB6gqrpub0FeMxRIQnbDo5hOmI0vZyQ/Lmr1PogzmMThq7gvwNg==
X-Received: by 2002:a05:6808:238f:b0:3d2:2a43:1c03 with SMTP id 5614622812f47-3d51b96c6e0mr5729881b6e.9.1718895109459;
        Thu, 20 Jun 2024 07:51:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476069ffsm2510209b6e.13.2024.06.20.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:51:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v3 04/33] qmi: Add qmi_qrtr_node_get_service
Date: Thu, 20 Jun 2024 09:50:51 -0500
Message-ID: <20240620145139.1135899-4-denkenz@gmail.com>
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

Introduce a new method that will return a qmi_service object handle
immediately, if possible.  This allows the lightweight service handles
to be obtained without requiring the caller to provide a callback
function and waiting for the event loop to invoke it.  On QRTR, the
underlying socket can access all services directly without needing to
exchange any messages to allocate a client for that service first, as
done by QMUX using QMI_CTL_GET_CLIENT_ID.
---
 drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
 drivers/qmimodem/qmi.h |  7 ++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c5a4a37b917d..c3b1f7fef64f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2332,6 +2332,32 @@ struct qmi_device *qmi_device_new_qrtr(void)
 	return &qrtr->super;
 }
 
+struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
+						uint32_t type)
+{
+	struct service_family *family;
+	const struct qmi_service_info *info;
+
+	if (!device)
+		return NULL;
+
+	if (type == QMI_SERVICE_CONTROL)
+		return NULL;
+
+	family = l_hashmap_lookup(device->family_list, L_UINT_TO_PTR(type));
+	if (family)
+		goto done;
+
+	info = __find_service_info_by_type(device, type);
+	if (!info)
+		return NULL;
+
+	family = service_family_create(device, info, 0);
+	l_hashmap_insert(device->family_list, L_UINT_TO_PTR(type), family);
+done:
+	return service_create(family);
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	return l_new(struct qmi_param, 1);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 3e532ec25abd..604e4e7e8659 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -58,9 +58,9 @@ enum qmi_data_endpoint_type {
 
 typedef void (*qmi_destroy_func_t)(void *user_data);
 
-
 struct qmi_device;
 struct qmi_result;
+struct qmi_service;
 
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
@@ -90,6 +90,9 @@ bool qmi_device_set_expected_data_format(struct qmi_device *device,
 struct qmi_device *qmi_device_new_qmux(const char *device);
 struct qmi_device *qmi_device_new_qrtr(void);
 
+struct qmi_service *qmi_qrtr_node_get_service(struct qmi_device *device,
+						uint32_t type);
+
 struct qmi_param;
 
 struct qmi_param *qmi_param_new(void);
@@ -128,8 +131,6 @@ void qmi_result_print_tlvs(struct qmi_result *result);
 
 int qmi_error_to_ofono_cme(int qmi_error);
 
-struct qmi_service;
-
 typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 
 bool qmi_service_create_shared(struct qmi_device *device,
-- 
2.45.0

