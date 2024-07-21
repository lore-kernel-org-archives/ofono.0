Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48C256E
	for <ofono@lists.linux.dev>; Sun, 21 Jul 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560486; cv=none; b=MNKiC262f/LrLCP8+M8AOdpOqZK/p4/GavydnNdUkF0b17oyEM8Rpx8BWExK7YrSUWEciYXqZQsq/MVZDDkAst6HK7Wt6vEXX7/IRD0dojqFLA5lccuCr5NaY2+2J0ZoVRKgeCtT/iHE+oXLCRaQhAnGehoSrA5r0siYc3QiyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560486; c=relaxed/simple;
	bh=HI3NB7Yb5qrU55CD8h356MRmvgcTca3hqWT36pWg/QM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fi1Nordd0165LxQKSHJJdW4uyebhBnyOeXVviNB/CedzD+aU+96kLHABvGx7lFE8nM7mWzjNumiDP64yIzOWnPhkXWwuHcjCrETPegyAqI/XlgkkeF4Sso5pZ0h0Xjuq+XjpW1egLbrKKozhin9AvZst097znlwvHylfhUcnHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccfmsXv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccfmsXv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so15230025e9.0
        for <ofono@lists.linux.dev>; Sun, 21 Jul 2024 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721560482; x=1722165282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9E/0tlUyV8pb1e7gO+j38qiDk/N3okwfAi62+5Irf6Y=;
        b=dccfmsXvrlXs9cjeeYpsoUGWQChO4E9SkVJRGDZVhDEb84d/JbQME6C14uykutsUeK
         pSWy/WFfTu4AjiCgNtL/74p0CIBjX0YIBhf9F3Qi1pAjW7z73t1cmivRQQsy3BTiXhVc
         iUezxP+jiwT7G2iz5/PAx5R1jh+5yD6Kj767h0h/+OlbLD6dZj/kp1hIsQ0R3nIAs090
         Af9ea4mFN5aS9GcFBEP+WHL1Gd0X6udru/vD0G11kEqpvY0w8n/4/vDEl2G6vegleIPG
         my06tBIeHWZxthbyEiTzz+PxAuESHLo5fQ2pGfIF8OKdi6h6muF8BZtVpCXsY/Eey1tj
         jkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560482; x=1722165282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E/0tlUyV8pb1e7gO+j38qiDk/N3okwfAi62+5Irf6Y=;
        b=bO+QKBCxLA29+YpNQvh8MqUoZBWEHLY0pCYgFKf5+196uOIcgBtz/dQvSCuRDUCyfr
         DaIjfzAtJ0jKUThfsHj4JLc+huFqH13G5mfhKlyw3EQEXeRXkNwQ6a/5qZd4nILCWksS
         3WHCkdy0OrZHeH3paJGCtIOiv5eQEEp5sJCBppLQCOUcojbdnmi3SnuR7PMuu8bviG6T
         vUIEIPxKKExTjZeRqnt/L83ur1w3kLRFPdoeKT8wC0KlYy+NyZ8M//WcPpwP2mJ3FahD
         e7m4RCD7Qify/nVKQ0yIpXnxTlV7QgAMxY33KcA7ce1kc6BopWUzmrl9bXWcdZxAX90x
         /wsw==
X-Gm-Message-State: AOJu0Ywl+KC7CuwZg4rkH+OPMvBUPTcthGhOe4LsfakrncbyYHV8zjI9
	0425xcK3FFaV0hEry39E2dStLVt/+hsIhGPvdmtIcROO4JFLVkmklg/6eg==
X-Google-Smtp-Source: AGHT+IHAVADd5wAUFhgI1zcKUFHLmtXI1NdGuRREmtn/0XEpgHK1WYO9lyc/JWcJqnSdb5Wz6na/8g==
X-Received: by 2002:adf:a3d8:0:b0:367:9049:da2e with SMTP id ffacd0b85a97d-369b66ae93fmr3137149f8f.8.1721560482304;
        Sun, 21 Jul 2024 04:14:42 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.246.116.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cece3sm5709575f8f.69.2024.07.21.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 04:14:41 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev, denkenz@gmail.com
Subject: Linker errors with external ELL
Date: Sun, 21 Jul 2024 12:14:39 +0100
Message-ID: <2705084.vuYhMxLoTh@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennnis

Just to let you know, I have to patch Makefile.am when building with external 
ELL as a few of the unit tests fail to link due to missing l_basename.

I dont want to go through the full git-patch-review cycle for something so 
trivilal, happy for you just to fix it.  My diff looks like this

Thanks

Adam


diff --git a/Makefile.am b/Makefile.am
index 1876e489..090791d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -884,7 +884,7 @@ unit_objects += $(unit_test_common_OBJECTS)
 
 unit_test_cell_info_SOURCES = unit/test-cell-info.c src/cell-info.c src/log.c
 unit_test_cell_info_CFLAGS = $(AM_CFLAGS) $(COVERAGE_OPT)
-unit_test_cell_info_LDADD = @GLIB_LIBS@ -ldl
+unit_test_cell_info_LDADD = @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_cell_info_OBJECTS)
 unit_tests += unit/test-cell-info
 
@@ -892,7 +892,7 @@ unit_test_cell_info_control_SOURCES = unit/test-cell-info-
control.c \
 			unit/fake_cell_info.c src/cell-info.c \
 			src/cell-info-control.c src/log.c
 unit_test_cell_info_control_CFLAGS = $(AM_CFLAGS) $(COVERAGE_OPT)
-unit_test_cell_info_control_LDADD = @GLIB_LIBS@ -ldl
+unit_test_cell_info_control_LDADD = @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_cell_info_control_OBJECTS)
 unit_tests += unit/test-cell-info-control
 
@@ -903,7 +903,7 @@ unit_test_cell_info_dbus_SOURCES = unit/test-dbus.c \
 			src/dbus-clients.c src/dbus.c src/log.c
 unit_test_cell_info_dbus_CFLAGS = $(AM_CFLAGS) $(COVERAGE_OPT) \
 			@DBUS_GLIB_CFLAGS@
-unit_test_cell_info_dbus_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl
+unit_test_cell_info_dbus_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl $
(ell_ldadd)
 unit_objects += $(unit_test_cell_info_dbus_OBJECTS)
 unit_tests += unit/test-cell-info-dbus
 
@@ -1010,7 +1010,7 @@ unit_test_dbus_clients_SOURCES = unit/test-dbus-
clients.c unit/test-dbus.c \
 				src/dbus-clients.c gdbus/object.c 
\
 				src/dbus.c src/log.c
 unit_test_dbus_clients_CFLAGS =  @DBUS_GLIB_CFLAGS@ $(COVERAGE_OPT) $
(AM_CFLAGS)
-unit_test_dbus_clients_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl
+unit_test_dbus_clients_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_dbus_clients_OBJECTS)
 unit_tests += unit/test-dbus-clients
 
@@ -1018,7 +1018,7 @@ unit_test_dbus_queue_SOURCES = unit/test-dbus-queue.c 
unit/test-dbus.c \
 				src/dbus-queue.c gdbus/object.c \
 				src/dbus.c src/log.c
 unit_test_dbus_queue_CFLAGS =  @DBUS_GLIB_CFLAGS@ $(COVERAGE_OPT) $
(AM_CFLAGS)
-unit_test_dbus_queue_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl
+unit_test_dbus_queue_LDADD = @DBUS_GLIB_LIBS@ @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_dbus_queue_OBJECTS)
 unit_tests += unit/test-dbus-queue
 
@@ -1026,7 +1026,7 @@ if SAILFISH_ACCESS
 unit_test_sailfish_access_SOURCES = unit/test-sailfish_access.c \
 			plugins/sailfish_access.c src/dbus-access.c 
src/log.c
 unit_test_sailfish_access_CFLAGS = $(AM_CFLAGS) $(COVERAGE_OPT)
-unit_test_sailfish_access_LDADD = @GLIB_LIBS@ -ldl
+unit_test_sailfish_access_LDADD = @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_sailfish_access_OBJECTS)
 unit_tests += unit/test-sailfish_access
 endif
@@ -1034,7 +1034,7 @@ endif
 unit_test_dbus_access_SOURCES = unit/test-dbus-access.c src/dbus-access.c \
 			src/log.c
 unit_test_dbus_access_CFLAGS = $(AM_CFLAGS) $(COVERAGE_OPT)
-unit_test_dbus_access_LDADD = @GLIB_LIBS@ -ldl
+unit_test_dbus_access_LDADD = @GLIB_LIBS@ -ldl $(ell_ldadd)
 unit_objects += $(unit_test_dbus_access_OBJECTS)
 unit_tests += unit/test-dbus-access
 




