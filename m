Content-Type: multipart/mixed; boundary="===============3304423729322580649=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 01/20] bug.h: Add BUILD_BUG_ON() and friends for compile-time
 assert checking
Date: Fri, 23 Jul 2010 13:59:49 -0700
Message-ID: <893d62f90fda3ee868f97babb7c5063718d8283d.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3304423729322580649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

These have been stolen from the Linux kernel source; come pretty handy
to make build-time consistency checks and thus avoid run-time
surprises.
---
 src/bug.h     |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.c |    1 +
 2 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 src/bug.h

diff --git a/src/bug.h b/src/bug.h
new file mode 100644
index 0000000..07c14b9
--- /dev/null
+++ b/src/bug.h
@@ -0,0 +1,50 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+/*
+ * Build time consistency checks
+ *
+ * Copied from the Linux kernel, linux/include/linux/kernel.h
+ * v2.6.35-rc; this file has no explicit license header, thus is
+ * covered by linux/COPYING which licenses it as GPL v2 only.
+ */
+
+/* Force a compilation error if condition is true */
+#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))
+
+/* Force a compilation error if condition is constant and true */
+#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))
+
+/* Force a compilation error if a constant expression is not a power of 2 =
*/
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) =3D=3D 0 || (((n) & ((n) - 1)) !=3D 0))
+
+/* Force a compilation error if condition is true, but also produce a
+   result (of value 0 and type size_t), so the expression can be used
+   e.g. in a structure initializer (or where-ever else comma expressions
+   aren't permitted). */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
+
+/*
+ * End of code copied from linux/include/linux/kernel.h
+ * v2.6.35-rc.
+ */
diff --git a/src/smsutil.c b/src/smsutil.c
index e41c041..6c2087a 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -37,6 +37,7 @@
 #include "util.h"
 #include "storage.h"
 #include "smsutil.h"
+#include "bug.h"
 =

 #define uninitialized_var(x) x =3D x
 =

-- =

1.6.6.1


--===============3304423729322580649==--

