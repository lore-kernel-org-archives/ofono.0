Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C58762CE
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649748; cv=none; b=Km+cEeKozRKkmflfQR+XWjQTPijwVbE+NOXb4nHsxYzOPryj5Vs1lK+dkb14AUqORkPf7Wrm6KzKndgBKqfGd2Snfb3/rnWEd/CA3SlINSTX2rGyzPbLpnJ3LbdCmyejhn/xzKiZIb1yIX4ORCTJt7qtr8xrm3Kn/MIcdGyPscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649748; c=relaxed/simple;
	bh=qNc3Wp33P3lSTcU0kj7FRg41RP3A3W0tLQ/un102U/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/eBZWeLwEppr01k7p5SG4pnHuPCAC4cNDmJaCFNUTVV33ghESkGdZAeKHF6ivDrfyjt8cGXr8fQCr3IQBtMvvJlfxtLTVcP8mXLZ4S0V5z91tjBUD60DzE86JBClXe/i8b6qCypkPzyqs4SNujyjSacPHXSXw4YsquaidHkTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdtBdkC6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdtBdkC6"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214ca209184so1995958fac.1
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649746; x=1707254546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcCKwqfJOURxSpC+fkwQR4gkkhDdnHZ6bLx/qbhv6Ek=;
        b=FdtBdkC6++tQcN+PQBf0MzZgGkIMkj4Dv7Oh3bcHChLEwynrWMSDiG4ByxPSa4PCFG
         XJ82CwCFJs581f+pS94iiqfs1tbk5RDbdISerm3yVK4t/upOUpcxzLHvONamIMa+n0HD
         7q9BU7gWgJn2kUT/vCrW1co+4dEaAeJNoWQIvLdK+uRapXeqBT4XMm5F4qRCtHFdeO7X
         0TpKFmxHmlAJ0eKUbLX1tlg+8vXufxzxAxLSGjB0xsldurspmXhYd91ecoamGa9YdjG4
         8LnqblN8mhH7hj4fnHhqbTQhlaQsbzj7nZQahRXe4GsC+W3ajY8o20k588yEbApb9Smb
         gsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649746; x=1707254546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcCKwqfJOURxSpC+fkwQR4gkkhDdnHZ6bLx/qbhv6Ek=;
        b=sFu8JuUEONzpVC2Hunk8ClyerHkzzT12kzv7sOa6wGnHUvir40p63HF5o+s94XdSJT
         Gj0dLkZ1tqmOrsMqRspMEkWJrQf8gaZ6stVm8h+nii+6TgR4RaUEUis9B3ev3exQqMmp
         3rkFZgIpB6y+7PgOnKp4IhLhBVVp+gQLBy8ZE7Vw6aOqve7amwTTHBUCdNrhQC4GCrzm
         bpwo80rTmIom/MHLRCrVGnkXrMesRHuW/xNIEIydxAFULO+hgtWzfnsY3yT+L5HUFIcN
         pZDa6bLok0lhV2K6ieBkkOvZTM7FsirbJ6VEpPtYJtutvD+fuD6JUNyLu2TQ+pIMsvvT
         kPkw==
X-Gm-Message-State: AOJu0YxsIL59uqp5tyOR5ZRNrubmBuqK2FOoPUkSez8NMNZAabp+T3Gl
	oeszFuB84J9lctZ1bAvGFHjre+zn+Kpay1Y8omzWjYzQEzj5HtVezakYdwJb
X-Google-Smtp-Source: AGHT+IGyRT46+CNoqtunqNjByujf+tQh4cOcuOh71Au64u10ssmUj3GWFFiQ4WC9lc490OWHRxtybA==
X-Received: by 2002:a05:6870:51e:b0:210:9bd3:ad86 with SMTP id j30-20020a056870051e00b002109bd3ad86mr11368941oao.41.1706649745808;
        Tue, 30 Jan 2024 13:22:25 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:25 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/17] build: Only enable backtrace(3) in maintainer mode
Date: Tue, 30 Jan 2024 15:21:07 -0600
Message-ID: <20240130212137.814082-2-denkenz@gmail.com>
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

