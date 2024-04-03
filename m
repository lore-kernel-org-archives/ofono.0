Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C414D706
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160363; cv=none; b=KOW31POvvX2NRtQF5jxNc35RAsPbuj4T969GygvJJlLLpw6Fzto8B5A9TGx+W5mEIApkQGBcZMkVbqZiqRQiRFLu09N19wZ+lwnElYRMd9cZ/nu5AZjyXHySH29czV1gTt37Xwr54vazG0k3v73dDVQ58HWEiGc/ANH6JDR1Uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160363; c=relaxed/simple;
	bh=/wymyt5xwpZ+tQHu282+4XSKoEkHISFJ7iCvFHqruTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTcnOLrqdQff/qPBdrR0yH+0Gi70iTAZjfG5Qwzg2Q2LdAEqCakhwZiy4+bpmH4575MNyt8fKpXjAXK/oLcsgQP+mejeL36WF6v8oDhgx7hR/dqBiews0DplXoXqEw3tu4gk8akq03AMlFRemWq+8He23UNmlfITWn0wLsA6V0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i24nYVlg; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i24nYVlg"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2220a389390so533479fac.0
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160360; x=1712765160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HoeR3bAAJqv5hNIJPwou9IBsNAQQueJ+Kbnp+RCSHI=;
        b=i24nYVlg9em1p+WXOHYfWpR5+mnniY4B/edsLQrF2ClCiArpW4agWWQkRXY+HLGovm
         lc5RDb5LQuxH82jNwJUDXvMZL/x696zChPNUnbK5QI+JKypo0X9c+XEZYrAZWj/wixGJ
         OLNR36TIDI1GJHS3yf2AzDUWkU58Rek8fAkgPXhPu+mN4qCENXFeF3uXQL888rJsVMl6
         8YX3hLx4cq/vZz5CKm1pDW32hdGGVo4bA6mYd1aVKb1Gb4jF5Dnh0LA1UoVdDCjJqn1A
         LDtl/YnKTK/IRI2mvf1tyIi85MBkUihOYTwE+NDdUu6SFrJ8VSvWzgl629mWoLjQ6gZ2
         7cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160360; x=1712765160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HoeR3bAAJqv5hNIJPwou9IBsNAQQueJ+Kbnp+RCSHI=;
        b=muscploKezY86kF0FqClIC3EfKLrhEPN80AUg4u345oaSlnymU01Og+Kevo7Q73oM0
         BMhJc1Ez92R4NXKZf9K9fla6qpZ5nSSaEJOvQT35HQ2dxeXFyD8QSdmvdMI3N5B4Nem1
         YV1XQV5tfLqI8/WDEvSZMdYIyFfrUYZAA6h/r5QFKBg3JyoP/3EJKZFftDO/R0yMLr2c
         //X1i1jH/7yhILu1P1TrJZ6mBNxl8W7n0j79oy62czGoCLWwbR/PfLz91Sop6W+1mgse
         mk9GYeYr+dAp7kYsEbBv0Ln64x7vfX6NczUg4pABubWQHl25EF17z3BZBl879NBkwuSu
         KrLg==
X-Gm-Message-State: AOJu0YzAXPi12X2iXKleYFseq78ttWOMuWEv/6MQGChv8cD86a81xEN0
	awl0LXuJzWLzjOAOG3LqOFHmwyBsiuk80y0o2hHHMCdS94kchTCabngDB6/4
X-Google-Smtp-Source: AGHT+IH7aRDSuPQp0wj5/47pJYk6UqW9pcC7J6vH1uPhFC9CkIoXxYMqw3fCbu1Am+RRenInHwHksg==
X-Received: by 2002:a05:6871:7247:b0:22a:5022:53e0 with SMTP id ml7-20020a056871724700b0022a502253e0mr30288oac.24.1712160359971;
        Wed, 03 Apr 2024 09:05:59 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:05:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/14] simutil: Convert eons APIs to use ell
Date: Wed,  3 Apr 2024 11:05:24 -0500
Message-ID: <20240403160557.2828145-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While here, also remove sim_eons_optimize() as it is no longer needed.
The ell queue implementation natively supports pushing to the back of a
linked list.  Also tighten up some length checks and make 'length'
arguments unsigned.
---
 src/network.c       |   2 -
 src/simutil.c       | 116 +++++++++++++++++++++-----------------------
 src/simutil.h       |  15 +++---
 unit/test-simutil.c |   1 -
 4 files changed, 63 insertions(+), 71 deletions(-)

diff --git a/src/network.c b/src/network.c
index 886e5bf0f9a3..629d5fb91eb8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1581,8 +1581,6 @@ static void sim_opl_read_cb(int ok, int length, int record,
 		return;
 
 optimize:
-	sim_eons_optimize(netreg->eons);
-
 	for (l = netreg->operator_list; l; l = l->next) {
 		struct network_operator_data *opd = l->data;
 		const struct sim_eons_operator_info *eons_info;
diff --git a/src/simutil.c b/src/simutil.c
index 543ab9962ef2..fbecf6db67de 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -36,10 +36,10 @@
 #include "missing.h"
 
 struct sim_eons {
-	struct sim_eons_operator_info *pnn_list;
-	GSList *opl_list;
-	gboolean pnn_valid;
-	int pnn_max;
+	struct l_queue *opl_list;
+	bool pnn_valid;
+	uint32_t pnn_max;
+	struct sim_eons_operator_info pnn_list[];
 };
 
 struct spdi_operator {
@@ -782,12 +782,12 @@ bool validate_utf8_tlv(const unsigned char *tlv)
 }
 
 static char *sim_network_name_parse(const unsigned char *buffer, int length,
-					gboolean *add_ci)
+					bool *add_ci)
 {
 	char *ret = NULL;
 	unsigned char dcs;
 	int i;
-	gboolean ci = FALSE;
+	bool ci = FALSE;
 	unsigned char *unpacked_buf;
 	long num_char, written;
 	int spare_bits;
@@ -999,22 +999,18 @@ void sim_spdi_free(struct sim_spdi *spdi)
 	g_free(spdi);
 }
 
-static void pnn_operator_free(struct sim_eons_operator_info *oper)
+struct sim_eons *sim_eons_new(uint32_t pnn_records)
 {
-	if (oper == NULL)
-		return;
+	struct sim_eons *eons = l_malloc(sizeof(struct sim_eons) +
+			sizeof(struct sim_eons_operator_info) * pnn_records);
 
-	l_free(oper->info);
-	l_free(oper->shortname);
-	l_free(oper->longname);
-}
+	eons->pnn_valid = false;
+	eons->pnn_max = pnn_records;
 
-struct sim_eons *sim_eons_new(int pnn_records)
-{
-	struct sim_eons *eons = g_new0(struct sim_eons, 1);
+	memset(eons->pnn_list, 0,
+			sizeof(struct sim_eons_operator_info) * pnn_records);
 
-	eons->pnn_list = g_new0(struct sim_eons_operator_info, pnn_records);
-	eons->pnn_max = pnn_records;
+	eons->opl_list = l_queue_new();
 
 	return eons;
 }
@@ -1024,8 +1020,8 @@ gboolean sim_eons_pnn_is_empty(struct sim_eons *eons)
 	return !eons->pnn_valid;
 }
 
-void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
-				const guint8 *tlv, int length)
+void sim_eons_add_pnn_record(struct sim_eons *eons, uint32_t record,
+				const uint8_t *tlv, uint16_t length)
 {
 	const unsigned char *name;
 	int namelength;
@@ -1053,9 +1049,9 @@ void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
 	eons->pnn_valid = TRUE;
 }
 
-static struct opl_operator *opl_operator_alloc(const guint8 *record)
+static struct opl_operator *opl_operator_alloc(const uint8_t *record)
 {
-	struct opl_operator *oper = g_new0(struct opl_operator, 1);
+	struct opl_operator *oper = l_new(struct opl_operator, 1);
 
 	sim_parse_mcc_mnc(record, oper->mcc, oper->mnc);
 	record += 3;
@@ -1071,40 +1067,52 @@ static struct opl_operator *opl_operator_alloc(const guint8 *record)
 }
 
 void sim_eons_add_opl_record(struct sim_eons *eons,
-				const guint8 *contents, int length)
+				const uint8_t *contents, uint16_t length)
 {
 	struct opl_operator *oper;
 
+	if (length < 8)
+		return;
+
 	oper = opl_operator_alloc(contents);
 
-	if (oper->id > eons->pnn_max) {
-		g_free(oper);
+	if (!oper->id || oper->id > eons->pnn_max) {
+		l_free(oper);
 		return;
 	}
 
-	eons->opl_list = g_slist_prepend(eons->opl_list, oper);
-}
-
-void sim_eons_optimize(struct sim_eons *eons)
-{
-	eons->opl_list = g_slist_reverse(eons->opl_list);
+	l_queue_push_tail(eons->opl_list, oper);
 }
 
 void sim_eons_free(struct sim_eons *eons)
 {
-	int i;
+	uint32_t i;
 
 	if (eons == NULL)
 		return;
 
-	for (i = 0; i < eons->pnn_max; i++)
-		pnn_operator_free(eons->pnn_list + i);
+	for (i = 0; i < eons->pnn_max; i++) {
+		struct sim_eons_operator_info *oper = eons->pnn_list + i;
 
-	g_free(eons->pnn_list);
+		l_free(oper->info);
+		l_free(oper->shortname);
+		l_free(oper->longname);
+	}
 
-	g_slist_free_full(eons->opl_list, g_free);
+	l_queue_destroy(eons->opl_list, l_free);
 
-	g_free(eons);
+	l_free(eons);
+}
+
+static bool opl_match_mcc_mnc(const char *opl, const char *s, size_t max)
+{
+	unsigned int i;
+
+	for (i = 0; i < max; i++)
+		if (s[i] != opl[i] && !(opl[i] == 'b' && s[i]))
+			return false;
+
+	return true;
 }
 
 static const struct sim_eons_operator_info *
@@ -1112,46 +1120,32 @@ static const struct sim_eons_operator_info *
 				const char *mcc, const char *mnc,
 				gboolean have_lac, guint16 lac)
 {
-	GSList *l;
+	const struct l_queue_entry *entry;
 	const struct opl_operator *opl;
-	int i;
 
-	for (l = eons->opl_list; l; l = l->next) {
-		opl = l->data;
+	for (entry = l_queue_get_entries(eons->opl_list);
+						entry; entry = entry->next) {
+		opl = entry->data;
 
-		for (i = 0; i < OFONO_MAX_MCC_LENGTH; i++)
-			if (mcc[i] != opl->mcc[i] &&
-					!(opl->mcc[i] == 'b' && mcc[i]))
-				break;
-		if (i < OFONO_MAX_MCC_LENGTH)
+		if (!opl_match_mcc_mnc(opl->mcc, mcc, OFONO_MAX_MCC_LENGTH))
 			continue;
 
-		for (i = 0; i < OFONO_MAX_MNC_LENGTH; i++)
-			if (mnc[i] != opl->mnc[i] &&
-					!(opl->mnc[i] == 'b' && mnc[i]))
-				break;
-		if (i < OFONO_MAX_MNC_LENGTH)
+		if (!opl_match_mcc_mnc(opl->mnc, mnc, OFONO_MAX_MNC_LENGTH))
 			continue;
 
 		if (opl->lac_tac_low == 0 && opl->lac_tac_high == 0xfffe)
-			break;
+			goto found;
 
 		if (have_lac == FALSE)
 			continue;
 
 		if ((lac >= opl->lac_tac_low) && (lac <= opl->lac_tac_high))
-			break;
+			goto found;
 	}
 
-	if (l == NULL)
-		return NULL;
-
-	opl = l->data;
-
-	/* 0 is not a valid record id */
-	if (opl->id == 0)
-		return NULL;
+	return NULL;
 
+found:
 	return &eons->pnn_list[opl->id - 1];
 }
 
diff --git a/src/simutil.h b/src/simutil.h
index 9584d4d9cd62..8c34f9f36488 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -20,6 +20,7 @@
  */
 
 #include <stdbool.h>
+#include <stdint.h>
 
 #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
 #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
@@ -299,9 +300,9 @@ enum ber_tlv_data_encoding_type {
 
 struct sim_eons_operator_info {
 	char *longname;
-	gboolean long_ci;
+	bool long_ci;
 	char *shortname;
-	gboolean short_ci;
+	bool short_ci;
 	char *info;
 };
 
@@ -460,18 +461,18 @@ gboolean ber_tlv_builder_recurse_comprehension(struct ber_tlv_builder *builder,
 void ber_tlv_builder_optimize(struct ber_tlv_builder *builder,
 				unsigned char **pdu, unsigned int *len);
 
-struct sim_eons *sim_eons_new(int pnn_records);
-void sim_eons_add_pnn_record(struct sim_eons *eons, int record,
-				const guint8 *tlv, int length);
+struct sim_eons *sim_eons_new(uint32_t pnn_records);
+void sim_eons_add_pnn_record(struct sim_eons *eons, uint32_t record,
+				const uint8_t *tlv, uint16_t length);
 gboolean sim_eons_pnn_is_empty(struct sim_eons *eons);
 void sim_eons_add_opl_record(struct sim_eons *eons,
-				const guint8 *contents, int length);
+				const uint8_t *contents, uint16_t length);
 void sim_eons_optimize(struct sim_eons *eons);
 const struct sim_eons_operator_info *sim_eons_lookup_with_lac(
 						struct sim_eons *eons,
 						const char *mcc,
 						const char *mnc,
-						guint16 lac);
+						uint16_t lac);
 const struct sim_eons_operator_info *sim_eons_lookup(struct sim_eons *eons,
 						const char *mcc,
 						const char *mnc);
diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 4199991a4d2a..365ef318d937 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -393,7 +393,6 @@ static void test_eons(void)
 	g_assert(!sim_eons_pnn_is_empty(eons_info));
 
 	sim_eons_add_opl_record(eons_info, valid_efopl, sizeof(valid_efopl));
-	sim_eons_optimize(eons_info);
 
 	op_info = sim_eons_lookup(eons_info, "246", "82");
 	g_assert(op_info == NULL);
-- 
2.43.0

