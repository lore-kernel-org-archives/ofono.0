Content-Type: multipart/mixed; boundary="===============2286376651707980087=="
MIME-Version: 1.0
From: caiwen.zhang@intel.com
Subject: [PATCH] Fix modem doesn't auto register to network issue
Date: Thu, 12 Sep 2013 01:33:47 +0800
Message-ID: <1378920827-6086-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2286376651707980087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Caiwen Zhang <caiwen.zhang@intel.com>

Some modem may return registration status whitch is out of the range
(0-5). it will cause the modem don't auto register to network when
network atom initializes.
---
 src/network.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index d1bfca6..a1e317d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1481,9 +1481,9 @@ static void init_registration_status(const struct ofo=
no_error *error,
 	}
 =

 	if (netreg->mode !=3D NETWORK_REGISTRATION_MODE_MANUAL &&
-		(status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED ||
-			status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
-			status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)) {
+		(status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_SEARCHING &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING)) {
 		if (netreg->driver->register_auto !=3D NULL)
 			netreg->driver->register_auto(netreg, init_register,
 							netreg);
-- =

1.7.9.5


--===============2286376651707980087==--

