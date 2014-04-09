Content-Type: multipart/mixed; boundary="===============8743672989479224347=="
MIME-Version: 1.0
From: Brian Ruptash <bruptash@gmail.com>
Subject: [PATCH] gprs: Correctly set driver_attached
Date: Wed, 09 Apr 2014 12:13:44 +0200
Message-ID: <1397038424-3410-1-git-send-email-bruptash@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8743672989479224347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It seems to me gprs->driver_attached must always be set prior to
calling gprs->driver->set_attached(), since if set_attached() fails the
callback inverts driver_attached to revert to its prior state.
---
 src/gprs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..6fffe73 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1593,8 +1593,8 @@ static void gprs_netreg_update(struct ofono_gprs *gpr=
s)
 =

 	gprs->flags |=3D GPRS_FLAG_ATTACHING;
 =

-	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
 	gprs->driver_attached =3D attach;
+	gprs->driver->set_attached(gprs, attach, gprs_attach_callback, gprs);
 }
 =

 static void netreg_status_changed(int status, int lac, int ci, int tech,
@@ -2178,6 +2178,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs=
, int status)
 =

 detach:
 	gprs->flags |=3D GPRS_FLAG_ATTACHING;
+
+	gprs->driver_attached =3D FALSE;
 	gprs->driver->set_attached(gprs, FALSE, gprs_attach_callback, gprs);
 }
 =

-- =

1.7.9.5


--===============8743672989479224347==--

