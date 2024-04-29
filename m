Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F482D7C
	for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406252; cv=none; b=FNYdVBGiPiUnLP3dudZrD5PrXAuJhOQl17CO4pI4A1u0sB1BzRm3BdDyfW/ynI0R6F3e9Z29HWM3+r3y9f2HWXv5ulGZ0TeYpUJnq6XtdTgZUdINrz0+0QlY9wm3r+mJKnj0d01STDspJALfUilfY4jWckkB1r0+MeEH36/tMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406252; c=relaxed/simple;
	bh=XBvVcaHcaKnSZ9Aj1nxMtPV6/0Cv0B6uOGrYS0Qj/us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn4nqbEHmyOTuSIeYgSycdHnOXiCgs3my1l/RRNqFMqSvHW8wQf76shMXe5KVuzjRVg1mhC4BiwcelSpgy3Sr8fHNQxXancontTSpeYgo7JiWOW35MApwRPCY6lNjScvamCXilvWifYmzoz/d2Tl8svgc1XN/M+R0aKWR6jsJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZgjoTlx; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZgjoTlx"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ee266e2999so773091a34.2
        for <ofono@lists.linux.dev>; Mon, 29 Apr 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714406249; x=1715011049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWVpySXbFdAnt6Ba2qRjeMx8UM7/1DCO5OCEFMBZL/w=;
        b=IZgjoTlxe5n1kOhDba0X371ginjvPtt9svUruNca5jiMfHbvWefqzpCHHIOdIgjNQ+
         N8ar2JJpWk47hSoIj9KNSiTaBnfQdWOP9U9iavrJjPkxNQUelqs/x16VfkxdWfbsP4VZ
         2EBUTSYN4rkkhJaQAsducEnLwHFpjWFH2N5i1ldsXe2Sk9ViZmy2gC6i5hfaOB0HMwzr
         jVNMsDaXD/Ya2BXeaNka202ofyPaCBU0yZ+EgH7iuoxuLCkgv2hfDsbD1lIavWwnWhv4
         uYevYWk4imrXW+c83ZsWbbRoEeS4lURH9vBKZk1eu6P4ftM5eA2I8Qk4OlX3Bw6V8Iwj
         FR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406249; x=1715011049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWVpySXbFdAnt6Ba2qRjeMx8UM7/1DCO5OCEFMBZL/w=;
        b=mfY97sAVYnIrp3mkCJU0LfszQJ/2gk0BQh0yEh8+hUkb8nyr9Dd0pvt2hWW00Igdyv
         QZ4bliIbLytKfMPyDDjo/vmOmZOu0xuxDk2brLHt1ax9flEY4K3op6bVJAHtMYsnzyEh
         NPgYDA/G4YsYWzdAR4tsYLfSb+gD28pbnFc4zSBVtFHuy/fNUZlsnXd0PJ8muapGyBfe
         RaRN+6wBAGLb2SYrDLsNuoSD3ap1f343gcMIivy7ocFYnv3vdbhmP6si2hA3Up52KLxY
         OztOLh829rwQdcSwg6OzYelQl3j0MQVPps9QzY79EwlJvwqppKZG5LItm9YbUrIQjDqG
         zVDg==
X-Gm-Message-State: AOJu0YwbEXu5C0vQ0pbefP2XFi0oMUDxNLIr3enOGiDOmxnKFO6CxCJj
	F2++d8ITkIPK3awQNinvMkvL77AVaUa+yfRBIbdTsm4drZDluoP1HuOm+w==
X-Google-Smtp-Source: AGHT+IGI9o5epM8b1LLxUrhR2/plVe+BdzauT/J+wmvQaxjt3QScfIrjJxutwjwGqlGwcayXacDksA==
X-Received: by 2002:a05:6808:2a8a:b0:3c8:2c20:718c with SMTP id fc10-20020a0568082a8a00b003c82c20718cmr10333896oib.2.1714406249662;
        Mon, 29 Apr 2024 08:57:29 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id bf29-20020a056808191d00b003c7443c0efasm3117820oib.1.2024.04.29.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:57:29 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] qmi: wds: Move enum conversion into wds.c
Date: Mon, 29 Apr 2024 10:56:54 -0500
Message-ID: <20240429155726.51479-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429155726.51479-1-denkenz@gmail.com>
References: <20240429155726.51479-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new wds.c file which will house various utilities, such as
enumeration conversion, that could be shared between multiple QMI based
atom drivers.  Move ofono_gprs_auth_method conversion here.
---
 Makefile.am                     |  1 +
 drivers/qmimodem/gprs-context.c | 17 +----------------
 drivers/qmimodem/wds.c          | 25 +++++++++++++++++++++++++
 drivers/qmimodem/wds.h          |  2 ++
 4 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 drivers/qmimodem/wds.c

diff --git a/Makefile.am b/Makefile.am
index b5a32fac1c89..815d96904943 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,6 +362,7 @@ qmi_sources = drivers/qmimodem/qmi.h drivers/qmimodem/qmi.c \
 					drivers/qmimodem/pds.h \
 					drivers/qmimodem/common.h \
 					drivers/qmimodem/wda.h \
+					drivers/qmimodem/wds.c \
 					drivers/qmimodem/voice.h
 
 builtin_sources += $(qmi_sources) \
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 4004876bab87..9ac57c893725 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -239,21 +239,6 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 	l_free(cbd);
 }
 
-static uint8_t auth_method_to_qmi_auth(enum ofono_gprs_auth_method method)
-{
-	/* QMI uses a bitmap */
-	switch (method) {
-	case OFONO_GPRS_AUTH_METHOD_CHAP:
-		return QMI_WDS_AUTHENTICATION_CHAP;
-	case OFONO_GPRS_AUTH_METHOD_PAP:
-		return QMI_WDS_AUTHENTICATION_PAP;
-	case OFONO_GPRS_AUTH_METHOD_NONE:
-		return 0;
-	}
-
-	return 0;
-}
-
 static void qmi_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *user_data)
@@ -288,7 +273,7 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 
 	qmi_param_append_uint8(param, QMI_WDS_PARAM_IP_FAMILY, ip_family);
 
-	auth = auth_method_to_qmi_auth(ctx->auth_method);
+	auth = qmi_wds_auth_from_ofono(ctx->auth_method);
 
 	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
 					auth);
diff --git a/drivers/qmimodem/wds.c b/drivers/qmimodem/wds.c
new file mode 100644
index 000000000000..748ad867c2cc
--- /dev/null
+++ b/drivers/qmimodem/wds.c
@@ -0,0 +1,25 @@
+/*
+ * oFono - Open Source Telephony
+ * Copyright (C) 2024  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "src/common.h"
+
+#include "wds.h"
+
+int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method)
+{
+	/* QMI uses a bitmap */
+	switch (method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		return QMI_WDS_AUTHENTICATION_CHAP;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		return QMI_WDS_AUTHENTICATION_PAP;
+	case OFONO_GPRS_AUTH_METHOD_NONE:
+		return 0;
+	}
+
+	return -ENOENT;
+}
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 6d7071fe244f..c8aeefe430bb 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -108,3 +108,5 @@ enum qmi_wds_command {
 	QMI_WDS_CONFIGURE_PROFILE_EVENT_LIST		= 0xA7,
 	QMI_WDS_PROFILE_CHANGED				= 0xA8,
 };
+
+int qmi_wds_auth_from_ofono(enum ofono_gprs_auth_method method);
-- 
2.44.0

