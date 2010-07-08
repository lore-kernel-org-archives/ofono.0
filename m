Content-Type: multipart/mixed; boundary="===============9041440965908862806=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/2] Support option --disable-optimization
Date: Thu, 08 Jul 2010 19:00:06 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731F03E5E2@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1278586639-6329-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9041440965908862806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
	Forget to mention, this patch series (2 patches) is against phonesim.

>-----Original Message-----
>From: Gu, Yang
>Sent: Thursday, July 08, 2010 6:57 PM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: [PATCH 1/2] Support option --disable-optimization
>
>---
> configure.ac |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
>
>diff --git a/configure.ac b/configure.ac
>index 887c91a..a85fda3 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -14,6 +14,13 @@ PKG_PROG_PKG_CONFIG
> AC_PROG_CXX
> AC_PROG_INSTALL
>
>+AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
>+			[disable code optimization through compiler]), [
>+	if (test "${enableval}" =3D "no"); then
>+		CXXFLAGS=3D"$CXXFLAGS -O0"
>+	fi
>+])
>+
> PKG_CHECK_MODULES(QT, QtCore QtGui QtXml QtNetwork, dummy=3Dyes,
> 						AC_MSG_ERROR(Qt is required))
> AC_SUBST(QT_CFLAGS)
>--
>1.7.0.4



Regards,
-Yang

--===============9041440965908862806==--

