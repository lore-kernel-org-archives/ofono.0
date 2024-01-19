Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A057876
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698677; cv=none; b=htJDxxEadN2l1L0YAgYSF9a+Pog0Fytv+LS5qhL6aHrhOpvr+7f7/sEkWiG8MXirR0mvnhG9n0uKM2qepgHIgiSG8M9wEL5bei9hd/T8qLFLlIYwT2AM0+3WvFTn1nvrM2EWKjy3gZkeaDwhmetZee7T+rSzcUXqqI9ZRBGuEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698677; c=relaxed/simple;
	bh=RDNdMHGq322zUUyHnRKOlTXnAJxyOJfnxA/WSdKHH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFPAIOL/yD6abSQCb7IZLLWnBUogIIaa3o2f3SWsdOvfiOTPZtdrfEGFMMgB9YfnKR8T3ie0wVdFTICZBztg2LZVfYfMHGWiVUZCw76qqwLWi6mc3c1aN8VA9X6onanodp2f2jUunURsplvSk5W50tOYAN8f752Ik0MvyWF9NR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXCrBC+i; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXCrBC+i"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21086556f32so758231fac.3
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698675; x=1706303475; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wImi+2WVa89uNvBkW7IjKC1OhglJFQcx0Z902htyno0=;
        b=DXCrBC+i+Gcszw5PzH7j+Ynl6AgBlEqoPpzwLSAMVyYKdSZos9EjoEELN6RtZmphXy
         NtzOYnIUe6lVGc5W4NQO7+IOzkXaGqbZCfTSVC3t+nw7D5SysyAOwB3TFv6xGOuOM4eg
         9ltZJWjnt0BenVobLP58xY7tu/XQKkkj79vbX4jXgPeYPxCQfwx27agtHHEhInTFMSlc
         Y3qOZBtvUbSewc9Ih4pNpiRgf093lDfv2tFSoCGT0JePGSfkr6SqF+0rHPRt49yAfXch
         ovKhiZUZcuf4oEl0rBccgg72aKxUXjreNeQ4kEX9HYkFGYLt/MNgakcuQ8+KMwFdxhHV
         9ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698675; x=1706303475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wImi+2WVa89uNvBkW7IjKC1OhglJFQcx0Z902htyno0=;
        b=EeZzBGxfBOGsyaffTFZDJGqNnc8H/Jdmzja3VSi+eY2n3JXzLcsL6KWHR5UXbfxv5V
         4tAjzG6VFrrfVD0Q7K5C6hNGgcjG64wD0V1xKUnTT98mZkADM4yOAJlhKzG/l0ywvZkK
         4TXLN0b+LWy9iO7Ji8Vs73UgYOg55l3p4XcyIIbYp7ifdg7ju6tLpR0G/ORle6G/0rBv
         nInN3YqlAce0vfQmCVH1+3ajtb9vJXBaWNTLcuyjkIpq2AamShWS8vquyOVCO8yodaGx
         BBiH+Lwb4m17J6LF3MjmlM4Iqf3q28v8IhzPUSl4Y/AG3GTM42UmRk7C5JtdtuWO354Y
         pbRQ==
X-Gm-Message-State: AOJu0Ywxc5Vj06lcgbxpwUb0YafK7nYlDzPsXRQeKCeVZWrNfdEz0MYs
	Y50w9B+pDkiIvLcp3DGUrOZGT4hIQ3lPjhJdVrB6xZikogzTjJjE9Ng5bV14
X-Google-Smtp-Source: AGHT+IFcYFA2jP8wEPxEByX2SdDp8L0WuZ6ILxAxaDfwk27HJxlWNDxxkfEYZjuy6hs1mTkAIx7HWQ==
X-Received: by 2002:a05:6870:4726:b0:205:e44e:de85 with SMTP id b38-20020a056870472600b00205e44ede85mr388161oaq.33.1705698674941;
        Fri, 19 Jan 2024 13:11:14 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:14 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/14] examples: Remove provision example
Date: Fri, 19 Jan 2024 15:09:48 -0600
Message-ID: <20240119211017.474598-12-denkenz@gmail.com>
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

