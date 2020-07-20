Content-Type: multipart/mixed; boundary="===============6163877236975093397=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] rilmodem: fix typo error in netmon.c
Date: Mon, 20 Jul 2020 16:34:50 +0900
Message-ID: <20200720073450.11596-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6163877236975093397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/netmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index 7dd3a562..547ebccc 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -201,7 +201,7 @@ static int process_cellinfo_list(struct ril_msg *messag=
e,
 =

 		lac =3D (lac >=3D 0 && lac <=3D 65535) ? lac : -1;
 		cid =3D (cid >=3D 0 && cid <=3D 268435455) ? cid : -1;
-		psc =3D (psc >=3D 0 && rssi <=3D 511) ? psc : -1;
+		psc =3D (psc >=3D 0 && psc <=3D 511) ? psc : -1;
 		rssi =3D (rssi >=3D 0 && rssi <=3D 31) ? rssi : -1;
 		ber =3D (ber >=3D 0 && ber <=3D 7) ? ber : -1;
 =

-- =

2.17.1

--===============6163877236975093397==--

