Content-Type: multipart/mixed; boundary="===============4802235814058450757=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 5/6] emulator: Set local and remote address of card
Date: Wed, 24 Apr 2013 14:13:50 -0300
Message-ID: <1366823631-26262-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4802235814058450757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit extracts local and remote address from the socket and
stores them into the card.
---
 src/emulator.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 4d5e835..6acf384 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -23,11 +23,15 @@
 #include <config.h>
 #endif
 =

+#include <stdlib.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
 =

 #include <glib.h>
+#include <sys/socket.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/handsfree-audio.h>
@@ -37,6 +41,7 @@
 #include "hfp.h"
 #include "gatserver.h"
 #include "gatppp.h"
+#include "bluetooth.h"
 =

 #define RING_TIMEOUT 3
 =

@@ -1002,11 +1007,50 @@ struct ofono_emulator *ofono_emulator_create(struct=
 ofono_modem *modem,
 	return em;
 }
 =

+static int card_set_local_remote(struct ofono_handsfree_card *card, int fd)
+{
+	struct sockaddr_rc saddr;
+	socklen_t optlen;
+	char local[18], remote[18];
+	int err;
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+
+	if (getsockname(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getsockname: %s (%d)", strerror(err), err);
+		return -err;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, local);
+
+	DBG("local %s", local);
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+
+	if (getpeername(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		err =3D errno;
+		ofono_error("RFCOMM getpeername: %s (%d)", strerror(err), err);
+		return -err;
+	}
+
+	bt_ba2str(&saddr.rc_bdaddr, remote);
+
+	DBG("remote %s", remote);
+
+	ofono_handsfree_card_set_local(card, local);
+	ofono_handsfree_card_set_remote(card, remote);
+
+	return 0;
+}
+
 int ofono_emulator_create_card(struct ofono_emulator *em, int fd, int vers=
ion)
 {
 	em->card =3D ofono_handsfree_card_create(0, NULL, NULL);
 =

-	return 0;
+	return card_set_local_remote(em->card, fd);
 }
 =

 void ofono_emulator_remove(struct ofono_emulator *em)
-- =

1.7.9.5


--===============4802235814058450757==--

