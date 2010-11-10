Content-Type: multipart/mixed; boundary="===============0579749919339046225=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: [PATCH] todo: ifxmodem apgs support
Date: Wed, 10 Nov 2010 11:43:11 -0800
Message-ID: <1289418194-2905-2-git-send-email-robertino.benis@intel.com>
In-Reply-To: <1289418194-2905-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0579749919339046225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index bf2305b..fe617af 100644
--- a/TODO
+++ b/TODO
@@ -496,3 +496,19 @@ Miscellaneous
 =

   Priority: Low
   Complexity: C4
+
+
+Modem support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Infineon modem:
+  Adding support for Assisted GPS in Infenion modem driver.
+  Enabling:
+
+  - postion requests from mobile networks
+  - position responses to mobile networks
+  - time injection
+
+  Priority: Low
+  Complexity: C1
+  Owner: Robertino Benis <robertino.benis@intel.com>
-- =

1.7.0.4


--===============0579749919339046225==--

