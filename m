Content-Type: multipart/mixed; boundary="===============3615040374743378744=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] gatchat: Print error message if opening tun failes
Date: Fri, 24 Aug 2012 14:16:39 +0200
Message-ID: <1345810599-22871-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3615040374743378744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

This is a very common misstake. Let's help the users to
configure their system correctly.
---
Hi,

I was not able to find out why the check in at_grps_context_prope() does not
hit when the tun module is not loaded. Therefore, this on gets only
an RFC state...

cheers,
daniel

 gatchat/ppp_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 1609b99..813ed9b 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -155,8 +155,12 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
 	if (fd < 0) {
 		/* open a tun interface */
 		fd =3D open("/dev/net/tun", O_RDWR);
-		if (fd < 0)
+		if (fd < 0) {
+			ppp_debug(ppp, "Couldn't open tun device. "
+					"Do you run oFono as root and do you "
+					"have the TUN module loaded?");
 			goto error;
+		}
 =

 		ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
 		strcpy(ifr.ifr_name, "ppp%d");
-- =

1.7.12.rc1.16.g05a20c8


--===============3615040374743378744==--

