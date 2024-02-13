Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71F5FF1B
	for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838578; cv=none; b=QAf2GqKJuqmmKFwgS1CN7HPqYrdNFMANSgOZ9d0kLH6oO+o4Rkm+mRuSN2qYI6Ml+vOLel7lG9jl1VlxGMXBJj86nquYuNT2Gexf0xDdwcNr5BP91LWJqlr4LNedyHnjpupjGna5OPtnetBXdezDq0VZx0x7j/6p8v/8x0DoDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838578; c=relaxed/simple;
	bh=h2hJ4Ktyc2i/lCDojdXVgQqe5ggpbiZv9if2lBthzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvcPSVxPkAmsh+VvP+wppJ6LSVuflPlWZI7aOvEyDnHmKVfNLIcWi6FdIRjD1jjJJpcqVTdTDV1gQAUMsW8ttlxdj6x5v4EBocll+ZVJ81xqC6ylZINhKI+Db+DsWZuBMgXDE9n72abHb5RyQ7ZrLWtNDWvu2PRICY2KTL5EBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEq3Sdkj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEq3Sdkj"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2143a96d185so1749427fac.3
        for <ofono@lists.linux.dev>; Tue, 13 Feb 2024 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707838573; x=1708443373; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcAQYr+tce1lCp4HP52ymPttjWw9ZOyZfu3oIqmrmOU=;
        b=WEq3SdkjeQBp0mL34dkc3f06YI/eUKkLFqyMPZjfW/w8gSs+hvQq8K/sBZL9avOQ8t
         NXN2XehMh9SNZO1SSCZBQbF1tSf/+vqopZQrvUlEp35ue/2eQPRjY3WT0CgEe0ADn3dx
         U1GfmBgF6/nw+VkNwq1QCF9hA/xz3+CDfPQdujcw+i1H3M0R6XPkhmC6ycLGETHbGZM7
         klASW/EQuTR4Nzs8hznQHk7jAw1llYDCCFDzdhw5eFddhKaRkqtkTzk05hyqUl8fO+pY
         rjIVHrOyxRwQihKfcwt4OB4Ahm7zliE4eUwOG1gfVbyf3t161W4CWyXbtr2ZJKrr0liy
         SRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838573; x=1708443373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcAQYr+tce1lCp4HP52ymPttjWw9ZOyZfu3oIqmrmOU=;
        b=RfaPDMEDgWVWtiT+4T5eRXhVdGu5E8uxeSz7RWxVNuUrM5WLGofai+LzNZVZaIxU+X
         9ODFZPlvltg2f0IT1ImPtMucjFTSZKGMHrtj5xCCEIQdu79+e5AoejC4FNkxPI1uzD+i
         TRRLNtpGg4J3+7IFIvDmnz/wX+UKmjQYiuks0ero7PlOBJGD2zoF5ueCzfx+5MSY17dH
         1ZH7MeIuUe/VfQefnQFGHcycN5T2Honv/0huxwfF/Ja8Lwdn74zf6cY/7nA9QmxZes0W
         f9njMOjLhl8Qc/LpJ85PGSEACKyYy4WqhwBLZP/y5XUbkkQbLl00QNfFs0X8qh1dV4SU
         RhUQ==
X-Gm-Message-State: AOJu0YxGIZMmRcrGT24IoKaTeFocVLmwnL2y3V56aoAW7Baf3T7oPJmX
	BuTWD/mKxXLjAmpyluJ6F3Yg03ipyLt6QwdWoxGKfdLy1Vm4Et13DxWfKHsA
X-Google-Smtp-Source: AGHT+IE94GLheiLE3FzQD8Ej1CMEpuSITSz5QyEaSJpH7feT3Ksx06F1mwBzKsXLGFNkUYGr6QB7gQ==
X-Received: by 2002:a05:6870:b6a6:b0:214:2e69:c04a with SMTP id cy38-20020a056870b6a600b002142e69c04amr8884027oab.22.1707838573251;
        Tue, 13 Feb 2024 07:36:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id dx19-20020a056870769300b0021a0f032341sm1861999oab.22.2024.02.13.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:36:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] sim: Move EFli and EFlp parsers to simutil
Date: Tue, 13 Feb 2024 09:35:07 -0600
Message-ID: <20240213153524.1085649-3-denkenz@gmail.com>
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

While here, convert from using g_slist to l_strv utilities and remove
other GLib usage.
---
 src/sim.c     | 105 ++++++++++++++------------------------------------
 src/simutil.c |  62 +++++++++++++++++++++++++++++
 src/simutil.h |   3 ++
 3 files changed, 93 insertions(+), 77 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index fedd000923b9..1873eccccf2e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2181,76 +2181,33 @@ static bool sim_efli_format(const unsigned char *ef, int length)
 	return true;
 }
 
-static GSList *parse_language_list(const unsigned char *ef, int length)
+static char **concat_lang_prefs(char **a, char **b)
 {
-	int i;
-	GSList *ret = NULL;
-
-	for (i = 0; i < length; i += 2) {
-		if (ef[i] > 0x7f || ef[i+1] > 0x7f)
-			continue;
-
-		/*
-		 * ISO 639 codes contain only characters that are coded
-		 * identically in SMS 7 bit charset, ASCII or UTF8 so
-		 * no conversion.
-		 */
-		ret = g_slist_prepend(ret, g_ascii_strdown((char *)ef + i, 2));
-	}
-
-	if (ret)
-		ret = g_slist_reverse(ret);
-
-	return ret;
-}
-
-static GSList *parse_eflp(const unsigned char *eflp, int length)
-{
-	int i;
-	char code[3];
-	GSList *ret = NULL;
-
-	for (i = 0; i < length; i++) {
-		if (!iso639_2_from_language(eflp[i], code))
-			continue;
-
-		ret = g_slist_prepend(ret, g_strdup(code));
-	}
-
-	if (ret)
-		ret = g_slist_reverse(ret);
-
-	return ret;
-}
-
-static char **concat_lang_prefs(GSList *a, GSList *b)
-{
-	GSList *l, *k;
 	char **ret;
-	int i = 0;
-	int total = g_slist_length(a) + g_slist_length(b);
+	int i;
+	int j;
+	int total = l_strv_length(a) + l_strv_length(b);
 
 	if (total == 0)
 		return NULL;
 
-	ret = g_new0(char *, total + 1);
-
-	for (l = a; l; l = l->next)
-		ret[i++] = g_strdup(l->data);
-
-	for (l = b; l; l = l->next) {
-		gboolean duplicate = FALSE;
+	ret = l_new(char *, total + 1);
 
-		for (k = a; k; k = k->next)
-			if (!strcmp(k->data, l->data))
-				duplicate = TRUE;
+	for (i = 0; a && a[i]; i++)
+		ret[i] = a[i];
 
-		if (duplicate)
+	for (j = 0; b && b[j]; j++) {
+		if (l_strv_contains(a, b[j])) {
+			l_free(b[j]);
 			continue;
+		}
 
-		ret[i++] = g_strdup(l->data);
+		ret[i++] = b[j];
 	}
 
+	l_free(a);
+	l_free(b);
+
 	return ret;
 }
 
@@ -2262,22 +2219,23 @@ static void sim_efpl_read_cb(int ok, int length, int record,
 	const char *path = __ofono_atom_get_path(sim->atom);
 	DBusConnection *conn = ofono_dbus_get_connection();
 	bool efli_format = true;
-	GSList *efli = NULL;
-	GSList *efpl = NULL;
+	char **efli = NULL;
+	char **efpl = NULL;
 
 	if (!ok || length < 2)
 		goto skip_efpl;
 
-	efpl = parse_language_list(data, length);
+	efpl = sim_parse_language_list(data, length);
 
 skip_efpl:
 	if (sim->efli && sim->efli_length > 0) {
 		efli_format = sim_efli_format(sim->efli, sim->efli_length);
 
 		if (efli_format)
-			efli = parse_language_list(sim->efli, sim->efli_length);
+			efli = sim_parse_language_list(sim->efli,
+							sim->efli_length);
 		else
-			efli = parse_eflp(sim->efli, sim->efli_length);
+			efli = sim_parse_eflp(sim->efli, sim->efli_length);
 	}
 
 	/*
@@ -2293,13 +2251,14 @@ skip_efpl:
 	 */
 	if (efli_format) {
 		if (sim->efli_length >= 2 && sim->efli[0] == 0xff &&
-				sim->efli[1] == 0xff)
-			sim->language_prefs = concat_lang_prefs(NULL, efpl);
-		else
-			sim->language_prefs = concat_lang_prefs(efli, efpl);
-	} else {
+				sim->efli[1] == 0xff) {
+			l_strfreev(efli);
+			efli = NULL;
+		}
+
+		sim->language_prefs = concat_lang_prefs(efli, efpl);
+	} else
 		sim->language_prefs = concat_lang_prefs(efpl, efli);
-	}
 
 	if (sim->efli) {
 		g_free(sim->efli);
@@ -2307,14 +2266,6 @@ skip_efpl:
 		sim->efli_length = 0;
 	}
 
-	if (efli) {
-		g_slist_free_full(efli, g_free);
-	}
-
-	if (efpl) {
-		g_slist_free_full(efpl, g_free);
-	}
-
 	if (sim->language_prefs != NULL)
 		ofono_dbus_signal_array_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
diff --git a/src/simutil.c b/src/simutil.c
index 0354cafd087f..7345f38db571 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1827,3 +1827,65 @@ gboolean sim_parse_gsm_authenticate(const unsigned char *buffer, int len,
 gsm_end:
 	return FALSE;
 }
+
+char **sim_parse_language_list(const unsigned char *ef, int length)
+{
+	int i;
+	size_t n_languages = 0;
+	char **ret;
+
+	for (i = 0; i + 1 < length; i += 2) {
+		if (ef[i] > 0x7f || ef[i + 1] > 0x7f)
+			continue;
+
+		n_languages += 1;
+	}
+
+	if (!n_languages)
+		return NULL;
+
+	ret = l_new(char *, n_languages + 1);
+
+	for (i = 0, n_languages = 0; i + 1 < length; i += 2) {
+		if (ef[i] > 0x7f || ef[i + 1] > 0x7f)
+			continue;
+
+		/*
+		 * ISO 639 codes contain only characters that are coded
+		 * identically in SMS 7 bit charset, ASCII or UTF8 so
+		 * no conversion.
+		 */
+		ret[n_languages++] = l_ascii_strdown((const char *)ef + i, 2);
+	}
+
+	return ret;
+}
+
+char **sim_parse_eflp(const unsigned char *eflp, int length)
+{
+	int i;
+	char code[3];
+	char **ret;
+	size_t n_languages = 0;
+
+	for (i = 0; i < length; i++) {
+		if (!iso639_2_from_language(eflp[i], code))
+			continue;
+
+		n_languages += 1;
+	}
+
+	if (!n_languages)
+		return NULL;
+
+	ret = l_new(char *, n_languages + 1);
+
+	for (i = 0, n_languages = 0; i < length; i++) {
+		if (!iso639_2_from_language(eflp[i], code))
+			continue;
+
+		ret[n_languages++] = l_strdup(code);
+	}
+
+	return ret;
+}
diff --git a/src/simutil.h b/src/simutil.h
index fd3967ffd336..9584d4d9cd62 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -541,3 +541,6 @@ gboolean sim_parse_umts_authenticate(const unsigned char *buffer, int len,
 
 gboolean sim_parse_gsm_authenticate(const unsigned char *buffer, int len,
 		const unsigned char **sres, const unsigned char **kc);
+
+char **sim_parse_language_list(const unsigned char *ef, int length);
+char **sim_parse_eflp(const unsigned char *eflp, int length);
-- 
2.43.0

