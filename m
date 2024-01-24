Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C9131E54
	for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130849; cv=none; b=hoSRkewM2eSkV7HfIl8ACUUxW9m87vVu8DrIVMdJbUqjSZMIb63cJiRQ+pyaH33c8OImXolSzohvNtglmAhy753Hnzey7eZUdh1c/aSWclItrWNLWhHWZJtTuilqmVfGJgARCllLProqngWqQKY4ZxtOmUsm04IPDS9p+9/wsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130849; c=relaxed/simple;
	bh=sgRKj5La7bgo46JyN0H4VYUEBWKsJ69kjflhQUzyT04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdMjE9jpLAq/MCnZaEAelF75iiGGeSaruxyD3V+5VsUmy6WyZ0ZKEH1o7hS/wKHEAIngCMidqO6RZxukawyrvBEidx/XCAJpKRKSX8oVjDpW8hoNc1ZhhL/CZcBQKGrxplTA+/PQ7B5yCVN9HonmkE7rhp7ou2E+ZN8hW3lgz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNzvakp1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNzvakp1"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bdca4f495cso1040944b6e.3
        for <ofono@lists.linux.dev>; Wed, 24 Jan 2024 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706130846; x=1706735646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRNE+QM5zfRefQAJYk6aR9ObWZSmLdNRqhoSSebGHXs=;
        b=HNzvakp1ubdV6WKpL7raGeZf2LjH/5g3lLLvk6x8AFSCzQnR33HCIwPxGkZ63Mkn2V
         uy9bILkC9Oh+N0K7yOSlGMheBrcb5HOMjO1TvdcyfmxnmHVt9ZymfH5XDZsIJZ5Yy20R
         DV3xY8w59+uNG3GrZTYuUfvZMvJlEJ3T19fwUJxpjgS2pVG42y9xWjMHiUgnCvBLgyqA
         sspldi1qyiYRUal/IzYLRksUut1JlFjf0PNpXEkrFzBKygB2o9D8MNZyGA9JP89WAgJJ
         jEi7WouW/1/r0qRdzLCHs7zwMnV6pQt9/5szm6QFMVa0ZBFkyFVNcslbK8l0GPvxffpB
         XINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706130846; x=1706735646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRNE+QM5zfRefQAJYk6aR9ObWZSmLdNRqhoSSebGHXs=;
        b=n4PwFLCIbWr/3V7PN3GaMJBWR4uCGLt8Y04+jXalkSSWSTX1DoSxx4xokf467JSLN8
         RmH17vABO/qzRmKU6Are2GSChnKENHqvjNK5/HFr/kXqfDoeTocNAKsWnAnd216v/wJb
         NPyGAHZjnm/dVdfHZN/yNnK71ZZ/iMnAZYAJTX4WX4bOn1bsxm+1YgPwrdj2oa2zWtkl
         fmSXfvDVCH49ogSgforoatXylN1EShTSBkdh3qsw3pbK5fBYV4KTmPjSfiRoHQ9VeLdI
         5lJ+rdvTbwK5QN4I+Mz617kIdNhjUvfU2xUrafMz3KaMnCq1gAw10euohuZWSJSk6j7Q
         aw5Q==
X-Gm-Message-State: AOJu0Yw6kIHnPqtGOfyuHjvmxe0Fuq52lcCHGG1cB4OyMQ4qxgTXm9bR
	n+jvDn0G5PW90ljuAabdbeCJQV18tHHZ7/M6El94ZHWn8VT1G6fcx4jtTKWV
X-Google-Smtp-Source: AGHT+IE9UAXhj2S63vTxiykpZX/TdnlZ/s7sSryUvTQauSj2Vsql+aP2orvFm5Hh9IBZQdz9xLwfAA==
X-Received: by 2002:a05:6808:48f:b0:3bd:72dc:65a6 with SMTP id z15-20020a056808048f00b003bd72dc65a6mr1831388oid.58.1706130846543;
        Wed, 24 Jan 2024 13:14:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id t27-20020a0568080b3b00b003bdac23eb89sm2003318oij.34.2024.01.24.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:14:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] provision: Remove use of ofono_gprs_provision_data
Date: Wed, 24 Jan 2024 15:13:00 -0600
Message-ID: <20240124211317.611706-2-denkenz@gmail.com>
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

Switch to using struct provisiondb_entry instead of struct
ofono_gprs_provision_data.  For now, mark all string attributes of this
structure as const.  Strings are currently not allocated and instead
point to loations in the provisiondb memory mapped region.  Since the
provisioning database is only opened at startup and never unmapped
during oFono's runtime, returning const pointers to such strings is
safe.

While here, mark __get_string() as returning a pointer to a const char.
---
 Makefile.am              |  2 +-
 include/gprs-provision.h | 49 ----------------------------------------
 src/gprs.c               |  5 ++--
 src/ofono.h              |  4 ++--
 src/provision.c          | 10 ++++----
 src/provisiondb.c        | 16 ++++++-------
 src/provisiondb.h        | 17 ++++++++++++--
 tools/lookup-apn.c       |  8 +++----
 8 files changed, 38 insertions(+), 73 deletions(-)
 delete mode 100644 include/gprs-provision.h

diff --git a/Makefile.am b/Makefile.am
index 15d220f7..280653f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -144,7 +144,7 @@ pkginclude_HEADERS = include/log.h include/plugin.h include/history.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h \
 			include/sim-auth.h \
-			include/gprs-provision.h include/emulator.h \
+			include/emulator.h \
 			include/location-reporting.h \
 			include/gnss.h \
 			include/private-network.h \
diff --git a/include/gprs-provision.h b/include/gprs-provision.h
deleted file mode 100644
index ac0f5905..00000000
--- a/include/gprs-provision.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
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
-#ifndef __OFONO_GPRS_PROVISION_H
-#define __OFONO_GPRS_PROVISION_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <stdint.h>
-
-#include "gprs-context.h"
-
-struct ofono_gprs_provision_data {
-	uint32_t type; /* Multiple types can be set in a bitmap */
-	enum ofono_gprs_proto proto;
-	char *name;
-	char *apn;
-	char *username;
-	char *password;
-	enum ofono_gprs_auth_method auth_method;
-	char *message_proxy;
-	char *message_center;
-};
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_GPRS_PROVISION_H */
diff --git a/src/gprs.c b/src/gprs.c
index 40642324..f8b6fd3c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -43,6 +43,7 @@
 #include "ofono.h"
 
 #include "common.h"
+#include "provisiondb.h"
 #include "storage.h"
 #include "simutil.h"
 #include "util.h"
@@ -2371,7 +2372,7 @@ static DBusMessage *gprs_get_contexts(DBusConnection *conn,
 	return reply;
 }
 
-static void provision_context(const struct ofono_gprs_provision_data *ap,
+static void provision_context(const struct provision_db_entry *ap,
 				struct ofono_gprs *gprs)
 {
 	unsigned int id;
@@ -2463,7 +2464,7 @@ static void provision_context(const struct ofono_gprs_provision_data *ap,
 static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
 				const char *mnc, const char *spn)
 {
-	struct ofono_gprs_provision_data *settings;
+	struct provision_db_entry *settings;
 	size_t count;
 	size_t i;
 
diff --git a/src/ofono.h b/src/ofono.h
index 42298e43..a243d3fb 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -581,10 +581,10 @@ void __ofono_nettime_info_received(struct ofono_modem *modem,
 
 #include <ofono/sim-auth.h>
 
-#include <ofono/gprs-provision.h>
+struct provision_db_entry;
 bool __ofono_provision_get_settings(const char *mcc,
 				const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
+				struct provision_db_entry **settings,
 				size_t *count);
 
 #include <ofono/emulator.h>
diff --git a/src/provision.c b/src/provision.c
index cd5cf569..a2dfcf6c 100644
--- a/src/provision.c
+++ b/src/provision.c
@@ -11,6 +11,8 @@
 
 #include <stddef.h>
 
+#include <ofono/gprs-context.h>
+
 #include "provisiondb.h"
 #include "ofono.h"
 
@@ -18,11 +20,11 @@ static struct provision_db *pdb;
 
 bool __ofono_provision_get_settings(const char *mcc,
 				const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
+				struct provision_db_entry **settings,
 				size_t *count)
 {
 	size_t n_contexts;
-	struct ofono_gprs_provision_data *contexts;
+	struct provision_db_entry *contexts;
 	int r;
 	size_t i;
 	uint32_t type;
@@ -38,7 +40,7 @@ bool __ofono_provision_get_settings(const char *mcc,
 			n_contexts, mcc, mnc, spn);
 
 	for (i = 0; i < n_contexts; i++) {
-		struct ofono_gprs_provision_data *ap = contexts + i;
+		struct provision_db_entry *ap = contexts + i;
 
 		DBG("APN: %s, Type: %x, Proto: %x",
 				ap->apn, ap->type, ap->proto);
@@ -50,7 +52,7 @@ bool __ofono_provision_get_settings(const char *mcc,
 
 	/* Make sure there are no duplicates */
 	for (i = 0, type = 0; i < n_contexts; i++) {
-		struct ofono_gprs_provision_data *ap = contexts + i;
+		struct provision_db_entry *ap = contexts + i;
 
 		if (type & ap->type) {
 			ofono_warn("Duplicate detected for %s%s, spn: %s",
diff --git a/src/provisiondb.c b/src/provisiondb.c
index 6b864dec..53305eab 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -21,8 +21,7 @@
 #include <ell/ell.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
+#include <ofono/gprs-context.h>
 
 #include "provisiondb.h"
 
@@ -205,7 +204,7 @@ static struct provision_data *__get_provision_data(struct node *node)
 }
 
 static int __get_string(struct provision_db *pdb, uint64_t offset,
-				char **out_str)
+				const char **out_str)
 {
 	if (!offset) {
 		*out_str = NULL;
@@ -220,13 +219,13 @@ static int __get_string(struct provision_db *pdb, uint64_t offset,
 }
 
 static int __get_contexts(struct provision_db *pdb, uint64_t offset,
-				struct ofono_gprs_provision_data **contexts,
+				struct provision_db_entry **contexts,
 				size_t *n_contexts)
 {
 	void *start = pdb->addr + pdb->contexts_offset;
 	uint64_t num;
 	uint64_t i;
-	struct ofono_gprs_provision_data *ret;
+	struct provision_db_entry *ret;
 	int r;
 
 	if (offset + sizeof(__le64) >= pdb->contexts_size)
@@ -238,7 +237,7 @@ static int __get_contexts(struct provision_db *pdb, uint64_t offset,
 	if (offset + num * sizeof(struct context) > pdb->contexts_size)
 		return -EPROTO;
 
-	ret = l_new(struct ofono_gprs_provision_data, num);
+	ret = l_new(struct provision_db_entry, num);
 
 	for (i = 0; i < num; i++, offset += sizeof(struct context)) {
 		struct context *context = start + offset;
@@ -375,8 +374,7 @@ static int key_from_mcc_mnc(const char *mcc, const char *mnc, uint32_t *key)
 
 int provision_db_lookup(struct provision_db *pdb,
 			const char *mcc, const char *mnc, const char *match_spn,
-			struct ofono_gprs_provision_data **items,
-			size_t *n_items)
+			struct provision_db_entry **items, size_t *n_items)
 {
 	int r;
 	uint32_t key;
@@ -422,7 +420,7 @@ int provision_db_lookup(struct provision_db *pdb,
 	}
 
 	for (i = 0; i < count; i++) {
-		char *spn;
+		const char *spn;
 
 		r = __get_string(pdb, L_LE64_TO_CPU(data[i].spn_offset), &spn);
 		if (r < 0)
diff --git a/src/provisiondb.h b/src/provisiondb.h
index d7381b94..ee203c61 100644
--- a/src/provisiondb.h
+++ b/src/provisiondb.h
@@ -5,14 +5,27 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-struct ofono_gprs_provision_data;
+#include <stdint.h>
+
 struct provision_db;
 
+struct provision_db_entry {
+	uint32_t type; /* Multiple types can be set in a bitmap */
+	enum ofono_gprs_proto proto;
+	const char *name;
+	const char *apn;
+	const char *username;
+	const char *password;
+	enum ofono_gprs_auth_method auth_method;
+	const char *message_proxy;
+	const char *message_center;
+};
+
 struct provision_db *provision_db_new(const char *pathname);
 struct provision_db *provision_db_new_default(void);
 void provision_db_free(struct provision_db *pdb);
 
 int provision_db_lookup(struct provision_db *pdb,
 			const char *mcc, const char *mnc, const char *spn,
-			struct ofono_gprs_provision_data **items,
+			struct provision_db_entry **items,
 			size_t *n_items);
diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index ff791993..34d689a4 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -18,8 +18,8 @@
 #include <ell/ell.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
+#include <ofono/types.h>
+#include <ofono/gprs-context.h>
 
 #include "provisiondb.h"
 
@@ -29,7 +29,7 @@ static int lookup_apn(const char *match_mcc, const char *match_mnc,
 							const char *match_spn)
 {
 	struct provision_db *pdb;
-	struct ofono_gprs_provision_data *contexts;
+	struct provision_db_entry *contexts;
 	size_t n_contexts;
 	int r;
 	size_t i;
@@ -58,7 +58,7 @@ static int lookup_apn(const char *match_mcc, const char *match_mnc,
 	}
 
 	for (i = 0; i < n_contexts; i++) {
-		struct ofono_gprs_provision_data *ap = contexts + i;
+		struct provision_db_entry *ap = contexts + i;
 
 		fprintf(stdout, "\nName: %s\n", ap->name);
 		fprintf(stdout, "APN: %s\n", ap->apn);
-- 
2.43.0

