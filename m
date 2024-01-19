Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D05787F
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698678; cv=none; b=sIj1IJc394eeI0B/gx+7d05Pc8gry3fU5+6WfzGXpTPQUtYCS8C8px9I2o3gc1Ot/07lBGEwhHyvW+Jtl5YLM/V+Tb1UQU2C4C8u4mDc/kfb5cD7SOPt2zMSU6v0B8MDAAc5AkWFGok96JssccbabGFtC1MhtG/liGtdLTVUlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698678; c=relaxed/simple;
	bh=2NMMTWmNQuSQtUMvi2mjrNuRNmZGzPBsWMXgt9txLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6UetQVy1p8zZJAmVcZtSH+dcWJM8Z0PaCnTPQ6LokTQQD24Znrq+ajNvht9h7K/8ctIiB4n5fVbICx7fy/HfQoYuCzuoF+rXcznGjMTd/Dj46ZvrqihnIIg1WZ/7OaqDNeNC55o1CgYyoTeTkwygxhmMUQYbd5NJrjO1ROD438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3kNxvzo; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3kNxvzo"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dddf12f280so753116a34.0
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698675; x=1706303475; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6hbsIajVURxx1kyQ5Wv5rqK08/OoZOZAMgDSqNw/Uw=;
        b=X3kNxvzoNLYrc6JcZk3PR4/dZsHgnY3SOkPToR5gS8n5Kp+vD0ksgPLjcEXrxkgBYN
         8alMHi/PoOMvKiHiD5lDGvmAmLQdAKH8BDTufNDRXcH4KO2RPTWsA4roWP2/JpZ998TX
         53H5SrEkh4+NNUBOoxqDo+bT1UvU7hCOSYhbYgobBV4C0wTCmTug9orW+SXc9XgXQFwZ
         +qUmof0Z2Gsath9P74iRBBTl1ifW1JfZg70fPl6dxZT4CbR2/gTaFaHDGgwKNPofly2U
         TYhX2/mgE3Aju98pDZcxRqSPEOLvdK+aYBbr3oNodITP8L/7KPD8qYy5SghxQywjAdbY
         5Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698675; x=1706303475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6hbsIajVURxx1kyQ5Wv5rqK08/OoZOZAMgDSqNw/Uw=;
        b=sa1Nr7aHvaYSG+FR/jntTRgPCwfudXwfxsPR7qEnmDMJlJB3mNLfBj1wtTlb/XFbAt
         EZjBgQGk+PiYuS4fUzNXHIcv3f3PONLF04QOqiXunMKn2LpAF7JKEwzHPByU7OjaJ1Yz
         pxcgFGt9VPraoRPJlHtEkKb4HHJomzxa0h9YbWl8LYRp40YS5ECKArOnePOD3VBBzxtH
         J0u7vyudZKo+YePORcw0ihCQ9T77m5AVTuPgwAWoEnL2RkjqlBpkYAadF3gZ1FRRhgbr
         /5rl/UMG39i6v/yyNEFMzff1Hn4EGeONCLIu4I9k5zA4avwWCZZaGMAXN8HLNZpIuO1w
         XZ9Q==
X-Gm-Message-State: AOJu0YyQkuhU1J5uwh810MCGLrgboWDLm90Gs7GbaW6zt9sAEaQ7C1D1
	byoJCu0o/hOVYSGjLYoxI/d6spJf0hmkQFbtQiTLuJCzvynGc0dXVPKghnOy
X-Google-Smtp-Source: AGHT+IHGPmBrLsnpVKn/Bt8l6ly0RMdKp+KzponSDn8Gy+nkc0miqQDc2Xd1rDZLWVG0tNLJLWmh3Q==
X-Received: by 2002:a9d:7cc9:0:b0:6dd:e237:2f22 with SMTP id r9-20020a9d7cc9000000b006dde2372f22mr497752otn.15.1705698675560;
        Fri, 19 Jan 2024 13:11:15 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:15 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/14] gprs-provision: Remove no longer used atom/driver
Date: Fri, 19 Jan 2024 15:09:49 -0600
Message-ID: <20240119211017.474598-13-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119211017.474598-1-denkenz@gmail.com>
References: <20240119211017.474598-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am              |   2 +-
 include/gprs-provision.h |  13 -----
 src/gprs-provision.c     | 101 ---------------------------------------
 3 files changed, 1 insertion(+), 115 deletions(-)
 delete mode 100644 src/gprs-provision.c

diff --git a/Makefile.am b/Makefile.am
index 1a97a1f1..15d220f7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -702,7 +702,7 @@ src_ofonod_SOURCES = $(builtin_sources) $(gatchat_sources) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/sim-auth.c \
-			src/message.h src/message.c src/gprs-provision.c \
+			src/message.h src/message.c \
 			src/emulator.c src/location-reporting.c \
 			src/gnss.c \
 			src/gnssagent.c src/gnssagent.h \
diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index 75808e66..ac0f5905 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -42,19 +42,6 @@ struct ofono_gprs_provision_data {
 	char *message_center;
 };
 
-struct ofono_gprs_provision_driver {
-	const char *name;
-	int priority;
-	int (*get_settings)(const char *mcc, const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count);
-};
-
-int ofono_gprs_provision_driver_register(
-			const struct ofono_gprs_provision_driver *driver);
-void ofono_gprs_provision_driver_unregister(
-			const struct ofono_gprs_provision_driver *driver);
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/gprs-provision.c b/src/gprs-provision.c
deleted file mode 100644
index 011d5a8d..00000000
--- a/src/gprs-provision.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <string.h>
-#include <glib.h>
-#include "ofono.h"
-
-static GSList *g_drivers = NULL;
-
-void  __ofono_gprs_provision_free_settings(
-				struct ofono_gprs_provision_data *settings,
-				int count)
-{
-	int i;
-
-	for (i = 0; i < count; i++) {
-		g_free(settings[i].name);
-		g_free(settings[i].apn);
-		g_free(settings[i].username);
-		g_free(settings[i].password);
-		g_free(settings[i].message_proxy);
-		g_free(settings[i].message_center);
-	}
-
-	g_free(settings);
-}
-
-ofono_bool_t __ofono_gprs_provision_get_settings(const char *mcc,
-				const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count)
-{
-	GSList *d;
-
-	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
-		return FALSE;
-
-	for (d = g_drivers; d != NULL; d = d->next) {
-		const struct ofono_gprs_provision_driver *driver = d->data;
-
-		if (driver->get_settings == NULL)
-			continue;
-
-		DBG("Calling provisioning plugin '%s'", driver->name);
-
-		if (driver->get_settings(mcc, mnc, spn, settings, count) < 0)
-			continue;
-
-		return TRUE;
-	}
-
-	return FALSE;
-}
-
-static gint compare_priority(gconstpointer a, gconstpointer b)
-{
-	const struct ofono_gprs_provision_driver *plugin1 = a;
-	const struct ofono_gprs_provision_driver *plugin2 = b;
-
-	return plugin2->priority - plugin1->priority;
-}
-
-int ofono_gprs_provision_driver_register(
-			const struct ofono_gprs_provision_driver *driver)
-{
-	DBG("driver: %p name: %s", driver, driver->name);
-
-	g_drivers = g_slist_insert_sorted(g_drivers, (void *) driver,
-						compare_priority);
-	return 0;
-}
-
-void ofono_gprs_provision_driver_unregister(
-			const struct ofono_gprs_provision_driver *driver)
-{
-	DBG("driver: %p name: %s", driver, driver->name);
-
-	g_drivers = g_slist_remove(g_drivers, driver);
-}
-- 
2.43.0

