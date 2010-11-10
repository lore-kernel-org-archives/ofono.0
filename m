Content-Type: multipart/mixed; boundary="===============2970315067223310966=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] TODO: Check SIM pin status if sim_change_pin fails.
Date: Wed, 10 Nov 2010 12:35:45 +0100
Message-ID: <1289388945-21096-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2970315067223310966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
I'm sorry if I gave the impression that I don't want to contribute to =

the development of oFono core, I guess I'm just not that familiar with
how things work. =


 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 84d5aa7..eefa605 100644
--- a/TODO
+++ b/TODO
@@ -133,6 +133,12 @@ SIM / SIM File system
   Complexity: C2
   Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

+- Check SIM pin status if sim_change_pin fails. If it is anything other th=
an
+  READY, we must tear the state back to pre_sim state and set the modem of=
fline.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Marit Henriksen <marit.henriksen@stericsson.com>
 =

 Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.0.4


--===============2970315067223310966==--

