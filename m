Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317437D1A
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCka5+9/"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b6f4ee4f7fso135574739f.0
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011283; x=1703616083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6hbsIajVURxx1kyQ5Wv5rqK08/OoZOZAMgDSqNw/Uw=;
        b=VCka5+9/P4D5e/CZYYH/FwmkbtjR9iTqtGygjyq8NWVy5GV3ZHICOQVVX8D2yv997z
         aU0PsFMmV+9Soe2DCO7pCMU206Ul26sRyR+jtWYI2bX+0dvDxSYp26Iw84m1WAURUPCb
         jCJ0pGNvas+6+n1ChcwG4C1r2r6JXfoLpvYvwtqSUe+q//00gHIbYyubm7I0MdxrArpH
         74Id2YwiQujvit9bJs4FrFlB4o1LOw9ygN6F7KpZI07j43TvTT+FK/k1sa2qi0JSCofX
         39J1R96MKnMDoLsQSDuxCMCFDAhdAVnS0eT/8OGsV1MLvi5FxuewlgXQKH9Ux7O3zaRq
         k7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011283; x=1703616083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6hbsIajVURxx1kyQ5Wv5rqK08/OoZOZAMgDSqNw/Uw=;
        b=Xfg/JVVoTE/Kt1d+ROoBGI+0vCaioMQbdosNkumtbff0UW6AtOuIg4meXvb+JseldM
         0TV7q0zdxRoI7UW2aUEUXAw+vqcRlWhe2SbcN4yQ9l7DjnllWyGW/YOWPdgVEzg2Spcb
         cVfCJOglGdkHCABI2F8xUQAM7/kIfpZGtWilVFPFL97OSUNfor+ov/NabHF8oRwDTkFq
         3DNCuwjC5WOZpWzghSyJ7mpxgCTmGpI81pgsLNzzZ5APQ1zFCCm9jwj8fAH3hhm/JAmH
         tY3jE75X2JIl834nh2wQvkTrL40Q3kvobAzl2QcjinbvFTiyrjcs2UT2cLVNBTpbJ9Ng
         9+9Q==
X-Gm-Message-State: AOJu0YwHKL7APr0mEwfR/ISSQkEoIQEs7A+4MWgsq8EHaOMBjw77MqXl
	jDXipgHp0F+bFusCzyRs35B+0EWh5kA=
X-Google-Smtp-Source: AGHT+IE+rzvbEKK7gRQKnAlBTGE0IbeBj8WzKLTKfSBTMsfs48ojt11x6vrt4OktFRr9Ychhh+qDFA==
X-Received: by 2002:a05:6e02:1aab:b0:35f:b403:e397 with SMTP id l11-20020a056e021aab00b0035fb403e397mr1173988ilv.25.1703011283065;
        Tue, 19 Dec 2023 10:41:23 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:22 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/15] gprs-provision: Remove no longer used atom/driver
Date: Tue, 19 Dec 2023 12:37:11 -0600
Message-ID: <20231219184016.420116-14-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
References: <20231219184016.420116-1-denkenz@gmail.com>
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

