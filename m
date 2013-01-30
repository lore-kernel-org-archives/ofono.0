Content-Type: multipart/mixed; boundary="===============1757493351663359624=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] TODO: Add task for supporting BlueZ 5 in dundee
Date: Wed, 30 Jan 2013 18:12:30 -0300
Message-ID: <1359580350-26208-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1757493351663359624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/TODO b/TODO
index 1fef651..c579718 100644
--- a/TODO
+++ b/TODO
@@ -159,6 +159,15 @@ Modem Emulator
   Priority: Medium
   Depends: HFP AG emulator as BlueZ service
 =

+- Add support for BlueZ 5 Profile1 API to dundee
+  BlueZ 5 introduced a new API for registration of external profiles, which
+  obsoletes the Serial API currently in use by dundee. The BlueZ 4 related
+  code will be kept around for some time still.
+
+  Complexity: C2
+  Priority: Medium
+  Owner: Paulo Borges <paulo.borges@openbossa.org>
+
 PPP
 =3D=3D=3D
 =

-- =

1.8.1.1


--===============1757493351663359624==--

