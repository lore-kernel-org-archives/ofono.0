Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB439FFB
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922440; cv=none; b=OWsZLw7+dyVKvVhZwGDB6/9suJD74rMMSpd3oBTF4/dmEzlq4F8PvAqKb+7eJklPUeWvNflFuul+t3PGs9qJbq0VBY3eUt+MPcf0MzaKELXQUKCv7P+5diNPX1siM7gi3nPIuTE4x/0WA4aUdtyUB4TBFCLlMcmX6PgAqFy7fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922440; c=relaxed/simple;
	bh=p8euwUjQHn5I/P71ymsg8AYSca4ABkhXAqeuNgOep9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcTZ7uM/bj+tq220ZAALrbjYr6xDE22sGRuG3d3jGYrFRObfV5smzOsuuO/3TRLUrZAkaO5DHmGrd/gSxHEs9DfiONAjKQUKs88gV2imVJTK87dL9SIzoboA01uSv206X7rSFShtfmvIOAb9R3P+tJa8UrNe1QAwBHlqaLTfwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMfz3eSC; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMfz3eSC"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24ca079af98so675137fac.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716922438; x=1717527238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9UIYlPrYhmQms74vgQcbaaF5tDKCbhmeuZBRpPdmKQ=;
        b=kMfz3eSCk8V2b2DxU3ZzgOrCsj05DdbQs4eevA5f/6jdMBxald5xK2HA1f2Z7beava
         uv49tECz58u5UbKFgFgr5BdP6lpAuo0PGl9N0EJyjlMxKCm4hnhV8+1uMqBENjYlUVg9
         MnCToAvBEtYr2YuOBv4WzzI5jW+5UBYCyQoiQOel7vVRLmDHfI3AsL4pyp8Zp1v2F20f
         DVRgHVE70Jf+xiy/+wNFIwM/QXDmVPllDl+zoLEO49atPo+uW9OMqGQfHkmT/fbWXuze
         mDDsxllc0KEhemxsM0JqYv8sQjIhK/3ky77wfh2mcT2mu2v1LtN6NwcWQswsp+l78tOx
         oQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716922438; x=1717527238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9UIYlPrYhmQms74vgQcbaaF5tDKCbhmeuZBRpPdmKQ=;
        b=uQbUuq7PlNCFvDn3Ta8e9oknESpwa4mglr/tAbWiV23dBcxO2NpfbEi4cSI+FWw7wX
         iUqPzIXtA+deJPTFpB0P79kGIsaCdNDYEd9VqaFf5aX3+smlllwUJqjpGnBdkXybfOzY
         LpcswyaXpsZS0TcVK5qC0qx+FC2baVZB0CmRJ9/ZVe+AEzSrPkSstIAbtK2B0GtV09B0
         NU0sqbRcYHzhLihxjHVsYbR7qdM9KOSf+GnXAaVd0MDSrd1cDrxWGLK6h8UDQPhJgLa1
         +NhsRDaWJ0CsAJdSwzpv8NV4ye8ZEJz0RovgGvJDU0Ls0YFSfj7B0bi5W5ZBVW0BRRkd
         IWxw==
X-Gm-Message-State: AOJu0YwbQriQcjL8IjVDPPwoAxkWsQi7lg9KQm3YZj8d/Qufj9WLyMy5
	Mn0wTt5w7xmu9BM8SB8vrSxDqyCKT0zjTtYE4zbqMOKjYjFEkMaL1fqMvA==
X-Google-Smtp-Source: AGHT+IFHSfpcsBOpvaeSAmCUgWv0/91x8B+hngTq0/DxcX6Wzi6AGhBjJxypecaP/qb7ZCZb2dNIiw==
X-Received: by 2002:a05:6870:4207:b0:24f:d9de:3bf9 with SMTP id 586e51a60fabf-24fd9de3d3emr10099617fac.47.1716922438331;
        Tue, 28 May 2024 11:53:58 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24fd7c50c37sm1933625fac.18.2024.05.28.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:53:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] log: Use l_basename instead of basename
Date: Tue, 28 May 2024 13:53:36 -0500
Message-ID: <20240528185354.224680-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528185354.224680-1-denkenz@gmail.com>
References: <20240528185354.224680-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/log.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index fdfad362cfd1..4348f1be6191 100644
--- a/src/log.c
+++ b/src/log.c
@@ -28,13 +28,14 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <string.h>
 #include <syslog.h>
 #ifdef HAVE_BACKTRACE
 #include <execinfo.h>
 #endif
 #include <dlfcn.h>
 
+#include <ell/ell.h>
+
 #include "ofono.h"
 
 static const char *program_exec;
@@ -309,7 +310,7 @@ int __ofono_log_init(const char *program, const char *debug,
 	signal_setup(signal_handler);
 #endif
 
-	openlog(basename(program), option, LOG_DAEMON);
+	openlog(l_basename(program), option, LOG_DAEMON);
 
 	syslog(LOG_INFO, "oFono version %s", VERSION);
 
-- 
2.45.0

