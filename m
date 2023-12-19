Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E3381AD
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+SyquGP"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b798e6f702so223586739f.2
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011282; x=1703616082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wImi+2WVa89uNvBkW7IjKC1OhglJFQcx0Z902htyno0=;
        b=U+SyquGPAcG/ERCJIHS8u0hX9wPsV1Na6HHi5pP7q2B0Tj8EZDPYd8dPXPpjGBUB07
         lkPyYi6WzkNmfZuEz9IcGDkkTz1NsZMk+7Yc+8YHBmGPQI3zhSPCq/vkv7YV7/uHAg4D
         2cCQYgnpar/2KRmZoleiB5KjXmIVm3zgesm3VlkZ3mIYVPGmr8Qn7inKPqI5zeJyfggE
         A3UdOiAOD8OLciIyncfsDGeoo/DUFBPysOkupzqC5A1mz9nOfW9tuAuNOH58LLDujD42
         gPjQuvJpbd9TKyyx0YFyKaOi1bLvacsVytMV18Xo3sEPw9MYCf64sPQrZOWlRmZ3yURv
         aQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011282; x=1703616082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wImi+2WVa89uNvBkW7IjKC1OhglJFQcx0Z902htyno0=;
        b=Q46NVCGTKqc9TYQbFVTaWs1QobpY1i2QkSNXBX3P81fcr6igKoaPBCHS/eYk0Fp0cH
         MMvcOOnJV6LBeKFKpdKR0F7UWMI7LE6kFgNrCaIrr0fjFSMEd7PYeMd8doo3Et5Dx5w/
         T4SN91HxBysZFjFjDTDkM0iPUbQaMgfG9zCh4lccUTxBch9Rpns56CSmE9Tad7DPIzej
         aWLPhuVo2fhcYvYbCW+RQvN8BWhM3IOvQGNmjmdrFgijUwZ1YQVdq9SXG/85JZY3V60p
         JfFYJarbNeOuoEFgaZqcfKQB3h/CYEtFUMddM51djysiN3wewEgqxXYxpfx08FAJa0SN
         6fig==
X-Gm-Message-State: AOJu0Yz0mqJzYvMCvVWkw9mVJGcbkbIrlUgyEOTF7o51QHUrLmCzqC+m
	v0kWvv1frLcTs7RDdJjNxC0ZGfuv1SY=
X-Google-Smtp-Source: AGHT+IHooqn/tDRpfJYCun6DDxuknxHUJDl/Itl3ZH5aEx6cC9DU9t0uyVt+GGJM0SqNyWQhxe5+RA==
X-Received: by 2002:a05:6602:449:b0:7b6:f32f:9a72 with SMTP id e9-20020a056602044900b007b6f32f9a72mr22495345iov.22.1703011282197;
        Tue, 19 Dec 2023 10:41:22 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:21 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/15] examples: Remove provision example
Date: Tue, 19 Dec 2023 12:37:10 -0600
Message-ID: <20231219184016.420116-13-denkenz@gmail.com>
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
 Makefile.am          |   3 --
 examples/provision.c | 101 -------------------------------------------
 2 files changed, 104 deletions(-)
 delete mode 100644 examples/provision.c

diff --git a/Makefile.am b/Makefile.am
index 447f2466..1a97a1f1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -660,9 +660,6 @@ builtin_sources += examples/history.c
 builtin_modules += example_nettime
 builtin_sources += examples/nettime.c
 
-builtin_modules += example_provision
-builtin_sources += examples/provision.c
-
 builtin_modules += example_emulator
 builtin_sources += examples/emulator.c
 
diff --git a/examples/provision.c b/examples/provision.c
deleted file mode 100644
index 3f9d124f..00000000
--- a/examples/provision.c
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
-
-#include <errno.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
-#include <ofono/types.h>
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-
-static int example_provision_get_settings(const char *mcc, const char *mnc,
-				const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count)
-{
-	ofono_debug("Provisioning...");
-	*count = 0;
-	*settings = NULL;
-
-	ofono_debug("Finding settings for MCC %s, MNC %s, SPN '%s'",
-			mcc, mnc, spn);
-
-	if (strcmp(mcc, "246") != 0 || strcmp(mnc, "81") != 0 ||
-						g_strcmp0(spn, "oFono") != 0)
-		return -ENOENT;
-
-	ofono_debug("Creating example settings for phonesim");
-
-	*settings = g_try_new0(struct ofono_gprs_provision_data, 2);
-	if (*settings == NULL)
-		return -ENOMEM;
-
-	*count = 2;
-
-	/* Internet context settings */
-	(*settings)[0].proto = OFONO_GPRS_PROTO_IP;
-	(*settings)[0].type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	(*settings)[0].name = g_strdup("Phonesim Internet");
-	(*settings)[0].apn = g_strdup("internetapn");
-
-	/* MMS context settings */
-	(*settings)[1].proto = OFONO_GPRS_PROTO_IP;
-	(*settings)[1].type = OFONO_GPRS_CONTEXT_TYPE_MMS;
-	(*settings)[1].name = g_strdup("Phonesim MMS");
-	(*settings)[1].apn = g_strdup("mmsapn");
-	(*settings)[1].username = g_strdup("mmsuser");
-	(*settings)[1].password = g_strdup("mmspass");
-	(*settings)[1].message_proxy = g_strdup("10.11.12.13:8080");
-	(*settings)[1].message_center = g_strdup("http://mms.example.com:8000");
-
-	return 0;
-}
-
-static struct ofono_gprs_provision_driver example_driver = {
-	.name		= "Example GPRS context provisioning",
-	.priority       = OFONO_PLUGIN_PRIORITY_LOW,
-	.get_settings	= example_provision_get_settings,
-};
-
-static int example_provision_init(void)
-{
-	return ofono_gprs_provision_driver_register(&example_driver);
-}
-
-static void example_provision_exit(void)
-{
-	ofono_gprs_provision_driver_unregister(&example_driver);
-}
-
-OFONO_PLUGIN_DEFINE(example_provision, "Example Provisioning Plugin",
-			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
-			example_provision_init,
-			example_provision_exit)
-- 
2.43.0

