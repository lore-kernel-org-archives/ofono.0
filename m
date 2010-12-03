Content-Type: multipart/mixed; boundary="===============6788667749692683036=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] TODO: add blacklisting
Date: Fri, 03 Dec 2010 11:02:07 +0200
Message-ID: <1291366927-21145-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6788667749692683036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a421a99..558c1d2 100644
--- a/TODO
+++ b/TODO
@@ -305,6 +305,14 @@ Voicecall
   Complexity: C2
   Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

+- Blacklisting. According to 3GPP TS 22.001 annex E, the TE must provide
+  automatic calling repeat call attempt restrictions.
+
+  There should be a method to manually reset blacklisting.
+
+  Priority: Medium
+  Complexity: C1
+
 =

 Sim Toolkit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.1


--===============6788667749692683036==--

