Content-Type: multipart/mixed; boundary="===============5781750375448740924=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] atmodem: CGDCONT handling for cid 0
Date: Fri, 27 Sep 2019 12:16:32 +0530
Message-ID: <1569566792-2914-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5781750375448740924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added handling for cid 0 in +CGDCONT callback.
---
 drivers/atmodem/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 16f4927..defbba0 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -240,7 +240,7 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult *=
result,
 		return;
 	}
 =

-	cids =3D l_uintset_new(activated_cid);
+	cids =3D l_uintset_new_from_range(0,activated_cid);
 =

 	l_uintset_put(cids, activated_cid);
 =

-- =

1.9.1


--===============5781750375448740924==--

