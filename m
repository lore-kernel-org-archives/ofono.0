Content-Type: multipart/mixed; boundary="===============2356286426987300379=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 3/7] udevng/gobi: log which iface is missing to succeed
 detection
Date: Mon, 01 May 2017 22:52:52 +0200
Message-ID: <20170501205256.4205-3-lynxis@fe80.eu>
In-Reply-To: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2356286426987300379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index e8b800c1..4d928d02 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -224,8 +224,15 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

-	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
+	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL) {
+		if (!qmi)
+			DBG("mandatory qmi interface missing");
+		if (!mdm)
+			DBG("mandatory mdm interface missing");
+		if (!net)
+			DBG("mandatory net interface missing");
 		return FALSE;
+	}
 =

 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

-- =

2.12.2


--===============2356286426987300379==--

