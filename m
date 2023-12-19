Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0F1E521
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VetiePcx"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so11068139f.1
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011277; x=1703616077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNYgPRJLKkZELSNj0mQSY/vA+jJVdikezjzsZe+sNJE=;
        b=VetiePcxew5yNYEL2kC9mzQyKqsLMKM2/KxaBIYTYaWDUuMDzrn37+pE8aFhLRNBGr
         mm3RIKLQFn8t7OMkgSbmmxTnrI7ktYPHFRWNVb43X61I9H7w4HKi4n4OHLBpu3FdPDsR
         x36phy+75o9KZa3dvtjpL4Yo1sqE+3YYq+Px7jI68foL3MYLfeZxGvZ3gTRC1UG8ND5X
         ASyeGGMubxi+NXMOYSniZthnLrE3Oy8YhgJun1RT2278Azj66Pmz5OSaA37BIwSWMgHh
         eo/1qjNN9rDUMTclqQUPnk/LSDsBXDbj/wWS14aPfE39mX2ch3vNhxou8o3EhDSby8jh
         zIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011277; x=1703616077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNYgPRJLKkZELSNj0mQSY/vA+jJVdikezjzsZe+sNJE=;
        b=l708XfqCxmERGQtgzBM91O6RpNPoBWsaIFNlhYQ5bZA4c3tKstYjQ38KSmjYw/9/et
         ZQOEZZDycGeLahYySLDRsMBzaveSNebiKu0iWR8n7IsXUIv3rJiD7LLaYsPT985RT4AJ
         RZNEuGOieC672l2c9+52+DnrKmRESDwoPp7G4uGT3+UpCUlo9LKbMWXS4JrWwlkCg3hb
         TttDR2KmCO4s/1hmce77OFOCvykYiyFG4GcEvsGN9WRvCl8qbSXa5oDebg+MFdmd1G+l
         S3RtHAQ/Z5vHPT7S6xiXBr8k889Ec2sah8yZC0zAvwFjKSq5yXzetzXYO8KmFiUCLxzB
         FpcA==
X-Gm-Message-State: AOJu0YzHY3ux3Xlp+BZDjlAFXVDM5pl4OSNeXmtfWWmtXBLzI8e9ObgN
	mE6VwnRpgPtxUiBbzBUJe62glAmA+tM=
X-Google-Smtp-Source: AGHT+IEoyNx2N6t82HIxXtdKJ5pfDQ230shcM5yMVFcO5LB/gSyOKrQPKhaJ1jTx3u00ibWHzz6l8A==
X-Received: by 2002:a6b:e714:0:b0:7b7:350b:1ed3 with SMTP id b20-20020a6be714000000b007b7350b1ed3mr19636823ioh.10.1703011277410;
        Tue, 19 Dec 2023 10:41:17 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:17 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/15] provision: Add new module
Date: Tue, 19 Dec 2023 12:37:06 -0600
Message-ID: <20231219184016.420116-9-denkenz@gmail.com>
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

This module will replace the gprs-provision module.  The new provisiondb
supercedes all other plugins in capability and there's no desire to
maintain the old code any longer.
---
 Makefile.am     |  3 +-
 src/ofono.h     |  5 ++++
 src/provision.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 src/provision.c

diff --git a/Makefile.am b/Makefile.am
index 3023ed0c..cfa05bf7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -726,7 +726,8 @@ src_ofonod_SOURCES = $(builtin_sources) $(gatchat_sources) src/ofono.ver \
 			src/netmon.c src/lte.c src/ims.c \
 			src/netmonagent.c src/netmonagent.h \
 			src/module.c \
-			src/provisiondb.h src/provisiondb.c
+			src/provisiondb.h src/provisiondb.c \
+			src/provision.c
 
 src_ofonod_LDADD = gdbus/libgdbus-internal.la $(builtin_libadd) $(ell_ldadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/ofono.h b/src/ofono.h
index e289ff08..6a8c53a1 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -582,6 +582,11 @@ void __ofono_nettime_info_received(struct ofono_modem *modem,
 #include <ofono/sim-auth.h>
 
 #include <ofono/gprs-provision.h>
+bool __ofono_provision_get_settings(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				size_t *count);
+
 ofono_bool_t __ofono_gprs_provision_get_settings(const char *mcc,
 				const char *mnc, const char *spn,
 				struct ofono_gprs_provision_data **settings,
diff --git a/src/provision.c b/src/provision.c
new file mode 100644
index 00000000..e419d15c
--- /dev/null
+++ b/src/provision.c
@@ -0,0 +1,73 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ *  SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stddef.h>
+
+#include "provisiondb.h"
+#include "ofono.h"
+
+static struct provision_db *pdb;
+
+bool __ofono_provision_get_settings(const char *mcc,
+				const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				size_t *count)
+{
+	size_t n_contexts;
+	struct ofono_gprs_provision_data *contexts;
+	int r;
+	size_t i;
+
+	if (mcc == NULL || strlen(mcc) == 0 || mnc == NULL || strlen(mnc) == 0)
+		return false;
+
+	r = provision_db_lookup(pdb, mcc, mnc, spn, &contexts, &n_contexts);
+	if (r < 0)
+		return false;
+
+	DBG("Obtained %zd contexts for %s%s, spn: %s",
+			n_contexts, mcc, mnc, spn);
+
+	for (i = 0; i < n_contexts; i++) {
+		struct ofono_gprs_provision_data *ap = contexts + i;
+
+		DBG("APN: %s, Type: %x, Proto: %x",
+				ap->apn, ap->type, ap->proto);
+
+		if (ap->type & OFONO_GPRS_CONTEXT_TYPE_MMS)
+			DBG("MMS Proxy: %s, MMSC: %s", ap->message_proxy,
+					ap->message_center);
+	}
+
+	*count = n_contexts;
+	*settings = contexts;
+
+	return true;
+}
+
+static int provision_init(void)
+{
+	DBG("");
+
+	pdb = provision_db_new_default();
+
+	if (!pdb)
+		l_warn("Unable to open provisioning database!");
+
+	return 0;
+}
+
+static void provision_exit(void)
+{
+	provision_db_free(pdb);
+}
+
+OFONO_MODULE(provision, provision_init, provision_exit)
-- 
2.43.0

