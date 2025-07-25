Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FA246BB9
	for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446036; cv=none; b=hSuDlVZy/tv44BVPUbNSm0jBAZbS/PKD5m3tdPAxu9j7s5o1B4arkk7ygJSMEpRkUZOLeTHwPfiKWd4gqMiUlmnKEEUr2UylleM3Iha90hUUOlFEaKvigyNBshECcUW9BOEuDW4t3aui79ToQO4nvNLmXzLc8WmSbCdNT8DgCBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446036; c=relaxed/simple;
	bh=Ajog3syg8pcB6IyRVA/8HsuXS2/2xzX8ZYihrMGuuiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpSp0IQ8onhHiIy1GekUdxqNVnwq+bcHdZUsiNyVasOLB+ebL8qmtWJBe0nYFTcPiHAZotnz2MwhN4mtKOM2L4iSuqDT2S7MWUUO+e5E5D63+YIJAx9ELsBE2Gd0i2717nN0uDxjlOF3qcw7mbt/0G0OSlk4Fpr1lpAs+KqxzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aatxooLD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aatxooLD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3444703a12.1
        for <ofono@lists.linux.dev>; Fri, 25 Jul 2025 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446033; x=1754050833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7rDdS5/N8lQ8C0DkJKNL70NG5N4ijERmlxujXWouxY=;
        b=aatxooLDEFw1FDiH8m8wnsuntu/ziImrmM4C/YMXFRfMjpFgY3XK/Jd8aIVya0VCmo
         XjqhsyOwkqa1EF1KlWCrkYtUaNp+AtIRZjidj91zvlRHY473ZUbiX2GFzO/2wolgecRf
         Vx7JX+HWZmA/EXnf42EH+dUCKXV6XQ6tb4AWDq0z7eGLixRAOXKafcWHrIA0avs7oTL0
         gljyS9ouVN6tJie/EceiHod6FhO1EEAUizg2j3I5CARYitDJOFRrY4YiBxCsU768FrCj
         QeRPRwBBZjXuFLKtuEj+zTDuOU4B23vaVr/3dxRtNFXr+1XVDhhCDRvY+CrN10j7DZBa
         Oxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446033; x=1754050833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7rDdS5/N8lQ8C0DkJKNL70NG5N4ijERmlxujXWouxY=;
        b=BwyZgLfFm9oM7L2EHy8AmbGHUCejb1VRvIYYzxTqGsfIWyXf7iXmvJF5OqbDfiRx/z
         VYKSX5wJGAjWF1ewDC7tl41C1HDJXP5bFA87sX1iSoZMSpdudAJ69YY0VhGBHwOFHmgN
         HXKUocwYW2zgcT39sCLR9tHAa1k3QsWDbXlx5bcMNvwvAXLn8iIMIxEyhB/Cb/yqeWc/
         1LYxHUDOPgO9sQ8pbTi6YYqyBxBaw6E2nVn51ivMAVLRTUWU1fC6LKgH//6861qXQ55S
         QOFmhGwhq4VZBZsdc+eKc1VUt6UohDGA9xpAYqoG3ZuGJ3jkvJzjffaQIXOTZDfkKLiM
         cWgQ==
X-Gm-Message-State: AOJu0YzcArBJ+WlyzoaugbSwoJbxLDx9dzNsHnHTJFQnOO+j/rCOiMBd
	QF0gb7m69kC9Eet7k9l0cFtoL32cj3PvUZQFMQNxgwO5NTDN+sH5d+rzA+23CA==
X-Gm-Gg: ASbGncu4UYGx1mAl7bQvn9OvAEfho3PGtJQQfNSd/nyRHPlrLLcKDiuEy3R2di5gOgw
	zGTXFjTL9u5buahat7639EDgF+GJjpuhLINOoD0dT6yvAUf8vcSFhhpv3l/UK3QxdGGIMcrqVOD
	Cr96taMNcsRUKOdlBx5R/mZxzzsrXSyxUMPT6dVzQk0wmgcbOCWN0QDfkaddIbRBHTe3rs5R4PE
	KD/HHqljmq7jxkUc25U8HX9cL9EG5as30yz4Rkf0d8Jmbd+Xnf0LDvfVG71LvcTs0cQpQfgLTZk
	u7YhTmvuZLDf/8uCPSQFctgVG4DMx3RJkPMicSIdBd6QinWEzyCxHAOSOmkBdJZV/c13sAZLJkP
	e3hozy4D/Pi/Q7KKQ2Hx9g8ClUuK/YHjeichuTeDHo5XY
X-Google-Smtp-Source: AGHT+IHU6qq+tmdlaaskb3xmYTDHPhTBP0M9APvAauVyvXJBS1Q6qtzj5nTfS9B5dUpBqg4gOSAMyg==
X-Received: by 2002:a17:907:6d18:b0:ae6:efe1:5baf with SMTP id a640c23a62f3a-af61c7af198mr187250366b.19.1753446032624;
        Fri, 25 Jul 2025 05:20:32 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e769sm264898866b.45.2025.07.25.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:20:32 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 6/6] plugins: drop droid and use gobi for droid4 modem instead
Date: Fri, 25 Jul 2025 15:19:54 +0300
Message-Id: <20250725121954.650668-7-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
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
index 5627f1ec..9d405d37 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -871,7 +871,9 @@ static gboolean setup_telitqmi(struct modem_info *modem)
 
 static gboolean setup_droid(struct modem_info *modem)
 {
-	const char *at = NULL;
+	const struct device_info *qmi = NULL;
+	const struct device_info *net = NULL;
+
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -879,22 +881,30 @@ static gboolean setup_droid(struct modem_info *modem)
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
+		return FALSE;
+
+	DBG("qmi=%s net=%s", qmi->devnode, get_ifname(net));
+
+
+	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "Device", at);
-	ofono_modem_set_driver(modem->modem, "droid");
+	ofono_modem_set_boolean(modem->modem, "LTE", false);
 
 	return TRUE;
 }
-- 
2.25.1

