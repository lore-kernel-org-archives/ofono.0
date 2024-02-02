Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13F126F22
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914502; cv=none; b=DmbRNulli93bAlO6VhzB+eogPjovn8qGirY/+ymMDQbKnic2MGC2zetNQkT+VETiSUqm3mCC/etlcmK2AVedOMkzMq5V+1UL32kBXgq/EJjapoOd7JOEUyODH0rRNr5sqEWlIcMvpNxRx1zCgak8Hka7pBW1XKlEac9mwjxtoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914502; c=relaxed/simple;
	bh=Ngatuek6+l25zNh0xP6q04ZFRNN40k61978NO7LmAp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1bYjFrCsHQ1EmLCqskLpbLDn81asK1MJB6JRdQmN6DKqHRceZVks9z+1BOdQ85iCIGb4dlwTK4pgirMZpYgdj8bWPbuTUgrvcBpdf+Vr6vfOBZ3eux6vfr6sWAcP9NByGx6F85rEKUo+CdrwQPBblB05xv9Awkzle51gddq190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjy3Rqro; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjy3Rqro"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1952033a34.0
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914499; x=1707519299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IAtEmaXu1T49urJjbCViXJjnctMYSLnV5sU6xtoewQ=;
        b=mjy3Rqrow2wnOUxJTR6N2NYEA+ouXHsE+FIdW+jesiYkAs7kmYgxj3psW7LNp3XZdD
         OweAzPKMQG1EJXMzSRCtlVbH4H05BL0VvT+S6ENVlxfRoO15D04iNf7nk9vouSJ1oqX6
         qRSh9bzPnx9yOQwQYivRG8eZNlZEgI4qahWWrfGX4AEy33Hoh195ZW+DZ9ANnifFW4DL
         I5ooXi+91ctpprK5rqTcg8qqq59c7UqYL5vblc3GIWX+z7JEu+rV84vljGiLZoRoFJIA
         XY2SrG7FkpvSVfRv+Olo9zgfHAxwLTEXYcGYMTa8E/beFV33IjwOh8M/AtW8vhSMgNH5
         sgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914499; x=1707519299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IAtEmaXu1T49urJjbCViXJjnctMYSLnV5sU6xtoewQ=;
        b=o05geIGOUhriHS3Vgthk2MnlHglsnm0qdMb+zr28Tz1waxtEI0qneB9I4BFxEJlJb4
         s7MvNKjK4gHrhwW8/FHqkwmPeD/EwjrhST1ClF/mHxQ2yzYbH8sfxrtNgSj2rs5T6BKa
         LR0wcIlcPMqMotDEuVnl3cw+9t1gYB44LiAD4rcq9WaZGju32c+pHD+3LJkYtMGookGk
         B5Iz3ILqfk2KdqCP9nDNN7zMd2px4LMziHIafraETE3TutoCoZ7AeYPBTC8J8dUrWqQv
         fnJMrqt0yeLz9rgTKulMsdk+GUJbLxQbETNmmGHQiajdPKvIRdJ05AGVVV5yEKYhjy2H
         s4NQ==
X-Gm-Message-State: AOJu0YySFC3o+m5LQc0F47cQOOgbb/HLw06a9KcX8P36GymCJVuPGY1y
	6Yq8KH1b199T5OFOG55CgPTT1/EjLuYH381VRF34KIWsPZYSETkWv36KwWB1
X-Google-Smtp-Source: AGHT+IHlWoZ0g/Q2Nb+9t5i20tWp75nsjeKHUMQ4yBE6SNgYLfpT/YQD7Uoyy1oi7nuzXRRIgiCzEw==
X-Received: by 2002:a05:6830:44c:b0:6dd:e0fc:258f with SMTP id d12-20020a056830044c00b006dde0fc258fmr7887113otc.5.1706914499612;
        Fri, 02 Feb 2024 14:54:59 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/18] common: Drop GLib use from gprs_auth_proto_to_string
Date: Fri,  2 Feb 2024 16:53:40 -0600
Message-ID: <20240202225405.993792-8-denkenz@gmail.com>
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

