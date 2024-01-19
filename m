Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7F57876
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698675; cv=none; b=I3/TmdC6x5UdIs7LqnkXqyESR1w11M5n3LH5MmhSiHoLklXcB+uJsMj2Cg+MvVkY/KafzkZxxFIQF6HSW/AGwaQOrVrO2j/kc+F/1sHMjKhG1JgDKoyttkvNFgPPmpskG7fekJpUEbe9ygoX3tTRZ89YIPMF7M9W7hvYYZC/J4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698675; c=relaxed/simple;
	bh=jsIL+eu+8tZVbgbJGkszt4dbh0kRjhXX8bVknyvr308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL7DTvqH7rnN3kYv6m9MQmeaywkdpyc63INLf6B5J/ccSWt2Ii5O2BufiN3shv+VyNIUSHMzBc59TojmvcDs9k+ouml1jQplhc7lVxBgeAqYa5pWmGDvMXZsHaODf9S7j48P42Q1uRdtkuTGpU4QhlDmSw0Gt+ZHy39UJiQf1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvvmXOsu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvvmXOsu"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e0a64d9449so764257a34.2
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698672; x=1706303472; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNYgPRJLKkZELSNj0mQSY/vA+jJVdikezjzsZe+sNJE=;
        b=EvvmXOsuENQVf04kkcjA5pxIa7KBlt7DtSYsQ+S6NasRBEMjrn+UY98/UX9kPAcfkl
         DqxqfJ6IQnHz6SzCMriRsfo5+6lxfMQnoUjOhlQ/jl8EotWAvnjmUJprqSmk/RFQoTPG
         /qvgSVvEopJ01eZR0zxKlGuVKdlnrfSlwptlV3EG3DNDWu5r50Tfo5jFJuLBfAc0lgit
         1z4gadlX9O6i2EULGeAAZfyvGhHh/IvWdozfDRd3rcyo99J0mwpWciLwdOisTU4UeF9g
         RaXwsjarrs58JJhIWeeDm3VGA/DmDgFUaX02nQtooI213Q11ssQZE4cw8E6EoKBR0z+2
         xIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698672; x=1706303472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNYgPRJLKkZELSNj0mQSY/vA+jJVdikezjzsZe+sNJE=;
        b=Z6pBopMbwbwmzSGycDr/XK7GX0NtZr3lmi5Epn/tyhQF/n+ezQUDLom0uNdySIKSua
         RU9SPpBJFCw14910T5rjPaj0oyVt+FmntYc+HH9zQrcPCGu0odenqSiR/V2YBk9othM7
         w+/PjVl41u0jEviPPe0AvSCM/Zfrpiwy3AxCJM+f2lHxeaXiY3KHeEmfWX1avoZUdZaj
         +CevDl7q+uW4r32ninOHv7+Kba/CIBfzvPKhpbQe9jV3GnzwenZfjdUKXrUlwvjO0eYj
         3kBi/z4KQEukk5NqYlpmHveKZWqGaADJTpSYwsKX5GJJ9/We9EAjcditEAt/gwHrHmik
         Gj7w==
X-Gm-Message-State: AOJu0Yz+zmPv+cFZIQzIVb6aLmbtXgIz+cRucE8nHWNCEilKpjrDyF+X
	KCdb2TB6oQK/r70gZeCsHvOHtFF7AwF2gt5L5jNr+ZRAfkqKqg+FMa95gcLj
X-Google-Smtp-Source: AGHT+IE+1gSd/N+HlCduj0iOGrU70Se7r2AvkkEpEim/SSgtKBf8BwzNFo+enhEP4wbjAqS3b+MnRQ==
X-Received: by 2002:a9d:4f14:0:b0:6dd:de6b:1cc5 with SMTP id d20-20020a9d4f14000000b006ddde6b1cc5mr481729otl.23.1705698672300;
        Fri, 19 Jan 2024 13:11:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/14] provision: Add new module
Date: Fri, 19 Jan 2024 15:09:44 -0600
Message-ID: <20240119211017.474598-8-denkenz@gmail.com>
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

