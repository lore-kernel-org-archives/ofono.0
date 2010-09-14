Content-Type: multipart/mixed; boundary="===============0799105200445422899=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/6] Fix common misspellings in TODO file
Date: Tue, 14 Sep 2010 00:06:04 -0300
Message-ID: <1284433565-26126-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0799105200445422899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspellings:

proprietory->proprietary
seperately->separately
---
 TODO |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index d41df04..d5d9082 100644
--- a/TODO
+++ b/TODO
@@ -26,7 +26,7 @@ SMS
   Proposed solution is to convert such messages to HTML and embed image /
   sound data as embedded MIME in the generated HTML stream.  The EMS messa=
ges
   will have to be detected (by the presence of particular tags in the SMS)
-  and signaled seperately from simple SMS messages.
+  and signaled separately from simple SMS messages.
 =

   Priority: Low
   Complexity: C8
@@ -136,7 +136,7 @@ SIM / SIM File system
   Priority: Low
   Complexity: C2
 =

-- Support proprietory extensions for SIM PIN retry counter.  Most vendors
+- Support proprietary extensions for SIM PIN retry counter.  Most vendors
   provide an extension commands to obtain such a retry counter for PINs and
   PUKs.  Need to enable this as a property in oFono.
 =

-- =

1.7.2.3


--===============0799105200445422899==--

