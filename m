Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23757880
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698676; cv=none; b=PHoheSspRY+gjQkglGgrSLXWkU5VrBP54LepXsMaVbkZDOCsDa036w4LjR4jmRLRAQL5hPM4CnxOd6RwOAmAmtIfNwaUvi5gss2LF9y35BROJQONVI9yL8UTtWyjLfPdfiGlJxv5OxuX0019kYPSZ1jI36k1Z6fN0tXrMCt1bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698676; c=relaxed/simple;
	bh=s5EbGVQVvAIl7aI+Hrul6eW/CUxsPCHrtZ/vCNa7Qck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCJGDsZxgcq/GrAOgpuuWZJKF4fI6aTUUD59egomQcyJS+VyeuQRb8MBT84ucxBaLGDs/Cijj3o6Ji1oT7Bq2jSVcMSTjoP49pk8QplFS1gJtSpaCliKCIrZg5McFDL9DL+CvQxaZX4bNmWduCORuK13wZ2ZS5gjUyfmB8cpoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9NFHI4m; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9NFHI4m"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddeb09bc68so967777a34.1
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698673; x=1706303473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LntWOTqbUhaBmzN3ggidiA/IpRJLFr9lLbhTxn85Jr0=;
        b=j9NFHI4mulu8wjxTXe4G0Qp3dTNKTEHjoOlrWqqbI9vVTXIaSd1WKes1NKCAEZHLqV
         S9mlgp2xAKY9Qy6eqt2rmjYdcm0xS8UzPVYLPo0b7rxFgNy7KeQART5H8ZNFqrZEFqxH
         Qn6u1gOYDOOyVCeH4gUtmwyXC8jnFMgXkYqj0jmxaDZWVDcNK86cd7bJTQDX0boQUfyY
         5PlH+JrzWqKXhHl8vbI70FwqB9Sgfz7ECp/wC8EDr2E6UlzjbtUsPBSFDblCb01VzwfK
         +/exCXe4qUAPWCWSsvWeXhFOKovfMpDXuUHThtMbv73x7IaEJlaNZGYilTkFWLGvMIWw
         WnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698673; x=1706303473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LntWOTqbUhaBmzN3ggidiA/IpRJLFr9lLbhTxn85Jr0=;
        b=XBLX93ynWvjAsvdQn81rC6xO3hXSyuO6550aY9Ug35M5k23gj8t6C5svcOctVZIVgK
         iNi8sqqfGJ0Snffxq3aahgf7IDBPq+HKdPQPX4wtTO4/RvdcoMV+Bjx26Yde5q0yo1aT
         ucezA0p6U3LiR+GEf+aqZ1Zoysty3cgPiNwwISyrZrGak2VjyrTym7w20Mt3kTnKn2ai
         MdIpjw872p+0VW5f3OldhbTUlkMOZwYS+xIfyeZgMDQ4OjGoRx0MeEPy/NAAbWJDQQPu
         AOSuUx3PIeB/zXvEZp92OAYI3ch+wIcCyHTx9q1V5AQ0xP6V0cp2mWz5Y0tib0oP4r79
         Ii1g==
X-Gm-Message-State: AOJu0YzWRrt4S9BkR4AaT1T0jMlCnubWjWwl/Ew93uHB/T8kdwfjjr+9
	nXKaPEdpxqR6SjKI9894m/IyYtx1UqBQZl8gI3Zx0MLY6oMtgi/R1RW5iK3P
X-Google-Smtp-Source: AGHT+IF0KWdNtjCwBztGYJTf3Jd8GEQbYRNODVbRUYys2HONr28HwdstydyzEg0HGHfBzq0MfiBkEg==
X-Received: by 2002:a9d:6e06:0:b0:6de:90d8:b350 with SMTP id e6-20020a9d6e06000000b006de90d8b350mr699592otr.0.1705698673584;
        Fri, 19 Jan 2024 13:11:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/14] plugins: Remove support for file-provision plugin
Date: Fri, 19 Jan 2024 15:09:46 -0600
Message-ID: <20240119211017.474598-10-denkenz@gmail.com>
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

