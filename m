Content-Type: multipart/mixed; boundary="===============5940367824551903621=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] gatppp: Check ppp instance before unref it
Date: Tue, 06 Jul 2010 17:57:37 +0800
Message-ID: <1278410258-3077-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5940367824551903621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 1d41ded..d9b1627 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -446,6 +446,9 @@ void g_at_ppp_unref(GAtPPP *ppp)
 {
 	gboolean is_zero;
 =

+	if (ppp =3D=3D NULL)
+		return;
+
 	is_zero =3D g_atomic_int_dec_and_test(&ppp->ref_count);
 =

 	if (is_zero =3D=3D FALSE)
-- =

1.6.3.3


--===============5940367824551903621==--

