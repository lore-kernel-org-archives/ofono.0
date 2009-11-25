Content-Type: multipart/mixed; boundary="===============4715240832055855960=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix: Add check for register_auto method
Date: Wed, 25 Nov 2009 13:43:27 +0800
Message-ID: <1259127807-19089-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4715240832055855960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add check for register_auto method to avoid crash. HFP backend
does not provide implementation for register_auto.
---
 src/network.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 8f99490..24cb911 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1305,8 +1305,11 @@ static void init_registration_status(const struct of=
ono_error *error,
 	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO &&
 		(status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED ||
 			status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
-			status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN))
-		netreg->driver->register_auto(netreg, init_register, netreg);
+			status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)) {
+		if (netreg->driver->register_auto)
+			netreg->driver->register_auto(netreg, init_register,
+					netreg);
+	}
 }
 =

 void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h)
-- =

1.6.2.5


--===============4715240832055855960==--

