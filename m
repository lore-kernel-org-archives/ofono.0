Content-Type: multipart/mixed; boundary="===============0937350664738192721=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] plugins: support for provisioning from config file
Date: Fri, 17 Feb 2017 15:44:48 +0100
Message-ID: <20170217144448.23940-3-c.ronco@kerlink.fr>
In-Reply-To: <20170217144448.23940-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0937350664738192721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index e1579745..d9f9b086 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -555,6 +555,10 @@ builtin_sources +=3D plugins/provision.c
 =

 builtin_modules +=3D cdma_provision
 builtin_sources +=3D plugins/cdma-provision.c
+
+builtin_modules +=3D file_provision
+builtin_sources +=3D plugins/file-provision.c
+
 endif
 =

 if MAINTAINER_MODE
-- =

2.11.0


--===============0937350664738192721==--

