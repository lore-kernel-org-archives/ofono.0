Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85F1A38DE
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513751; cv=none; b=uLluQJiukG9W0/LaCxFjJXqrmhXLs3shvMdR34Sg3fXSU81/Nf/wKPyD0J0xj0p/kDV4JTHJt2Vcj8Rgrc4qBw8xC0HEX8xKag5nXBgvnTLc8CafQoRvs2k9MUHufyN6EfK3acnXa5Ecf4oo0yPvYYWLFr2prxydtc3UxplfsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513751; c=relaxed/simple;
	bh=fWcSjJw5cwaev0VqJ9JNiW12lYKkExPeYqdIOES6NGs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clyP1BEfbRsTFQp1/tvMpI42xq4oQ+LNocVcR0uIHURovS0temBSPp/z6kZmFiUU0jGr3sA4bKalMOzYD6oLUyodYAvuWujA9Aj/nqqQeMWC/Xr4boUkWeklCMCTmCMv2z/YeF5nFlrJSfoqIEx8G6H/5pzuu+v29JM5w+EbBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEQnalnL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEQnalnL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41c011bb920so1353065e9.1
        for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714513747; x=1715118547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E47Lzytdp9K1WEqJb7WWyrUVlWJaz8jW4O3T7iBiM70=;
        b=VEQnalnLYAEnJKSpiaKyIAU0IncRNykyg8BM7VoUBdGbitZ+ZcFZt0idH+51QZhgDv
         T8ah8Rs6HKopEhjI14XUlHF11MWYSpRoBI0DNk89xvRWtTJcwP8zjcZdLCCVAvzMS78r
         2QT7nzMgqdyGibShpEBcodbsJ0ApWFVU7WYZqFIo8M8Y8ZLLSc4Sc+dc5P0FNXhB01iA
         kZ7fLvD5ffR+m6Lo4qVGyGqDwVBrMAD045h7zM962/PyAqcIwWOYAzsoJDfAnQqrHTsx
         6xM+nwfkn0+9zK/x/80JJyjmJet5WgOn8yFiwvtkhe31GMyQaj7vIyVtAGzaCQHzZtDd
         oj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513747; x=1715118547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E47Lzytdp9K1WEqJb7WWyrUVlWJaz8jW4O3T7iBiM70=;
        b=wdCCxyfVsVus8IffVH34hrvesX7FmktL6QFXGdK7Mw+yHt5uyh7DMELbwM3H5GRdEm
         mBCMgAMoHLGXlQ1U7El/I3fxSWDcOCmdauKbBqRue/HC9tvXGfy3z86pSTC9BEYJg2rK
         rT3nrg8WV5UNP4aoSzZiHYVbZyWcOQfsYqOsnt9wZ/oJJkQ5ZYzVSEahyGjZAAQYL8J1
         OfaMhi40401YxtTvjxjeipqBT3rXq3L8KEcmiy0SKXHztyI6tBSWDwOcdl0HPv7dBbZa
         KdCiqZQYPeFdb0kMoTuYGwifbF9diU7qL8/+Yf9F3KTcyZ47KWBgTgZpnxZK3qvYlZ/+
         nLyQ==
X-Gm-Message-State: AOJu0YxhP1eVsCT28dfJH7cMJ4xi6S4nyRdmbmTQXojyMvHqB1BNZrig
	hF/aywlNQgo+Ah6fvw0OODGkm8kxxpOsHuPcL3Gtt76WvC/2tylvQW0j6A==
X-Google-Smtp-Source: AGHT+IFJFC17vWeGK42l7HqnEQOYGhEMSbtZ82zOvZL7cbU1/XUdv6IQeSLbkbfPh4499Jo7Nyh0EQ==
X-Received: by 2002:a05:600c:1f82:b0:41b:8c5c:31b9 with SMTP id je2-20020a05600c1f8200b0041b8c5c31b9mr853529wmb.14.1714513747451;
        Tue, 30 Apr 2024 14:49:07 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.243.134.17])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm185641wms.5.2024.04.30.14.49.06
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:49:07 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: RFC - Add AT interface to qmi device
Date: Tue, 30 Apr 2024 22:49:05 +0100
Message-ID: <2269874.vFx2qVVIhK@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi

I would appreciate views on this patch I need for the Pinephone modem.  This 
adds code to the gobi plugin and qmi_device to get a handle to the GAtChat Aux 
interface.  The voicecall and sms drivers can then use this interface to 
trigger call/sms notification.

This is done in addition to the QMI interface, because it seems that 
_sometimes_ the modem does not always send the QMI notification, or it is 
missed due to the phone being in a deep sleep state.  The AT interface is 
always triggered.

I do not expect to upstream this, but there may be useful parts, or you may be 
able to suggest another method?

Thanks

Adam

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 69a0e535..d94c5498 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -39,6 +39,7 @@
 #include <ell/ell.h>
 
 #include <ofono/log.h>
+#include <gatchat.h>
 
 #include "qmi.h"
 #include "ctl.h"
@@ -106,6 +107,7 @@ struct qmi_device {
 	bool writer_active : 1;
 	bool shutting_down : 1;
 	bool destroyed : 1;
+	GAtChat *atmodem;
 };
 
 struct qmi_device_qmux {
@@ -1053,6 +1055,22 @@ bool qmi_device_has_service(struct qmi_device *device, 
uint16_t type)
 	return __find_service_info_by_type(device, type);
 }
 
+void qmi_device_set_atmodem(struct qmi_device *device, GAtChat* atmodem)
+{
+	if (device == NULL)
+		return;
+
+	device->atmodem = atmodem;
+}
+
+GAtChat* qmi_device_get_atmodem(struct qmi_device *device)
+{
+	if (device == NULL)
+		return NULL;
+
+	return device->atmodem;
+}
+
 struct discover_data {
 	struct discovery super;
 	struct qmi_device *device;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0075f738..7bc423aa 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -21,6 +21,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <gatchat.h>
 
 #define QMI_SERVICE_CONTROL	0	/* Control service */
 #define QMI_SERVICE_WDS		1	/* Wireless data service 
*/
@@ -77,6 +78,9 @@ typedef void (*qmi_destroy_func_t)(void *user_data);
 
 struct qmi_device;
 
+void qmi_device_set_atmodem(struct qmi_device *device, GAtChat* atmodem);
+GAtChat* qmi_device_get_atmodem(struct qmi_device *device);
+
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index c6252d9d..f8882ab9 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -30,6 +30,8 @@
 #include <ofono/modem.h>
 #include <ofono/sms.h>
 
+#include <gatchat.h>
+
 #include "qmi.h"
 #include "wms.h"
 #include "util.h"
@@ -776,6 +778,15 @@ static void create_wms_cb(struct qmi_service *service, 
void *user_data)
 	ofono_sms_register(sms);
 }
 
+static void qmi_sms_at_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_sms *sms = user_data;
+
+	DBG("");
+
+	get_msg_list(sms);
+}
+
 static int qmi_sms_probe(struct ofono_sms *sms,
 				unsigned int vendor, void 
*user_data)
 {
@@ -790,6 +801,12 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 
 	qmi_service_create(device, QMI_SERVICE_WMS, create_wms_cb, sms, 
NULL);
 
+	GAtChat* atmodem = qmi_device_get_atmodem(device);
+	if (atmodem) {
+		guint ret = g_at_chat_register(atmodem, "+CMTI:", 
qmi_sms_at_notify, FALSE, sms, NULL);
+		DBG("SMS AT CHAT REGISTER %d", ret);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index c6383a56..4b01b784 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -24,12 +24,15 @@
 #include <config.h>
 #endif
 
+#include <ofono.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/voicecall.h>
 #include <src/common.h>
 #include <ell/ell.h>
 
+#include <gatchat.h>
+
 #include "voice.h"
 
 #include "qmi.h"
@@ -750,6 +753,17 @@ static void create_voice_cb(struct qmi_service *service, 
void *user_data)
 	ofono_voicecall_register(vc);
 }
 
+static void qmi_voicecall_ring_notify(GAtResult *result, gpointer user_data) 
{
+	struct ofono_voicecall *vc = user_data;
+	struct voicecall_data *data = ofono_voicecall_get_data(vc);
+
+	DBG("DETECTED AT RING");
+
+	qmi_service_send(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND, NULL,
+				all_call_status_ind, vc, NULL);
+
+}
+
 static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 					unsigned int vendor, 
void *user_data)
 {
@@ -766,6 +780,15 @@ static int qmi_voicecall_probe(struct ofono_voicecall 
*vc,
 	qmi_service_create(device, QMI_SERVICE_VOICE,
 					create_voice_cb, vc, 
NULL);
 
+	//Get a handle to the modem serial interface to detect RING signals
+	//Sometimes the QMI notify doesnt come through if the phone is
+	//asleep
+	GAtChat* atmodem = qmi_device_get_atmodem(device);
+	if (atmodem) {
+		guint ret = g_at_chat_register(atmodem, "RING", 
qmi_voicecall_ring_notify, FALSE, vc, NULL);
+		DBG("VOICE AT CHAT REGISTER %d", ret);
+	}
+
 	return 0;
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 550ce787..4a4d9d1b 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <net/if.h>
+#include <gatchat.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -60,6 +61,12 @@
 #include <drivers/qmimodem/wda.h>
 #include <drivers/qmimodem/util.h>
 
+//Define function from atutil.h as it cant be uncluded
+GAtChat *at_util_open_device(struct ofono_modem *modem, const char *key,
+				GAtDebugFunc debug_func, char 
*debug_prefix,
+				char *tty_option, ...);
+
+
 #define GOBI_DMS	(1 << 0)
 #define GOBI_NAS	(1 << 1)
 #define GOBI_WMS	(1 << 2)
@@ -448,6 +455,15 @@ static int gobi_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
 
+	//Get a handle to an AT interface if one was found, and attach it 
to the qmi_device
+	GAtChat *atchat = at_util_open_device(modem, "Aux", NULL, "Aux: ", 
NULL);
+	if (!atchat) {
+		DBG("No Aux");
+	} else {
+		DBG("Have atmodem");
+	}
+	qmi_device_set_atmodem(data->device, atchat); //Will set to NULL if 
doesnt exist
+
 	r = qmi_device_discover(data->device, discover_cb, modem, NULL);
 	if (!r)
 		return -EINPROGRESS;
diff --git a/plugins/udevng.c b/plugins/udevng.c
index b9d115f1..3f72ec3f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2085,6 +2085,12 @@ static void check_usb_device(struct udev_device 
*device)
 	const char *syspath, *devname, *driver;
 	const char *vendor = NULL, *model = NULL;
 	const char *kernel_driver;
+	const char* devsyspath = udev_device_get_syspath(device);
+
+	if (devsyspath == NULL) {
+		return;
+	}
+	DBG("devsyspath: %s", devsyspath);
 
 	usb_device = udev_device_get_parent_with_subsystem_devtype(device,
 							
"usb", "usb_device");
@@ -2156,10 +2162,39 @@ static void check_usb_device(struct udev_device 
*device)
 
 		if (driver == NULL)
 			return;
-	}
 
-	add_device(syspath, devname, driver, vendor, model, MODEM_TYPE_USB,
+		add_device(syspath, devname, driver, vendor, model, 
MODEM_TYPE_USB,
 			device, kernel_driver);
+
+		return;
+	}
+
+	//Now handle device as opposed to parent device
+	driver = udev_device_get_property_value(device, "ID_USB_DRIVER");
+	DBG("driver: %s", driver);
+
+	for (unsigned int i = 0; vendor_list[i].driver; i++) {
+		if (g_str_equal(vendor_list[i].drv, driver) == FALSE)
+			continue;
+
+		if (vendor_list[i].vid) {
+			if (!g_str_equal(vendor_list[i].vid, vendor))
+				continue;
+		}
+
+		if (vendor_list[i].pid) {
+			if (!g_str_equal(vendor_list[i].pid, model))
+				continue;
+		}
+
+		driver = vendor_list[i].driver;
+	}
+
+	if (driver == NULL)
+		return;
+
+	add_device(devsyspath, devname, driver, vendor, model, 
MODEM_TYPE_USB,
+		device, kernel_driver);
 }
 
 static const struct {



