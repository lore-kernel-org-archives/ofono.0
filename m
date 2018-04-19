Content-Type: multipart/mixed; boundary="===============1140711167639674299=="
MIME-Version: 1.0
From: Mark van der Putten <mark.van.der.putten@intemo.com>
Subject: A small patch for gemalto plugin
Date: Thu, 19 Apr 2018 09:58:50 +0200
Message-ID: <6a0fbd9d-ee1f-395c-af7c-529c2cb7b5d0@intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1140711167639674299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From df8af202e8382056be80ce24387bee104bf8f048 Mon Sep 17 00:00:00 2001
From: Mark van der Putten <mark.van.der.putten@intemo.com>
Date: Wed, 18 Apr 2018 17:19:01 +0200
Subject: [PATCH] Signal sim initialized for gemalto plugin

Modem type PLS8-E, firmware 03.017
---
=C2=A0plugins/gemalto.c | 5 +++++
=C2=A01 file changed, 5 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index af02403..ec8174d 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -204,6 +204,11 @@ static void gemalto_ciev_notify(GAtResult *result,
gpointer user_data)
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 NULL);
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
=C2=A0
+=C2=A0=C2=A0=C2=A0 /* USIM initialization completed. UE has finished readi=
ng USIM data. */
+=C2=A0=C2=A0=C2=A0 case 5:
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_in=
itialized_notify(sim);
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
+
=C2=A0=C2=A0=C2=A0=C2=A0 default:
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
=C2=A0=C2=A0=C2=A0=C2=A0 }
-- =

2.1.4


--===============1140711167639674299==--

