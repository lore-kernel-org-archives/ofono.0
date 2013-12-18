Content-Type: multipart/mixed; boundary="===============4245767326836000092=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH] features: Describe Siri feature
Date: Wed, 18 Dec 2013 15:03:02 +0000
Message-ID: <1387378982-22169-2-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387378982-22169-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4245767326836000092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/features.txt | 8 ++++++++
 1 file changed, 8 insertions(+)
 mode change 100644 =3D> 100755 doc/features.txt

diff --git a/doc/features.txt b/doc/features.txt
old mode 100644
new mode 100755
index 563a0f5..de12d6d
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -739,3 +739,11 @@ Bluetooth Handsfree Profile
   access to Bluetooth HFP specific features via the oFono Handsfree interf=
ace.
   These features include voice recognition activation, last number redial,
   etc.
+  =

+Apple Siri
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Siri feature. oFono can query availability of Siri on an iOS device. oFo=
no
+  uses 'EyesFreeMode' property on the Siri interface to control the state =
of the
+  Siri Eyes Free Mode. When EyesFreeMode state is enabled, the iOS device=
=E2=80=99s
+  screen won=E2=80=99t light up during a voice recognition session and an =
incoming call.
-- =

1.7.11.7


--===============4245767326836000092==--

