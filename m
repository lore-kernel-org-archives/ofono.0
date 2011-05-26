Content-Type: multipart/mixed; boundary="===============4790523562754086209=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] add udev rule for Option GTM661W modem
Date: Thu, 26 May 2011 09:53:23 +0800
Message-ID: <1306374803-5467-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4790523562754086209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 5a36380..268b327 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -391,6 +391,7 @@ ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"740=
1", ENV{OFONO_DRIVER}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7601", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7701", ENV{OFONO_DRIVE=
R}=3D"hso"
 ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"7901", ENV{OFONO_DRIVE=
R}=3D"hso"
+ATTRS{idVendor}=3D=3D"0af0", ATTRS{idProduct}=3D=3D"9000", ENV{OFONO_DRIVE=
R}=3D"hso"
 =

 # Ericsson F3507g
 ATTRS{idVendor}=3D=3D"0bdb", ATTRS{idProduct}=3D=3D"1900", ENV{OFONO_DRIVE=
R}=3D"mbm"
-- =

1.7.5


--===============4790523562754086209==--

