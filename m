Content-Type: multipart/mixed; boundary="===============1431083097140271828=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH] gprs: Deactivate old contexts on attach
Date: Mon, 04 Apr 2016 18:11:48 +0200
Message-ID: <1459786308-11511-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1431083097140271828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some cases it is possible that a context is opened after a detach
event has been received, and right before an attach, depending on the
modem. We make sure that those contexts are removed to keep
consistency.
---
 src/gprs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 3acb412..3a4a819 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1624,6 +1624,12 @@ static void gprs_attached_update(struct ofono_gprs *=
gprs)
 		release_active_contexts(gprs);
 		gprs->bearer =3D -1;
 	} else if (have_active_contexts(gprs) =3D=3D TRUE) {
+		/*
+		 * Some times the context activates after a detach event and
+		 * right before an attach. We close it to avoid unexpected open
+		 * contexts.
+		 */
+		release_active_contexts(gprs);
 		gprs->flags |=3D GPRS_FLAG_ATTACHED_UPDATE;
 		return;
 	}
-- =

2.5.0


--===============1431083097140271828==--

