Content-Type: multipart/mixed; boundary="===============1641700384753068665=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] ppp: do not allow mtu > 1500 to be set
Date: Thu, 22 Apr 2010 14:22:56 -0700
Message-ID: <1271971376-9938-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1641700384753068665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index fc1f9fb..53d62fa 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -53,7 +53,7 @@ void ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
 	struct ifreq ifr;
 	int sock;
 =

-	if (net =3D=3D NULL)
+	if (net =3D=3D NULL || mtu >=3D MAX_PACKET)
 		return;
 =

 	net->mtu =3D mtu;
-- =

1.6.6.1


--===============1641700384753068665==--

