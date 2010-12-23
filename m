Content-Type: multipart/mixed; boundary="===============7140551047457605816=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] Mark 'Frequency Band Selection' task as done
Date: Thu, 23 Dec 2010 09:18:00 -0200
Message-ID: <1293103080-8895-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1293103080-8895-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7140551047457605816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |   10 ----------
 doc/features.txt |    3 +++
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index 463f74c..db20513 100644
--- a/TODO
+++ b/TODO
@@ -384,16 +384,6 @@ Miscellaneous
   Complexity: C4
   Priority: Low
 =

-- Frequency Band Selection.  Add frequency band selection capability to the
-  RadioSettings atom.
-  Owner: Lucas De Marchi <lucas.demarchi@profusion.mobi>
-
-  This feature is not discussed in 27.007, thus manufacturer specific comm=
ands
-  are required.
-
-  Complexity: C2
-  Priority: Low
-
 - PolicyKit support.  Add support for PolicyKit checking of all oFono D-Bus
   interfaces.
 =

diff --git a/doc/features.txt b/doc/features.txt
index 3f741b7..a1a3c25 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -246,6 +246,9 @@ Radio settings
   using the device but some networking applications are online using
   packet data.
 =

+- Frequency Band Selection support. This feature allows the user to limit =
the
+  frequency bands in which the cellular modem can operate.
+
 Text Telephony
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.3.4


--===============7140551047457605816==--

