Content-Type: multipart/mixed; boundary="===============1060986263620530380=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCHv2] doc: add dialup-overview.txt
Date: Wed, 30 Mar 2011 16:45:26 +0200
Message-ID: <1301496326-32762-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1060986263620530380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-overview.txt |   47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 doc/dialup-overview.txt

diff --git a/doc/dialup-overview.txt b/doc/dialup-overview.txt
new file mode 100644
index 0000000..f407560
--- /dev/null
+++ b/doc/dialup-overview.txt
@@ -0,0 +1,47 @@
+DialUp Networking diagram
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+This diagram explains how oFono and ConnMan are interacting to
+handle a data call from a DUN client.
+1) GAtServer receive ATD*99#.
+2) The GAtPPP server is setup.
+3) oFono through GAtPPP notify ConnMan that he needs a TUN/TAP interface.
+4) oFono is notified that TUN/TAP interface is created and can start excha=
nging
+PPP packets with DUN client. Those PPP packets are converted into IP stream
+and transmitted to/received from TUN/TAP interface.
+5) ConnMan is selecting which interface to send IP packets (WiFi, 3G, ethX=
, ...).
+
+*----------------*            *----------------*
+|                |  ATD*99#   |                |
+|   DUN Client   |----------->|    GAtServer   |
+|                |<---*       |                |
+*----------------*    |       *----------------*
+                      |             |
+              PPP     |             | setup_ppp()
+              Packets |             |
+                      |             |
+                      |             V           Need
+                      |    *----------------*   /dev/net/tun *------------=
----*
+                      *--->|                |   interface    |            =
    |
+                           |     GAtPPP     |<-------------->|     ConnMan=
    |
+                      *--->|                |   interface    |            =
    |
+                      |    *----------------*   created      *------------=
----*
+              IP      |                                          |
+              Stream  |                                          |Create
+                      |    *------------------------*            |/dev/net=
/tun
+                      |    |                        |            |interface
+                      *--->|    TUN/TAP interface   |<-----------*
+                           |                        |
+                           *------------------------*
+                                      IP | Stream
+                             routed with | ConnMan rules
+                   *---------------------*--------------------*
+                   |                     |                    |
+                   |                     |                    |
+                   V                     V                    V
+            *-------------*       *-------------*      *-------------*
+            |             |       |             |      |             |
+            |  WiFi       |       |   Modem     |      |    EthX     |
+            |             |       |             |      |             |
+            *-------------*       *-------------*      *-------------*
+
-- =

1.7.1


--===============1060986263620530380==--

