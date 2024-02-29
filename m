Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FA13E7D4
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251024; cv=none; b=V2GBLe/0Ok/BZoRZdxTQABCX13cEyYoYX7uT1JaVSfhnPlTZ1gnwcxGEtcPH9wrzmAe2j94Ens7g2qMfTQ/ldz1Ap/k9cuD0mw+kzcj7GCykynlse2eEQR0213AgXIlw5gTpRRkNBAkKXSraYvNJRpHmQwMFKLABACsFBLrqzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251024; c=relaxed/simple;
	bh=qMrPX3B0ea9JH7iXks5jZGBltkUg328nkgR3BjUGZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DOL4RwKLxf3qD6RA9ZutQ9z1M/1gpz8mwp6MAC+8F/3P9UBSgUZUI5C+D0CZIPGI1NcTzu9zJ/m6DM9pRG8pNdT2E0Tkh0m5bazJg+BgGtg01uWAx5mG4ZaCoItKmGaJGgX5fBicZN3a3qFR3rd3hpSrzPLeUvGdWLfE1/4WY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/fh6Nc/; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/fh6Nc/"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e49a5b1bbfso750970a34.3
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709251022; x=1709855822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsJ/vc7UBnX7r1irL3SxA5VOv/+YGwf/fxgBlUNaTFU=;
        b=S/fh6Nc/m66Hqc6slvwAxaOsdQ7tbjxBrxmrVs5/bOoIXEBRnuKC3bluCbaup3yTah
         nqq/PYvImOy+6dTTqYSdNNEUbw/+NY3uc/3tmB7Anhwc4E09J0/eO9vCpY3JUJIkdBZI
         iOo6GkQPrwA2eLPe+wXSP4pFngkuNqsHge8cTIicWAWtBmuQ9rE5qDd/IrrlQrFp9UKc
         0x9lcCbhFhXxSg6oaeY6F48vQixUDO+810ii01RwFmnyRIsVd60C/bN2zEblnfr7uvxs
         /N0KcNah810eNQ47+rW+o+KAodB9Xju5gZ1rNK80g6niYY0Jo6KhWmmhgfM/1DvQbXDe
         TAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709251022; x=1709855822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsJ/vc7UBnX7r1irL3SxA5VOv/+YGwf/fxgBlUNaTFU=;
        b=BuNNSf1Kc1NXktGEDNySQUIi92ACt6I6pVSAwoRpzy5hgIGEGp7pvC0NxgvHEceQes
         VuW56Zd1t89tMMDoLzbF89Qh61Dk2eReNEYmj8NosLvUaUx0ZKpyXgu2c8URzIktnGKS
         29TV9biOv2tV8ASWOa1kJEKGjtWTWiShLBTPMrhrRuQ1ejii8FjdWoe5oiTCxaFBY9zO
         /AhSjN5DlnCysx3u+Qi3ocCxCA4bMc/+tV9B5SyLRM2fvH5tNZ1y+K0i7G3o0NmhLsqF
         j2Cwd3X5ScTaF2qiPo9Gqr7nsR2ix9DZ7BM8srihM4gn6xwAHS2GVEf7f2eE0qZjy91Q
         FjYw==
X-Gm-Message-State: AOJu0YxS/9nQv5XA2MGn0PSRlnCRYG78hHe0yrFTNMEDaEiWVzh7es7M
	dU1iZ4aqma8wZnIRVIcC6jRoBq4IzEoCiZxly4rheu2+ulfFCYkkYFyaMFMz
X-Google-Smtp-Source: AGHT+IFhr8+YWDnR9SlEhIt9VPqiM6ZQv97fg6m3G25096iPf69UPDTTNPz26s1iRjvwVhAbqf8dGw==
X-Received: by 2002:a9d:7347:0:b0:6e4:b7ba:31ab with SMTP id l7-20020a9d7347000000b006e4b7ba31abmr336235otk.0.1709251021728;
        Thu, 29 Feb 2024 15:57:01 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830060300b006e4b3c42595sm473924oti.32.2024.02.29.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:57:01 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] smsutil: Use a safer strlcpy
Date: Thu, 29 Feb 2024 17:56:41 -0600
Message-ID: <20240229235658.1703008-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sms_address_from_string is meant as private API, to be used with string
form addresses that have already been sanitized.  However, to be safe,
use a safe version of strcpy to avoid overflowing the buffer in case the
input was not sanitized properly.  While here, add a '__' prefix to the
function name to help make it clearer that this API is private and
should be used with more care.
---
 src/smsutil.c   | 14 +++++++-------
 src/smsutil.h   |  2 +-
 unit/test-sms.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 6fe2bcb4477f..5934da9055dd 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1887,15 +1887,15 @@ time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote)
 	return ret;
 }
 
-void sms_address_from_string(struct sms_address *addr, const char *str)
+void __sms_address_from_string(struct sms_address *addr, const char *str)
 {
 	addr->numbering_plan = SMS_NUMBERING_PLAN_ISDN;
 	if (str[0] == '+') {
 		addr->number_type = SMS_NUMBER_TYPE_INTERNATIONAL;
-		strcpy(addr->address, str + 1);
+		l_strlcpy(addr->address, str + 1, sizeof(addr->address));
 	} else {
 		addr->number_type = SMS_NUMBER_TYPE_UNKNOWN;
-		strcpy(addr->address, str);
+		l_strlcpy(addr->address, str, sizeof(addr->address));
 	}
 }
 
@@ -3084,7 +3084,7 @@ gboolean status_report_assembly_report(struct status_report_assembly *assembly,
 		}
 	}
 
-	sms_address_from_string(&addr, straddr);
+	__sms_address_from_string(&addr, straddr);
 
 	if (pending == TRUE && node->deliverable == TRUE) {
 		/*
@@ -3177,7 +3177,7 @@ void status_report_assembly_expire(struct status_report_assembly *assembly,
 	while (g_hash_table_iter_next(&iter_addr, (gpointer) &straddr,
 					(gpointer) &id_table)) {
 
-		sms_address_from_string(&addr, straddr);
+		__sms_address_from_string(&addr, straddr);
 		g_hash_table_iter_init(&iter_node, id_table);
 
 		/* Go through different messages. */
@@ -3470,7 +3470,7 @@ GSList *sms_datagram_prepare(const char *to,
 	template.submit.vp.relative = 0xA7; /* 24 Hours */
 	template.submit.dcs = 0x04; /* Class Unspecified, 8 Bit */
 	template.submit.udhi = TRUE;
-	sms_address_from_string(&template.submit.daddr, to);
+	__sms_address_from_string(&template.submit.daddr, to);
 
 	offset = 1;
 
@@ -3597,7 +3597,7 @@ GSList *sms_text_prepare_with_alphabet(const char *to, const char *utf8,
 	template.submit.srr = use_delivery_reports;
 	template.submit.mr = 0;
 	template.submit.vp.relative = 0xA7; /* 24 Hours */
-	sms_address_from_string(&template.submit.daddr, to);
+	__sms_address_from_string(&template.submit.daddr, to);
 
 	/* There are two enums for the same thing */
 	dialect = (enum gsm_dialect)alphabet;
diff --git a/src/smsutil.h b/src/smsutil.h
index 5389757c309c..98e10e15de72 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -465,7 +465,7 @@ int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
 
 const char *sms_address_to_string(const struct sms_address *addr);
-void sms_address_from_string(struct sms_address *addr, const char *str);
+void __sms_address_from_string(struct sms_address *addr, const char *str);
 
 const guint8 *sms_extract_common(const struct sms *sms, gboolean *out_udhi,
 					guint8 *out_dcs, guint8 *out_udl,
diff --git a/unit/test-sms.c b/unit/test-sms.c
index 154bb33ed244..66755f34e603 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1603,7 +1603,7 @@ static void test_sr_assembly(void)
 			sr3.status_report.mr);
 	}
 
-	sms_address_from_string(&addr, "+4915259911630");
+	__sms_address_from_string(&addr, "+4915259911630");
 
 	sra = status_report_assembly_new(NULL);
 
@@ -1626,7 +1626,7 @@ static void test_sr_assembly(void)
 	 * Send sms-message in the national address-format,
 	 * but receive in the international address-format.
 	 */
-	sms_address_from_string(&addr, "9911630");
+	__sms_address_from_string(&addr, "9911630");
 	status_report_assembly_add_fragment(sra, sha1, &addr, 4, time(NULL), 2);
 	status_report_assembly_add_fragment(sra, sha1, &addr, 5, time(NULL), 2);
 
@@ -1641,7 +1641,7 @@ static void test_sr_assembly(void)
 	 * Send sms-message in the international address-format,
 	 * but receive in the national address-format.
 	 */
-	sms_address_from_string(&addr, "+358123456789");
+	__sms_address_from_string(&addr, "+358123456789");
 	status_report_assembly_add_fragment(sra, sha1, &addr, 6, time(NULL), 1);
 
 	g_assert(status_report_assembly_report(sra, &sr3, id, &delivered));
-- 
2.43.0

