Content-Type: multipart/mixed; boundary="===============8572836753808735490=="
MIME-Version: 1.0
From: Mike Brudevold <puffy.taco@gmail.com>
Subject: [PATCH] voicecall: fix release and answer existing call validation
Date: Thu, 19 Apr 2012 17:10:43 -0500
Message-ID: <1334873443-21124-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8572836753808735490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Michael Brudevold <michael.brudevold@logicpd.com>

Release and answer should be allowed when there are held calls as well as t=
he
existing check for waiting calls.  Most implementations use AT+CHLD=3D1 whi=
ch
will resume the other call, be it waiting or held.  This follows the HFP,
GSM 07.07 and 3GPP 27.007 specs.
---
 src/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 263f1ee..2d261bf 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1684,7 +1684,7 @@ static DBusMessage *manager_release_and_answer(DBusCo=
nnection *conn,
 	if (vc->pending || vc->dial_req || vc->pending_em)
 		return __ofono_error_busy(msg);
 =

-	if (!voicecalls_have_waiting(vc))
+	if (!(voicecalls_have_waiting(vc) || voicecalls_have_held(vc)))
 		return __ofono_error_failed(msg);
 =

 	if (vc->driver->release_all_active =3D=3D NULL)
-- =

1.7.5.4


--===============8572836753808735490==--

