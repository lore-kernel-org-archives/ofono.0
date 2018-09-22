Content-Type: multipart/mixed; boundary="===============3039080294798990287=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/lte.c: clarified failed registration message
Date: Sat, 22 Sep 2018 11:49:00 +0200
Message-ID: <20180922094900.13652-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3039080294798990287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lte.c b/src/lte.c
index a6d26b3c..e16d9aab 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -343,7 +343,7 @@ void ofono_lte_register(struct ofono_lte *lte)
 	const char *imsi =3D ofono_sim_get_imsi(sim);
 =

 	if (imsi =3D=3D NULL) {
-		ofono_error("No sim atom required for registering LTE atom.");
+		ofono_error("No sim atom found. It is required for registering LTE atom.=
");
 		return;
 	}
 =

-- =

2.17.1


--===============3039080294798990287==--

