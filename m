Content-Type: multipart/mixed; boundary="===============2390070697377774917=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 11:01:01 +0200
Message-ID: <1296464461-4287-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2390070697377774917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 3e8c91b..c27cec9 100644
--- a/TODO
+++ b/TODO
@@ -53,6 +53,17 @@ SMS
   Priority: Low
   Complexity: C2
 =

+- Add support for setting the SMS Validity Period (3GPP 23.040). Currently=
 the
+  value is hard coded as 24 hours.
+
+  Validity period can be given in three different formats
+  (Relative/Enhanced/Absolute), but support for Relative format (as curren=
tly
+  used in hard coded value as well) is comprehensive enough. Therefore Enh=
anced
+  and Absolute formats will not be supported unless later on so required.
+
+  Priority: Medium
+  Complexity: C1
+
 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.0.4


--===============2390070697377774917==--

