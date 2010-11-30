Content-Type: multipart/mixed; boundary="===============8673957634159310356=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH] HACKING: Add ofono.conf file copy command required
Date: Tue, 30 Nov 2010 18:56:23 -0300
Message-ID: <20101130215623.GA22264@rafazurita.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8673957634159310356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Add ofono.conf copy command required for oFono core daemon to work.

---
 HACKING |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/HACKING b/HACKING
index e825185..e632279 100644
--- a/HACKING
+++ b/HACKING
@@ -76,6 +76,9 @@ use the plugins directly from within the repository. This=
 removes the need
 to use "make install" when testing "ofonod". The "bootstrap-configure"
 automatically includes this option.
 =

+  Copy configuration file which specifies the required security policies
+    # sudo cp ./src/ofono.conf /etc/dbus-1/system.d/
+
   Run daemon in foreground with debugging
     # sudo ./src/ofonod -n -d 'plugins/*'
=20

--===============8673957634159310356==--

