Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBF2727FC
	for <ofono@lists.linux.dev>; Sat, 28 Feb 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270256; cv=none; b=M6uOIeiEwvXCATqVFF5B14mqElwLwk2ZU1cZe+BWJd9ZHj+bWvPvJmOgyADY3YWhZJoT7JtZvF3hGmRtpmJpAv5WF0iBkuj0b/GiraxGwSu6j90FRZdN4b3KaOIO/HVt/wIQ+jLk41YGQRvOhdxLifWoSR5MewPqnuZ5TAScevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270256; c=relaxed/simple;
	bh=aPbKK3RugRrmFfuR6QB1gJMtmItJ8h02mPhGccLzrMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=j8GWepeEA/kgiUXFnUkAep+PZQQkGVgq5w80w7unx7RBORpPa8Q1/GSMKNruGmdrPvuN4R+PUQYYStb8nSQF6oejuzQHNUU5ekq0/buuI5DNk2rxGIz6LGb4uM9za2NAEnGh4ZX1PK10mfcJNQgfXyjWcEty/SpRdh531L3pU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id DCE59113850; Sat, 28 Feb 2026 04:17:34 -0500 (EST)
Received: from 5400 (unknown [172.56.160.155])
	by spindle.queued.net (Postfix) with ESMTPSA id 7E6D2113828;
	Sat, 28 Feb 2026 04:17:34 -0500 (EST)
Date: Sat, 28 Feb 2026 04:17:32 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Cc: jbb.prv@gmx.de
Subject: [PATCH phonesim 3/3] Make configure script detect and enable Qt6 if
 available
Message-ID: <20260228041732.346c5b16@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
In-Reply-To: <20260228041213.45bc0030@5400>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

From: Andres Salomon <dilinger@queued.net>

We also bump the C++ standard up to C++17.
---
 configure.ac | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index ec40d8c..fd8d9fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -26,17 +26,25 @@ AC_ARG_ENABLE(optimization, AS_HELP_STRING([--disable-optimization],
 	fi
 ])
 
-PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus [Qt5Widgets >= 5.10],
-				dummy=yes, AC_MSG_ERROR(Qt5 is required))
+PKG_CHECK_MODULES(QT6, Qt6Core Qt6Gui Qt6Xml Qt6Network Qt6Qml Qt6DBus Qt6Core5Compat [Qt6Widgets >= 6.0.0], AC_SUBST(QT6_ENABLED, "yes"),
+	[PKG_CHECK_MODULES(QT5, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus [Qt5Widgets >= 5.10], dummy=yes, AC_MSG_ERROR(Qt5 is required))]
+)
 
 # Needed for qOverload
-CXXFLAGS="$CXXFLAGS --std=gnu++14"
-
-AC_SUBST(QT_CFLAGS)
-AC_SUBST(QT_LIBS)
-
-AC_MSG_CHECKING(for Qt5 host_bins)
-PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt5Core, host_bins)
+CXXFLAGS="$CXXFLAGS --std=gnu++17"
+
+AC_SUBST(QT_CFLAGS, "${QT5_CFLAGS} ${QT6_CFLAGS}")
+AC_SUBST(QT_LIBS, "${QT6_LIBS} ${QT5_LIBS}")
+
+AS_IF([test "x$QT6_ENABLED" = "xyes"], [
+	# Try for Qt6
+	AC_MSG_CHECKING(for Qt6 host_bins)
+	PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt6Core, libexecdir)
+], [
+	# Try for Qt5
+	AC_MSG_CHECKING(for Qt5 host_bins)
+	PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt5Core, host_bins)
+])
 AC_SUBST(QMAKE_PATH_HOST_BINS)
 AC_MSG_RESULT($QMAKE_PATH_HOST_BINS)
 
-- 
2.51.0

