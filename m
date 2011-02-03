Content-Type: multipart/mixed; boundary="===============1676707557278373065=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/2] TODO: Remove completed CPHS CSP task
Date: Thu, 03 Feb 2011 15:28:08 +0200
Message-ID: <1296739688-26585-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739688-26585-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1676707557278373065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index 13a6baa..82066fa 100644
--- a/TODO
+++ b/TODO
@@ -88,19 +88,6 @@ SIM / SIM File system
   Complexity: C1
   Owner: Marit Henriksen <marit.henriksen@stericsson.com>
 =

-- Add support for CPHS Customer Service Profile (CSP).  This task adds sup=
port
-  for reading the EFcsp file and in particular, interpreting the PLMN mode=
 bit
-  within the 'Value Added Services' service group.
-
-  Based on the PLMN mode value, manual network selection needs to either be
-  enabled or disabled in the netreg atom.  Also to accommodate this, there
-  probably needs to be a new 'forced' mode to indicate that manual network
-  selection is disabled.
-
-  Priority: Medium
-  Complexity: C1
-  Owner: Aki Niemi <aki.niemi@nokia.com>
-
 - Support SIM authentication: SIM and AKA suites.
 =

   Priority: Medium
-- =

1.7.1


--===============1676707557278373065==--

