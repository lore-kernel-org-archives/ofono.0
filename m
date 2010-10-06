Content-Type: multipart/mixed; boundary="===============1501100974603752150=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ussd-mmi PATCH 2/4] Check stk requests in __ofono_voicecall_is_busy()
Date: Wed, 06 Oct 2010 17:52:17 +0300
Message-ID: <1286376739-20677-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286376739-20677-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1501100974603752150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Return true if a call is being dialed by stk.

Use __ofono_voicecall_is_busy() in __ofono_voicecall_dial().
---
 src/voicecall.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 2833e64..e072be8 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2171,7 +2171,7 @@ int ofono_voicecall_get_next_callid(struct ofono_voic=
ecall *vc)
 ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
 					enum ofono_voicecall_interaction type)
 {
-	if (vc->pending)
+	if (vc->pending || vc->dial_req)
 		return TRUE;
 =

 	switch (type) {
@@ -2272,7 +2272,7 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 			vc->driver->release_all_active =3D=3D NULL)
 		return -ENOSYS;
 =

-	if (vc->dial_req || vc->pending)
+	if (__ofono_voicecall_is_busy(vc, interaction) =3D=3D TRUE)
 		return -EBUSY;
 =

 	/*
@@ -2293,11 +2293,6 @@ int __ofono_voicecall_dial(struct ofono_voicecall *v=
c,
 =

 	vc->dial_req =3D req;
 =

-	if (__ofono_voicecall_is_busy(vc, interaction) =3D=3D TRUE) {
-		dial_request_finish(vc, FALSE);
-		return -EBUSY;
-	}
-
 	switch (interaction) {
 	case OFONO_VOICECALL_INTERACTION_NONE:
 		dial_request(vc);
-- =

1.7.0.4


--===============1501100974603752150==--

