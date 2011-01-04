Content-Type: multipart/mixed; boundary="===============3850028491178780372=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v4, 4/5] ofono-rules: Add nokiacdma device
Date: Mon, 03 Jan 2011 17:50:16 -0800
Message-ID: <1294105817-23397-5-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3850028491178780372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ofono.rules |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 770834f..65ab7e2 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -432,4 +432,8 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"060=
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


--===============3850028491178780372==--

