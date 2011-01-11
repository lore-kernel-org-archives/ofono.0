Content-Type: multipart/mixed; boundary="===============6756370128275450551=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v5, 4/5] ofono-rules: Add nokiacdma device
Date: Mon, 10 Jan 2011 17:45:31 -0800
Message-ID: <1294710332-6028-5-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6756370128275450551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index d1d18b2..fe62db0 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -438,4 +438,8 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060=
e", ENV{OFONO_DRIVER}=3D"nokia"
 # Nokia Internet Stick CS-17
 ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"0623", ENV{OFONO_DRIVE=
R}=3D"nokia"
 =

+# Nokia CDMA Device
+ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"023e", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
+ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"00b6", ENV{OFONO_DRIVE=
R}=3D"nokiacdma"
+
 LABEL=3D"ofono_end"
-- =

1.7.0.4


--===============6756370128275450551==--

