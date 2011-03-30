Content-Type: multipart/mixed; boundary="===============1936240432183980869=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] doc: add data-call.txt
Date: Wed, 30 Mar 2011 15:56:39 +0200
Message-ID: <1301493399-32041-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1936240432183980869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/data-call.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 doc/data-call.txt

diff --git a/doc/data-call.txt b/doc/data-call.txt
new file mode 100644
index 0000000..f407560
--- /dev/null
+++ b/doc/data-call.txt
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


--===============1936240432183980869==--

