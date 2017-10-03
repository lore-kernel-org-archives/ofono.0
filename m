Content-Type: multipart/mixed; boundary="===============4358111587732782101=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/5] aes: small module for AES128
Date: Tue, 03 Oct 2017 09:32:35 -0700
Message-ID: <1507048360-15441-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507048360-15441-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4358111587732782101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A new module with AES128 functionality using kernel crypto
APIs. SimAuth module requires AES128 for UMTS authenticate
command.
---
 src/aes.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/aes.h |  32 +++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 src/aes.c
 create mode 100644 src/aes.h

diff --git a/src/aes.c b/src/aes.c
new file mode 100644
index 0000000..921ec79
--- /dev/null
+++ b/src/aes.c
@@ -0,0 +1,121 @@
+/*************************************************************************=
***
+**
+** This file is part of the Qt Extended Opensource Package.
+**
+** Copyright (C) 2017  Intel Corporation. All rights reserved.
+**
+** This file may be used under the terms of the GNU General Public License
+** version 2.0 as published by the Free Software Foundation and appearing
+** in the file LICENSE.GPL included in the packaging of this file.
+**
+** Please review the following information to ensure GNU General Public
+** Licensing requirements will be met:
+**     http://www.fsf.org/licensing/licenses/info/GPLv2.html.
+**
+**
+**************************************************************************=
**/
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/socket.h>
+#include <alloca.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "aes.h"
+
+#ifndef AF_ALG
+#define AF_ALG	38
+#define PF_ALG	AF_ALG
+#endif
+
+#ifndef HAVE_LINUX_IF_ALG_H
+struct sockaddr_alg {
+    uint16_t    salg_family;
+    uint8_t     salg_type[14];
+    uint32_t    salg_feat;
+    uint32_t    salg_mask;
+    uint8_t     salg_name[64];
+};
+
+#define ALG_SET_KEY     1
+#define ALG_SET_OP      3
+#define ALG_OP_ENCRYPT  1
+#else
+#include <linux/if_alg.h>
+#endif
+
+#ifndef SOL_ALG
+#define SOL_ALG 279
+#endif
+
+bool aes_encrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+        uint8_t *out, size_t len)
+{
+    uint32_t op =3D ALG_OP_ENCRYPT;
+    char *msg_buf;
+    size_t msg_size;
+    struct msghdr msg;
+    struct cmsghdr *c_msg;
+    ssize_t result;
+
+    struct sockaddr_alg sa =3D {
+            .salg_family =3D AF_ALG,
+            .salg_type =3D "skcipher",
+            .salg_name =3D "ecb(aes)"
+    };
+
+    struct iovec iov =3D {
+            .iov_base =3D (void *) in,
+            .iov_len =3D len
+    };
+
+    int sock =3D socket(AF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+    if (bind(sock, (struct sockaddr *)&sa, sizeof(sa))) {
+        close(sock);
+        return 0;
+    }
+    if (setsockopt(sock, SOL_ALG, ALG_SET_KEY, key, key_len)) {
+        close(sock);
+        return 0;
+    }
+
+    int cipher =3D accept4(sock, NULL, 0, SOCK_CLOEXEC);
+    if (cipher =3D=3D -1) {
+        close(sock);
+        return 0;
+    }
+    close(sock);
+
+    msg_size =3D CMSG_SPACE(sizeof(op));
+
+    msg_buf =3D alloca(msg_size);
+
+    memset(msg_buf, 0, msg_size);
+    memset(&msg, 0, sizeof(msg));
+
+    msg.msg_iov =3D &iov;
+    msg.msg_control =3D msg_buf;
+    msg.msg_controllen =3D msg_size;
+    msg.msg_iovlen =3D 1;
+
+    c_msg =3D CMSG_FIRSTHDR(&msg);
+    c_msg->cmsg_level =3D SOL_ALG;
+    c_msg->cmsg_type =3D ALG_SET_OP;
+    c_msg->cmsg_len =3D CMSG_LEN(sizeof(op));
+    memcpy(CMSG_DATA(c_msg), &op, sizeof(op));
+
+    result =3D sendmsg(cipher, &msg, 0);
+    if (result < 0) {
+        return 0;
+    }
+
+    result =3D read(cipher, out, len);
+    if (result < 0) {
+        return 0;
+    }
+
+    return 1;
+}
+
diff --git a/src/aes.h b/src/aes.h
new file mode 100644
index 0000000..278e0cc
--- /dev/null
+++ b/src/aes.h
@@ -0,0 +1,32 @@
+/*************************************************************************=
***
+**
+** This file is part of the Qt Extended Opensource Package.
+**
+** Copyright (C) 2017  Intel Corporation. All rights reserved.
+**
+** This file may be used under the terms of the GNU General Public License
+** version 2.0 as published by the Free Software Foundation and appearing
+** in the file LICENSE.GPL included in the packaging of this file.
+**
+** Please review the following information to ensure GNU General Public
+** Licensing requirements will be met:
+**     http://www.fsf.org/licensing/licenses/info/GPLv2.html.
+**
+**
+**************************************************************************=
**/
+
+#ifndef CIPHER_H
+#define CIPHER_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+bool aes_encrypt(const uint8_t *key, size_t key_len, const uint8_t *in,
+        uint8_t *out, size_t len);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* CIPHER_H */
-- =

2.7.4


--===============4358111587732782101==--

