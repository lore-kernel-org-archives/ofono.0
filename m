Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FF1A2549
	for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391197; cv=none; b=B2pAMlGr/BNlhueLVdvdmpstos03Lrbr7I2CXRW/Zfnb5ZocSKiMja+ZwYsi8Hu/xP9zdaLFezfXGlddhZj0JEGAMEvMB5EyjZtmzjr1iIQksEiJ6iidgoqorOj8BDoslK+pk0P1wuFIFampFS+qn1OTywtqBEpy5mOnfcJaBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391197; c=relaxed/simple;
	bh=/mi4MGlLF8/XlsUgO17PUk4L8xiJsC0dn9+1Zui2Wrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL17nfTZqFamy5u5OVAP+x9OSgxHenxcKeWc6E9nDtqWTtzroWeIc4164/bnncWPi5dxTTkAMgnFEwgfJEEbqwSX6BtFwJQM1D1LLpW/i6D3yfXDSCFv5T6WkUEdcv0NVn11t/nmfKEzpbQ3cwU5UxhOVc5bDftemDdNsJHL/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2T9wJ+a; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2T9wJ+a"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24c9f91242dso1043080fac.2
        for <ofono@lists.linux.dev>; Fri, 14 Jun 2024 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391195; x=1718995995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNlPm4zwFTGp7ZIoWdhV6v3B9oY3qoHoJqVIz/U4NKM=;
        b=i2T9wJ+aX2EumDmn6wH8K/yFSnsHTfAiOlq+dPQauZgM+iys+U8CoEEyVyIrAobtxF
         wlg8jfLXggcWqeelQNT430C/KP05jPHi/y1uSul22CyHuselcg/6r8pzRiTstV5Ksoyw
         4rR7F+PgkqXvUC+W8PEmVadyHE6+2Bi+VhNCVRtaN1iv3wWM7csbzGglSIeJ02WMLxfv
         SBdrdLVp61sIEqEj5ZcVpxcO/cxYj8CkF+nYbkuVuNChZB/xObhJtt3aJKC7IduGFGQw
         p9W/7TcH+saHp4Vlhs0eCBUmLkdwYjAKbDRiyioICtU+4vIx13ee0byzQGKMpSkEqihJ
         ElRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391195; x=1718995995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNlPm4zwFTGp7ZIoWdhV6v3B9oY3qoHoJqVIz/U4NKM=;
        b=qcrGoqyQ8yTdamUc6rhc/kmXbcAON/0iRgX3EU6MNIWsWZmhTd6RlkeJT2SY+xqKvT
         2KQIQHkmXFunHvLtnx1rx+tc4LFRHsptf4Q67pRB0gkggT+h1+ghMStJHUFWoy76dUki
         DWkFoJtxD1eudo0qOeO4Ff+lf8hNdO4GvbW0TjQGEj82x4utN/biEm5yIu0I51ux3kMx
         kQf57f7XoqB4IKVr6ZNNpcsZMxI0dBVCtHKVBpmfBEQJ0+tWFME3OGkhOz2H0eYQHUOb
         y7tJqknzGc0VCXuGLXbugCuY08zSBbe97XmgghtjjWIPDC19WAyc1ZjrkI5IE7yH49Ar
         oEdQ==
X-Gm-Message-State: AOJu0Yxy2BOQwGisVT+e7cJIohABA5kZaQF/m0cwlzfIuomo9Vg7ekJE
	BfsDW2JPER8KriFai3DZm533z3j37NNQKw6H3sTUV4LqnWJoV9x7dhYy3g==
X-Google-Smtp-Source: AGHT+IF/6sgZCq0aC8fDxJLqI1gyTjl/bTk99r0xYiE+YCycL9NemwxEqiE84bc3VXZe0wpYeUPB9A==
X-Received: by 2002:a05:6870:452:b0:254:a386:f029 with SMTP id 586e51a60fabf-25842b79513mr3604628fac.37.1718391194925;
        Fri, 14 Jun 2024 11:53:14 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569934cf6fsm1095763fac.47.2024.06.14.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:53:14 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 16/27] qmi: Rework qmi_service_get_version
Date: Fri, 14 Jun 2024 13:52:28 -0500
Message-ID: <20240614185300.1086701-16-denkenz@gmail.com>
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

With the introduction of QRTR support, qmi_service_get_version became
somewhat confusing.  It still returns the minor version, however QRTR
does not have such a concept.  Additionally, QRTR is limited to 8 bit
service versions.  Rework qmi_service_get_version API to make this
clearer.  While here, add some documentation and update the unit test to
the new API.
---
 drivers/qmimodem/qmi.c   | 22 +++++++++++++++-------
 drivers/qmimodem/qmi.h   |  3 +--
 unit/test-qmimodem-qmi.c |  7 +++----
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a56e5588c698..6d605d58ad65 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2538,17 +2538,25 @@ const char *qmi_service_get_identifier(struct qmi_service *service)
 	return __service_type_to_string(service->family->info.service_type);
 }
 
-bool qmi_service_get_version(struct qmi_service *service,
-					uint16_t *major, uint16_t *minor)
+/**
+ * qmi_service_get_version:
+ * @service: lightweight service handle
+ * @out_version: version output
+ *
+ * Returns the version of the service this handle is currently referring to.
+ * On QMUX this corresponds to the 'major' version of the service.  On QRTR,
+ * this corresponds to the lower 8 bits of the 'instance' attribute and is thus
+ * limited to uint8_t.
+ *
+ * Returns: #false if the service handle is NULL, #true on success.
+ */
+bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version)
 {
 	if (!service)
 		return false;
 
-	if (major)
-		*major = service->family->info.major;
-
-	if (minor)
-		*minor = service->family->info.minor;
+	if (out_version)
+		*out_version = service->family->info.major;
 
 	return true;
 }
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 65fe0d56e4bc..0d2ffb61fdea 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -142,8 +142,7 @@ struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
 const char *qmi_service_get_identifier(struct qmi_service *service);
-bool qmi_service_get_version(struct qmi_service *service,
-					uint16_t *major, uint16_t *minor);
+bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version);
 
 uint16_t qmi_service_send(struct qmi_service *service,
 				uint16_t message, struct qmi_param *param,
diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index c40e9bb1d8af..4ea9c736c284 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -232,15 +232,14 @@ static void test_create_services(const void *data)
 
 	for (i = 0; i < TEST_SERVICE_COUNT; i++) {
 		struct qmi_service *service;
-		uint16_t major, minor;
+		uint8_t version;
 
 		service_type = unique_service_type(i);
 		service = qmi_qrtr_node_get_service(info->node, service_type);
 		assert(service);
 
-		assert(qmi_service_get_version(service, &major, &minor));
-		assert(major == unique_service_version(i));
-		assert(minor == 0);
+		assert(qmi_service_get_version(service, &version));
+		assert(version == unique_service_version(i));
 
 		qmi_service_free(service);
 	}
-- 
2.45.0

