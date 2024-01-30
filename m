Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFF762FC
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649752; cv=none; b=KgTLSYHtlCxB8sJCnx9KAbcZP0AU+pGaUQODM5KEoxSgHtSEVmL1mBw8OHowwDr0/ycQ7e1A4nC6Uv+R6wWM2XzdPVkG5AFcSkCNLljdGZXAkLiyhdBO1l3ZD9lwq8FBk4jb82TX0W8sc+ZqOEjpEkgdKcsJvJLr97P9VKwQFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649752; c=relaxed/simple;
	bh=ZMMiTVdeQnHJAS/8QiGXwXAUWm/ilJKLjB6UX/sx1cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkeM5xiZQXgx6gsX8v2MnNhhPnQUiUf3SViYvWeHzdQSGSGzUpQSxGW8O93qWs/EtYJzrqAC6Rugb5wJgrjkAvLlWXQx+z3whpJ7H8LzT0AVQvZSbOyt/U4qHAmPuX3kxNsdtVZv+1t7KVJKoGABwKeAEDophyl28EpZf4YYXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gro0NLmZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gro0NLmZ"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21433afcc53so2446042fac.3
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649749; x=1707254549; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKMDcWb7/Hz1o/SS9+fE6kkkILRaJrotU8QEBL553Vg=;
        b=Gro0NLmZFWk2lHtoMC3v1A1VS2OQXPRzjvsYr5V3QiakAe0Dghcv9OSRwgCfkFPvIj
         Nm4ZNRJRCOvsWER3Egy+KfWTToN939GvH4/nyeddBwBh6GVolGasj/sxgR5qF0OLy8tP
         p977aw/EV/dCBnidsuXIjCcH5MBgRCANnbDzrEreYGkqEtI7U73Ve1zWdcIxL4/SI1Ix
         HlfOSuyeAW8kPkqfnyNos/Ye0M75Kt+R0bFDJL3qICI5Yan2qbqwchVV80WTh+9kHpjZ
         Dsos4K/yybDrhEbLJx7WKjIepEPnJK49ddmoQHDSiy8OB02lvuTIWkofk3kf0I796b1W
         Ucqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649749; x=1707254549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKMDcWb7/Hz1o/SS9+fE6kkkILRaJrotU8QEBL553Vg=;
        b=mrw1y6EpTRzSNDhYD2etc0+T0CrZJMJIjNRsHSzZ2JgDxmsvyXKRy2y2OK8F62hkWR
         EQ5LdznvdBYYgzWzZhy62cvZz4bQwCJxAg1RWZcOjKaF+z+gi2WyTj6lCVk9rNhwXF1i
         K4P1kswg03mF10/cvwIyys5Y/bcPkvfL3Tg1r5nH3Pje9Asx+8BP7SwJDGXwIE1yCLpJ
         QhCbpqoHPC1E2kdMsCOVt79Yn5Aba1qV/gb+3/deyWEbYB29qYn2ILwXAsDMcuI3T3Zn
         qmWqv2IsiXIQZ+FxT1nB7UQFv/XbfOgBeSKfhiE8YIR9Q0250RdBnJgQ7PkCAWVAbUcK
         okCw==
X-Gm-Message-State: AOJu0YxlRBdqmvdGxUXNJ12ZtqPT2ht+HwdRAbAUVoUt/SZhO5A/WiMp
	EgObuGE1VPRiX3dUNVkiCpORWLSRZWITrSnpr/iGWfGWHc9EeCr3XzwoLHvc
X-Google-Smtp-Source: AGHT+IF7zngx9hZxXPU1ZtHsbt1iGMA0bHYvW/+zgCvoL0K4PUUGKmY3nSPPMT3OwI7MSMZct2iBqQ==
X-Received: by 2002:a05:6870:d693:b0:218:449a:9c6b with SMTP id z19-20020a056870d69300b00218449a9c6bmr7162282oap.15.1706649749476;
        Tue, 30 Jan 2024 13:22:29 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:29 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/17] common: Drop GLib use from gprs_proto_to_string
Date: Tue, 30 Jan 2024 15:21:13 -0600
Message-ID: <20240130212137.814082-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor this function to use bool from stdbool.h as well as drop usage
of GLib in favor of ell.
---
 src/common.c | 16 ++++++++--------
 src/common.h |  2 +-
 src/gprs.c   |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/common.c b/src/common.c
index 79094ee4906c..abb151b6e8a1 100644
--- a/src/common.c
+++ b/src/common.c
@@ -778,19 +778,19 @@ const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth)
 	return NULL;
 }
 
-gboolean gprs_auth_method_from_string(const char *str,
+bool gprs_auth_method_from_string(const char *str,
 					enum ofono_gprs_auth_method *auth)
 {
-	if (g_str_equal(str, "chap")) {
+	if (l_streq0(str, "chap")) {
 		*auth = OFONO_GPRS_AUTH_METHOD_CHAP;
-		return TRUE;
-	} else if (g_str_equal(str, "pap")) {
+		return true;
+	} else if (l_streq0(str, "pap")) {
 		*auth = OFONO_GPRS_AUTH_METHOD_PAP;
-		return TRUE;
-	} else if (g_str_equal(str, "none")) {
+		return true;
+	} else if (l_streq0(str, "none")) {
 		*auth = OFONO_GPRS_AUTH_METHOD_NONE;
-		return TRUE;
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
diff --git a/src/common.h b/src/common.h
index 779de7278446..bfbf2cff0437 100644
--- a/src/common.h
+++ b/src/common.h
@@ -189,5 +189,5 @@ const char *gprs_proto_to_string(enum ofono_gprs_proto proto);
 bool gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto);
 
 const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth);
-gboolean gprs_auth_method_from_string(const char *str,
+bool gprs_auth_method_from_string(const char *str,
 					enum ofono_gprs_auth_method *auth);
diff --git a/src/gprs.c b/src/gprs.c
index 3eb7df83ac54..dbf9b0605b7c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1201,7 +1201,7 @@ static DBusMessage *pri_set_auth_method(struct pri_context *ctx,
 	GKeyFile *settings = ctx->gprs->settings;
 	enum ofono_gprs_auth_method auth;
 
-	if (gprs_auth_method_from_string(str, &auth) == FALSE)
+	if (!gprs_auth_method_from_string(str, &auth))
 		return __ofono_error_invalid_format(msg);
 
 	if (ctx->context.auth_method == auth)
@@ -3183,7 +3183,7 @@ static gboolean load_context(struct ofono_gprs *gprs, const char *group)
 	if (authstr == NULL)
 		authstr = g_strdup("chap");
 
-	if (gprs_auth_method_from_string(authstr, &auth) == FALSE)
+	if (!gprs_auth_method_from_string(authstr, &auth))
 		goto error;
 
 	if (strlen(password) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
-- 
2.43.0

