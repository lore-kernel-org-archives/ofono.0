Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83875FF19
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838575; cv=none; b=F4qOCDoMrJ+iRqREcwBVI+/OECrsYhDZZ7ux9qq3OBZAUJbrwxEhlp7tRxBtSIExWJ3svcXykqJWrsEnaA9wZ2frzjeNYoqgIOVMyeEAmNfjI9ifrF97TLxAi0825UfTGiU+I+qms8IstEjLClUaODsORYS723dsDZIYz3NIovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838575; c=relaxed/simple;
	bh=51KlFVjVQQBgV3dUwrvr6pRVrkInm1p0OJThcE4BxXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgxz/djGlHojR5BMgeGGFfoXCJiPnYuCo0CiwKPS7PuOgNAntIIMBOyTTL6hR022XDT03o86AXjbM2c5u55aqz/9o7pqCWI6VkriEc8IAJcg5fZf5Rj/rzWpHjJygqoZRZilR12mkBAF0OZNyYHzru2NwgnwTlrX5IZWaosYx6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NijWO2kM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NijWO2kM"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21922481a2fso3205298fac.0
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838572; x=1708443372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KU8714d1Ytb8k6N+teFTUslr4KoUAjWHuKOPRIzJEs=;
        b=NijWO2kMKUZmcyR9UT5kiPa6ouuvsipFU+LlDAx2tqpvTLUjS3fQRChTvb51Yk4DEL
         B0lJRGyFjFNVNtV5Y+7S7nZ3MYHf/kmPzm/jo/X6qhJdVGOy4O7hstdrrix74B04awth
         z7+oxwG9dPvECNALf4OaWYvgzr6nhzoOBrJ49sTBfzRG8xRLZ5cNnEujEvBacAA36TCX
         ce40EPQmty/L5WkDdPP64Q1qJj4t14eHgyMp6fAEl4a0LHG5tKQQmAEst69cxwBSwG0H
         W5EkJWXAdzpg0hJK+nqaOLmVpyrgpPasc6faWLyCHSXUaRxTBWffs5XYTadShIVSIxNR
         Nzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838572; x=1708443372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KU8714d1Ytb8k6N+teFTUslr4KoUAjWHuKOPRIzJEs=;
        b=j4tk9huzTn1MtRRVSDSaPH4CuEz/QTDSBP8bjxRCbisfKYCb37JS5tlFoHvgUGR7OE
         oRoR5T8b6TvVjgJFOUeRrBvGSyQ9ivmuWt+BPHQUpgiS5sXY/lJgnKICOzsq628TIno2
         WI5tydk07EfafQGBC5Qr6XQ3r/4Cu+2ELmh3txKXXPNKiVF9HizWTzFT5DF0MfNMKiuQ
         YUObuHj+4i9OwHrBU/3ouZrzoY3wrCRLuBOsUUhRiOU9mixKHQPNp6x/8d9G6/396BF1
         kKJTlZdgPL5El1IsaWPq/gpkbpat65LIwo4BP8X0/N3BMMjX3kOefgh03lFagmm+dcdG
         UMxg==
X-Gm-Message-State: AOJu0Yyw61ZcTOfj2enWjS/melJFBH8C3oDx4JwMdFrC1QUAyGMG5M12
	xpWnfSvwjxsHry2SJ0bpsBFbD6muxKSuN3fr3Cgvpzzz4eQgzluW8pKpYZlK
X-Google-Smtp-Source: AGHT+IFZ7dqSrvmnjUZ17l4pGTW8vnXpPU8OUMRsDfvJOzdtBv1JzKOKIDAtTPhabLNYl4NucYMaEQ==
X-Received: by 2002:a05:6870:4723:b0:219:3054:3ea5 with SMTP id b35-20020a056870472300b0021930543ea5mr10147385oaq.45.1707838572595;
        Tue, 13 Feb 2024 07:36:12 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:12 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] smsutil: Move iso639_2_from_language to util
Date: Tue, 13 Feb 2024 09:35:06 -0600
Message-ID: <20240213153524.1085649-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213153524.1085649-1-denkenz@gmail.com>
References: <20240213153524.1085649-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also while here, convert to using stdbool instead of gboolean
---
 src/sim.c     |   2 +-
 src/smsutil.c | 111 --------------------------------------------------
 src/smsutil.h |  27 +-----------
 src/util.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h    |  26 ++++++++++++
 5 files changed, 140 insertions(+), 137 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 55ff5f448647..fedd000923b9 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2211,7 +2211,7 @@ static GSList *parse_eflp(const unsigned char *eflp, int length)
 	GSList *ret = NULL;
 
 	for (i = 0; i < length; i++) {
-		if (iso639_2_from_language(eflp[i], code) == FALSE)
+		if (!iso639_2_from_language(eflp[i], code))
 			continue;
 
 		ret = g_slist_prepend(ret, g_strdup(code));
diff --git a/src/smsutil.c b/src/smsutil.c
index f46507f00e1c..d4f28c01bd79 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3937,117 +3937,6 @@ gboolean cbs_extract_app_port(const struct cbs *cbs, int *dst, int *src,
 	return extract_app_port_common(&iter, dst, src, is_8bit);
 }
 
-gboolean iso639_2_from_language(enum cbs_language lang, char *iso639)
-{
-	switch (lang) {
-	case CBS_LANGUAGE_GERMAN:
-		iso639[0] = 'd';
-		iso639[1] = 'e';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_ENGLISH:
-		iso639[0] = 'e';
-		iso639[1] = 'n';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_ITALIAN:
-		iso639[0] = 'i';
-		iso639[1] = 't';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_FRENCH:
-		iso639[0] = 'f';
-		iso639[1] = 'r';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_SPANISH:
-		iso639[0] = 'e';
-		iso639[1] = 's';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_DUTCH:
-		iso639[0] = 'n';
-		iso639[1] = 'l';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_SWEDISH:
-		iso639[0] = 's';
-		iso639[1] = 'v';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_DANISH:
-		iso639[0] = 'd';
-		iso639[1] = 'a';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_PORTUGESE:
-		iso639[0] = 'p';
-		iso639[1] = 't';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_FINNISH:
-		iso639[0] = 'f';
-		iso639[1] = 'i';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_NORWEGIAN:
-		iso639[0] = 'n';
-		iso639[1] = 'o';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_GREEK:
-		iso639[0] = 'e';
-		iso639[1] = 'l';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_TURKISH:
-		iso639[0] = 't';
-		iso639[1] = 'r';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_HUNGARIAN:
-		iso639[0] = 'h';
-		iso639[1] = 'u';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_POLISH:
-		iso639[0] = 'p';
-		iso639[1] = 'l';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_CZECH:
-		iso639[0] = 'c';
-		iso639[1] = 's';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_HEBREW:
-		iso639[0] = 'h';
-		iso639[1] = 'e';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_ARABIC:
-		iso639[0] = 'a';
-		iso639[1] = 'r';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_RUSSIAN:
-		iso639[0] = 'r';
-		iso639[1] = 'u';
-		iso639[2] = '\0';
-		return TRUE;
-	case CBS_LANGUAGE_ICELANDIC:
-		iso639[0] = 'i';
-		iso639[1] = 's';
-		iso639[2] = '\0';
-		return TRUE;
-	default:
-		iso639[0] = '\0';
-		break;
-	}
-
-	return FALSE;
-}
-
 char *cbs_decode_text(GSList *cbs_list, char *iso639_lang)
 {
 	GSList *l;
diff --git a/src/smsutil.h b/src/smsutil.h
index 01487de4b67c..5389757c309c 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -19,6 +19,8 @@
  *
  */
 
+enum cbs_language;
+
 #define CBS_MAX_GSM_CHARS 93
 #define SMS_MSGID_LEN 20
 
@@ -196,30 +198,6 @@ enum sms_pid_type {
 	SMS_PID_TYPE_USIM_DOWNLOAD = 0x7f,
 };
 
-enum cbs_language {
-	CBS_LANGUAGE_GERMAN = 0x0,
-	CBS_LANGUAGE_ENGLISH = 0x1,
-	CBS_LANGUAGE_ITALIAN = 0x2,
-	CBS_LANGUAGE_FRENCH = 0x3,
-	CBS_LANGUAGE_SPANISH = 0x4,
-	CBS_LANGUAGE_DUTCH = 0x5,
-	CBS_LANGUAGE_SWEDISH = 0x6,
-	CBS_LANGUAGE_DANISH = 0x7,
-	CBS_LANGUAGE_PORTUGESE = 0x8,
-	CBS_LANGUAGE_FINNISH = 0x9,
-	CBS_LANGUAGE_NORWEGIAN = 0xA,
-	CBS_LANGUAGE_GREEK = 0xB,
-	CBS_LANGUAGE_TURKISH = 0xC,
-	CBS_LANGUAGE_HUNGARIAN = 0xD,
-	CBS_LANGUAGE_POLISH = 0xE,
-	CBS_LANGUAGE_UNSPECIFIED = 0xF,
-	CBS_LANGUAGE_CZECH = 0x20,
-	CBS_LANGUAGE_HEBREW = 0x21,
-	CBS_LANGUAGE_ARABIC = 0x22,
-	CBS_LANGUAGE_RUSSIAN = 0x23,
-	CBS_LANGUAGE_ICELANDIC = 0x24
-};
-
 enum cbs_geo_scope {
 	CBS_GEO_SCOPE_CELL_IMMEDIATE,
 	CBS_GEO_SCOPE_PLMN,
@@ -576,7 +554,6 @@ gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
 			enum sms_charset *charset, gboolean *compressed,
 			enum cbs_language *language, gboolean *iso639);
 
-gboolean iso639_2_from_language(enum cbs_language lang, char *iso639);
 gboolean cbs_decode(const unsigned char *pdu, int len, struct cbs *out);
 gboolean cbs_encode(const struct cbs *cbs, int *len, unsigned char *pdu);
 gboolean cbs_extract_app_port(const struct cbs *cbs, int *dst, int *src,
diff --git a/src/util.c b/src/util.c
index 627be7eec097..0a5212a2bca4 100644
--- a/src/util.c
+++ b/src/util.c
@@ -3753,3 +3753,114 @@ unsigned char *convert_ucs2_to_gsm(const unsigned char *text, long len,
 						GSM_DIALECT_DEFAULT,
 						GSM_DIALECT_DEFAULT);
 }
+
+bool iso639_2_from_language(enum cbs_language lang, char *iso639)
+{
+	switch (lang) {
+	case CBS_LANGUAGE_GERMAN:
+		iso639[0] = 'd';
+		iso639[1] = 'e';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_ENGLISH:
+		iso639[0] = 'e';
+		iso639[1] = 'n';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_ITALIAN:
+		iso639[0] = 'i';
+		iso639[1] = 't';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_FRENCH:
+		iso639[0] = 'f';
+		iso639[1] = 'r';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_SPANISH:
+		iso639[0] = 'e';
+		iso639[1] = 's';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_DUTCH:
+		iso639[0] = 'n';
+		iso639[1] = 'l';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_SWEDISH:
+		iso639[0] = 's';
+		iso639[1] = 'v';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_DANISH:
+		iso639[0] = 'd';
+		iso639[1] = 'a';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_PORTUGESE:
+		iso639[0] = 'p';
+		iso639[1] = 't';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_FINNISH:
+		iso639[0] = 'f';
+		iso639[1] = 'i';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_NORWEGIAN:
+		iso639[0] = 'n';
+		iso639[1] = 'o';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_GREEK:
+		iso639[0] = 'e';
+		iso639[1] = 'l';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_TURKISH:
+		iso639[0] = 't';
+		iso639[1] = 'r';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_HUNGARIAN:
+		iso639[0] = 'h';
+		iso639[1] = 'u';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_POLISH:
+		iso639[0] = 'p';
+		iso639[1] = 'l';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_CZECH:
+		iso639[0] = 'c';
+		iso639[1] = 's';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_HEBREW:
+		iso639[0] = 'h';
+		iso639[1] = 'e';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_ARABIC:
+		iso639[0] = 'a';
+		iso639[1] = 'r';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_RUSSIAN:
+		iso639[0] = 'r';
+		iso639[1] = 'u';
+		iso639[2] = '\0';
+		return true;
+	case CBS_LANGUAGE_ICELANDIC:
+		iso639[0] = 'i';
+		iso639[1] = 's';
+		iso639[2] = '\0';
+		return true;
+	default:
+		iso639[0] = '\0';
+		break;
+	}
+
+	return false;
+}
diff --git a/src/util.h b/src/util.h
index 3e7dfea3e8bc..a70fb49f7ae5 100644
--- a/src/util.h
+++ b/src/util.h
@@ -38,6 +38,30 @@ enum gsm_dialect {
 	GSM_DIALECT_URDU,
 };
 
+enum cbs_language {
+	CBS_LANGUAGE_GERMAN = 0x0,
+	CBS_LANGUAGE_ENGLISH = 0x1,
+	CBS_LANGUAGE_ITALIAN = 0x2,
+	CBS_LANGUAGE_FRENCH = 0x3,
+	CBS_LANGUAGE_SPANISH = 0x4,
+	CBS_LANGUAGE_DUTCH = 0x5,
+	CBS_LANGUAGE_SWEDISH = 0x6,
+	CBS_LANGUAGE_DANISH = 0x7,
+	CBS_LANGUAGE_PORTUGESE = 0x8,
+	CBS_LANGUAGE_FINNISH = 0x9,
+	CBS_LANGUAGE_NORWEGIAN = 0xA,
+	CBS_LANGUAGE_GREEK = 0xB,
+	CBS_LANGUAGE_TURKISH = 0xC,
+	CBS_LANGUAGE_HUNGARIAN = 0xD,
+	CBS_LANGUAGE_POLISH = 0xE,
+	CBS_LANGUAGE_UNSPECIFIED = 0xF,
+	CBS_LANGUAGE_CZECH = 0x20,
+	CBS_LANGUAGE_HEBREW = 0x21,
+	CBS_LANGUAGE_ARABIC = 0x22,
+	CBS_LANGUAGE_RUSSIAN = 0x23,
+	CBS_LANGUAGE_ICELANDIC = 0x24
+};
+
 char *convert_gsm_to_utf8(const unsigned char *text, long len, long *items_read,
 				long *items_written, unsigned char terminator);
 
@@ -105,3 +129,5 @@ unsigned char *convert_ucs2_to_gsm_with_lang(const unsigned char *text,
 unsigned char *convert_ucs2_to_gsm(const unsigned char *text, long len,
 					long *items_read, long *items_written,
 					unsigned char terminator);
+
+bool iso639_2_from_language(enum cbs_language lang, char *iso639);
-- 
2.43.0

