Content-Type: multipart/mixed; boundary="===============7823673162637904462=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/2] network/ofono_netreg_status_notify: debug log the lac and
 ci
Date: Sat, 27 Apr 2019 16:16:48 +0200
Message-ID: <20190427141649.12587-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7823673162637904462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index ae3175d4a7e9..19e7e7824067 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1351,8 +1351,8 @@ void ofono_netreg_status_notify(struct ofono_netreg *=
netreg, int status,
 	if (netreg =3D=3D NULL)
 		return;
 =

-	DBG("%s status %d tech %d", __ofono_atom_get_path(netreg->atom),
-							status, tech);
+	DBG("%s status %d tech %d lac %d ci %d",
+	    __ofono_atom_get_path(netreg->atom), status, tech, lac, ci);
 =

 	if (netreg->status !=3D status) {
 		struct ofono_modem *modem;
-- =

2.21.0


--===============7823673162637904462==--

