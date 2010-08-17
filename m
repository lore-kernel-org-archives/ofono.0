Content-Type: multipart/mixed; boundary="===============7704764132575349510=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 7/8] plugins/ste: Use SOCK_STREAM for CAIF and enable
 interface specification.
Date: Tue, 17 Aug 2010 14:22:33 +0200
Message-ID: <1282047754-15562-8-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7704764132575349510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ste.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 16ddbe1..479d85c 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <net/if.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -171,14 +172,31 @@ static int ste_enable(struct ofono_modem *modem)
 	if (!device) {
 		struct sockaddr_caif addr;
 		int err;
+		const char *interface;
 =

 		/* Create a CAIF socket for AT Service */
-		fd =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
+		fd =3D socket(AF_CAIF, SOCK_STREAM, CAIFPROTO_AT);
 		if (fd < 0) {
 			ofono_error("Failed to create CAIF socket for AT");
 			return -EIO;
 		}
 =

+		/* Bind CAIF socket to specified interface */
+		interface =3D ofono_modem_get_string(modem, "Interface");
+		if (interface) {
+			struct ifreq ifreq;
+			memset(&ifreq, 0, sizeof(ifreq));
+			strcpy(ifreq.ifr_name, interface);
+			err =3D setsockopt(fd, SOL_SOCKET,
+					SO_BINDTODEVICE, &ifreq, sizeof(ifreq));
+			if (err < 0) {
+				ofono_error("Failed to bind caif socket "
+					"to interface");
+				close(fd);
+				return err;
+			}
+		}
+
 		memset(&addr, 0, sizeof(addr));
 		addr.family =3D AF_CAIF;
 		addr.u.at.type =3D CAIF_ATTYPE_PLAIN;
-- =

1.6.3.3


--===============7704764132575349510==--

