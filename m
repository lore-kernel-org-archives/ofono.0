Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462385958
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914496; cv=none; b=bdzLJHouwDMTqPVraedFF82Gdkfje6oN38w/xbBcpGREFY0fs6s2nHG1f5VdnK8YYLcCIN3tlnFSAS+A0yziqs5wGGoCKFZiyb78JZVZJNqwI4R6DLWHwYMfcoC3lDI/7V6wod+igAQNfT9lubefrpJ0I+O8h8NpIJIoOAo5Hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914496; c=relaxed/simple;
	bh=qNc3Wp33P3lSTcU0kj7FRg41RP3A3W0tLQ/un102U/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soBOaZVpj1Xhici5y9O8ETzr9gRezAcNVklnroYv7IAcUAeAheY1am5nL/Yy7reJD70zGiJnvQHCH9NngmdbCTbyFnRMpyxzgxlna79q7RNn2WWXfBX0VCwDdp6FLl8AU1XspyePdCjgWPLlOPUXb6Der1uN0/PT0icPfLQuUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnE7MhUM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnE7MhUM"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1951978a34.0
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914494; x=1707519294; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcCKwqfJOURxSpC+fkwQR4gkkhDdnHZ6bLx/qbhv6Ek=;
        b=dnE7MhUM0Z7aYIy2g1L7hmIDyM9UWgi+qPTdIx4cp8pn+rPTaokVKze4xQakJuN0Q2
         a9SsatVN2wxjlOf4dMRWLw+XeAVSv+l7G2b/3fC4TOs4s4igE8RSNZjNbcwM0/gC0Acy
         u+aRQwrnxB6Yjr66FvqpmPLLwBQF/gEodk8fBjO2UO5qcj9zWy660GL/jvIOSirTJFyM
         cB8HORGrryO1Kbo+pnG/Ix/M3Q7+la5fywBf8gkA+nsajTS/S9TDxaG8XNCEmdv1o64w
         JCxxWxhtrd5t2hgkz9aakWqZmrp08vZcf+pTG/5erSOXKaWWJo/hG0x3LzLhmvS1782f
         EHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914494; x=1707519294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcCKwqfJOURxSpC+fkwQR4gkkhDdnHZ6bLx/qbhv6Ek=;
        b=RoebdPAv7hFMsDW4/ZE9EEZ7mLydSDz3iC1n5o8aL3frTaIc/y2TKrpSQwTW78HDTB
         lNTpCI1RlFggmDWSLohagVYmabKbXW329n3l1+ZEpmj7A1+0uBoh04stBDl9eJ2taxqv
         rP9EW2mzsu9KwusvDAqCz3xS/H1ziYkrx6pPfI6Zav1A4iAEJt4LQh2+cjAGnv0VYTMC
         HvNKzzBmkVaZast5GxoeXNtM00SqKziQQoWta40k78tBAh1U7b9FOv2J+TDrQJmENwiB
         CBVtNI3TiLEZnfTPkDTbKAAHApJkyeuiw37nup+Tlk68/1N03S8zbZ6R4MxX1Gwxu0PS
         HnyA==
X-Gm-Message-State: AOJu0Yx6NgRwDLa32BZX9kUr2M9RpE+Wb/kf2ZT6MX5Y9aJWJKJsbP4L
	IotD4tc83lXVLgwuGFyPbDwGxt0Vi7Yh+MGcuUriXuDS5mhcY26fAEJiTdta
X-Google-Smtp-Source: AGHT+IE9oCfk0hzAljJYcPnNN+rFigp3lt+Ju549H2XrswWuJAqJyS1wnPOa9yCE8OmV6YUgB0yYCw==
X-Received: by 2002:a9d:7c88:0:b0:6dd:e9e2:de67 with SMTP id q8-20020a9d7c88000000b006dde9e2de67mr7676960otn.20.1706914494096;
        Fri, 02 Feb 2024 14:54:54 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:53 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/18] build: Only enable backtrace(3) in maintainer mode
Date: Fri,  2 Feb 2024 16:53:34 -0600
Message-ID: <20240202225405.993792-2-denkenz@gmail.com>
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

Using backtrace() is of no use when building with PIE (which most
distro compilers do by default) and prevents catching the coredump
for later retracing, which is needed since distros usually don't
install debug symbols by default either.

This patch thus only enables backtrace() when --enable-maintainer-mode
is passed and also tries to explicitly disable PIE.

This commit is based on the following commit from 'iwd':
b6910e121082 ("build: only enable backtrace(3) in maintainer mode")
---
 configure.ac | 11 +++++++++++
 src/log.c    |  8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index c18cfa3a696f..551f863538ed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,6 +110,17 @@ AC_ARG_ENABLE(ubsan, AS_HELP_STRING([--enable-ubsan],
 AC_CHECK_FUNCS(explicit_bzero)
 AC_CHECK_FUNCS(rawmemchr)
 
+# In maintainer mode: try to build with application backtrace and disable PIE.
+if (test "${USE_MAINTAINER_MODE}" = yes); then
+	AC_SEARCH_LIBS([backtrace], [execinfo],
+		[
+			AC_DEFINE([HAVE_BACKTRACE], [1],
+				[Define to 1 if you have backtrace(3).])
+			CFLAGS="$CFLAGS -fno-PIE"
+			LDFLAGS="$LDFLAGS -no-pie"
+		])
+fi
+
 AC_CHECK_FUNC(signalfd, dummy=yes,
 			AC_MSG_ERROR(signalfd support is required))
 
diff --git a/src/log.c b/src/log.c
index b33a7d262474..a8b4ef10eaae 100644
--- a/src/log.c
+++ b/src/log.c
@@ -30,7 +30,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 #include <execinfo.h>
 #endif
 #include <dlfcn.h>
@@ -115,7 +115,7 @@ void ofono_debug(const char *format, ...)
 	va_end(ap);
 }
 
-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 static void print_backtrace(unsigned int offset)
 {
 	void *frames[99];
@@ -303,7 +303,7 @@ int __ofono_log_init(const char *program, const char *debug,
 	if (detach == FALSE)
 		option |= LOG_PERROR;
 
-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 	signal_setup(signal_handler);
 #endif
 
@@ -320,7 +320,7 @@ void __ofono_log_cleanup(void)
 
 	closelog();
 
-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 	signal_setup(SIG_DFL);
 #endif
 
-- 
2.43.0

