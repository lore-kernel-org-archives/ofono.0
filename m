Content-Type: multipart/mixed; boundary="===============8391499190891286905=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: deattach driver when gprs status indicates unregistered
Date: Tue, 17 Sep 2019 23:48:07 +0200
Message-ID: <20190917214807.19663-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8391499190891286905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In the same way as we consider the driver attached when the
gprs status indicates we are registered, we should consider
it deattached when the status indicates unregistration.

If we don't, then we would not always recover from the case
when deattaching the driver fails. We would just revert back
the driver attached status to true, and "ignore" if the status
indicates the opposite when we check the registration status
afterwards.
---
 src/gprs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index de172979..c7b181f5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2568,12 +2568,6 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 =

 	gprs->status =3D status;
 =

-	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-		gprs_attached_update(gprs);
-		return;
-	}
-
 	/*
 	 * If we're already taking action, e.g. attaching or detaching, then
 	 * ignore this notification for now, we will take appropriate action
@@ -2582,6 +2576,12 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 	if (gprs->flags & GPRS_FLAG_ATTACHING)
 		return;
 =

+	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
+		ofono_gprs_detached_notify(gprs);
+		return;
+	}
+
 	/* We registered without being powered */
 	if (gprs->powered =3D=3D FALSE)
 		goto detach;
-- =

2.20.1


--===============8391499190891286905==--

