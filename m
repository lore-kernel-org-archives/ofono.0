Content-Type: multipart/mixed; boundary="===============5769541891237041489=="
MIME-Version: 1.0
From: Torgny Johansson <torgny.johansson@ericsson.com>
Subject: [PATCH] Add vid/pid for Ericsson F5521gw
Date: Mon, 08 Nov 2010 09:48:37 +0100
Message-ID: <1289206117-7838-1-git-send-email-torgny.johansson@ericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5769541891237041489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 859da56..f2a8162 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -388,6 +388,9 @@ ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"104=
9", ENV{OFONO_DRIVER}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190a", ENV{OFONO_DRIVE=
R}=3D"mbm"
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1909", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

+# Ericsson F5521gw
+ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"190d", ENV{OFONO_DRIVE=
R}=3D"mbm"
+
 # Sony-Ericsson MD300
 ATTRS{idVendor}=3D=3D"0fce", ATTRS{idProduct}=3D=3D"d0cf", ENV{OFONO_DRIVE=
R}=3D"mbm"
 =

-- =

1.7.1


--===============5769541891237041489==--

