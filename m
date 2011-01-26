Content-Type: multipart/mixed; boundary="===============5618256593194773013=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 2/6] conf: Add bare bones configuration file
Date: Wed, 26 Jan 2011 10:56:22 +0200
Message-ID: <1296032186-21497-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5618256593194773013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.conf |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 src/main.conf

diff --git a/src/main.conf b/src/main.conf
new file mode 100644
index 0000000..facb950
--- /dev/null
+++ b/src/main.conf
@@ -0,0 +1,4 @@
+[General]
+
+# List of plugins that should not be loaded on oFono startup
+#DisablePlugins =3D
-- =

1.7.1


--===============5618256593194773013==--

