Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614F1350EF
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130854; cv=none; b=m1MBkFOwg9qBL+Olu4RE+zf3LmQTMW6GX5lozOns8Yh2pI81bHeBsdGVTbhvkZV1ynM4mEB+/c020T/axcGb+T75mfc3hOtgpo7keTNde38esqZBui5u5QeUJcSnMNIvguquFxyT/RvQ2NM2Uj1ot0WZ94iDkzW6/YqwSvIW2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130854; c=relaxed/simple;
	bh=fXj6TCCcD6KtcYVi9PJWzT0PNGLvwAyTLvdpLiAosnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRgQ71+ubr5Q57wQRJl9qKi2k0te39SnzyzuTHQvjW3DZNn83aUHNwkZHEaEZIXk64G1GjPtRnOD3J/eJUFgU6/cuWHTGHtwH3xY9UhM6tzz081eP8idoWQ2pDI5sqQ7rrNsJ5GJM26Q1qHIYHdY5vq45NM3SRPRKd4UEC2Jxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvZQOFyv; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvZQOFyv"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bdca4f495cso1040952b6e.3
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130848; x=1706735648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS6NKrt6pFWwmyHz1EIk1H2Fr7l6F4zHWyQFOQ18vuU=;
        b=QvZQOFyvkwftuCqneEi0gBxM30J4wpgtBEp8kqZeKYK8WDcWe40fRpoSl+5iCctwTF
         j3QtIIKPCGI5aITN2zhj3OmZJ12gsVXWSDez88Ska7FrHpY5l96JuHjuyMWe/uHfM8gb
         qdNPBqKwE6etFapDw+AMxNemUxqKwBMdgs3hp+ZXcU7weaVEYeRR4Q6A+k4szeuv5do+
         EJq0UWRXH9uJG5TC7irrSdZ8qghC5ai8HX2GgrdOQLa0PtNKF+I3V0dbL5MFyQxleAv7
         Fmn/kyzMSlMVnZxFxvQTvlJlQDaPbB1Kb/MWiPPl7G6t7aGXj1OlNpjJNV6mjTdSFSgv
         VhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130848; x=1706735648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vS6NKrt6pFWwmyHz1EIk1H2Fr7l6F4zHWyQFOQ18vuU=;
        b=fH3OyMZZr27YEtoB3F2kup49w6qwqODHHt+2YUI0g0JEmiYv91nrj7wbNOq5Xgc6GF
         IC3wwfFAlC4wCJOgXAP3fxb9spj74D72omgQflKpnR1oHRnZJT/gdDJQ6n8AN6glIv27
         tAVkPi+38o8pGpyaiNIeyDk/RGwo0v8N2C1VvXlj0fo6mD5gl7nDPVQE4pCMMoNmmbSd
         IRmY+41s0aN8P7gmq7JHgxY2fd/dFkGEZeO2HXOKKMBFwYSd0Upm8/9iHNf7mQ4KqDqA
         Bw3jzYf8XNJrOhZ4ltYUOaFT3sl5l3mY+qYUAhEduHAMAkSHb4lFtkVYWVNRbMIsjnkF
         taAg==
X-Gm-Message-State: AOJu0YyXwNS1vEgJOlv4hQvMHtyBFJrH/lfO3Ne1DPSxkMC2vuGYQweP
	6NgH7REy4/N7uwLJEWn6+Z94FgSQjI71B9RLtqRIpl7e0QxOgV0NW61p7rHa
X-Google-Smtp-Source: AGHT+IE0in9En3aK1mW33pYPtnDEVNICDyLPu/djehawmPVWey4dJM7fiGka1W60HaLJMas5pAezBg==
X-Received: by 2002:a05:6808:1059:b0:3bd:7e06:5865 with SMTP id c25-20020a056808105900b003bd7e065865mr1529777oih.62.1706130847923;
        Wed, 24 Jan 2024 13:14:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t27-20020a0568080b3b00b003bdac23eb89sm2003318oij.34.2024.01.24.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:14:07 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] unit: Add provisioning database tests
Date: Wed, 24 Jan 2024 15:13:02 -0600
Message-ID: <20240124211317.611706-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124211317.611706-1-denkenz@gmail.com>
References: <20240124211317.611706-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 .gitignore               |   2 +
 Makefile.am              |  25 +++-
 unit/test-provision.c    | 280 +++++++++++++++++++++++++++++++++++++++
 unit/test-provision.json |  92 +++++++++++++
 4 files changed, 395 insertions(+), 4 deletions(-)
 create mode 100644 unit/test-provision.c
 create mode 100644 unit/test-provision.json

diff --git a/.gitignore b/.gitignore
index 87405231..0cfe5283 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,6 +47,8 @@ unit/test-rilmodem-cs
 unit/test-rilmodem-gprs
 unit/test-rilmodem-sms
 unit/test-mbim
+unit/test-provision
+unit/test-provision.db
 unit/test-*.log
 unit/test-*.trs
 test-driver
diff --git a/Makefile.am b/Makefile.am
index 280653f3..79645e76 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,10 +8,12 @@ noinst_LTLIBRARIES =
 if EXTERNAL_ELL
 ell_cflags = @ELL_CFLAGS@
 ell_ldadd = @ELL_LIBS@
+ell_dependencies =
 ell_built_sources = ell/shared
 else
 ell_cflags =
 ell_ldadd = ell/libell-internal.la
+ell_dependencies = $(ell_ldadd)
 ell_built_sources = ell/shared ell/internal ell/ell.h
 
 noinst_LTLIBRARIES += ell/libell-internal.la
@@ -736,7 +738,8 @@ endif
 
 AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ $(ell_cflags) $(builtin_cflags) \
 					-DOFONO_PLUGIN_BUILTIN \
-					-DPLUGINDIR=\""$(build_plugindir)"\"
+					-DPLUGINDIR=\""$(build_plugindir)"\" \
+					-DUNITDIR=\""$(top_builddir)/unit/"\"
 
 AM_CPPFLAGS = -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
@@ -876,7 +879,9 @@ test_SCRIPTS = $(test_scripts)
 endif
 
 EXTRA_DIST = src/genbuiltin plugins/ofono.rules plugins/ofono-speedup.rules \
-				$(doc_files) $(test_scripts)
+		tools/provisiontool \
+		unit/test-provision.json \
+		$(doc_files) $(test_scripts)
 
 dist_man_MANS = doc/ofonod.8
 
@@ -890,7 +895,8 @@ unit_tests = unit/test-common unit/test-util \
 				unit/test-rilmodem-cs \
 				unit/test-rilmodem-sms \
 				unit/test-rilmodem-cb \
-				unit/test-rilmodem-gprs
+				unit/test-rilmodem-gprs \
+				unit/test-provision
 
 noinst_PROGRAMS = $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -981,6 +987,17 @@ unit_test_mbim_SOURCES = unit/test-mbim.c \
 unit_test_mbim_LDADD = $(ell_ldadd)
 unit_objects += $(unit_test_mbim_OBJECTS)
 
+unit/test-provision.db: unit/test-provision.json
+	$(AM_V_GEN)$(srcdir)/tools/provisiontool generate \
+		--infile $< --outfile $@
+
+unit_test_provision_SOURCES = unit/test-provision.c \
+				src/provisiondb.h src/provisiondb.c
+unit_test_provision_LDADD = $(ell_ldadd)
+unit_test_provision_DEPENDENCIES = $(ell_dependencies) \
+					unit/test-provision.db
+unit_objects += $(unit_test_provision_OBJECTS)
+
 TESTS = $(unit_tests)
 
 if TOOLS
@@ -1103,4 +1120,4 @@ maintainer-clean-local:
 	-rm -rf build-aux ell
 
 clean-local:
-	@$(RM) -rf include/ofono
+	@$(RM) -rf include/ofono unit/test-provision.db
diff --git a/unit/test-provision.c b/unit/test-provision.c
new file mode 100644
index 00000000..9c3dfad4
--- /dev/null
+++ b/unit/test-provision.c
@@ -0,0 +1,280 @@
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
+#include <assert.h>
+#include <errno.h>
+#include <ell/ell.h>
+
+#include <ofono/types.h>
+#include <ofono/gprs-context.h>
+
+#include "provisiondb.h"
+
+static struct provision_db *pdb;
+
+static void null_provision_db(const void *data)
+{
+	struct provision_db_entry *items;
+	size_t n_items;
+	int r;
+
+	r = provision_db_lookup(NULL, "123", "345", NULL, &items, &n_items);
+	assert(r == -EBADF);
+}
+
+static void invalid_mcc_mnc(const void *data)
+{
+	struct provision_db_entry *items;
+	size_t n_items;
+	int r;
+
+	r = provision_db_lookup(pdb, "3444", "33", NULL, &items, &n_items);
+	assert(r == -EINVAL);
+
+	r = provision_db_lookup(pdb, "3ab", "33", NULL, &items, &n_items);
+	assert(r == -EINVAL);
+
+	r = provision_db_lookup(pdb, "333", "3", NULL, &items, &n_items);
+	assert(r == -EINVAL);
+
+	r = provision_db_lookup(pdb, "333", "3334", NULL, &items, &n_items);
+	assert(r == -EINVAL);
+}
+
+struct provision_test {
+	const char *mcc;
+	const char *mnc;
+	const char *spn;
+	int result;
+	size_t n_items;
+	const struct provision_db_entry *items;
+};
+
+static const struct provision_db_entry alpha_contexts[] = {
+	{
+		.name = "Internet",
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET,
+		.proto = OFONO_GPRS_PROTO_IP,
+		.apn = "internet",
+		.auth_method = OFONO_GPRS_AUTH_METHOD_NONE,
+	},
+	{
+		.name = "IMS+MMS",
+		.type = OFONO_GPRS_CONTEXT_TYPE_IMS |
+			OFONO_GPRS_CONTEXT_TYPE_MMS |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.apn = "imsmms",
+		.proto = OFONO_GPRS_PROTO_IPV6,
+		.auth_method = OFONO_GPRS_AUTH_METHOD_PAP,
+		.message_center = "foobar.mmsc:80",
+		.message_proxy = "mms.proxy.net",
+	},
+};
+
+static const struct provision_db_entry zyx_contexts[] = {
+	{
+		.name = "ZYX",
+		.apn = "zyx",
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.auth_method = OFONO_GPRS_AUTH_METHOD_NONE,
+		.proto = OFONO_GPRS_PROTO_IP,
+	},
+};
+
+static const struct provision_db_entry beta_contexts[] = {
+	{
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.proto = OFONO_GPRS_PROTO_IPV4V6,
+		.apn = "beta.internet",
+		.auth_method = OFONO_GPRS_AUTH_METHOD_CHAP,
+	},
+};
+
+static const struct provision_db_entry charlie_contexts[] = {
+	{
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.proto = OFONO_GPRS_PROTO_IPV4V6,
+		.apn = "charlie.internet",
+		.auth_method = OFONO_GPRS_AUTH_METHOD_CHAP,
+	},
+};
+
+static const struct provision_db_entry xyz_contexts[] = {
+	{
+		.type = OFONO_GPRS_CONTEXT_TYPE_INTERNET |
+			OFONO_GPRS_CONTEXT_TYPE_IA,
+		.proto = OFONO_GPRS_PROTO_IPV4V6,
+		.apn = "xyz",
+		.auth_method = OFONO_GPRS_AUTH_METHOD_CHAP,
+	}
+};
+
+/* Make sure mccmnc not in the database isn't found */
+static const struct provision_test unknown_mcc_mnc = {
+	.mcc = "994",
+	.mnc = "42",
+	.result = -ENOENT,
+};
+
+/* Successful lookup of 'Operator Beta' settings */
+static const struct provision_test lookup_beta = {
+	.mcc = "999",
+	.mnc = "006",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(beta_contexts),
+	.items = beta_contexts,
+};
+
+/* Make sure two digit mnc is treated as != to 3 digit mnc */
+static const struct provision_test two_digit_mnc = {
+	.mcc = "999",
+	.mnc = "06",
+	.result = -ENOENT,
+};
+
+/*
+ * Fallback to non-MVNO settings in case SPN doesn't match and an operator with
+ * no SPN is found.  This follows legacy oFono behavior and allows provisioning
+ * to work on modem drivers that do not support EFspn reading.
+ */
+static const struct provision_test fallback_no_spn = {
+	.mcc = "999",
+	.mnc = "005",
+	.spn = "Bogus",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(beta_contexts),
+	.items = beta_contexts,
+};
+
+/* Same as above, but with an MVNO entry for the same mcc/mnc */
+static const struct provision_test fallback_no_spn_2 = {
+	.mcc = "999",
+	.mnc = "002",
+	.spn = "Bogus",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(alpha_contexts),
+	.items = alpha_contexts,
+};
+
+/* Successful lookup of Operator Alpha */
+static const struct provision_test lookup_alpha = {
+	.mcc = "999",
+	.mnc = "001",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(alpha_contexts),
+	.items = alpha_contexts,
+};
+
+/* Successful lookup of ZYX (MVNO on Alpha) */
+static const struct provision_test lookup_zyx = {
+	.mcc = "999",
+	.mnc = "01",
+	.spn = "ZYX",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(zyx_contexts),
+	.items = zyx_contexts,
+};
+
+/*
+ * Successful lookup of Charlie.  This has to be an exact SPN match since
+ * no wildcard value is available
+ */
+static const struct provision_test lookup_charlie = {
+	.mcc = "999",
+	.mnc = "10",
+	.spn = "Charlie",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(charlie_contexts),
+	.items = charlie_contexts,
+};
+
+/* Successful lookup of XYZ (MVNO on Charlie) */
+static const struct provision_test lookup_xyz = {
+	.mcc = "999",
+	.mnc = "11",
+	.spn = "XYZ",
+	.result = 0,
+	.n_items = L_ARRAY_SIZE(xyz_contexts),
+	.items = xyz_contexts,
+};
+
+/* No match with for an MCC/MNC present in the DB, but no wildcard entry */
+static const struct provision_test lookup_no_match = {
+	.mcc = "999",
+	.mnc = "11",
+	.result = -ENOENT,
+};
+
+static void provision_lookup(const void *data)
+{
+	const struct provision_test *test = data;
+	struct provision_db_entry *items;
+	size_t n_items;
+	size_t i;
+	int r;
+
+	r = provision_db_lookup(pdb, test->mcc, test->mnc, test->spn,
+					&items, &n_items);
+	assert(r == test->result);
+
+	if (r < 0)
+		return;
+
+	assert(n_items == test->n_items);
+	for (i = 0; i < n_items; i++) {
+		const struct provision_db_entry *a = items + i;
+		const struct provision_db_entry *b = test->items + i;
+
+		assert(b->type == a->type);
+		assert(b->proto == a->proto);
+		assert(l_streq0(b->apn, a->apn));
+		assert(l_streq0(b->name, a->name));
+		assert(l_streq0(b->username, a->username));
+		assert(l_streq0(b->password, a->password));
+		assert(b->auth_method == a->auth_method);
+		assert(l_streq0(b->message_proxy, a->message_proxy));
+		assert(l_streq0(b->message_center, a->message_center));
+	}
+
+	l_free(items);
+}
+
+int main(int argc, char **argv)
+{
+	int r;
+
+	l_test_init(&argc, &argv);
+
+	l_test_add("Lookup on NULL provision db", null_provision_db, NULL);
+	l_test_add("MCC/MNC input validation", invalid_mcc_mnc, NULL);
+	l_test_add("Unknown MCC/MNC", provision_lookup, &unknown_mcc_mnc);
+	l_test_add("Successful Lookup (Beta)", provision_lookup, &lookup_beta);
+	l_test_add("Two digit MNC", provision_lookup, &two_digit_mnc);
+	l_test_add("Fallback no-SPN", provision_lookup, &fallback_no_spn);
+	l_test_add("Fallback no-SPN#2", provision_lookup, &fallback_no_spn_2);
+	l_test_add("Successful lookup (Alpha)", provision_lookup, &lookup_alpha);
+	l_test_add("Successful lookup (ZYX)", provision_lookup, &lookup_zyx);
+	l_test_add("Exact match (Charlie)", provision_lookup, &lookup_charlie);
+	l_test_add("Exact match (XYZ)", provision_lookup, &lookup_xyz);
+	l_test_add("Exact math (no match)", provision_lookup, &lookup_no_match);
+
+	pdb = provision_db_new(UNITDIR "test-provision.db");
+	assert(pdb);
+
+	r = l_test_run();
+	provision_db_free(pdb);
+
+	return r;
+}
diff --git a/unit/test-provision.json b/unit/test-provision.json
new file mode 100644
index 00000000..61d060ad
--- /dev/null
+++ b/unit/test-provision.json
@@ -0,0 +1,92 @@
+[
+  {
+    "name": "Operator Alpha",
+    "ids": [
+      "99955", "99956", "99901", "99902", "999001", "999002", "999056", "999055"
+    ],
+    "apns": [
+      {
+        "name": "Internet",
+        "apn": "internet",
+        "type": [
+          "internet"
+        ],
+        "authentication": "none",
+        "protocol": "ipv4"
+      },
+      {
+        "name": "IMS+MMS",
+        "apn": "imsmms",
+        "type": [
+          "ims", "mms", "ia"
+        ],
+        "mmsc": "foobar.mmsc:80",
+        "mmsproxy": "mms.proxy.net",
+        "authentication": "pap",
+        "protocol": "ipv6"
+      }
+    ]
+  },
+  {
+    "name": "ZYX (MVNO on Alpha)",
+    "ids": [
+      "999001", "999002", "99901", "99902"
+    ],
+    "spn": "ZYX",
+    "apns": [
+      {
+        "name": "ZYX",
+        "apn": "zyx",
+        "type": [
+          "internet", "ia"
+        ],
+        "authentication": "none",
+        "protocol": "ipv4"
+      }
+    ]
+  },
+  {
+    "name": "Operator Beta",
+    "ids": [
+      "999005", "999006"
+    ],
+    "apns": [
+      {
+        "apn": "beta.internet",
+        "type": [
+          "internet", "ia"
+        ]
+      }
+    ]
+  },
+  {
+    "name": "Operator Charlie",
+    "ids": [
+      "99910", "99911"
+    ],
+    "spn": "Charlie",
+    "apns": [
+      {
+        "apn": "charlie.internet",
+        "type": [
+          "internet", "ia"
+        ]
+      }
+    ]
+  },
+  {
+    "name": "XYZ (MVNO on Charlie)",
+    "ids": [
+      "99911"
+    ],
+    "spn": "XYZ",
+    "apns": [
+      {
+        "apn": "xyz",
+        "type": [
+          "internet", "ia"
+        ]
+      }
+    ]
+  }
+]
-- 
2.43.0

