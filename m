Content-Type: multipart/mixed; boundary="===============2963406959393643412=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 4/4] TODO: mark HFP AG 1.6 indicator activation as done
Date: Wed, 31 Aug 2011 17:21:33 +0200
Message-ID: <1314804093-12504-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1314804093-12504-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2963406959393643412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    7 -------
 doc/features.txt |    8 ++++----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/TODO b/TODO
index 516d325..5672259 100644
--- a/TODO
+++ b/TODO
@@ -148,13 +148,6 @@ Modem Emulator
   Complexity: C4
   Priority: Medium
 =

-- Support new HFP 1.6 AG command related to indicators (AT+BIA).
-
-  Complexity: C1
-  Priority: Low
-  Owner: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com>
-  Depends: HFP AG emulator
-
 - Support new HFP 1.6 AG commands allowing to publish, select and connect =
audio
   codecs (AT+BAC, AT+BCS, +BCS, AT+BCC). This will need to interact with a=
udio
   framework.
diff --git a/doc/features.txt b/doc/features.txt
index b8bcdb1..ad4d176 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -675,11 +675,11 @@ Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 - Support for Bluetooth HandsFree Profile Audio Gateway (HFP AG).  oFono
-  supports the underlying AT command protocol specified by BT HFP version =
1.5.
+  supports the underlying AT command protocol specified by BT HFP version =
1.6.
   Supported features include 3-way calling, ability to reject a call,
-  enhanced call status, enhanced call control and report of extended error
-  results code.  Audio management is assumed to be performed in another sy=
stem
-  component, e.g. PulseAudio.
+  enhanced call status, enhanced call control, report of extended error re=
sults
+  code and indicator activation. Audio management is assumed to be perform=
ed in
+  another system component, e.g. PulseAudio.
 =

 - Support for Bluetooth DUN profile.  oFono supports the Dial Up Networking
   profile and all mandatory commands specified by BT DUN 1.1.  For a list
-- =

1.7.1


--===============2963406959393643412==--

