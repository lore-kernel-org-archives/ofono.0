Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD81C2A8
	for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740958; cv=none; b=KpQMoqzJU5ihdkPrePi8BaKsOGZk4VwnO+w/LGkpSmr2zVQMrCdKYc97GkcvaZa4d+8TRBNEzRiswlEIY148WPFuW730J5d+lHIkTEiF5fpZ4fg+TV1Bf2QSFXTL1hB7Pae/JldDmBARpM5AugqqTQQESp/1uo664DfZB0RtemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740958; c=relaxed/simple;
	bh=cvtgdm1y3G36NkEXoYKr7nrLcI+ssUA9k2ctylwZ3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=befDO3dCuOmtlkyUwRetTeaJttrwuUbLjVdd8pCxwbaitITCyXxucmIQZWlBxOuceH2A1KtH1+/pLUbL/k7C2x4P2MppvyVB+ZWZxJdb62NMHkg6HHUZxZfeUI/QY6PhIxQoJnvhrtRvHD8n97tk0/W8IMstac4WKbZlcc2mjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfFl2lDz; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfFl2lDz"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25957dfd971so1341910fac.0
        for <ofono@lists.linux.dev>; Tue, 18 Jun 2024 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740956; x=1719345756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=MfFl2lDzFfmoaO/ZLRAPGd/V1zWRpaqnpFQ9xckZdjlauiagmI/zOHHXHKzGXeusCT
         JHqOMBulKOBglDkGUmIeCQICgYn9JsJzC+AkejP7WfZpfxpZs8uNXr2GwsFf6W01gYIb
         GWyMU4/iFRpN0jprlg3Q2UGHhx9ZNKTaK9c6GkaFlBUmVTAaMbBx2aH5inThVN+mrv4V
         TNau+gomFu6txLxJUPIEQqnlR1Rpp1ILFEq+rpPCDDC6u7bYTq2nOnYZWTUdS/EL72U+
         h8I4pjTDugCN16E6RoNp7LZTsEU+DAW/GGLKb+sUmmUZTCXBi8d28zyoqS8p1ozQIro3
         YLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740956; x=1719345756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=QGquk3TiuDYmkfaG65k0IpEkmSJAJtmT9m5DrqGJEFAcCaDdzLj/XCUpH8NpehvPH8
         l6hBQTaZLIHqYsnvudq9927Inc4E8ZqdiqrPqUOJEFJ8LmMYdpxZQAwgC5AFRp/c6+aA
         rb2PePX+Jjd13wwOmd/u1v0zZToxi2XmWUwm8l9QbsEb/RbljQhSVV7oXeKBbJ3GR04W
         93ziE4dTSti3R0XcmpUhPqq8SuZ6MSH8HYWeqlwFmxqI6y4/XrTLR5auhoqLZ1jbZT0e
         q2JhCsfxJu5SxMPKSsTdPJqQtH02vxQ/j7nJLZFoA9YCHdcmI7f1Ru2jceHrBXMetg1E
         ZZrA==
X-Gm-Message-State: AOJu0YyljVat0N6vAb/DBUa7Wc5GfsL2+Val+ONvtY1l/3K4d8NTJ/5+
	Wo4kx+Jj5S+/oYRGWZw2DsQn9m8QaYQ5DCZ4Wobem+ETgFCg8RmTz8E8Lg==
X-Google-Smtp-Source: AGHT+IGHh7YIEdiSZZ8SrjrTJhOpn5p2FzXh61eBy/xrj5Ye0ILz8Ij6BSgWSvzqbiVGdXx4EwSeLA==
X-Received: by 2002:a05:6870:6593:b0:254:ab8e:471b with SMTP id 586e51a60fabf-25c94e48921mr1008807fac.50.1718740955889;
        Tue, 18 Jun 2024 13:02:35 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7d31sm3305744fac.14.2024.06.18.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:02:35 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/33] qmi: Add qmi_qrtr_node_get_service
Date: Tue, 18 Jun 2024 15:01:46 -0500
Message-ID: <20240618200231.1129282-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618200231.1129282-1-denkenz@gmail.com>
References: <20240618200231.1129282-1-denkenz@gmail.com>
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

