Content-Type: multipart/mixed; boundary="===============1567408135406199478=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] TODO: Lower priority and remove owner of CE4A task
Date: Tue, 24 May 2011 09:56:05 +0200
Message-ID: <1306223765-6423-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1306223765-6423-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1567408135406199478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/TODO b/TODO
index 4b291bd..73768a5 100644
--- a/TODO
+++ b/TODO
@@ -102,16 +102,15 @@ Modem Emulator
   Priority: Medium
   Owner: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com>
 =

-- Support extensions to HFP AG emulator.  Some carkits support additional
-  AT command extensions to the Bluetooth HFP AG standard.  Refer to CE4A
+- Support CE4A extensions to HFP AG emulator. CE4A defines additional
+  AT command extensions to the Bluetooth HFP AG standard. Refer to CE4A
   white paper: "AT-commands for Automotive Premium Phone Integration".
   Plugins can register additional command handlers appropriately to handle
   such commands.
 =

   Complexity: C4
-  Priority: Medium
+  Priority: Low
   Depends: HFP AG emulator
-  Owner: Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@linux.intel.com>
 =

 - Support HSP AG.  Similar to HFP AG emulator but implements the much redu=
ced
   Bluetooth HSP AG profile.
-- =

1.7.1


--===============1567408135406199478==--

