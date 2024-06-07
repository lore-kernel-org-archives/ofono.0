Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244919D8B5
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800474; cv=none; b=j85hJsaq0nij2hCLtx5ZXpjqsGmjpSyIBbKdsMNn43H0+zioVLrMtBJcQW0bfrT8C1bxweVzQhhCqSXawXdrA+hteAythR8l1Y1VzbwQPDhnZQVFDQlJZMvnox+rLaPulLqclmWbaE1Lr2LpvMjrpBtQ+5tcMaM40sfNnUUU8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800474; c=relaxed/simple;
	bh=v3NYrCIbc8O3gNo5zAII2decMYYYS0rNP05Ofuq3Hrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqDn6TYRcuwKXsMn514+KWbnnhidAsaFNDCU+GfTUikxPeAM+M/mPJeRpx5PKYnReTRniCFvH7rO90QrEDO9tU3kXNuS7KJ9NoFVavIY7sqVEgFg1h0FH+Kcp5Bt2sBnFQnhQ6BwkKL1CX8JuKBlMN9UIiw12kdby+9/lU2vfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwrVRkkX; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwrVRkkX"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ba74c25fb3so1450873eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800471; x=1718405271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz3oV2SPzU8qCiEWnTf29QXcGiJ7UaZ8jkvFO5aa0QU=;
        b=QwrVRkkXBCl+TTz/QAyuOiJnBMi6vUfHt8jME9Ecq/6BMuQ5EvzVTLKcfW0ILPH6vU
         mrfLCu79b89FiFhFkiGMLZMIp8/oBqVP+2YsqZIsDgIjmauoMHPIB+CuohDEklawSSCb
         nN+q8dcdRDk9aBGYsQdNA63sYBMOo2DeC9N4Gf3mNIr13O4gPIF+pJz3r22sgffofa+T
         cGqVbPzdjXrXpJRkuoVEYyTC/uVyQz8V5S/gcnPz6RUpidDtMH54olzflN9WkKrCG+Il
         LMUdHCgOy/J3Vipkph48UZd/GeMfZfKrCRcyiS/B6PkxywP/FbUZiE2e8Wro76IO4AaH
         sJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800471; x=1718405271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz3oV2SPzU8qCiEWnTf29QXcGiJ7UaZ8jkvFO5aa0QU=;
        b=I33voSKPRjmvBGTOR/i/RyyPF0Dv7V/EwVxl7MvHzJJzlYIUZr5dfxuJvOTOIFsWX6
         BGEQ0zYgBv2CIFcEZz3cjjdgcVjMXfZDvvFW0qfobZONNwEWiwbF2tdTzuDCH4XoSTeN
         NXTLy/vx0fj5XAeqkC2lMf1e7HGYU6EzybYh3o1ge+qwuzW6x25U8dgCc/bsxEnfZc+M
         2RAe51MWKfy84cv+IY5t3H8xBNWC3X8ZW7kmcFw14B593DlFZxQcx4SNhqtHL2Ke4E6X
         3AZdOUmqsTqRiiDAVm5YnTtPVk1yRnkWwOTW+nA7MYNmgHixQsRY7xd72EI2mXtm0Esc
         ARTw==
X-Gm-Message-State: AOJu0YzfreHKaijLz0Ym2sSv7KaAn12O954vV5BknJJcPcjgjwBoEwtS
	vrS0QgmpP04Wj0zuDx716kwBUAo755FfWqBjBXYy5nlNmN4gG9ZA5ERaSw==
X-Google-Smtp-Source: AGHT+IFjMklrrppcdqOQlahxSm6as5Zf6zsBDzmYOVnqpHi2GJfmH/1+MqC3c4ZPTQj7iw0UseP+mQ==
X-Received: by 2002:a05:6820:1609:b0:5b2:f2e5:a8c8 with SMTP id 006d021491bc7-5baae8c3542mr5039928eaf.8.1717800470844;
        Fri, 07 Jun 2024 15:47:50 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/23] core: allow multiple args in atom constructors
Date: Fri,  7 Jun 2024 17:47:03 -0500
Message-ID: <20240607224746.903769-3-denkenz@gmail.com>
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

It would be useful to send multiple arguments to atom probe() functions
without having to define / create an intermediate structure.  To that
end, add the ability to send multiple arguments to all atom
constructors.  To keep backwards compatibility, the probe() method is
invoked with a single void * argument.
---
 include/audio-settings.h     |  6 +++++-
 include/call-barring.h       |  6 +++++-
 include/call-forwarding.h    |  6 +++++-
 include/call-meter.h         |  6 +++++-
 include/call-settings.h      |  6 +++++-
 include/call-volume.h        |  6 +++++-
 include/cbs.h                |  5 ++++-
 include/ctm.h                |  5 ++++-
 include/devinfo.h            |  6 +++++-
 include/gnss.h               |  6 +++++-
 include/gprs-context.h       |  6 +++++-
 include/gprs.h               |  6 +++++-
 include/handsfree.h          |  6 +++++-
 include/ims.h                |  5 ++++-
 include/location-reporting.h |  6 +++++-
 include/lte.h                |  5 ++++-
 include/netmon.h             |  6 +++++-
 include/netreg.h             |  7 +++++--
 include/phonebook.h          |  6 +++++-
 include/radio-settings.h     |  6 +++++-
 include/sim.h                |  5 ++++-
 include/siri.h               |  6 +++++-
 include/sms.h                |  5 ++++-
 include/stk.h                |  5 ++++-
 include/ussd.h               |  6 +++++-
 include/voicecall.h          |  6 +++++-
 src/ofono.h                  | 16 +++++++++++++---
 27 files changed, 136 insertions(+), 30 deletions(-)

diff --git a/include/audio-settings.h b/include/audio-settings.h
index 797f6e3780ec..452d7e73632d 100644
--- a/include/audio-settings.h
+++ b/include/audio-settings.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_audio_settings;
@@ -19,6 +21,8 @@ struct ofono_audio_settings;
 struct ofono_audio_settings_driver {
 	int (*probe)(struct ofono_audio_settings *as,
 				unsigned int vendor, void *data);
+	int (*probev)(struct ofono_audio_settings *as,
+				unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_audio_settings *as);
 };
 
@@ -30,7 +34,7 @@ void ofono_audio_settings_mode_notify(struct ofono_audio_settings *as,
 struct ofono_audio_settings *ofono_audio_settings_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_audio_settings_register(struct ofono_audio_settings *as);
 void ofono_audio_settings_remove(struct ofono_audio_settings *as);
diff --git a/include/call-barring.h b/include/call-barring.h
index 05df4270543b..99e2764e64da 100644
--- a/include/call-barring.h
+++ b/include/call-barring.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_call_barring;
@@ -24,6 +26,8 @@ typedef void (*ofono_call_barring_query_cb_t)(const struct ofono_error *error,
 struct ofono_call_barring_driver {
 	int (*probe)(struct ofono_call_barring *cb, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_call_barring *cb, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_call_barring *cb);
 	void (*set)(struct ofono_call_barring *barr, const char *lock,
 			int enable, const char *passwd, int cls,
@@ -38,7 +42,7 @@ struct ofono_call_barring_driver {
 struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data);
+							...);
 
 void ofono_call_barring_register(struct ofono_call_barring *cb);
 void ofono_call_barring_remove(struct ofono_call_barring *cb);
diff --git a/include/call-forwarding.h b/include/call-forwarding.h
index b4ad0a206788..2eb2f1817b8d 100644
--- a/include/call-forwarding.h
+++ b/include/call-forwarding.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_call_forwarding;
@@ -34,6 +36,8 @@ typedef void (*ofono_call_forwarding_query_cb_t)(
 struct ofono_call_forwarding_driver {
 	int (*probe)(struct ofono_call_forwarding *cf, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_call_forwarding *cf, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_call_forwarding *cf);
 	void (*activation)(struct ofono_call_forwarding *cf,
 				int type, int cls,
@@ -56,7 +60,7 @@ struct ofono_call_forwarding_driver {
 struct ofono_call_forwarding *ofono_call_forwarding_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_call_forwarding_register(struct ofono_call_forwarding *cf);
 void ofono_call_forwarding_remove(struct ofono_call_forwarding *cf);
diff --git a/include/call-meter.h b/include/call-meter.h
index feaef17ed5f1..9a00104a2ede 100644
--- a/include/call-meter.h
+++ b/include/call-meter.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_call_meter;
@@ -30,6 +32,8 @@ typedef void(*ofono_call_meter_set_cb_t)(const struct ofono_error *error,
 struct ofono_call_meter_driver {
 	int (*probe)(struct ofono_call_meter *cm, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_call_meter *cm, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_call_meter *cm);
 	void (*call_meter_query)(struct ofono_call_meter *cm,
 				ofono_call_meter_query_cb_t cb, void *data);
@@ -52,7 +56,7 @@ struct ofono_call_meter_driver {
 struct ofono_call_meter *ofono_call_meter_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data);
+							...);
 
 void ofono_call_meter_register(struct ofono_call_meter *cm);
 void ofono_call_meter_remove(struct ofono_call_meter *cm);
diff --git a/include/call-settings.h b/include/call-settings.h
index 854cc96afa97..ced1047fd3d2 100644
--- a/include/call-settings.h
+++ b/include/call-settings.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_call_settings;
@@ -28,6 +30,8 @@ typedef void (*ofono_call_settings_clir_cb_t)(const struct ofono_error *error,
 struct ofono_call_settings_driver {
 	int (*probe)(struct ofono_call_settings *cs, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_call_settings *cs, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_call_settings *cs);
 	void (*clip_query)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
@@ -52,7 +56,7 @@ struct ofono_call_settings_driver {
 struct ofono_call_settings *ofono_call_settings_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_call_settings_register(struct ofono_call_settings *cs);
 void ofono_call_settings_remove(struct ofono_call_settings *cs);
diff --git a/include/call-volume.h b/include/call-volume.h
index bf3606353cff..90629b25cc1f 100644
--- a/include/call-volume.h
+++ b/include/call-volume.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 #include <ofono/dbus.h>
 
@@ -23,6 +25,8 @@ typedef void (*ofono_call_volume_cb_t)(const struct ofono_error *error,
 struct ofono_call_volume_driver {
 	int (*probe)(struct ofono_call_volume *cv, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_call_volume *cv, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_call_volume *cv);
 	void (*speaker_volume)(struct ofono_call_volume *cv,
 				unsigned char percent,
@@ -41,7 +45,7 @@ void ofono_call_volume_set_microphone_volume(struct ofono_call_volume *cv,
 void ofono_call_volume_set_muted(struct ofono_call_volume *cv, int muted);
 
 struct ofono_call_volume *ofono_call_volume_create(struct ofono_modem *modem,
-			unsigned int vendor, const char *driver, void *data);
+			unsigned int vendor, const char *driver, ...);
 
 void ofono_call_volume_register(struct ofono_call_volume *cv);
 void ofono_call_volume_remove(struct ofono_call_volume *cv);
diff --git a/include/cbs.h b/include/cbs.h
index 7ec4b60afeda..9d3367b7b24f 100644
--- a/include/cbs.h
+++ b/include/cbs.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_cbs;
@@ -21,6 +23,7 @@ typedef void (*ofono_cbs_set_cb_t)(const struct ofono_error *error,
 
 struct ofono_cbs_driver {
 	int (*probe)(struct ofono_cbs *cbs, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_cbs *cbs, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_cbs *cbs);
 	void (*set_topics)(struct ofono_cbs *cbs, const char *topics,
 				ofono_cbs_set_cb_t cb, void *data);
@@ -32,7 +35,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsigned char *pdu, int len);
 
 struct ofono_cbs *ofono_cbs_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_cbs_register(struct ofono_cbs *cbs);
 void ofono_cbs_remove(struct ofono_cbs *cbs);
diff --git a/include/ctm.h b/include/ctm.h
index 5d600a500f9e..315fa5d562f3 100644
--- a/include/ctm.h
+++ b/include/ctm.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_ctm;
@@ -24,6 +26,7 @@ typedef void (*ofono_ctm_query_cb_t)(const struct ofono_error *error,
 
 struct ofono_ctm_driver {
 	int (*probe)(struct ofono_ctm *ctm, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_ctm *ctm, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_ctm *ctm);
 	void (*query_tty)(struct ofono_ctm *ctm,
 				ofono_ctm_query_cb_t cb, void *data);
@@ -33,7 +36,7 @@ struct ofono_ctm_driver {
 
 struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_ctm_register(struct ofono_ctm *ctm);
 void ofono_ctm_remove(struct ofono_ctm *ctm);
diff --git a/include/devinfo.h b/include/devinfo.h
index 59a1bd21ecdb..ac553e959443 100644
--- a/include/devinfo.h
+++ b/include/devinfo.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_devinfo;
@@ -22,6 +24,8 @@ typedef void (*ofono_devinfo_query_cb_t)(const struct ofono_error *error,
 struct ofono_devinfo_driver {
 	int (*probe)(struct ofono_devinfo *info, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_devinfo *info, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_devinfo *info);
 	void (*query_manufacturer)(struct ofono_devinfo *info,
 			ofono_devinfo_query_cb_t cb, void *data);
@@ -38,7 +42,7 @@ struct ofono_devinfo_driver {
 struct ofono_devinfo *ofono_devinfo_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data);
+							...);
 void ofono_devinfo_register(struct ofono_devinfo *info);
 void ofono_devinfo_remove(struct ofono_devinfo *info);
 
diff --git a/include/gnss.h b/include/gnss.h
index 700fc2737a6d..dd1b79246f72 100644
--- a/include/gnss.h
+++ b/include/gnss.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_gnss;
@@ -21,6 +23,8 @@ typedef void (*ofono_gnss_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_gnss_driver {
 	int (*probe)(struct ofono_gnss *gnss, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_gnss *gnss, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_gnss *gnss);
 	void (*send_element)(struct ofono_gnss *gnss,
 				const char *xml,
@@ -36,7 +40,7 @@ void ofono_gnss_notify_posr_reset(struct ofono_gnss *gnss);
 
 struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_gnss_register(struct ofono_gnss *gnss);
 void ofono_gnss_remove(struct ofono_gnss *gnss);
diff --git a/include/gprs-context.h b/include/gprs-context.h
index dab00191d3f6..2bc9dd166787 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_gprs_context;
@@ -42,6 +44,8 @@ typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
 struct ofono_gprs_context_driver {
 	int (*probe)(struct ofono_gprs_context *gc, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_gprs_context *gc, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_gprs_context *gc);
 	void (*activate_primary)(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
@@ -61,7 +65,7 @@ void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
 
 struct ofono_gprs_context *ofono_gprs_context_create(struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 void ofono_gprs_context_remove(struct ofono_gprs_context *gc);
 
 void ofono_gprs_context_set_data(struct ofono_gprs_context *gc, void *data);
diff --git a/include/gprs.h b/include/gprs.h
index f4706c5cdbd7..62bf05baf30b 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_gprs;
@@ -25,6 +27,8 @@ typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *data);
 struct ofono_gprs_driver {
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_gprs *gprs, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_gprs *gprs);
 	void (*set_attached)(struct ofono_gprs *gprs, int attached,
 				ofono_gprs_cb_t cb, void *data);
@@ -52,7 +56,7 @@ struct ofono_modem *ofono_gprs_get_modem(struct ofono_gprs *gprs);
 
 struct ofono_gprs *ofono_gprs_create(struct ofono_modem *modem,
 					unsigned int vendor, const char *driver,
-					void *data);
+					...);
 void ofono_gprs_register(struct ofono_gprs *gprs);
 void ofono_gprs_remove(struct ofono_gprs *gprs);
 
diff --git a/include/handsfree.h b/include/handsfree.h
index 326d79c33c9e..43fe572693f6 100644
--- a/include/handsfree.h
+++ b/include/handsfree.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_handsfree;
@@ -30,6 +32,8 @@ typedef void (*ofono_handsfree_cnum_query_cb_t)(const struct ofono_error *error,
 struct ofono_handsfree_driver {
 	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_handsfree *hf, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_handsfree *hf);
 	void (*cnum_query)(struct ofono_handsfree *hf,
 				ofono_handsfree_cnum_query_cb_t cb, void *data);
@@ -66,7 +70,7 @@ void ofono_handsfree_battchg_notify(struct ofono_handsfree *hf,
 					unsigned char level);
 
 struct ofono_handsfree *ofono_handsfree_create(struct ofono_modem *modem,
-			unsigned int vendor, const char *driver, void *data);
+			unsigned int vendor, const char *driver, ...);
 
 void ofono_handsfree_register(struct ofono_handsfree *hf);
 void ofono_handsfree_remove(struct ofono_handsfree *hf);
diff --git a/include/ims.h b/include/ims.h
index 737532b17500..c394d5160c26 100644
--- a/include/ims.h
+++ b/include/ims.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_ims;
@@ -24,6 +26,7 @@ typedef void (*ofono_ims_status_cb_t)(const struct ofono_error *error,
 
 struct ofono_ims_driver {
 	int (*probe)(struct ofono_ims *ims, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_ims *ims, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_ims *ims);
 	void (*ims_register)(struct ofono_ims *ims,
 				ofono_ims_register_cb_t cb, void *data);
@@ -38,7 +41,7 @@ void ofono_ims_status_notify(struct ofono_ims *ims, int reg_info,
 
 struct ofono_ims *ofono_ims_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_ims_register(struct ofono_ims *ims);
 void ofono_ims_remove(struct ofono_ims *ims);
diff --git a/include/location-reporting.h b/include/location-reporting.h
index 38003a950005..7faf0ba3c485 100644
--- a/include/location-reporting.h
+++ b/include/location-reporting.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_location_reporting;
@@ -32,6 +34,8 @@ struct ofono_location_reporting_driver {
 	enum ofono_location_reporting_type type;
 	int (*probe)(struct ofono_location_reporting *lr, unsigned int vendor,
 								void *data);
+	int (*probev)(struct ofono_location_reporting *lr, unsigned int vendor,
+								va_list args);
 	void (*remove)(struct ofono_location_reporting *lr);
 	void (*enable)(struct ofono_location_reporting *lr,
 			ofono_location_reporting_enable_cb_t cb, void *data);
@@ -42,7 +46,7 @@ struct ofono_location_reporting_driver {
 struct ofono_location_reporting *ofono_location_reporting_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_location_reporting_register(struct ofono_location_reporting *lr);
 void ofono_location_reporting_remove(struct ofono_location_reporting *lr);
diff --git a/include/lte.h b/include/lte.h
index 378b8faf5d43..3f8dbd535e69 100644
--- a/include/lte.h
+++ b/include/lte.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_lte;
@@ -29,6 +31,7 @@ typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_lte_driver {
 	int (*probe)(struct ofono_lte *lte, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_lte *lte, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_lte *lte);
 	void (*set_default_attach_info)(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
@@ -37,7 +40,7 @@ struct ofono_lte_driver {
 
 struct ofono_lte *ofono_lte_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_lte_register(struct ofono_lte *lte);
 
diff --git a/include/netmon.h b/include/netmon.h
index 85d25706f06a..d1eef952314e 100644
--- a/include/netmon.h
+++ b/include/netmon.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_netmon;
@@ -21,6 +23,8 @@ typedef void (*ofono_netmon_cb_t)(const struct ofono_error *error, void *data);
 struct ofono_netmon_driver {
 	int (*probe)(struct ofono_netmon *netmon, unsigned int vendor,
 					void *data);
+	int (*probev)(struct ofono_netmon *netmon, unsigned int vendor,
+					va_list args);
 	void (*remove)(struct ofono_netmon *netmon);
 	void (*request_update)(struct ofono_netmon *netmon,
 					ofono_netmon_cb_t cb, void *data);
@@ -80,7 +84,7 @@ void ofono_netmon_serving_cell_notify(struct ofono_netmon *netmon,
 
 struct ofono_netmon *ofono_netmon_create(struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_netmon_register(struct ofono_netmon *netmon);
 
diff --git a/include/netreg.h b/include/netreg.h
index e70283bf6bd5..48a13e161fea 100644
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_netreg;
@@ -57,6 +59,8 @@ typedef void (*ofono_netreg_strength_cb_t)(const struct ofono_error *error,
 struct ofono_netreg_driver {
 	int (*probe)(struct ofono_netreg *netreg, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_netreg *netreg, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_netreg *netreg);
 	void (*registration_status)(struct ofono_netreg *netreg,
 			ofono_netreg_status_cb_t cb, void *data);
@@ -81,8 +85,7 @@ void ofono_netreg_time_notify(struct ofono_netreg *netreg,
 
 struct ofono_netreg *ofono_netreg_create(struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver,
-						void *data);
+						const char *driver, ...);
 
 void ofono_netreg_register(struct ofono_netreg *netreg);
 void ofono_netreg_remove(struct ofono_netreg *netreg);
diff --git a/include/phonebook.h b/include/phonebook.h
index 2944e3a0d836..2c895fa9cf13 100644
--- a/include/phonebook.h
+++ b/include/phonebook.h
@@ -26,6 +26,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_phonebook;
@@ -39,6 +41,8 @@ typedef void (*ofono_phonebook_cb_t)(const struct ofono_error *error,
 struct ofono_phonebook_driver {
 	int (*probe)(struct ofono_phonebook *pb, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_phonebook *pb, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_phonebook *pb);
 	void (*export_entries)(struct ofono_phonebook *pb, const char *storage,
 				ofono_phonebook_cb_t cb, void *data);
@@ -55,7 +59,7 @@ void ofono_phonebook_entry(struct ofono_phonebook *pb, int index,
 struct ofono_phonebook *ofono_phonebook_create(struct ofono_modem *modem,
 							unsigned int vendor,
 							const char *driver,
-							void *data);
+							...);
 
 void ofono_phonebook_register(struct ofono_phonebook *pb);
 void ofono_phonebook_remove(struct ofono_phonebook *pb);
diff --git a/include/radio-settings.h b/include/radio-settings.h
index c424d374bb57..7dcccf81d226 100644
--- a/include/radio-settings.h
+++ b/include/radio-settings.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 enum ofono_radio_access_mode {
@@ -73,6 +75,8 @@ typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
 struct ofono_radio_settings_driver {
 	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_radio_settings *rs, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_radio_settings *rs);
 	void (*query_rat_mode)(struct ofono_radio_settings *rs,
 				ofono_radio_settings_rat_mode_query_cb_t cb,
@@ -103,7 +107,7 @@ struct ofono_radio_settings_driver {
 struct ofono_radio_settings *ofono_radio_settings_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-						const char *driver, void *data);
+						const char *driver, ...);
 
 void ofono_radio_settings_register(struct ofono_radio_settings *rs);
 void ofono_radio_settings_remove(struct ofono_radio_settings *rs);
diff --git a/include/sim.h b/include/sim.h
index 326a6fe09709..c362cc0ecb62 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_sim;
@@ -124,6 +126,7 @@ typedef void (*ofono_sim_set_active_card_slot_cb_t)(
 
 struct ofono_sim_driver {
 	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_sim *sim, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_sim *sim);
 	void (*read_file_info)(struct ofono_sim *sim, int fileid,
 			const unsigned char *path, unsigned int path_len,
@@ -200,7 +203,7 @@ struct ofono_sim_driver {
 
 struct ofono_sim *ofono_sim_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_sim_register(struct ofono_sim *sim);
 void ofono_sim_remove(struct ofono_sim *sim);
diff --git a/include/siri.h b/include/siri.h
index be09c49236a4..0a9702b2037a 100644
--- a/include/siri.h
+++ b/include/siri.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_siri;
@@ -21,6 +23,8 @@ typedef void (*ofono_siri_cb_t)(const struct ofono_error *error,
 
 struct ofono_siri_driver {
 	int (*probe)(struct ofono_siri *siri, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_siri *siri, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_siri *siri);
 	void (*set_eyes_free_mode) (struct ofono_siri *siri, ofono_siri_cb_t cb,
 					unsigned int val);
@@ -30,7 +34,7 @@ void ofono_siri_set_status(struct ofono_siri *siri, int value);
 
 struct ofono_siri *ofono_siri_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_siri_register(struct ofono_siri *siri);
 void ofono_siri_remove(struct ofono_siri *siri);
diff --git a/include/sms.h b/include/sms.h
index 21ac6a3a3d35..d843ae6ae122 100644
--- a/include/sms.h
+++ b/include/sms.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_sms;
@@ -30,6 +32,7 @@ typedef void (*ofono_sms_bearer_query_cb_t)(const struct ofono_error *error,
 
 struct ofono_sms_driver {
 	int (*probe)(struct ofono_sms *sms, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_sms *sms, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_sms *sms);
 	void (*sca_query)(struct ofono_sms *sms, ofono_sms_sca_query_cb_t cb,
 				void *data);
@@ -52,7 +55,7 @@ void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char *pdu,
 
 struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_sms_register(struct ofono_sms *sms);
 void ofono_sms_remove(struct ofono_sms *sms);
diff --git a/include/stk.h b/include/stk.h
index 93311d564223..8575b2819b4a 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_stk;
@@ -25,6 +27,7 @@ typedef void (*ofono_stk_generic_cb_t)(const struct ofono_error *error,
 
 struct ofono_stk_driver {
 	int (*probe)(struct ofono_stk *stk, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_stk *stk, unsigned int vendor, va_list args);
 	void (*remove)(struct ofono_stk *stk);
 	void (*envelope)(struct ofono_stk *stk,
 				int length, const unsigned char *command,
@@ -37,7 +40,7 @@ struct ofono_stk_driver {
 
 struct ofono_stk *ofono_stk_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_stk_register(struct ofono_stk *stk);
 void ofono_stk_remove(struct ofono_stk *stk);
diff --git a/include/ussd.h b/include/ussd.h
index 0b4895a82d52..04a91e8483b7 100644
--- a/include/ussd.h
+++ b/include/ussd.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 /* 3GPP TS 27.007 section 7.15, values for <m> */
@@ -30,6 +32,8 @@ typedef void (*ofono_ussd_cb_t)(const struct ofono_error *error, void *data);
 
 struct ofono_ussd_driver {
 	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
+	int (*probev)(struct ofono_ussd *ussd, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_ussd *ussd);
 	void (*request)(struct ofono_ussd *ussd, int dcs,
 			const unsigned char *pdu, int len,
@@ -43,7 +47,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
 
 struct ofono_ussd *ofono_ussd_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_ussd_register(struct ofono_ussd *ussd);
 void ofono_ussd_remove(struct ofono_ussd *ussd);
diff --git a/include/voicecall.h b/include/voicecall.h
index 50480b5ee015..345e52b15a0e 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -12,6 +12,8 @@
 extern "C" {
 #endif
 
+#include <stdarg.h>
+
 #include <ofono/types.h>
 
 struct ofono_modem;
@@ -29,6 +31,8 @@ typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
 struct ofono_voicecall_driver {
 	int (*probe)(struct ofono_voicecall *vc, unsigned int vendor,
 			void *data);
+	int (*probev)(struct ofono_voicecall *vc, unsigned int vendor,
+			va_list args);
 	void (*remove)(struct ofono_voicecall *vc);
 
 	/* According to 22.030 the dial is expected to do the following:
@@ -149,7 +153,7 @@ struct ofono_modem *ofono_voicecall_get_modem(struct ofono_voicecall *vc);
 
 struct ofono_voicecall *ofono_voicecall_create(struct ofono_modem *modem,
 					unsigned int vendor,
-					const char *driver, void *data);
+					const char *driver, ...);
 
 void ofono_voicecall_register(struct ofono_voicecall *vc);
 void ofono_voicecall_remove(struct ofono_voicecall *vc);
diff --git a/src/ofono.h b/src/ofono.h
index cb4eae81db1a..c6fa16f2dc01 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -5,6 +5,7 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+#include <stdarg.h>
 #include <glib.h>
 #include <ell/ell.h>
 
@@ -231,15 +232,17 @@ extern struct ofono_driver_desc __stop___ ## type[];			\
 struct ofono_ ## type *ofono_ ## type ##_create(			\
 				struct ofono_modem *modem,		\
 				unsigned int vendor, const char *driver,\
-				void *data)				\
+				...)					\
 {									\
 	const struct ofono_ ## type ## _driver *drv =			\
 		__ofono_driver_builtin_find(driver,			\
 				__start___ ## type,			\
 				__stop___ ## type);			\
+	va_list args;							\
 	struct ofono_ ## type *atom;					\
+	int r;								\
 									\
-	if (!drv || !drv->probe)					\
+	if (!drv || (!drv->probe && !drv->probev))			\
 		return NULL;						\
 									\
 	atom = g_new0(struct ofono_ ##type, 1);				\
@@ -247,7 +250,14 @@ struct ofono_ ## type *ofono_ ## type ##_create(			\
 				type ##_remove, atom);			\
 	__VA_ARGS__							\
 									\
-	if (drv->probe(atom, vendor, data) < 0)	{			\
+	va_start(args, driver);						\
+	if (drv->probev)						\
+		r = drv->probev(atom, vendor, args);			\
+	else								\
+		r = drv->probe(atom, vendor, va_arg(args, void *));	\
+	va_end(args);							\
+									\
+	if (r < 0) {							\
 		ofono_ ## type ##_remove(atom);				\
 		return NULL;						\
 	}								\
-- 
2.45.0

