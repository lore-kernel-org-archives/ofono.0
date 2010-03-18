Content-Type: multipart/mixed; boundary="===============6701788087677389668=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 1/7] Barring services can only be activated/deactivated.
Date: Thu, 18 Mar 2010 16:44:25 +0200
Message-ID: <1268923471-29059-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6701788087677389668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 src/call-barring.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 2a04b25..13d625e 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -457,13 +457,13 @@ static gboolean cb_ss_control(int type, const char *s=
c,
 	switch (type) {
 	case SS_CONTROL_TYPE_ACTIVATION:
 	case SS_CONTROL_TYPE_REGISTRATION:
-		cb->ss_req_type =3D SS_CONTROL_TYPE_REGISTRATION;
+		cb->ss_req_type =3D SS_CONTROL_TYPE_ACTIVATION;
 		cb->driver->set(cb, fac, 1, sia, cls,
 				cb_ss_set_lock_callback, cb);
 		break;
 	case SS_CONTROL_TYPE_ERASURE:
 	case SS_CONTROL_TYPE_DEACTIVATION:
-		cb->ss_req_type =3D SS_CONTROL_TYPE_ERASURE;
+		cb->ss_req_type =3D SS_CONTROL_TYPE_DEACTIVATION;
 		cb->driver->set(cb, fac, 0, sia, cls,
 				cb_ss_set_lock_callback, cb);
 		break;
-- =

1.6.3.3


--===============6701788087677389668==--

