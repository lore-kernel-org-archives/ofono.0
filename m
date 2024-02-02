Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB512C7F6
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914503; cv=none; b=ObTrkFYM5PXXU85nQa5iP2shBT+Bj/rlDFc/RAn9aRxxclcjaLaJU5bFLiIWVlwbhqu9w+Rfy7tRT1vUPtNhcJxJBbAvi1xz5agIsVETxVc0nyb3iPNqBHhAU8GDjmIVeUkMncIl0teKpXEi6DtEFSNwScaKptkYUSMoqmtazoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914503; c=relaxed/simple;
	bh=ZMMiTVdeQnHJAS/8QiGXwXAUWm/ilJKLjB6UX/sx1cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qApLbTQAobjxT567jq3WVgWuzh5xZ4+LhJ/CRwP0yQsBbis44AvF+x8BtV+DmfK9iMGX1jGWlALVScrYq8tKjvc5vZnGRWoyCo19rHt/YKf4XNKvdXTiRwFlj+YXnlW77iRs/EO0iFuLxaPiwNDE8x8esI46qeuvIANYiq4SG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY37KFBL; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY37KFBL"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e12db57fedso519942a34.1
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914500; x=1707519300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKMDcWb7/Hz1o/SS9+fE6kkkILRaJrotU8QEBL553Vg=;
        b=CY37KFBLwHE8ux6RRPPmjHTwZUeP0M6BdqfREB7TCIXGVzNpy/r29sCoNhFz+6WiGQ
         nu/Hxcb2BL5OXkI4MfFs6Zgg4qJVdLLK+2IbGhiC3E4LEEzwJEO9kRbh6ZHI0oItJhOa
         XmJZK96876ns5jN4UaxAx/9LWVLgLBQwVGJYBNTsePh59XAEDY0gsrx20GhUCQddylqx
         thYeVnHX5l1wK2g5hwkM+txsgVlTZvlaONxmpd8BNYrTmE1lQt1RFvpFQkDsDW0Td7qN
         qmqL77sRYeRxnt62s+CwnxtY5DgSFRi4ez9nH2VUsNVSwhP6SKEpbAYroFvPuPMoxjuM
         Z8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914500; x=1707519300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKMDcWb7/Hz1o/SS9+fE6kkkILRaJrotU8QEBL553Vg=;
        b=D+61NZGWgp5GkN8YVGmFbVb3RPHn2RTKVBy3YsO3VRF+scy8D826nzD0hxTWuTd5HB
         Yzdx7zevAwjiffKAfmitE4viobUAACYzHZ/5hgYlqvk1OyqIZpWjDeAXxYA9rmJ6t3Pk
         hH5TsksRLdU2HzyVbmujD3ApxsElgtTzMzU4215hrJJh69LytvzOFtowJiqwODniX/G2
         WBfCvYAUjkonlTcGJ32cCGFdjy9BY8vXUpUDoizO7mH/BftSYMBwXl65UKxn5UwTWfn5
         v/84UGDWr8vj/zkITfnF3N5+zLLc8ZUUWxbk/3VqO/D7lMf4F1lqB4SVv3KTDnCcDD5v
         8+ZQ==
X-Gm-Message-State: AOJu0YwrB4EjGE6KzXCYpMZVAacaUZaDglA0SRCw4I2AD6CHfzsmtiRA
	CYOxRp33bHcWnjUfxXByeF5F9+KgFyXh+uTc17Ef/3uT8Yfb3Qmtjwelft7+
X-Google-Smtp-Source: AGHT+IFYc5xeb/xW8I+2p4VbImf+4SsWkcA4tzj9XNxkJy+rJ8Yp/unKZiyzQBK29raxSukY+ZFvVQ==
X-Received: by 2002:a9d:6e85:0:b0:6e1:3531:549b with SMTP id a5-20020a9d6e85000000b006e13531549bmr31525otr.0.1706914500402;
        Fri, 02 Feb 2024 14:55:00 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:00 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 09/18] common: Drop GLib use from gprs_proto_to_string
Date: Fri,  2 Feb 2024 16:53:41 -0600
Message-ID: <20240202225405.993792-9-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
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

