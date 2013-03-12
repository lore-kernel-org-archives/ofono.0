Content-Type: multipart/mixed; boundary="===============6733044001514877853=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 07/15] core: Add bt_str2ba() to bluetooth.h
Date: Tue, 12 Mar 2013 09:42:05 -0300
Message-ID: <1363092133-1092-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6733044001514877853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a utility Bluetooth function to convert Bluetooth
address from string to bdaddr_t.
---
 src/bluetooth.h       | 8 ++++++++
 src/handsfree-audio.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/bluetooth.h b/src/bluetooth.h
index 1584109..af6f02c 100644
--- a/src/bluetooth.h
+++ b/src/bluetooth.h
@@ -69,3 +69,11 @@ static inline int bt_bacmp(const bdaddr_t *ba1, const bd=
addr_t *ba2)
 {
 	return memcmp(ba1, ba2, sizeof(bdaddr_t));
 }
+
+static inline void bt_str2ba(const char *str, bdaddr_t *ba)
+{
+	int i;
+
+	for (i =3D 5; i >=3D 0; i--, str +=3D 3)
+		ba->b[i] =3D strtol(str, NULL, 16);
+}
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 1e636cc..c11c325 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -26,6 +26,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
-- =

1.7.11.7


--===============6733044001514877853==--

