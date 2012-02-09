Content-Type: multipart/mixed; boundary="===============5941258092229956457=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] voicecall: Fix emulator AT+CHUP for HFP
Date: Thu, 09 Feb 2012 10:12:34 +0100
Message-ID: <1328778754-5108-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5941258092229956457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AT+CHUP should be able to hang-up active or incoming calls
---
 src/voicecall.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 094f41d..e224d3a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2931,7 +2931,8 @@ static void emulator_chup_cb(struct ofono_emulator *e=
m,
 			goto done;
 		}
 =

-		if (voicecalls_have_active(vc) =3D=3D FALSE)
+		if (voicecalls_have_active(vc) =3D=3D FALSE &&
+				voicecalls_have_incoming(vc) =3D=3D FALSE)
 			goto fail;
 =

 		vc->pending_em =3D em;
-- =

1.7.1


--===============5941258092229956457==--

