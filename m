Content-Type: multipart/mixed; boundary="===============8691077445383359328=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] Use org.ofono.phonesim.Script as interface name
Date: Thu, 14 Oct 2010 20:34:41 +0800
Message-ID: <1287059682-12973-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8691077445383359328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/control.h b/src/control.h
index e455437..3c85e22 100644
--- a/src/control.h
+++ b/src/control.h
@@ -31,9 +31,9 @@ class Control;
 class Script: public QDBusAbstractAdaptor
 {
 Q_OBJECT
-    Q_CLASSINFO("D-Bus Interface", "org.phonesim.Script")
+    Q_CLASSINFO("D-Bus Interface", "org.ofono.phonesim.Script")
     Q_CLASSINFO("D-Bus Introspection", ""
-"  <interface name=3D\"org.phonesim.Script\">\n"
+"  <interface name=3D\"org.ofono.phonesim.Script\">\n"
 "    <method name=3D\"SetPath\">\n"
 "      <arg direction=3D\"in\" type=3D\"s\" name=3D\"path\"/>\n"
 "    </method>\n"
-- =

1.7.2.3


--===============8691077445383359328==--

