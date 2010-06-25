Content-Type: multipart/mixed; boundary="===============8641235217860985768=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 02/23] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Fri, 25 Jun 2010 16:15:24 -0700
Message-ID: <bae960413a408d22e3f6818ae710d051a99a1425.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8641235217860985768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

These have been stolen from the Linux kernel source; come pretty handy
to make build-time consistency checks and thus avoid run-time
surprises.
---
 src/util.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/util.h b/src/util.h
index 9da81aa..b972120 100644
--- a/src/util.h
+++ b/src/util.h
@@ -80,3 +80,31 @@ char *sim_string_to_utf8(const unsigned char *buffer, in=
t length);
 =

 unsigned char *utf8_to_sim_string(const char *utf,
 					int max_length, int *out_length);
+/*
+ * Build time consistency checks
+ *
+ * Stolen from the Linux kernel 2.6.35-rc; as most taken from the
+ * Linux kernel, this is licensed GPL v2 or newer.
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
+ * End of code stolen from the Linux kernel 2.6.35-rc. From now, code
+ * is GPL v2 only.
+ */
-- =

1.6.6.1


--===============8641235217860985768==--

