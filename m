Content-Type: multipart/mixed; boundary="===============2426157267019531566=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/2] isigen: fix phonet address initialization
Date: Mon, 01 Nov 2010 17:53:01 +0200
Message-ID: <1288626782-16009-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288626782-16009-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2426157267019531566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/isigen.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 0ea2db3..493d926 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -286,9 +286,10 @@ static int isigen_probe(struct ofono_modem *modem)
 	}
 =

 	if (address) {
-		int error =3D g_pn_netlink_set_address(idx, PN_DEV_PC);
+		int error =3D g_pn_netlink_set_address(idx, address);
 		if (error && error !=3D -EEXIST) {
 			DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+			g_pn_netlink_stop(link);
 			return -errno;
 		}
 	}
-- =

1.7.0.4


--===============2426157267019531566==--

