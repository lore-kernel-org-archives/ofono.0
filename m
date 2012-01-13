Content-Type: multipart/mixed; boundary="===============1261522086252884183=="
MIME-Version: 1.0
From: ying.an.deng@intel.com
Subject: [PATCH] dd support to u3501 dongle with PID 1c9e:9605 add support to
 u3501 dongle with PID 1c9e:9605
Date: Fri, 13 Jan 2012 15:07:37 +0800
Message-ID: <1326438457-11458-1-git-send-email-ying.an.deng@intel.com>
In-Reply-To: <ying.an.deng@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1261522086252884183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: DengYingAn <ying.an.deng@intel.com>

---
 plugins/ofono-speedup.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono-speedup.rules b/plugins/ofono-speedup.rules
index f43fc7b..1acbb79 100644
--- a/plugins/ofono-speedup.rules
+++ b/plugins/ofono-speedup.rules
@@ -20,4 +20,8 @@ ATTRS{idVendor}=3D=3D"2020", ATTRS{idProduct}=3D=3D"1008"=
, ENV{ID_USB_INTERFACE_NUM}=3D=3D"0
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"modem"
 ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9800", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"02", ENV{OFONO_LABEL}=3D"aux"
 =

+# U3501
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9605", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"03", ENV{OFONO_LABEL}=3D"modem"
+ATTRS{idVendor}=3D=3D"1c9e", ATTRS{idProduct}=3D=3D"9605", ENV{ID_USB_INTE=
RFACE_NUM}=3D=3D"01", ENV{OFONO_LABEL}=3D"aux"
+
 LABEL=3D"ofono_speedup_end"
-- =

1.7.2.3


--===============1261522086252884183==--

