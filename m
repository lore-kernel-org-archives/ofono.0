Content-Type: multipart/mixed; boundary="===============5737243111495137157=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] mbim: add an optional TEMP_FAILURE_RETRY macro copy
Date: Thu, 23 May 2019 18:20:30 -0700
Message-ID: <20190524012030.28913-1-raj.khem@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5737243111495137157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes build on musl which does not provide this macro

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 drivers/mbimmodem/mbim-private.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mbimmodem/mbim-private.h b/drivers/mbimmodem/mbim-priv=
ate.h
index e159235..51693ea 100644
--- a/drivers/mbimmodem/mbim-private.h
+++ b/drivers/mbimmodem/mbim-private.h
@@ -21,6 +21,15 @@
 =

 #define align_len(len, boundary) (((len)+(boundary)-1) & ~((boundary)-1))
 =

+#ifndef TEMP_FAILURE_RETRY
+#define TEMP_FAILURE_RETRY(expression) ({     \
+  __typeof(expression) __result;              \
+  do {                                        \
+    __result =3D (expression);                  \
+  } while (__result =3D=3D -1 && errno =3D=3D EINTR); \
+  __result; })
+#endif
+
 enum mbim_control_message {
 	MBIM_OPEN_MSG =3D 0x1,
 	MBIM_CLOSE_MSG =3D 0x2,
-- =

2.21.0


--===============5737243111495137157==--

