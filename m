Content-Type: multipart/mixed; boundary="===============0922019780783673958=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] gprs: fix error check of gprs_cid_alloc function
Date: Wed, 15 Feb 2017 17:54:20 +0100
Message-ID: <20170215165421.30121-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0922019780783673958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On huawei E3372, context id can be 0:
AT+CGDCONT=3D?
+CGDCONT: (0-31),"IP",,,(0-2),(0-3),(0,1),(0,1),(0-2),(0,1)
+CGDCONT: (0-31),"IPV6",,,(0-2),(0-3),(0,1),(0,1),(0-2),(0,1)
+CGDCONT: (0-31),"IPV4V6",,,(0-2),(0-3),(0,1),(0,1),(0-2),(0,1)
+CGDCONT: (0-31),"PPP",,,(0-2),(0-3),(0,1),(0,1),(0-2),(0,1)

OK
During first time activation, gprs_cid_alloc (and idmap_alloc)
will return 0 as context id. This is not an error.

Christophe Ronco (1):
  gprs: fix error check of gprs_cid_alloc function

 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- =

2.11.0


--===============0922019780783673958==--

