Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B9221D92
	for <ofono@lists.linux.dev>; Tue, 29 Jul 2025 05:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766525; cv=none; b=R+dtbL5ooMXpHw+Ao8nj2DvaXbNbyUIrjzymfbuwU1KHTUWlfQfUf6Vp9h4zM0y/R7EfwPerRis7wMyBn6ayqfxxbvyD1uxl1+seIdNdYcLycEctz5ZBCleg8nJtREDsZAoNqUYgS4BqlJaRznQ6Ttb22pLdvrxpSLijq5ERP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766525; c=relaxed/simple;
	bh=e6RgRLt7+xY4HJcZ3SqADNvkXGVZYvlY0w+3xlZGsTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E37rVGL6wjBwXhAUnN7MPjwO1SGR5F7KaOkrEQzuNxR2yifUA1+0j/tTMBw53pNqVjRWAIgoG0hUbUznJ2cYmoxs2Xh9geQVOu1h97kgSZ/dtx5ZRLsH1g9RpE1pBPEFzE/oyafDG3tWcO3xlHT/nu7xl2Jsrq+8R0HQr0qAM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA8QqM/N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA8QqM/N"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so8780608a12.2
        for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 22:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753766522; x=1754371322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfjENXCXgFP6em9JXegPUc2H6IaPkyPrsYwxf6xt5bI=;
        b=eA8QqM/NKN/Nk2FNfMabYzzzNKjF8db9cdrdnnNCxgACsSzpXBhv8CisJ4olzJNry9
         kR/elznJ/R/uYPLWaUgkiNPP5tBSM4nSfgLkDBEgHtw6w475XaBzW3D3hXveEKSLMIoX
         7LsCHY51T2p49kjfcur7LiUTT/XUmvW1e/9rmmlXsYPm1VxYnO/bmXgesd9jnlzh4yKu
         GgjaMBfm6mbwTbIg2yUX82kINr1/NNhIp6ettpWVCpZUac2V7nreCkQeYM6LIzu3mJ5K
         xrr8XE7bFQ7beekld3oIa4Z2WeqTQHaprdFmykNJq5Yw6pKwhjrS3KdlsjVp5ZkV0s3j
         W/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766522; x=1754371322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfjENXCXgFP6em9JXegPUc2H6IaPkyPrsYwxf6xt5bI=;
        b=iiIgDJk0Zwe+2xEt59JEj1dy9o1/fx3SQ6s9jWkDvblcRFRxPRkqkds/asCTh2N5sN
         V8B6aNIyJ+G9LSDlAeIbCOLm/36nikUedh8H6ICAVrwiCwbtgl/AFhKmeHMNGEOyqfNI
         KEp7+RZx9T0HkfycYFxykkkD1OqwFdrWqLgY41kT8vRtqe5qyMeEYYVpHJTAiiMw7VTa
         3ygmc7p6MEfRuF7IMgbAwSQF7w0XiHaAxzzncJrbxBJ4c0E0nYIhQRIoUcuKFDIKwSZI
         fFV/SG9sonB1wNdt+lGJkks/l2emgGZq0Vg9jETh6LPQWlj4VLu6GQkdOug848SC1j+b
         OGiQ==
X-Gm-Message-State: AOJu0YzqiGnaCpSqKQa7wEncLqffU4L6rB7kkQS4MsUl/WygxGGwUoHA
	pzxZ3YwYKTgcEreoeBixILulAJ1SBdF4+CX8JyCPEZKFumwndcNYKP0Js4rufA==
X-Gm-Gg: ASbGnctf4i+OIRK4cSq6j1QntmkU82itr/SOj8ZYkiQ/p5Jc6XB4iKCXWg42nBvBH1u
	6IS8ewaZOM79VojuN1kLZjx32rxfvsqsLbEGuP0ZEhU7r0mFJks3tXWmGuZXpNzwTCgWbGei0IJ
	V/GTLa1tjAz2mnaS5uQG8/oQdMPO9HVSVpsDzwatu07mRl8JEQaSNGJfIhfwAxRbvMnLttkU4sx
	Yr/1xATPBX1yXoJ2dlU6mDsTSLomp/wRk73s6sS+FUbbHIy1wH28U5XX7iSsv6ARlj/qRdfTH7f
	ErxLFlEIIJ0oCvMa8zuQlS8YoNMTk+WbGNdoMQMNOL25jQBFsC38WXSwFPvZtYPMHRyPwh+X7Oe
	nSfx8vnsMYg1PYv1ntmTFUfb/2qT+bHdC3TsOOzvcGQtV
X-Google-Smtp-Source: AGHT+IFYPkBNKDwFJQtgJybMg8Wm0wizT15dm/x+6iOPqElcujSAvwDiIWk+7sQbCEpNZzecvliuKg==
X-Received: by 2002:a17:906:1705:b0:af6:a116:f13c with SMTP id a640c23a62f3a-af6a116f8c9mr258968666b.23.1753766522209;
        Mon, 28 Jul 2025 22:22:02 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63589cab0sm525110266b.38.2025.07.28.22.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:22:01 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/3] plugins: drop droid and use gobi for droid4 modem instead
Date: Tue, 29 Jul 2025 08:21:32 +0300
Message-Id: <20250729052132.779994-4-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
References: <20250729052132.779994-1-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am      |   1 -
 plugins/droid.c  | 172 -----------------------------------------------
 plugins/udevng.c |  32 ++++++---
 3 files changed, 21 insertions(+), 184 deletions(-)
 delete mode 100644 plugins/droid.c

diff --git a/Makefile.am b/Makefile.am
index c013e77d..cf51cdf1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -578,7 +578,6 @@ builtin_sources += plugins/telit.c
 builtin_sources += plugins/quectel.c
 builtin_sources += plugins/ublox.c
 builtin_sources += plugins/xmm7xxx.c
-builtin_sources += plugins/droid.c
 
 builtin_modules += stemgr
 builtin_sources += plugins/stemgr.c
diff --git a/plugins/droid.c b/plugins/droid.c
deleted file mode 100644
index 1dfae9ee..00000000
--- a/plugins/droid.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * oFono - Open Source Telephony
- * Copyright (C) 2008-2011  Intel Corporation
- * Copyright (C) 2009  Collabora Ltd
- * Copyright (C) 2020  Pavel Machek
- *
- * SPDX-License-Identifier: GPL-2.0-only
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdlib.h>
-#include <errno.h>
-
-#include <glib.h>
-#include <gatchat.h>
-#include <gattty.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/call-barring.h>
-#include <ofono/call-forwarding.h>
-#include <ofono/call-meter.h>
-#include <ofono/call-settings.h>
-#include <ofono/devinfo.h>
-#include <ofono/message-waiting.h>
-#include <ofono/netreg.h>
-#include <ofono/phonebook.h>
-#include <ofono/sim.h>
-#include <ofono/sms.h>
-#include <ofono/ussd.h>
-#include <ofono/voicecall.h>
-
-#include <drivers/atmodem/atutil.h>
-#include <drivers/atmodem/vendor.h>
-
-static void droid_debug(const char *str, void *user_data)
-{
-	const char *prefix = user_data;
-
-	ofono_info("%s%s", prefix, str);
-}
-
-/* Detect hardware, and initialize if found */
-static int droid_probe(struct ofono_modem *modem)
-{
-	DBG("");
-
-	return 0;
-}
-
-static void droid_remove(struct ofono_modem *modem)
-{
-	GAtChat *chat = ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (chat) {
-		g_at_chat_unref(chat);
-		ofono_modem_set_data(modem, NULL);
-	}
-}
-
-static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem = user_data;
-
-	DBG("");
-
-	if (ok)
-		ofono_modem_set_powered(modem, TRUE);
-}
-
-/* power up hardware */
-static int droid_enable(struct ofono_modem *modem)
-{
-	GAtChat *chat;
-
-	DBG("");
-
-	chat = at_util_open_device(modem, "Device", droid_debug, "", NULL);
-	ofono_modem_set_data(modem, chat);
-
-	/* ensure modem is in a known state; verbose on, echo/quiet off */
-	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
-
-	/* power up modem */
-	g_at_chat_send(chat, "AT+CFUN=1", NULL, cfun_set_on_cb, modem, NULL);
-
-	return 0;
-}
-
-static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem = user_data;
-	GAtChat *chat = ofono_modem_get_data(modem);
-
-	DBG("");
-
-	g_at_chat_unref(chat);
-	ofono_modem_set_data(modem, NULL);
-
-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
-}
-
-static int droid_disable(struct ofono_modem *modem)
-{
-	GAtChat *chat = ofono_modem_get_data(modem);
-
-	DBG("");
-
-	/* power down modem */
-	g_at_chat_cancel_all(chat);
-	g_at_chat_unregister_all(chat);
-	g_at_chat_send(chat, "AT+CFUN=0", NULL, cfun_set_off_cb, modem, NULL);
-
-	return -EINPROGRESS;
-}
-
-static void droid_pre_sim(struct ofono_modem *modem)
-{
-	GAtChat *chat = ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
-
-	DBG("");
-
-	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	sim = ofono_sim_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
-	ofono_voicecall_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
-
-	if (sim)
-		ofono_sim_inserted_notify(sim, TRUE);
-}
-
-static void droid_post_sim(struct ofono_modem *modem)
-{
-	GAtChat *chat = ofono_modem_get_data(modem);
-	struct ofono_message_waiting *mw;
-
-	DBG("");
-
-	ofono_ussd_create(modem, 0, "atmodem", chat);
-	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
-	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, 0, "atmodem", chat);
-	/*
-	 * Droid 4 modem has problems with AT+CPUC?, avoid call meter for now.
-	 */
-	ofono_call_barring_create(modem, 0, "atmodem", chat);
-	ofono_sms_create(modem, OFONO_VENDOR_DROID, "atmodem", chat);
-	ofono_phonebook_create(modem, 0, "atmodem", chat);
-
-	mw = ofono_message_waiting_create(modem);
-	if (mw)
-		ofono_message_waiting_register(mw);
-}
-
-static struct ofono_modem_driver droid_driver = {
-	.probe		= droid_probe,
-	.remove		= droid_remove,
-	.enable		= droid_enable,
-	.disable	= droid_disable,
-	.pre_sim	= droid_pre_sim,
-	.post_sim	= droid_post_sim,
-};
-
-OFONO_MODEM_DRIVER_BUILTIN(droid, &droid_driver)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 320cd3a6..18954d44 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -870,7 +870,9 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 
 static gboolean setup_droid(struct modem_info *modem)
 {
-	const char *at = NULL;
+	const struct device_info *qmi = NULL;
+	const struct device_info *net = NULL;
+
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -878,23 +880,31 @@ static gboolean setup_droid(struct modem_info *modem)
 	for (list = modem->devices; list; list = list->next) {
 		struct device_info *info = list->data;
 		const char *subsystem =
-			udev_device_get_subsystem(info->udev_device);
-
-		DBG("%s %s %s %s %s", info->devnode, info->interface,
-				info->number, info->label, subsystem);
+				udev_device_get_subsystem(info->udev_device);
+		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label,
+						info->sysattr, subsystem);
 
-		if (g_strcmp0(info->interface, "255/255/255") == 0 &&
-				g_strcmp0(info->number, "04") == 0) {
-			at = info->devnode;
+		if (g_strcmp0(subsystem, "usbmisc") == 0) {
+			if (g_strcmp0(info->number, "05") == 0)
+				qmi = info;
+		} else if (g_strcmp0(subsystem, "net") == 0) {
+			if (g_strcmp0(info->number, "05") == 0)
+				net = info;
 		}
 	}
 
-	if (at == NULL)
+	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "Device", at);
-	ofono_modem_set_driver(modem->modem, "droid");
+	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
+
+
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
+		return FALSE;
 
+	ofono_modem_set_string(modem->modem, "OfflineOperatingMode",
+				"PersistentLowPower");
 	return TRUE;
 }
 
-- 
2.25.1

