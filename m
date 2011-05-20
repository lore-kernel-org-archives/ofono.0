Content-Type: multipart/mixed; boundary="===============8727848395019932729=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] doc: add hfp-overview.txt
Date: Fri, 20 May 2011 11:47:18 +0200
Message-ID: <1305884838-4646-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8727848395019932729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/hfp-overview.txt |   49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 doc/hfp-overview.txt

diff --git a/doc/hfp-overview.txt b/doc/hfp-overview.txt
new file mode 100644
index 0000000..3ca1213
--- /dev/null
+++ b/doc/hfp-overview.txt
@@ -0,0 +1,49 @@
+HandsFree Profile Audio Gateway diagram
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This diagram explains how oFono manages HFP AG.
+
+AT commands and unsolicited results are managed in their related atom (eg.=
 ATA
+is managed in voicecall atom).
+The emulator atom is managing AT commands or unsolicited results that are =
not
+falling into a specific atom.
+
+1) HFP AG plugin registers a HFP AG server as soon as a voicecall atom exi=
st.
+2) When a connection occurs on this server, HFP AG plugin creates and regi=
sters
+   an emulator atom.
+3) Emulator atom will start a GAtServer and registers non-atom-specific
+   AT commands to it.
+4) On emulator atom registration, voice call related atoms (voicecall, net=
work
+   and sim) register AT callbacks they managed through emulator atom.
+
+
+*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*                *-----------------*
+|           |   Register     |                 |
+|   BlueZ   |<---------------|  HFP AG plugin  |
+|           |   SDP record   |                 |
+*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*                *-----------------*
+                                      |
+                                      | Start emulator on connection
+                                      |
+                                      V
+                             *-----------------*
+                             |                 |
+                   *-------->|  Emulator Atom  |
+                   |         |                 |
+                   |         *-----------------*
+                   |                  |
+         Register  |                  | Register AT commands
+            AT     |                  V
+         callbacks |         *-----------------*
+                   |         |                 |
+                   |         |    GAtServer    |
+                   |         |                 |
+                   |         *-----------------*
+                   |
+                   *---------------------*-------------------*
+                   |                     |                   |
+          *----------------*     *--------------*     *-------------*
+          |                |     |              |     |             |
+          | Voicecall atom |     | Network atom |     |  SIM atom   |
+          |                |     |              |     |             |
+          *----------------*     *--------------*     *-------------*
-- =

1.7.1


--===============8727848395019932729==--

