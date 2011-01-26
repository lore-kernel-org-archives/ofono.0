Content-Type: multipart/mixed; boundary="===============2540020991680227122=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 4/6] conf: Add ref number setting for MessageManager
Date: Wed, 26 Jan 2011 10:56:24 +0200
Message-ID: <1296032186-21497-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2540020991680227122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.conf |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index facb950..0b23998 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -2,3 +2,9 @@
 =

 # List of plugins that should not be loaded on oFono startup
 #DisablePlugins =3D
+
+[MessageManager]
+
+# Use 16bit long reference numbers in outgoing SMSs. The default is
+# False, which causes 8bit long reference numbers to be used.
+Use16bitReference =3D false
-- =

1.7.1


--===============2540020991680227122==--

