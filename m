Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F3762E1
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649751; cv=none; b=Q0pTL19NF9qcyo5+GqPorUdycX+3lwPCEUewfIJRrTuFaQySzpc7eAkx6lqtcd0AF5mmXFi8zWVrMAANTEiuwL0e6x8IYttJV/omPtNQd+pwLGfKXA+uwYiDgncoNoWboTj85ix4P6lIFpvH11yzf4IUAWO/pYChqgaZvedP0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649751; c=relaxed/simple;
	bh=Ngatuek6+l25zNh0xP6q04ZFRNN40k61978NO7LmAp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVLgmLpHqc+z5dztxhvtOe5PzYqlO6HzsR1bMWjnDaTR2cm46XrNf0WMY1aSx9+nUXAqAfcW9PdKIWjfNCtz2++cWXWMdBdXGpkpPymcAIBkVfNDKFe+sAf256edg6WwqBXHt84mwVU53KPSdgWRRvjgmjyj+bqgBEfE70nYb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAuYrjdt; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAuYrjdt"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb9b28acb4so3158054b6e.2
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649749; x=1707254549; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IAtEmaXu1T49urJjbCViXJjnctMYSLnV5sU6xtoewQ=;
        b=mAuYrjdtbLZ52SFY63GMAmBJHuvx0tdNPYXlEuuN6zq2/MrhmSl4EOf4b1XYLoPmTP
         qFQI3KSTy4liZdrB15dQYWCT8t5KhIRmvLaKPJ1T1ci8qIgtBPRHRCNm2XrddLLs6jAE
         qwSNKxdYUwNmIJL+Fegtq3dcq5rVvpvNtjy0RFaV7n8tC6futxYHNCtkX7Zo+o9qUocB
         ljWEWI6illpCt0K10BaU0LRO2RJ9VKP4Nh5H1EocWsvyxnoGEL1plryTxMzJot/b8YWv
         6Gz3tku/Mlr6hWR5lZSPd8tg3n+OJavb9dUMiIQricEILxlWYS5FKfJcTzgc6K+X6HPU
         Rq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649749; x=1707254549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IAtEmaXu1T49urJjbCViXJjnctMYSLnV5sU6xtoewQ=;
        b=hAVliCF5Z0MQm4InPLTWee0jhXzVNzk5pd00Zt+1NimT5B3VwJ3nAkBpiIuseOVCgY
         D2B57CAq5FgOtSGHGLIomcA451ovVurDxUF0Pi8r1QxzIzfbGpihP/p+OKqkhsxvCuAb
         IM0oBKSBObdEadmcEaIN0z2OeG/A/MIZ6MFT4x/+J4CTkvQQss1mq0IgtDU4MCE4DlkU
         ZvazdbZLiHwK3owJJ9U+kkZE0MTzFhenVNdMtIzk5hg+jTYrJ4qj4f51LOwJQ8INtDqP
         kN4kZv7Y2978RPaxMH/TpYiI/CCtYMCiV94W0RTqVZcLinqSrYkhhXMFtQ0ojmuIojdC
         IK8A==
X-Gm-Message-State: AOJu0YxI5d/cmER8YCivcRD89t/0Iyn0Xboe3WlREhJJCJ4gUw9z19Yx
	pajwi9e5w0lrS1VGRTMjnWmILKSof+3Q/kyQZ0mY+t1INiJ0gxG/EADO7vcS
X-Google-Smtp-Source: AGHT+IGeTHYb5JcYqTapxfiF6P9fZ9fRVSycqGXxpHpTMK5c2cugywzK65lo6FkUmYkz79Drud2HEg==
X-Received: by 2002:a05:6870:610a:b0:214:294d:7835 with SMTP id s10-20020a056870610a00b00214294d7835mr6635367oae.28.1706649748869;
        Tue, 30 Jan 2024 13:22:28 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:28 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/17] common: Drop GLib use from gprs_auth_proto_to_string
Date: Tue, 30 Jan 2024 15:21:12 -0600
Message-ID: <20240130212137.814082-7-denkenz@gmail.com>
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
 src/common.c | 15 ++++++++-------
 src/common.h |  3 ++-
 src/gprs.c   |  4 ++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/common.c b/src/common.c
index 9a55990b6435..79094ee4906c 100644
--- a/src/common.c
+++ b/src/common.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 
 #include <glib.h>
+#include <ell/ell.h>
 
 #include <ofono/types.h>
 #include <ofono/gprs-context.h>
@@ -747,20 +748,20 @@ const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
 	return NULL;
 }
 
-gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto)
+bool gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto)
 {
-	if (g_str_equal(str, "ip")) {
+	if (l_streq0(str, "ip")) {
 		*proto = OFONO_GPRS_PROTO_IP;
-		return TRUE;
-	} else if (g_str_equal(str, "ipv6")) {
+		return true;
+	} else if (l_streq0(str, "ipv6")) {
 		*proto = OFONO_GPRS_PROTO_IPV6;
-		return TRUE;
+		return true;
 	} else if (g_str_equal(str, "dual")) {
 		*proto = OFONO_GPRS_PROTO_IPV4V6;
-		return TRUE;
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
 
 const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth)
diff --git a/src/common.h b/src/common.h
index 3d30e2497ebb..779de7278446 100644
--- a/src/common.h
+++ b/src/common.h
@@ -19,6 +19,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <glib.h>
 
 #include <ofono/types.h>
@@ -185,7 +186,7 @@ gboolean is_valid_apn(const char *apn);
 const char *call_status_to_string(enum call_status status);
 
 const char *gprs_proto_to_string(enum ofono_gprs_proto proto);
-gboolean gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto);
+bool gprs_proto_from_string(const char *str, enum ofono_gprs_proto *proto);
 
 const char *gprs_auth_method_to_string(enum ofono_gprs_auth_method auth);
 gboolean gprs_auth_method_from_string(const char *str,
diff --git a/src/gprs.c b/src/gprs.c
index 7b681d850c21..3eb7df83ac54 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1087,7 +1087,7 @@ static DBusMessage *pri_set_proto(struct pri_context *ctx,
 	GKeyFile *settings = ctx->gprs->settings;
 	enum ofono_gprs_proto proto;
 
-	if (gprs_proto_from_string(str, &proto) == FALSE)
+	if (!gprs_proto_from_string(str, &proto))
 		return __ofono_error_invalid_format(msg);
 
 	if (ctx->context.proto == proto)
@@ -3162,7 +3162,7 @@ static gboolean load_context(struct ofono_gprs *gprs, const char *group)
 	if (protostr == NULL)
 		protostr = g_strdup("ip");
 
-	if (gprs_proto_from_string(protostr, &proto) == FALSE)
+	if (!gprs_proto_from_string(protostr, &proto))
 		goto error;
 
 	username = g_key_file_get_string(gprs->settings, group,
-- 
2.43.0

