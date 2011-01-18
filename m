Content-Type: multipart/mixed; boundary="===============4083108923855810091=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 5/5] TODO: Remove completed CPHS CSP task
Date: Tue, 18 Jan 2011 15:19:07 +0200
Message-ID: <1295356747-29758-6-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295356747-29758-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4083108923855810091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index 1acae81..345952e 100644
--- a/TODO
+++ b/TODO
@@ -97,19 +97,6 @@ SIM / SIM File system
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
 Modem Emulator
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.1


--===============4083108923855810091==--

