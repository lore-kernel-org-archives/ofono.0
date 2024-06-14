Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F01A2C0A
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391188; cv=none; b=HT4mSHwcudy8HqePBxrOOgyfKzL9EViAmcSKH6/yXRhjZc2C1M/UGjFopzpti9bmj7eZf2lfwjforbPDi/iJPMOWZ0qxkSopLmd0fJIvsD9uNgvShFIuEui8OYJ9zrCYKuHvXjbYXlVcK3IaoGQiyNU63xFZp3Te7mciO6dXUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391188; c=relaxed/simple;
	bh=cvtgdm1y3G36NkEXoYKr7nrLcI+ssUA9k2ctylwZ3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqX//+I5Gm0JIcTOHKxXqQ2bzVWdw7I5a3sLruUjsGfQE6ogcM5vrBQvtQnxZNbD5zcGpbF8o2/AEE2sNIKTQ8EAq5P/444784t3A80eLg8/Kj5OIC6z/FKiJDh+g759lSBX+oOVo9+53S0S5ncKeWbYMfspQtNEjJyBmBYbPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxfrYdEM; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxfrYdEM"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5bafe063f35so1490088eaf.0
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391186; x=1718995986; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=NxfrYdEMaDddzcDqalG57H9lGJ52pYzvjK4l4ljelOM+/WzcvI7Myw7KUbq0PrJKkI
         MzkfUrY+WhVDnqdJBG4VawtzQ6Nx0YxHR+GFkwc8lfS4Klc2kG+tjD7z6jO1EYVXJaQc
         55e07asZIXfxsi2jWYiwvanVXkDFAVQTaj5xChIz/yjRKEDqIgyKfJ656LrcUvbwQySE
         o4+n1fkvbMzuePZi+V0yeZlwZFKm7yof2X/irC58i9snPe7svRePgF78CaY1JwVWWfo0
         WL7PeTpS3RYIPvBNmaeacC/JzTzZwP+HUABycG28bHGLpPhAYe+R/FU8o6b2FvPqbSNl
         phng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391186; x=1718995986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5bZSi5L/Rb3uzEjv2RqXCaHnwLky7slVhKdTDg/n/Q=;
        b=mDAZa7thq7+AAriUVxSuWPxXxQw0QesHUSbjZ+VoejS7XoF2hweagF4iCeI3o58hPy
         JoQ1JWbWPKRmTNAzdXvu3dMgOBQWrlub41SSDVInuMwhHFkHkmVRsiVrG5hg/xcoOsB+
         RfYlzEnTTSxa7j37XX8tTPwDHRl4Zr4D96JkC0/+P9G9Iz3ea7F6LKAZvGTg9ulOekyO
         ueUmy5/0q97+XzKJVLfrJYJlj/OLUmzjZVS3lG/rZRRt4VzPbLBMmLaSbcKXrX7yMDXS
         3mOCL98yrvYChmFv7QkMbLTOG/ey25LNidgPL96NhoBWn4mr70lNM8/v2e5+nrmcFRhS
         IPGg==
X-Gm-Message-State: AOJu0YyFWy2wfkhS7wWvDoi82J2Pl1zDLPm5OfFxcJuhvBJ8Ythkgh/4
	8zrvkRPyAUeDOvQ2JYS0jIVlzBpFIWre0es+TVPziAvDjjyAT0pSxkYkhw==
X-Google-Smtp-Source: AGHT+IEnROC1hLIhreDUlAE0o08GTkmRJTv/KNy9qqq5TQV+B3vXE3shSbjz7UqwEMS2gsy+ETzRCQ==
X-Received: by 2002:a05:6870:93c3:b0:254:a218:89e6 with SMTP id 586e51a60fabf-2552b3b455fmr3450714fac.23.1718391184297;
        Fri, 14 Jun 2024 11:53:04 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 04/27] qmi: Add qmi_qrtr_node_get_service
Date: Fri, 14 Jun 2024 13:52:16 -0500
Message-ID: <20240614185300.1086701-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614185300.1086701-1-denkenz@gmail.com>
References: <20240614185300.1086701-1-denkenz@gmail.com>
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

