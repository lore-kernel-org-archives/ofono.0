Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780562391AC
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337279; cv=none; b=t0D6BCYpnWG+c/wIhLM9o3rL9k/7At7d5Rz+rA/gakIOK+aPXQt+xq8B6BpIvQXrh+vt2atgBlE8pngNae6Hdc9JUgepV3rO3xHZ9NnFdsNf1Mx8ljO/HViAfjrGbLItXDLf61mseuSbVQ9LpEVshOfmz4fxzoYzrbJyOC5Vgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337279; c=relaxed/simple;
	bh=koqPOJuHG/OL4mQ2JlPmvCp64UUSU+zRNJEHgz7TcOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1kgTFvCwy2DhpllrJXshF1A0J/vkRgdKQjxxK0Tk7s2dIt/si3KfDb4YO/DbVFx8pTDpDHftQpLvFNJZnseczszDJDGO8C6UGxFANkQJQgc9qGJmN6aG5mA2ispwKmAKBUx6t4RqlQrWtaondA6I7RQ7Z7f4C1XrjIgnjADO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOsdWH8H; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOsdWH8H"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d5fddef37so33476a34.0
        for <ofono@lists.linux.dev>; Wed, 04 Dec 2024 10:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733337276; x=1733942076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96bH7mxaG3g8MO52gweg3pfYzp8385cZqyVYH7+Oiiw=;
        b=WOsdWH8H2/Tq92AnAJbupLL6QxBV5U6MgUQbJQtupHzf2ruwKyMv3SkdrV8HUEWEcR
         XW9Lr0EvTvxAWJaTg/ESGlxbJtI1GJcVkeU6bMTuR35a5UmxQmBBkqUef1OGjjJ2bG4q
         da5GN5yCfu5b6gKV5Go7YFbmyyvJYJKRI8dpkUg8aLSk6RO+1TIL6lh15CltHkkAHp0/
         r/H+ZkpwIWbxGGOPTVYoEbWLAJotQVqh2nItxpWCAznYcR5m+NlJebtiGoGVbNCvEGs6
         pr58I5dbGIJokDDdPqGjpN9rXYu7fuE70d22aDgtOvdgSD3o9xfuePQgSH4HVmbtivQA
         /Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337276; x=1733942076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96bH7mxaG3g8MO52gweg3pfYzp8385cZqyVYH7+Oiiw=;
        b=dITUWnMmXBdoQEc/1vfXhF/3ObVVwt6vKxvzaUXzSoXxnxgOgvIl6SUUU1dj5WZrXW
         mFsfi1ufy9VTQzZMdGM+Q3G1S4vL469uri6nUH9UOE0nsxtzK83W1KpjJydN0WPKL4jn
         gVzxBU22gUhyWRi48Fb8QJl4dItmVcc1txISKY7Pr7O2z7u9a7v1B3xt2KqiU4CqVyWy
         PYJgiSz5lAewbDwW3XfkCXCRL9hken6XVxNsYNZ+ZavpG6nCcr5mWqRY+8nHEoEa9bye
         UXD/Tnoe80JgsZEBiNQ6//2s91b72QdmYkEsxwvLTW96ock/aGtgPUtLQbfoBh/mph4B
         bACg==
X-Gm-Message-State: AOJu0YyTOg1MGlneDYK3GHkXcYay5l3xoBZD8QWKfVT+DN10zP+mv4YO
	QoXAu9my9rS/gNM56ntYLTenl9/4oVTeQ3A5K+OmPbN2v3R6uQA/rkD4RQ==
X-Gm-Gg: ASbGncvuSGiEenBxZ6J6a01i6BkrjEj1GKEz6pECTZMmnliHYbdHrwbrsi+XuVMAfez
	6TZLM6lU0sbAOIwNxX59xNj60miPmnlU13Qa0CSdTu3nls2VFYowlXF+MLpZXUWrIXXHsRyt18U
	5gFsl57tyIpaPpnpS5CSEWJEu743OLjdyZRhnMdmM4rvi8xNDkPv6/2VwWIFsecMNW40HbSvBsI
	ZeyYG83bXXWrYL3FnW/3Ea1AFmT83jGNcx+HRYFuzMj40nvVfQbXoluVE4J6d1tXDYdpFEETzA4
	fBpZE074A7qY1y4jT4G+en9/
X-Google-Smtp-Source: AGHT+IFKan7LFhQe+stmY4Rz1DwhY0/1QbJC59ZHuXxHjCaxadXAiDceQdOIxx0NgUzpZ463tiQ0RQ==
X-Received: by 2002:a05:6830:378d:b0:71d:3fe2:2051 with SMTP id 46e09a7af769-71dad6cc74bmr8897845a34.22.1733337276146;
        Wed, 04 Dec 2024 10:34:36 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a4cda26sm3409959eaf.27.2024.12.04.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:34:35 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] smsutil: Use size_t for lengths and offsets
Date: Wed,  4 Dec 2024 12:34:25 -0600
Message-ID: <20241204183434.251701-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some unknown reason 'int' was used as the data type for length and
offset values, which can never be negative.  Fix that.
---
 src/message-waiting.c |   6 ++-
 src/smsutil.c         | 120 +++++++++++++++++++++---------------------
 src/smsutil.h         |  22 ++++----
 src/stkutil.c         |   4 +-
 4 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 2f40c148ab83..28a5af800cc7 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -782,9 +782,11 @@ static void handle_special_sms_iei(struct ofono_message_waiting *mw,
 
 static void handle_enhanced_voicemail_iei(struct ofono_message_waiting *mw,
 						const guint8 *iei,
-						gboolean *discard, int length)
+						gboolean *discard,
+						size_t length)
 {
-	int profile, n;
+	int profile;
+	size_t n;
 	gboolean set;
 	struct sms_address mailbox_address;
 
diff --git a/src/smsutil.c b/src/smsutil.c
index a706e26ffbca..5c9826d35f13 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -59,11 +59,11 @@ static GSList *sms_assembly_add_fragment_backup(struct sms_assembly *assembly,
  * This function uses the meanings of digits 10..15 according to the rules
  * defined in 23.040 Section 9.1.2.3 and 24.008 Table 10.5.118
  */
-void extract_bcd_number(const unsigned char *buf, int len, char *out)
+void extract_bcd_number(const unsigned char *buf, size_t len, char *out)
 {
 	static const char digit_lut[] = "0123456789*#abc\0";
 	unsigned char oct;
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++) {
 		oct = buf[i];
@@ -246,7 +246,7 @@ gboolean sms_mwi_dcs_decode(guint8 dcs, enum sms_mwi_type *type,
 	return TRUE;
 }
 
-int sms_udl_in_bytes(guint8 ud_len, guint8 dcs)
+size_t sms_udl_in_bytes(guint8 ud_len, guint8 dcs)
 {
 	int len_7bit = (ud_len + 1) * 7 / 8;
 	int len_8bit = ud_len;
@@ -297,8 +297,8 @@ int sms_udl_in_bytes(guint8 ud_len, guint8 dcs)
 	return 0;
 }
 
-static inline gboolean next_octet(const unsigned char *pdu, int len,
-					int *offset, unsigned char *oct)
+static inline gboolean next_octet(const unsigned char *pdu, size_t len,
+					size_t *offset, unsigned char *oct)
 {
 	if (len == *offset)
 		return FALSE;
@@ -310,7 +310,7 @@ static inline gboolean next_octet(const unsigned char *pdu, int len,
 	return TRUE;
 }
 
-static inline gboolean set_octet(unsigned char *pdu, int *offset,
+static inline gboolean set_octet(unsigned char *pdu, size_t *offset,
 					unsigned char oct)
 {
 	pdu[*offset] = oct;
@@ -320,7 +320,7 @@ static inline gboolean set_octet(unsigned char *pdu, int *offset,
 }
 
 gboolean sms_encode_scts(const struct sms_scts *in, unsigned char *pdu,
-				int *offset)
+				size_t *offset)
 {
 	guint timezone;
 
@@ -378,8 +378,8 @@ guint8 sms_decode_semi_octet(guint8 in)
 	return (in & 0x0f) * 10 + (in >> 4);
 }
 
-gboolean sms_decode_scts(const unsigned char *pdu, int len,
-				int *offset, struct sms_scts *out)
+gboolean sms_decode_scts(const unsigned char *pdu, size_t len,
+				size_t *offset, struct sms_scts *out)
 {
 	unsigned char oct = 0;
 
@@ -444,8 +444,8 @@ gboolean sms_decode_scts(const unsigned char *pdu, int len,
 	return TRUE;
 }
 
-static gboolean decode_validity_period(const unsigned char *pdu, int len,
-					int *offset,
+static gboolean decode_validity_period(const unsigned char *pdu, size_t len,
+					size_t *offset,
 					enum sms_validity_period_format vpf,
 					struct sms_validity_period *vp)
 {
@@ -484,7 +484,7 @@ static gboolean decode_validity_period(const unsigned char *pdu, int len,
 
 static gboolean encode_validity_period(const struct sms_validity_period *vp,
 					enum sms_validity_period_format vpf,
-					unsigned char *pdu, int *offset)
+					unsigned char *pdu, size_t *offset)
 {
 	switch (vpf) {
 	case SMS_VALIDITY_PERIOD_FORMAT_ABSENT:
@@ -509,7 +509,7 @@ static gboolean encode_validity_period(const struct sms_validity_period *vp,
 }
 
 gboolean sms_encode_address_field(const struct sms_address *in, gboolean sc,
-					unsigned char *pdu, int *offset)
+					unsigned char *pdu, size_t *offset)
 {
 	const char *addr = (const char *)&in->address;
 	size_t len = strlen(addr);
@@ -601,13 +601,13 @@ out:
 	return TRUE;
 }
 
-gboolean sms_decode_address_field(const unsigned char *pdu, int len,
-					int *offset, gboolean sc,
+gboolean sms_decode_address_field(const unsigned char *pdu, size_t len,
+					size_t *offset, gboolean sc,
 					struct sms_address *out)
 {
 	unsigned char addr_len;
 	unsigned char addr_type;
-	int byte_len;
+	size_t byte_len;
 
 	if (!next_octet(pdu, len, offset, &addr_len))
 		return FALSE;
@@ -694,9 +694,9 @@ gboolean sms_decode_address_field(const unsigned char *pdu, int len,
 }
 
 static gboolean encode_deliver(const struct sms_deliver *in, unsigned char *pdu,
-				int *offset)
+				size_t *offset)
 {
-	int ud_oct_len;
+	size_t ud_oct_len;
 	unsigned char oct;
 
 	oct = 0;
@@ -735,11 +735,11 @@ static gboolean encode_deliver(const struct sms_deliver *in, unsigned char *pdu,
 	return TRUE;
 }
 
-static gboolean decode_deliver(const unsigned char *pdu, int len,
+static gboolean decode_deliver(const unsigned char *pdu, size_t len,
 				struct sms *out)
 {
-	int offset = 0;
-	int expected;
+	size_t offset = 0;
+	size_t expected;
 	unsigned char octet;
 
 	out->type = SMS_TYPE_DELIVER;
@@ -770,7 +770,7 @@ static gboolean decode_deliver(const unsigned char *pdu, int len,
 
 	expected = sms_udl_in_bytes(out->deliver.udl, out->deliver.dcs);
 
-	if (expected < 0 || expected > (int)sizeof(out->deliver.ud))
+	if (expected > sizeof(out->deliver.ud))
 		return FALSE;
 
 	if ((len - offset) < expected)
@@ -782,7 +782,8 @@ static gboolean decode_deliver(const unsigned char *pdu, int len,
 }
 
 static gboolean encode_submit_ack_report(const struct sms_submit_ack_report *in,
-						unsigned char *pdu, int *offset)
+						unsigned char *pdu,
+						size_t *offset)
 {
 	unsigned char oct;
 
@@ -816,7 +817,8 @@ static gboolean encode_submit_ack_report(const struct sms_submit_ack_report *in,
 }
 
 static gboolean encode_submit_err_report(const struct sms_submit_err_report *in,
-						unsigned char *pdu, int *offset)
+						unsigned char *pdu,
+						size_t *offset)
 {
 	unsigned char oct;
 
@@ -851,10 +853,10 @@ static gboolean encode_submit_err_report(const struct sms_submit_err_report *in,
 	return TRUE;
 }
 
-static gboolean decode_submit_report(const unsigned char *pdu, int len,
+static gboolean decode_submit_report(const unsigned char *pdu, size_t len,
 					struct sms *out)
 {
-	int offset = 0;
+	size_t offset = 0;
 	unsigned char octet;
 	gboolean udhi;
 	guint8 uninitialized_var(fcs);
@@ -924,7 +926,7 @@ static gboolean decode_submit_report(const unsigned char *pdu, int len,
 	}
 
 	if (pi & 0x04) {
-		int expected;
+		size_t expected;
 
 		if (!next_octet(pdu, len, &offset, &udl))
 			return FALSE;
@@ -935,14 +937,14 @@ static gboolean decode_submit_report(const unsigned char *pdu, int len,
 			return FALSE;
 
 		if (out->type == SMS_TYPE_SUBMIT_REPORT_ERROR) {
-			if (expected > (int) sizeof(out->submit_err_report.ud))
+			if (expected > sizeof(out->submit_err_report.ud))
 				return FALSE;
 
 			out->submit_err_report.udl = udl;
 			memcpy(out->submit_err_report.ud,
 					pdu + offset, expected);
 		} else {
-			if (expected > (int) sizeof(out->submit_ack_report.ud))
+			if (expected > sizeof(out->submit_ack_report.ud))
 				return FALSE;
 
 			out->submit_ack_report.udl = udl;
@@ -955,7 +957,7 @@ static gboolean decode_submit_report(const unsigned char *pdu, int len,
 }
 
 static gboolean encode_status_report(const struct sms_status_report *in,
-					unsigned char *pdu, int *offset)
+					unsigned char *pdu, size_t *offset)
 {
 	unsigned char octet;
 
@@ -1008,10 +1010,10 @@ static gboolean encode_status_report(const struct sms_status_report *in,
 	return TRUE;
 }
 
-static gboolean decode_status_report(const unsigned char *pdu, int len,
+static gboolean decode_status_report(const unsigned char *pdu, size_t len,
 					struct sms *out)
 {
-	int offset = 0;
+	size_t offset = 0;
 	unsigned char octet;
 
 	out->type = SMS_TYPE_STATUS_REPORT;
@@ -1066,7 +1068,7 @@ static gboolean decode_status_report(const unsigned char *pdu, int len,
 	}
 
 	if (out->status_report.pi & 0x04) {
-		int expected;
+		size_t expected;
 
 		if (!next_octet(pdu, len, &offset, &out->status_report.udl))
 			return FALSE;
@@ -1077,7 +1079,7 @@ static gboolean decode_status_report(const unsigned char *pdu, int len,
 		if ((len - offset) < expected)
 			return FALSE;
 
-		if (expected > (int)sizeof(out->status_report.ud))
+		if (expected > sizeof(out->status_report.ud))
 			return FALSE;
 
 		memcpy(out->status_report.ud, pdu + offset, expected);
@@ -1088,7 +1090,7 @@ static gboolean decode_status_report(const unsigned char *pdu, int len,
 
 static gboolean encode_deliver_ack_report(const struct sms_deliver_ack_report *in,
 						unsigned char *pdu,
-						int *offset)
+						size_t *offset)
 {
 	unsigned char oct;
 
@@ -1108,7 +1110,7 @@ static gboolean encode_deliver_ack_report(const struct sms_deliver_ack_report *i
 		set_octet(pdu, offset, in->dcs);
 
 	if (in->pi & 0x4) {
-		int ud_oct_len = sms_udl_in_bytes(in->udl, in->dcs);
+		size_t ud_oct_len = sms_udl_in_bytes(in->udl, in->dcs);
 
 		set_octet(pdu, offset, in->udl);
 		memcpy(pdu + *offset, in->ud, ud_oct_len);
@@ -1120,7 +1122,7 @@ static gboolean encode_deliver_ack_report(const struct sms_deliver_ack_report *i
 
 static gboolean encode_deliver_err_report(const struct sms_deliver_err_report *in,
 						unsigned char *pdu,
-						int *offset)
+						size_t *offset)
 {
 	unsigned char oct;
 
@@ -1155,7 +1157,7 @@ static gboolean encode_deliver_err_report(const struct sms_deliver_err_report *i
 static gboolean decode_deliver_report(const unsigned char *pdu, int len,
 					struct sms *out)
 {
-	int offset = 0;
+	size_t offset = 0;
 	unsigned char octet;
 	gboolean udhi;
 	guint8 uninitialized_var(fcs);
@@ -1218,7 +1220,7 @@ static gboolean decode_deliver_report(const unsigned char *pdu, int len,
 	}
 
 	if (pi & 0x04) {
-		int expected;
+		size_t expected;
 
 		if (!next_octet(pdu, len, &offset, &udl))
 			return FALSE;
@@ -1229,14 +1231,14 @@ static gboolean decode_deliver_report(const unsigned char *pdu, int len,
 			return FALSE;
 
 		if (out->type == SMS_TYPE_DELIVER_REPORT_ERROR) {
-			if (expected > (int) sizeof(out->deliver_err_report.ud))
+			if (expected > sizeof(out->deliver_err_report.ud))
 				return FALSE;
 
 			out->deliver_err_report.udl = udl;
 			memcpy(out->deliver_err_report.ud,
 					pdu + offset, expected);
 		} else {
-			if (expected > (int) sizeof(out->deliver_ack_report.ud))
+			if (expected > sizeof(out->deliver_ack_report.ud))
 				return FALSE;
 
 			out->deliver_ack_report.udl = udl;
@@ -1249,10 +1251,10 @@ static gboolean decode_deliver_report(const unsigned char *pdu, int len,
 }
 
 static gboolean encode_submit(const struct sms_submit *in,
-					unsigned char *pdu, int *offset)
+					unsigned char *pdu, size_t *offset)
 {
 	unsigned char octet;
-	int ud_oct_len;
+	size_t ud_oct_len;
 
 	/* SMS Submit */
 	octet = 0x1;
@@ -1296,11 +1298,11 @@ static gboolean encode_submit(const struct sms_submit *in,
 	return TRUE;
 }
 
-gboolean sms_decode_unpacked_stk_pdu(const unsigned char *pdu, int len,
+gboolean sms_decode_unpacked_stk_pdu(const unsigned char *pdu, size_t len,
 					struct sms *out)
 {
 	unsigned char octet;
-	int offset = 0;
+	size_t offset = 0;
 
 	if (!next_octet(pdu, len, &offset, &octet))
 		return FALSE;
@@ -1348,12 +1350,12 @@ gboolean sms_decode_unpacked_stk_pdu(const unsigned char *pdu, int len,
 	return TRUE;
 }
 
-static gboolean decode_submit(const unsigned char *pdu, int len,
+static gboolean decode_submit(const unsigned char *pdu, size_t len,
 					struct sms *out)
 {
 	unsigned char octet;
-	int offset = 0;
-	int expected;
+	size_t offset = 0;
+	size_t expected;
 
 	out->type = SMS_TYPE_SUBMIT;
 
@@ -1391,7 +1393,7 @@ static gboolean decode_submit(const unsigned char *pdu, int len,
 	if ((len - offset) < expected)
 		return FALSE;
 
-	if (expected > (int) sizeof(out->submit.ud))
+	if (expected > sizeof(out->submit.ud))
 		return FALSE;
 
 	memcpy(out->submit.ud, pdu + offset, expected);
@@ -1400,7 +1402,7 @@ static gboolean decode_submit(const unsigned char *pdu, int len,
 }
 
 static gboolean encode_command(const struct sms_command *in,
-					unsigned char *pdu, int *offset)
+					unsigned char *pdu, size_t *offset)
 {
 	unsigned char octet;
 
@@ -1435,11 +1437,11 @@ static gboolean encode_command(const struct sms_command *in,
 	return TRUE;
 }
 
-static gboolean decode_command(const unsigned char *pdu, int len,
+static gboolean decode_command(const unsigned char *pdu, size_t len,
 					struct sms *out)
 {
 	unsigned char octet;
-	int offset = 0;
+	size_t offset = 0;
 
 	out->type = SMS_TYPE_COMMAND;
 
@@ -1485,8 +1487,8 @@ static gboolean decode_command(const unsigned char *pdu, int len,
 gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
 			unsigned char *pdu)
 {
-	int offset = 0;
-	int tpdu_start;
+	size_t offset = 0;
+	size_t tpdu_start;
 
 	if (in->type == SMS_TYPE_DELIVER || in->type == SMS_TYPE_SUBMIT ||
 			in->type == SMS_TYPE_COMMAND ||
@@ -1546,11 +1548,11 @@ gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
 	return TRUE;
 }
 
-gboolean sms_decode(const unsigned char *pdu, int len, gboolean outgoing,
-			int tpdu_len, struct sms *out)
+gboolean sms_decode(const unsigned char *pdu, size_t len, gboolean outgoing,
+			size_t tpdu_len, struct sms *out)
 {
 	unsigned char type;
-	int offset = 0;
+	size_t offset = 0;
 
 	if (out == NULL)
 		return FALSE;
@@ -2394,7 +2396,7 @@ static gboolean sms_assembly_extract_address(const char *straddr,
 {
 	unsigned char pdu[12];
 	long len;
-	int offset = 0;
+	size_t offset = 0;
 
 	if (decode_hex_own_buf(straddr, -1, &len, 0, pdu) == NULL)
 		return FALSE;
@@ -2405,7 +2407,7 @@ static gboolean sms_assembly_extract_address(const char *straddr,
 gboolean sms_address_to_hex_string(const struct sms_address *in, char *straddr)
 {
 	unsigned char pdu[12];
-	int offset = 0;
+	size_t offset = 0;
 
 	if (sms_encode_address_field(in, FALSE, pdu, &offset) == FALSE)
 		return FALSE;
diff --git a/src/smsutil.h b/src/smsutil.h
index 2da1aaf3d2b7..2c1c7d2e5965 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -413,13 +413,13 @@ static inline unsigned char bit_field(unsigned char oct, int start, int num)
 	return (oct >> start) & mask;
 }
 
-void extract_bcd_number(const unsigned char *buf, int len, char *out);
+void extract_bcd_number(const unsigned char *buf, size_t len, char *out);
 void encode_bcd_number(const char *number, unsigned char *out);
 
-gboolean sms_decode(const unsigned char *pdu, int len, gboolean outgoing,
-			int tpdu_len, struct sms *out);
+gboolean sms_decode(const unsigned char *pdu, size_t len, gboolean outgoing,
+			size_t tpdu_len, struct sms *out);
 
-gboolean sms_decode_unpacked_stk_pdu(const unsigned char *pdu, int len,
+gboolean sms_decode_unpacked_stk_pdu(const unsigned char *pdu, size_t len,
 					struct sms *out);
 
 gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
@@ -431,22 +431,22 @@ gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
  */
 #define DECLARE_SMS_ADDR_STR(a) char a[25]
 
-gboolean sms_decode_address_field(const unsigned char *pdu, int len,
-					int *offset, gboolean sc,
+gboolean sms_decode_address_field(const unsigned char *pdu, size_t len,
+					size_t *offset, gboolean sc,
 					struct sms_address *out);
 
 gboolean sms_encode_address_field(const struct sms_address *in, gboolean sc,
-					unsigned char *pdu, int *offset);
+					unsigned char *pdu, size_t *offset);
 
 guint8 sms_decode_semi_octet(guint8 in);
 
-gboolean sms_decode_scts(const unsigned char *pdu, int len,
-				int *offset, struct sms_scts *out);
+gboolean sms_decode_scts(const unsigned char *pdu, size_t len,
+				size_t *offset, struct sms_scts *out);
 
 gboolean sms_encode_scts(const struct sms_scts *in, unsigned char *pdu,
-				int *offset);
+				size_t *offset);
 
-int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
+size_t sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 
 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
 
diff --git a/src/stkutil.c b/src/stkutil.c
index d73cf1505e92..8c47b25037fa 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1026,7 +1026,7 @@ static bool parse_dataobj_datetime_timezone(
 {
 	struct sms_scts *scts = user;
 	const uint8_t *data;
-	int offset = 0;
+	size_t offset = 0;
 
 	if (comprehension_tlv_iter_get_length(iter) != 7)
 		return false;
@@ -4690,7 +4690,7 @@ static bool build_dataobj_datetime_timezone(struct stk_tlv_builder *tlv,
 {
 	const struct sms_scts *scts = data;
 	uint8_t value[7];
-	int offset = 0;
+	size_t offset = 0;
 	uint8_t tag = STK_DATA_OBJECT_TYPE_DATETIME_TIMEZONE;
 
 	if (scts->month == 0 && scts->day == 0)
-- 
2.47.0

