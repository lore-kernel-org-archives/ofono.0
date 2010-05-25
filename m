Content-Type: multipart/mixed; boundary="===============3981357987761588318=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 2/4] Fix: set correct local address for phonet on PCs.
Date: Tue, 25 May 2010 23:37:05 +0300
Message-ID: <1274819827-27993-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274819827-27993-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3981357987761588318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/usbpnmodem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/usbpnmodem.c b/plugins/usbpnmodem.c
index e1ce4fd..68beb6f 100644
--- a/plugins/usbpnmodem.c
+++ b/plugins/usbpnmodem.c
@@ -69,7 +69,7 @@ static void usbpn_status_cb(GIsiModem *idx,
 		return;
 	}
 =

-	error =3D g_pn_netlink_set_address(idx, PN_DEV_SOS);
+	error =3D g_pn_netlink_set_address(idx, PN_DEV_PC);
 	if (error && error !=3D -EEXIST) {
 		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
 		return;
-- =

1.6.3.3


--===============3981357987761588318==--

