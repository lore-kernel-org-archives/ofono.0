Content-Type: multipart/mixed; boundary="===============3290740345653252188=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 03/11] Enable status report.
Date: Thu, 27 May 2010 13:54:42 +0300
Message-ID: <1274957690-4893-3-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3290740345653252188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 src/smsutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index e634764..2679cc2 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2596,7 +2596,7 @@ GSList *sms_text_prepare(const char *utf8, guint16 re=
f,
 	template.submit.rd =3D FALSE;
 	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
 	template.submit.rp =3D FALSE;
-	template.submit.srr =3D FALSE;
+	template.submit.srr =3D TRUE;
 	template.submit.mr =3D 0;
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 =

-- =

1.6.0.4


--===============3290740345653252188==--

