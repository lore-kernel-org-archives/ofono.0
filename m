Content-Type: multipart/mixed; boundary="===============3734638087514128742=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] TODO: Mark Bluetooth DUN task as done
Date: Thu, 25 Aug 2011 16:19:51 +0200
Message-ID: <1314281991-16595-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1314281991-16595-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3734638087514128742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    7 -------
 doc/features.txt |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index 9cc5dc0..8249e32 100644
--- a/TODO
+++ b/TODO
@@ -110,13 +110,6 @@ Modem Emulator
   Priority: Low
   Complexity: C1
 =

-- Support DUN emulator. Implement the Bluetooth DUN profile with only mand=
atory
-  AT command support.
-
-  Complexity: C4
-  Priority: Medium
-  Owner: Guillaume Zajac <guillaume.zajac@linux.intel.com>
-
 - Implement USB DUN.
 =

   Complexity: C4
diff --git a/doc/features.txt b/doc/features.txt
index 1eaad64..4a2ac9a 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -680,3 +680,8 @@ Modem Emulator
   enhanced call status, enhanced call control and report of extended error
   results code.  Audio management is assumed to be performed in another sy=
stem
   component, e.g. PulseAudio.
+
+- Support Bluetooth DUN profile. Only mandatory AT commands are supported,=
 see
+  dialup-command-set.txt.
+  =

+
-- =

1.7.1


--===============3734638087514128742==--

