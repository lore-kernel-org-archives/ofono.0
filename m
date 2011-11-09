Content-Type: multipart/mixed; boundary="===============2641483872337510991=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] TODO: Add CDMA network name task
Date: Wed, 09 Nov 2011 18:44:33 +0100
Message-ID: <1320860673-27449-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2641483872337510991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As cdma dongles don't return any operator name in long alphanumeric format,=
 we
need to identify the serving network according to SID and retrieve the Oper=
ator
Name from a look-up table.
For that, I intend to extend mobile-broadband-provider-info plugin to parse=
 also
cdma providers and retrieve the operator name matching with the provided SI=
D.
---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 326ebab..58c9f61 100644
--- a/TODO
+++ b/TODO
@@ -554,6 +554,14 @@ CDMA Network Acquisition
   Priority: Medium
   Complexity: C2
 =

+- Support reporting of the current registered operator name in long alphan=
umeric
+  format. Based on the System Identifier (SID) broadcasted by the modem, t=
he
+  CDMA network name is retrieved from a look-up table (aka the 'mobile
+  broadband provider info'data base).
+
+  Priority: Medium
+  Complexity: C2
+
 CDMA Connection Manager
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.1


--===============2641483872337510991==--

