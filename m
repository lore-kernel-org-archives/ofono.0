Content-Type: multipart/mixed; boundary="===============0092084738967567371=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 7/9] ofono-rules: Add cdmagen device
Date: Fri, 17 Dec 2010 15:11:19 -0800
Message-ID: <1292627481-9109-8-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0092084738967567371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index da8a8ef..34698f0 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -429,6 +429,10 @@ ATTRS{idVendor}=3D=3D"0930", ATTRS{idProduct}=3D=3D"13=
11", ENV{OFONO_DRIVER}=3D"mbm"
 # Nokia Internet Stick CS-10
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060e", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

+# Nokia CDMA Device
+ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"cdmagen"
+ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"cdmagen"
+
 # Nokia Internet Stick CS-17
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"0623", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

-- =

1.7.0.4


--===============0092084738967567371==--

