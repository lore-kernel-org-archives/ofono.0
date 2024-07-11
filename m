Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E736381AD
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716421; cv=none; b=Ojnh/18Ge+0eOleG2l8XcWYOFHfz0dK3F/uwGB8nsU5Uhcy/etK5fsc43+XcnpEcHTqR7epU6pikHFuNVfVzj8klt5Dbe+rjAvx+PP3fHePqXncF/BPGPqSGx4z6lmoRGk/ru6MCvi+FSD7p4kAoGcEK+Zc176OVdzIocGq44mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716421; c=relaxed/simple;
	bh=vZemnAQx6lt/5RW9tkn97Ir7UgxKrTvGJK9H4hhc7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJLQcTxFoH0GO5o6q0X7k0Ir7eN/6RXngO3wrWi02G61x/cMHcxsnzPeVe/QeS+3XrwV2dGd1avlZzYiB6YPPxxVy8NkoSor5I7UJs49j8xqxfjfgCTHBv5JhrLu8G5Y3PpcJqP3nA2Gjzi+DwvPqSRuZ6IN6T6K1dAILuoBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZQ9IeGw; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZQ9IeGw"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f70a708f54so42710239f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716419; x=1721321219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=lZQ9IeGwP+SOHgHtIxlLrG+UZDn4O/HBX5IXaULFiJgLrR6vXe8ynyQliMQCqYAFq3
         pKPR/oXQatD1OIXSol6JiQLh0XDedAlDEh86BZvSozinQVXysoW8YjcVFjEB4lV831/R
         iSZ5nmmMpER+TB81FWGLxoV4Apm0Al2FL78cx54vDjzy9aAabNeDteVev1IiBnO9lAa6
         o2JT1V6l013OW7dC8onKkC8XjMOZm2R3qwoopA3l7eJt39XLlGfzWvjX8CBJ7uKO+mYm
         +QX2UYaaDO4g+N0ZeT5d5RPjOaCY+E5r5GSKDeXMLJpdbJIoRSNvPhYwzYVNnF98sIgC
         Gphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716419; x=1721321219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=jMQyWIzFZn6KBjEMVmT0k9i8dw/uAgMTC2bwq8f+mNH2eZA7X+ekGisObMigpEVCeJ
         rM15TyNvQ+iJhomXtd0wSI3ODBwMxXoXm2ZFHHw3x/HvfdcslxJzmVLqNaRu2Kydd18A
         PRyaU7QYPiOk0Lm9qdqX6Dv7ErtsAcK7nRZC4E6ME5FPosUCLJ8Z5Z3/A0igqNOaSePR
         S9EXGlx+qbdG9G4MuQhJIFs2nWS29RPNQHQKkpkO151S9azzt5nVY8XgAL+f0HUyj5W3
         i5xp0cpBZ1M9Qzxg/F19UksWd94u/5btl/LwBB5Nf8iB8bYTTatXjrehwRj0mOfQ7M88
         3wNQ==
X-Gm-Message-State: AOJu0Yx9biA2Q7s1+RO8+WxHS/fJ/m/IAwI7waDbVLD48PDdFJ0uRmPE
	n4HZ59yaCKHHzdVyvqDT2Z8s/VzGpUYBOjdPxaKbGr7MGWS0OQT3Is7xfw==
X-Google-Smtp-Source: AGHT+IFRr5F06pXOcftViF+/WaoSBW6FEaMryItPQ0nPk2AcaQlHznzSjliEx4RVJ8tMGSR/hV0ROQ==
X-Received: by 2002:a6b:6801:0:b0:7f8:c1b2:9784 with SMTP id ca18e2360f4ac-80004173ab3mr959725439f.20.1720716419244;
        Thu, 11 Jul 2024 09:46:59 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 06/11] qmi: Enable _auto_ use for some classes
Date: Thu, 11 Jul 2024 11:46:23 -0500
Message-ID: <20240711164654.1688558-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables ell _auto_ keyword use with qmi_service_free and
qmi_param_free.
---
 drivers/qmimodem/qmi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0e48313ebb64..69698ee049c6 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -5,6 +5,8 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+#include <ell/cleanup.h>
+
 #include <stdbool.h>
 #include <stdint.h>
 
@@ -110,6 +112,8 @@ struct qmi_param;
 struct qmi_param *qmi_param_new(void);
 void qmi_param_free(struct qmi_param *param);
 
+DEFINE_CLEANUP_FUNC(qmi_param_free)
+
 bool qmi_param_append(struct qmi_param *param, uint8_t type,
 					uint16_t length, const void *data);
 bool qmi_param_append_uint8(struct qmi_param *param, uint8_t type,
@@ -146,6 +150,8 @@ int qmi_error_to_ofono_cme(int qmi_error);
 struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
+DEFINE_CLEANUP_FUNC(qmi_service_free)
+
 const char *qmi_service_get_identifier(struct qmi_service *service);
 bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version);
 
-- 
2.45.2

