Content-Type: multipart/mixed; boundary="===============3633298726964321872=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 5/5] Makefile: add call counters to the build
Date: Mon, 15 Nov 2010 13:50:28 +0200
Message-ID: <c00e972ede1dd58920d80c763b05a5d871637358.1289819191.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3633298726964321872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f841b4c..a1c6097 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -295,6 +295,9 @@ builtin_modules +=3D example_nettime
 builtin_sources +=3D examples/nettime.c
 endif
 =

+builtin_modules +=3D cc
+builtin_sources +=3D src/callcounters.c
+
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

-- =

1.7.0.4


--===============3633298726964321872==--

