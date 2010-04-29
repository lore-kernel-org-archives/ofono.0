Content-Type: multipart/mixed; boundary="===============1670163706651245274=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: fix return of drop_packet for NETWORK phase
Date: Thu, 29 Apr 2010 16:25:50 -0700
Message-ID: <1272583550-5791-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1670163706651245274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index f200ae7..2446d4e 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -89,7 +89,7 @@ static inline gboolean ppp_drop_packet(GAtPPP *ppp, guint=
16 protocol)
 	case PPP_PHASE_DEAD:
 		return TRUE;
 	case PPP_PHASE_NETWORK:
-		if (ppp->net =3D=3D NULL)
+		if (ppp->net =3D=3D NULL && protocol =3D=3D PPP_IP_PROTO)
 			return TRUE;
 		break;
 	}
-- =

1.6.6.1


--===============1670163706651245274==--

