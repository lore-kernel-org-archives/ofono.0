Content-Type: multipart/mixed; boundary="===============5358654936688758335=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] stk: Fix sizeof on memcpy
Date: Wed, 22 May 2013 20:01:47 -0300
Message-ID: <1369263708-19011-1-git-send-email-lucas.demarchi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5358654936688758335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

src/stk.c: In function =E2=80=98__ofono_cbs_sim_download=E2=80=99:
src/stk.c:283:45: error: argument to =E2=80=98sizeof=E2=80=99 in =E2=80=98m=
emcpy=E2=80=99 call is the
same expression as the source; did you mean to dereference it?
[-Werror=3Dsizeof-pointer-memaccess]
  memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
                                               ^
---
 src/stk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/stk.c b/src/stk.c
index 7974751..01c95b5 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -280,7 +280,7 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, co=
nst struct cbs *msg)
 =

 	e.type =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
 	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
-	memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
+	memcpy(&e.cbs_pp_download.page, msg, sizeof(*msg));
 =

 	err =3D stk_send_envelope(stk, &e, stk_cbs_download_cb,
 				ENVELOPE_RETRIES_DEFAULT);
-- =

1.8.2.3


--===============5358654936688758335==--

