Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDF37D35
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIqEahfY"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fc16720f9so3191415ab.1
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011280; x=1703616080; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LntWOTqbUhaBmzN3ggidiA/IpRJLFr9lLbhTxn85Jr0=;
        b=NIqEahfYbcKn+uq44LVb/zS/Lyl53PlQDbEDTpbDaA7QwZnW0wPAzcNKBmiGYAC/MC
         mZoqZPdHXkNybhdqSY5gkJ4DwVroUwKdvMl8ofQ/kJzfkzQTBBqYqSJg3Nj9RT8eJcFS
         7pznabs7pnTLcHhAQZpOjOUl7nBbh6yi8F7QGR1zcrX2i7QYakXXVlk7Z8E2JUKkJx1I
         vSqjmOtPmO4lep7cMUrD8nmQYSii5AY2E2/jeL07tG83nRVH67t+KKQrgIkkDi7h7kqy
         wkGnL5PpPABU1zDXnrfbUsmlwtCTDmRpnQ55jiyldg85fZFQO4tSYm3SXyVpV48+ppQi
         l/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011280; x=1703616080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LntWOTqbUhaBmzN3ggidiA/IpRJLFr9lLbhTxn85Jr0=;
        b=EGD8YF8ddOzLMMr3qCW0pmJYB02NfqSKIyiv3cpsMEnJjM05tbEurpAN5+CRgyFBUt
         JvB37S/WEvDzdlJkrouEgo2V2oC/r6do5bbiUj0LwAVhItBOTenhNVczOCvrQjIVOZnd
         X8wsSsPSX2sMwgjTnqb7WornpoqtRHv4OKy5EWi0O+MCWxh4I5xI4T5vVk/107zjJfu0
         DZulc37VTvkLhgPcc057AWlR39+La5tJizVBRik53QvzK7+DxzE09MU6n+Zn5S+QBSUe
         LdLDPaq7ln2xMQKfYlmLvYZiltUiMar61O/N6xq8Zg2iIjutsP4hw5s8VmWLjCSxgV4c
         eWyA==
X-Gm-Message-State: AOJu0YyAMhIHDPghLppS+LHgcACYW0p56S6g4T3E4F5QKCGaDHPzjAk/
	Lb5SLd1B1MWQZibPIO4MUQAAXekcE3E=
X-Google-Smtp-Source: AGHT+IEPVHn1UPHe/f6m+Ye9jmVRgsNxggSLP+vOerA13tFCRaRKKHVnolZrhcZOSDnPP9Yk/vBbcQ==
X-Received: by 2002:a05:6e02:1d1d:b0:35f:b387:40c2 with SMTP id i29-20020a056e021d1d00b0035fb38740c2mr3541286ila.41.1703011279936;
        Tue, 19 Dec 2023 10:41:19 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:18 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/15] plugins: Remove support for file-provision plugin
Date: Tue, 19 Dec 2023 12:37:08 -0600
Message-ID: <20231219184016.420116-11-denkenz@gmail.com>
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
 Makefile.am              |   3 -
 plugins/file-provision.c | 172 ---------------------------------------
 2 files changed, 175 deletions(-)
 delete mode 100644 plugins/file-provision.c

diff --git a/Makefile.am b/Makefile.am
index cfa05bf7..a7404121 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -658,9 +658,6 @@ builtin_sources += plugins/mbpi.h plugins/mbpi.c
 
 builtin_modules += provision
 builtin_sources += plugins/provision.c
-
-builtin_modules += file_provision
-builtin_sources += plugins/file-provision.c
 endif
 
 if MAINTAINER_MODE
diff --git a/plugins/file-provision.c b/plugins/file-provision.c
deleted file mode 100644
index a3829a34..00000000
--- a/plugins/file-provision.c
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2017  Kerlink SA.
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
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdio.h>
-#include <string.h>
-
-#include <glib.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
-#include <ofono/log.h>
-#include <ofono/plugin.h>
-
-#define CONFIG_FILE STORAGEDIR "/provisioning"
-
-static int config_file_provision_get_settings(const char *mcc,
-				const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count)
-{
-	int result = 0;
-	GKeyFile *key_file = NULL;
-	char *setting_group = NULL;
-	char *value;
-
-	DBG("Finding settings for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
-
-	*count = 0;
-	*settings = NULL;
-
-	key_file = g_key_file_new();
-
-	if (!g_key_file_load_from_file(key_file, CONFIG_FILE, 0, NULL)) {
-		result = -ENOENT;
-		goto error;
-	}
-
-	setting_group = g_try_malloc(strlen("operator:") + strlen(mcc) +
-							strlen(mnc) + 2);
-	if (setting_group == NULL) {
-		result = -ENOMEM;
-		goto error;
-	}
-
-	sprintf(setting_group, "operator:%s,%s", mcc, mnc);
-
-	value = g_key_file_get_string(key_file, setting_group,
-					"internet.AccessPointName", NULL);
-
-	if (value == NULL)
-		goto error;
-
-	*settings = g_try_new0(struct ofono_gprs_provision_data, 1);
-	if (*settings == NULL) {
-		result = -ENOMEM;
-		goto error;
-	}
-
-	*count = 1;
-
-	(*settings)[0].type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	(*settings)[0].apn = value;
-
-	value = g_key_file_get_string(key_file, setting_group,
-					"internet.Username", NULL);
-
-	if (value != NULL)
-		(*settings)[0].username = value;
-
-	value = g_key_file_get_string(key_file, setting_group,
-					"internet.Password", NULL);
-
-	if (value != NULL)
-		(*settings)[0].password = value;
-
-	/* select default authentication method */
-	(*settings)[0].auth_method = OFONO_GPRS_AUTH_METHOD_CHAP;
-
-	value = g_key_file_get_string(key_file, setting_group,
-					"internet.AuthenticationMethod", NULL);
-
-	if (value != NULL) {
-		if (g_strcmp0(value, "chap") == 0)
-			(*settings)[0].auth_method =
-						OFONO_GPRS_AUTH_METHOD_CHAP;
-		else if (g_strcmp0(value, "pap") == 0)
-			(*settings)[0].auth_method =
-						OFONO_GPRS_AUTH_METHOD_PAP;
-		else if (g_strcmp0(value, "none") != 0)
-			DBG("Unknown auth method: %s", value);
-
-		g_free(value);
-	}
-
-	(*settings)[0].proto = OFONO_GPRS_PROTO_IP;
-	value = g_key_file_get_string(key_file, setting_group,
-					"internet.Protocol", NULL);
-
-	if (value != NULL) {
-		DBG("CRO value:%s", value);
-		if (g_strcmp0(value, "ip") == 0) {
-			DBG("CRO value=ip");
-			(*settings)[0].proto = OFONO_GPRS_PROTO_IP;
-		} else if (g_strcmp0(value, "ipv6") == 0) {
-			DBG("CRO value=ipv6");
-			(*settings)[0].proto = OFONO_GPRS_PROTO_IPV6;
-		} else if (g_strcmp0(value, "dual") == 0)
-			(*settings)[0].proto = OFONO_GPRS_PROTO_IPV4V6;
-		else
-			DBG("Unknown protocol: %s", value);
-
-		g_free(value);
-	}
-
-error:
-	if (key_file != NULL)
-		g_key_file_free(key_file);
-
-	if (setting_group != NULL)
-		g_free(setting_group);
-
-	if (result == 0 && *count > 0)
-		DBG("Found. APN:%s, proto:%d, auth_method:%d",
-				(*settings)[0].apn, (*settings)[0].proto,
-				(*settings)[0].auth_method);
-	else
-		DBG("Not found. Result:%d", result);
-
-	return result;
-}
-
-static struct ofono_gprs_provision_driver config_file_provision_driver = {
-	.name		= "GPRS context provisioning",
-	.get_settings	= config_file_provision_get_settings,
-};
-
-static int config_file_provision_init(void)
-{
-	return ofono_gprs_provision_driver_register(
-						&config_file_provision_driver);
-}
-
-static void config_file_provision_exit(void)
-{
-	ofono_gprs_provision_driver_unregister(
-						&config_file_provision_driver);
-}
-
-OFONO_PLUGIN_DEFINE(file_provision, "Gprs Provisioning Plugin",
-			VERSION, OFONO_PLUGIN_PRIORITY_HIGH,
-			config_file_provision_init,
-			config_file_provision_exit)
-- 
2.43.0

