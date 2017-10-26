Content-Type: multipart/mixed; boundary="===============4118888256115258966=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gatchat: Removed unused GAtPPP field
Date: Thu, 26 Oct 2017 20:42:56 +0300
Message-ID: <1509039776-25064-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4118888256115258966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 5144084..4a80b4b 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -40,7 +40,6 @@
 #include "crc-ccitt.h"
 #include "ppp.h"
 =

-#define DEFAULT_MRU	1500
 #define DEFAULT_MTU	1500
 =

 #define PPP_ADDR_FIELD	0xff
@@ -66,7 +65,6 @@ struct _GAtPPP {
 	struct ppp_chap *chap;
 	struct ppp_pap *pap;
 	GAtHDLC *hdlc;
-	gint mru;
 	gint mtu;
 	char username[256];
 	char password[256];
@@ -830,7 +828,6 @@ static GAtPPP *ppp_init_common(gboolean is_server, guin=
t32 ip)
 	ppp->fd =3D -1;
 =

 	/* set options to defaults */
-	ppp->mru =3D DEFAULT_MRU;
 	ppp->mtu =3D DEFAULT_MTU;
 =

 	/* initialize the lcp state */
-- =

1.9.1


--===============4118888256115258966==--

