Content-Type: multipart/mixed; boundary="===============3801422689597106573=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: fix another hardcode of ppp_packet size
Date: Mon, 10 May 2010 15:17:22 -0700
Message-ID: <1273529842-8996-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3801422689597106573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 4e45ef1..bd1a60e 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -95,7 +95,7 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 {
 	struct ppp_net *net =3D (struct ppp_net *) userdata;
 	GIOStatus status;
-	gchar buf[MAX_PACKET + 2];
+	gchar buf[MAX_PACKET + sizeof(struct ppp_header)];
 	gsize bytes_read;
 	GError *error =3D NULL;
 	struct ppp_header *ppp =3D (struct ppp_header *) buf;
-- =

1.6.6.1


--===============3801422689597106573==--

