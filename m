Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A367215572D
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800475; cv=none; b=eDYjeCzfoXrDQovxR73+tB5VQa/2bKmAEAWSSuZRx7Wqb8Tz10zNlxtEACRhfHHVCdDy/+0P8p85oblSeYtcjnHO1wU8KUJ6eWO4dOIBDtwROdibUHRlNM6hVoS4gyWA3vI1vnejrlI7esMPcERjEoYOoWxD+gNsmnvggMemmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800475; c=relaxed/simple;
	bh=q0KuagSasHgfO/XncaDRh/6BzWr6ELAnEle7dOCmhfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TF1ftaD+CSDGA+tpRVeWRdPCRqvzNRBGrO9d8SxVr9TdE9VksObsz+j4ugGvgQ0aYnmDf80j944tmyC6NlYYUQuL8eMPZCuw5KEN0UbF9lQ7HxOv1cuKmWb0jjabvLz2qQKNgp56mu0XyinVzJzT82uOSGTKwg0fh+V8yXV4fy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgeaRyl5; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgeaRyl5"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b3241373adso1450053eaf.2
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800472; x=1718405272; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOOBg6Gsufpva0ieml7234FnSDXP7734brFuiYW5AHw=;
        b=ZgeaRyl5T7FZ5q79e5h59fp2SiZXsztkCBPoELDwKh40U37vBOQXb2KGZSP2hEiIdM
         xHWyr+P3ZxT6pPBdZk/2FLMmjjM8HRANxB5fZ5EIAa+yNRmMu1UWJTxgX8j8u61QbpDc
         0biCZuv4bAlOz6bB5jEGXwKWEXhyf7ErUpHnASS3ZLyNj45HdF3V9uvK/dKpedtB6W9t
         4Bg/NZA523Kp1O3nmskYeRoTCun1WY1r0eWhFSO/Q7m2m7+SlD/T7vIH4P+42+/IrJWa
         grtT5mZTVsY1n5SQfJ2MmgXtWotmA0May9VF/gQ2fSeNxM35w9z5NFcPquPpQNnzOTXn
         sZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800472; x=1718405272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOOBg6Gsufpva0ieml7234FnSDXP7734brFuiYW5AHw=;
        b=X6JRW60KlAhskKZCdBcUs/U1ptgVZfm2KsdTfzhJKSlTPqqrfD6alLrUK8TkWKPfO1
         7dfV5TdKopc7+OJySXTgkT/iS0xlB8egcfhXAenim8GXZcku7ilFYH7VJdJ26OM/kDcB
         gUPZJG6/6ybfdn6JuwW3+cuRNQgmEyhvWZDqLYwB209gSTmfUJl1WxeMNQfE5QleL5sM
         xcqYiVu4JvD+qy53kuCgqMKPk4snJgggk9lSIfmhcctsMkEbZHTM34LIgly7hmPDo8v9
         vgilQL+f5FGIWEyd+lzEeqv4gs1Q1VPRVF8cKVgXK7kt8/Ubuaj3kUvapuTASz6cFIiz
         cycA==
X-Gm-Message-State: AOJu0YxW26Qvw4ScPKd2hRW21YHGycIJzblfHhhBB40/DMSd7sB6F/FR
	dCqxQs3kXfQ3/JphMUjLuFFEx633D+rjFNEYIu15DoMvChgDmD/U/u7AYg==
X-Google-Smtp-Source: AGHT+IEAYbWFNr7gnDhiyrM+XqqWkJ68pAYsD6XI8cwShJM5IxvZ20oO3RjsREG/rGMIZgv0RUNfOA==
X-Received: by 2002:a05:6820:2290:b0:5b7:1979:ec49 with SMTP id 006d021491bc7-5baae242e65mr4130199eaf.0.1717800472208;
        Fri, 07 Jun 2024 15:47:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/23] core: Support register on probe flag
Date: Fri,  7 Jun 2024 17:47:05 -0500
Message-ID: <20240607224746.903769-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some atom drivers have no meaningful initialization to perform after
probe but prior to calling ofono_foo_atom_register().  Such atom drivers
are forced to use l_idle or g_timeout_add in order to invoke
ofono_foo_atom_register() outside of the probe() method.  Make this
easier by introducing a flag that will tell the core to call
ofono_foo_atom_register() automatically.

One exception is ofono_gprs_context drivers which have not had a
ofono_gprs_context_register() API.  Introduce such an API as a no-op for
now.
---
 drivers/atmodem/gprs-context.c      | 1 +
 drivers/gemaltomodem/gprs-context.c | 1 +
 drivers/hsomodem/gprs-context.c     | 1 +
 drivers/huaweimodem/gprs-context.c  | 1 +
 drivers/iceramodem/gprs-context.c   | 1 +
 drivers/ifxmodem/gprs-context.c     | 1 +
 drivers/isimodem/gprs-context.c     | 1 +
 drivers/mbimmodem/gprs-context.c    | 1 +
 drivers/mbmmodem/gprs-context.c     | 1 +
 drivers/qmimodem/gprs-context.c     | 1 +
 drivers/rilmodem/gprs-context.c     | 1 +
 drivers/stemodem/gprs-context.c     | 1 +
 drivers/swmodem/gprs-context.c      | 1 +
 drivers/ubloxmodem/gprs-context.c   | 1 +
 include/audio-settings.h            | 1 +
 include/call-barring.h              | 1 +
 include/call-forwarding.h           | 1 +
 include/call-meter.h                | 1 +
 include/call-settings.h             | 1 +
 include/call-volume.h               | 1 +
 include/cbs.h                       | 1 +
 include/ctm.h                       | 1 +
 include/devinfo.h                   | 1 +
 include/gnss.h                      | 1 +
 include/gprs-context.h              | 1 +
 include/gprs.h                      | 1 +
 include/handsfree.h                 | 1 +
 include/ims.h                       | 1 +
 include/location-reporting.h        | 1 +
 include/lte.h                       | 1 +
 include/modem.h                     | 2 ++
 include/netmon.h                    | 1 +
 include/netreg.h                    | 1 +
 include/phonebook.h                 | 1 +
 include/radio-settings.h            | 1 +
 include/sim.h                       | 1 +
 include/siri.h                      | 1 +
 include/sms.h                       | 1 +
 include/stk.h                       | 1 +
 include/ussd.h                      | 1 +
 include/voicecall.h                 | 1 +
 src/gprs.c                          | 4 ++++
 src/ofono.h                         | 5 +++++
 43 files changed, 51 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 5cca26f57ccb..da63fa1c72f3 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -495,6 +495,7 @@ static void at_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= at_gprs_context_probe,
 	.remove			= at_gprs_context_remove,
 	.activate_primary	= at_gprs_activate_primary,
diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gprs-context.c
index 34c044207274..f60fd4282a31 100644
--- a/drivers/gemaltomodem/gprs-context.c
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -327,6 +327,7 @@ static void gemalto_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= gemalto_gprs_context_probe,
 	.remove			= gemalto_gprs_context_remove,
 	.activate_primary	= gemalto_gprs_activate_primary,
diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-context.c
index 85f16404cb76..3b3346b0309b 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -363,6 +363,7 @@ static void hso_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= hso_gprs_context_probe,
 	.remove			= hso_gprs_context_remove,
 	.activate_primary	= hso_gprs_activate_primary,
diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-context.c
index 81eecbeded11..9108d490e0c5 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -322,6 +322,7 @@ static void huawei_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= huawei_gprs_context_probe,
 	.remove			= huawei_gprs_context_remove,
 	.activate_primary	= huawei_gprs_activate_primary,
diff --git a/drivers/iceramodem/gprs-context.c b/drivers/iceramodem/gprs-context.c
index 1bfaf703905c..070017c1d529 100644
--- a/drivers/iceramodem/gprs-context.c
+++ b/drivers/iceramodem/gprs-context.c
@@ -389,6 +389,7 @@ static void icera_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= icera_gprs_context_probe,
 	.remove			= icera_gprs_context_remove,
 	.activate_primary	= icera_gprs_activate_primary,
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-context.c
index f39c874a299b..da4632b5ce42 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -724,6 +724,7 @@ static void ifx_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= ifx_gprs_context_probe,
 	.remove			= ifx_gprs_context_remove,
 	.activate_primary	= ifx_gprs_activate_primary,
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-context.c
index ec4e9c15a69e..7d6fda2baf85 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -645,6 +645,7 @@ static void isi_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= isi_gprs_context_probe,
 	.remove			= isi_gprs_context_remove,
 	.activate_primary	= isi_gprs_activate_primary,
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-context.c
index 0c2042d92919..c420e300aa57 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -440,6 +440,7 @@ static void mbim_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= mbim_gprs_context_probe,
 	.remove			= mbim_gprs_context_remove,
 	.activate_primary	= mbim_gprs_activate_primary,
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-context.c
index 65668c36ef91..d9ea204da049 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -494,6 +494,7 @@ static void mbm_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= mbm_gprs_context_probe,
 	.remove			= mbm_gprs_context_remove,
 	.activate_primary	= mbm_gprs_activate_primary,
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 4b36d621630b..625fd0b8f193 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -608,6 +608,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_gprs_context_probe,
 	.remove			= qmi_gprs_context_remove,
 	.activate_primary	= qmi_activate_primary,
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-context.c
index be47731b295c..42d12b0f3e94 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -842,6 +842,7 @@ static void ril_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= ril_gprs_context_probe,
 	.remove			= ril_gprs_context_remove,
 	.activate_primary       = ril_gprs_context_activate_primary,
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-context.c
index e793c96cd4e3..a23c6f837ff4 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -412,6 +412,7 @@ out:
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= ste_gprs_context_probe,
 	.remove			= ste_gprs_context_remove,
 	.activate_primary	= ste_gprs_activate_primary,
diff --git a/drivers/swmodem/gprs-context.c b/drivers/swmodem/gprs-context.c
index 7de61871760e..32f8cef64c07 100644
--- a/drivers/swmodem/gprs-context.c
+++ b/drivers/swmodem/gprs-context.c
@@ -231,6 +231,7 @@ static void sw_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= sw_gprs_context_probe,
 	.remove			= sw_gprs_context_remove,
 	.activate_primary	= sw_gprs_activate_primary,
diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-context.c
index bba36ddd6c20..fab0207430b4 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -569,6 +569,7 @@ static void ublox_gprs_context_remove(struct ofono_gprs_context *gc)
 }
 
 static const struct ofono_gprs_context_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= ublox_gprs_context_probe,
 	.remove			= ublox_gprs_context_remove,
 	.activate_primary	= ublox_gprs_activate_primary,
diff --git a/include/audio-settings.h b/include/audio-settings.h
index 452d7e73632d..6b7eb0db1a7e 100644
--- a/include/audio-settings.h
+++ b/include/audio-settings.h
@@ -19,6 +19,7 @@ extern "C" {
 struct ofono_audio_settings;
 
 struct ofono_audio_settings_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_audio_settings *as,
 				unsigned int vendor, void *data);
 	int (*probev)(struct ofono_audio_settings *as,
diff --git a/include/call-barring.h b/include/call-barring.h
index 99e2764e64da..7ce787249a9e 100644
--- a/include/call-barring.h
+++ b/include/call-barring.h
@@ -24,6 +24,7 @@ typedef void (*ofono_call_barring_query_cb_t)(const struct ofono_error *error,
 					int status, void *data);
 
 struct ofono_call_barring_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_call_barring *cb, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_call_barring *cb, unsigned int vendor,
diff --git a/include/call-forwarding.h b/include/call-forwarding.h
index 2eb2f1817b8d..3e58bb40e48f 100644
--- a/include/call-forwarding.h
+++ b/include/call-forwarding.h
@@ -34,6 +34,7 @@ typedef void (*ofono_call_forwarding_query_cb_t)(
 			void *data);
 
 struct ofono_call_forwarding_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_call_forwarding *cf, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_call_forwarding *cf, unsigned int vendor,
diff --git a/include/call-meter.h b/include/call-meter.h
index 9a00104a2ede..455f1645ba0d 100644
--- a/include/call-meter.h
+++ b/include/call-meter.h
@@ -30,6 +30,7 @@ typedef void(*ofono_call_meter_set_cb_t)(const struct ofono_error *error,
 						void *data);
 
 struct ofono_call_meter_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_call_meter *cm, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_call_meter *cm, unsigned int vendor,
diff --git a/include/call-settings.h b/include/call-settings.h
index ced1047fd3d2..72c69df6ed20 100644
--- a/include/call-settings.h
+++ b/include/call-settings.h
@@ -28,6 +28,7 @@ typedef void (*ofono_call_settings_clir_cb_t)(const struct ofono_error *error,
 					int override, int network, void *data);
 
 struct ofono_call_settings_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_call_settings *cs, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_call_settings *cs, unsigned int vendor,
diff --git a/include/call-volume.h b/include/call-volume.h
index 90629b25cc1f..5b95d1814d86 100644
--- a/include/call-volume.h
+++ b/include/call-volume.h
@@ -23,6 +23,7 @@ typedef void (*ofono_call_volume_cb_t)(const struct ofono_error *error,
 					void *data);
 
 struct ofono_call_volume_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_call_volume *cv, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_call_volume *cv, unsigned int vendor,
diff --git a/include/cbs.h b/include/cbs.h
index 9d3367b7b24f..07e08836db6e 100644
--- a/include/cbs.h
+++ b/include/cbs.h
@@ -22,6 +22,7 @@ typedef void (*ofono_cbs_set_cb_t)(const struct ofono_error *error,
 					void *data);
 
 struct ofono_cbs_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_cbs *cbs, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_cbs *cbs, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_cbs *cbs);
diff --git a/include/ctm.h b/include/ctm.h
index 315fa5d562f3..19a7332dcc2b 100644
--- a/include/ctm.h
+++ b/include/ctm.h
@@ -25,6 +25,7 @@ typedef void (*ofono_ctm_query_cb_t)(const struct ofono_error *error,
 					ofono_bool_t enable, void *data);
 
 struct ofono_ctm_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_ctm *ctm, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_ctm *ctm, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_ctm *ctm);
diff --git a/include/devinfo.h b/include/devinfo.h
index ac553e959443..70190b8fcc62 100644
--- a/include/devinfo.h
+++ b/include/devinfo.h
@@ -22,6 +22,7 @@ typedef void (*ofono_devinfo_query_cb_t)(const struct ofono_error *error,
 					const char *attribute, void *data);
 
 struct ofono_devinfo_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_devinfo *info, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_devinfo *info, unsigned int vendor,
diff --git a/include/gnss.h b/include/gnss.h
index dd1b79246f72..5df31791ef80 100644
--- a/include/gnss.h
+++ b/include/gnss.h
@@ -22,6 +22,7 @@ struct ofono_gnss;
 typedef void (*ofono_gnss_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_gnss_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_gnss *gnss, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_gnss *gnss, unsigned int vendor,
 			va_list args);
diff --git a/include/gprs-context.h b/include/gprs-context.h
index 2bc9dd166787..0002724acbd3 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -42,6 +42,7 @@ typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
 					void *data);
 
 struct ofono_gprs_context_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_gprs_context *gc, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_gprs_context *gc, unsigned int vendor,
diff --git a/include/gprs.h b/include/gprs.h
index 62bf05baf30b..df288a125de4 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -25,6 +25,7 @@ typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_gprs_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_gprs *gprs, unsigned int vendor,
diff --git a/include/handsfree.h b/include/handsfree.h
index 43fe572693f6..19eeb52bd802 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -30,6 +30,7 @@ typedef void (*ofono_handsfree_cnum_query_cb_t)(const struct ofono_error *error,
 				void *data);
 
 struct ofono_handsfree_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_handsfree *hf, unsigned int vendor,
diff --git a/include/ims.h b/include/ims.h
index c394d5160c26..cee3ff804b37 100644
--- a/include/ims.h
+++ b/include/ims.h
@@ -25,6 +25,7 @@ typedef void (*ofono_ims_status_cb_t)(const struct ofono_error *error,
 						void *data);
 
 struct ofono_ims_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_ims *ims, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_ims *ims, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_ims *ims);
diff --git a/include/location-reporting.h b/include/location-reporting.h
index 7faf0ba3c485..75900eb5738c 100644
--- a/include/location-reporting.h
+++ b/include/location-reporting.h
@@ -31,6 +31,7 @@ typedef void (*ofono_location_reporting_disable_cb_t)(
 						void *data);
 
 struct ofono_location_reporting_driver {
+	unsigned int flags;
 	enum ofono_location_reporting_type type;
 	int (*probe)(struct ofono_location_reporting *lr, unsigned int vendor,
 								void *data);
diff --git a/include/lte.h b/include/lte.h
index 3f8dbd535e69..91a15fdcc1a0 100644
--- a/include/lte.h
+++ b/include/lte.h
@@ -30,6 +30,7 @@ struct ofono_lte_default_attach_info {
 typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_lte_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_lte *lte, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_lte *lte, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_lte *lte);
diff --git a/include/modem.h b/include/modem.h
index 08a7012acae4..65cb3a15bc95 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -41,6 +41,8 @@ struct ofono_driver_desc {
 	const void *driver;
 } __attribute__((aligned(8)));
 
+#define OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE	0x1
+
 #define OFONO_ATOM_DRIVER_BUILTIN(type, name, driver)			\
 	_Pragma("GCC diagnostic push")					\
 	_Pragma("GCC diagnostic ignored \"-Wattributes\"")		\
diff --git a/include/netmon.h b/include/netmon.h
index d1eef952314e..7eac8d070c80 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -21,6 +21,7 @@ struct ofono_netmon;
 typedef void (*ofono_netmon_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_netmon_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_netmon *netmon, unsigned int vendor,
 					void *data);
 	int (*probev)(struct ofono_netmon *netmon, unsigned int vendor,
diff --git a/include/netreg.h b/include/netreg.h
index 48a13e161fea..8d11518aa239 100644
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -57,6 +57,7 @@ typedef void (*ofono_netreg_strength_cb_t)(const struct ofono_error *error,
  * vendor extensions for signal strength notification.
  */
 struct ofono_netreg_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_netreg *netreg, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_netreg *netreg, unsigned int vendor,
diff --git a/include/phonebook.h b/include/phonebook.h
index 2c895fa9cf13..fbe689618215 100644
--- a/include/phonebook.h
+++ b/include/phonebook.h
@@ -39,6 +39,7 @@ typedef void (*ofono_phonebook_cb_t)(const struct ofono_error *error,
  * occurs, ofono_phonebook_entry should not be called
  */
 struct ofono_phonebook_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_phonebook *pb, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_phonebook *pb, unsigned int vendor,
diff --git a/include/radio-settings.h b/include/radio-settings.h
index 7dcccf81d226..487963c589d7 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -73,6 +73,7 @@ typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
 						void *data);
 
 struct ofono_radio_settings_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_radio_settings *rs, unsigned int vendor,
diff --git a/include/sim.h b/include/sim.h
index c362cc0ecb62..84592fc93e5a 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -125,6 +125,7 @@ typedef void (*ofono_sim_set_active_card_slot_cb_t)(
 					void *data);
 
 struct ofono_sim_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_sim *sim, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_sim *sim);
diff --git a/include/siri.h b/include/siri.h
index 0a9702b2037a..7a41694f0c09 100644
--- a/include/siri.h
+++ b/include/siri.h
@@ -22,6 +22,7 @@ typedef void (*ofono_siri_cb_t)(const struct ofono_error *error,
 					struct ofono_siri *siri);
 
 struct ofono_siri_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_siri *siri, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_siri *siri, unsigned int vendor,
 			va_list args);
diff --git a/include/sms.h b/include/sms.h
index d843ae6ae122..ba98c5e44287 100644
--- a/include/sms.h
+++ b/include/sms.h
@@ -31,6 +31,7 @@ typedef void (*ofono_sms_bearer_query_cb_t)(const struct ofono_error *error,
 						int bearer, void *data);
 
 struct ofono_sms_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_sms *sms, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_sms *sms, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_sms *sms);
diff --git a/include/stk.h b/include/stk.h
index 8575b2819b4a..b99f6ba255e4 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -26,6 +26,7 @@ typedef void (*ofono_stk_generic_cb_t)(const struct ofono_error *error,
 					void *data);
 
 struct ofono_stk_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_stk *stk, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_stk *stk, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_stk *stk);
diff --git a/include/ussd.h b/include/ussd.h
index 04a91e8483b7..1b928171ef9e 100644
--- a/include/ussd.h
+++ b/include/ussd.h
@@ -31,6 +31,7 @@ struct ofono_ussd;
 typedef void (*ofono_ussd_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_ussd_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
 	int (*probev)(struct ofono_ussd *ussd, unsigned int vendor,
 			va_list args);
diff --git a/include/voicecall.h b/include/voicecall.h
index 345e52b15a0e..370658369538 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -29,6 +29,7 @@ typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
  * not support vendor extensions for call progress indication.
  */
 struct ofono_voicecall_driver {
+	unsigned int flags;
 	int (*probe)(struct ofono_voicecall *vc, unsigned int vendor,
 			void *data);
 	int (*probev)(struct ofono_voicecall *vc, unsigned int vendor,
diff --git a/src/gprs.c b/src/gprs.c
index 28b3ddff6584..57b823b0f1c6 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2806,6 +2806,10 @@ static void gprs_context_remove(struct ofono_atom *atom)
 	g_free(gc);
 }
 
+static void ofono_gprs_context_register(struct ofono_gprs_context *gc)
+{
+}
+
 OFONO_DEFINE_ATOM_CREATE(gprs_context, OFONO_ATOM_TYPE_GPRS_CONTEXT, {
 	atom->type = OFONO_GPRS_CONTEXT_TYPE_ANY;
 })
diff --git a/src/ofono.h b/src/ofono.h
index c6fa16f2dc01..a853bba60ce6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -263,6 +263,11 @@ struct ofono_ ## type *ofono_ ## type ##_create(			\
 	}								\
 									\
 	atom->driver = drv;						\
+									\
+	if (atom->driver->flags &					\
+			OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE)	\
+		ofono_ ## type ##_register(atom);			\
+									\
 	return atom;							\
 }
 
-- 
2.45.0

