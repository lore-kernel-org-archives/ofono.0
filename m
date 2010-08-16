Content-Type: multipart/mixed; boundary="===============5580359860454563042=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v3 7/7] plugins/ste: Use SOCK_STREAM for CAIF and enable
 interface specification.
Date: Mon, 16 Aug 2010 22:35:49 +0200
Message-ID: <1281990950-21705-7-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281990950-21705-6-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5580359860454563042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 plugins/modem.conf  |    5 +++++
 plugins/modemconf.c |    1 +
 plugins/ste.c       |   20 +++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/plugins/modem.conf b/plugins/modem.conf
index 66bf932..b577114 100644
--- a/plugins/modem.conf
+++ b/plugins/modem.conf
@@ -44,3 +44,8 @@
 #[n900]
 #Driver=3Dn900modem
 #Interface=3Dphonet0
+
+# Sample STE modem
+#[ste]
+#Interface=3DcfttyS0
+#Driver=3Dste
diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 3747cd9..d7b1354 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -138,6 +138,7 @@ static struct {
 	{ "g1",		set_device	},
 	{ "wavecom",	set_device	},
 	{ "ste",	set_device	},
+	{ "ste",	set_interface	},
 	{ "calypso",	set_device	},
 	{ "palmpre",	set_device	},
 	{ "isimodem",	set_interface	},
diff --git a/plugins/ste.c b/plugins/ste.c
index 5a71945..e737bbb 100644
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


--===============5580359860454563042==--

