Content-Type: multipart/mixed; boundary="===============3224892919790531240=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Update overview.txt: move USSD from work in progress section
 to implemented section.
Date: Mon, 28 Mar 2011 15:37:55 +0200
Message-ID: <1301319475-2774-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3224892919790531240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/overview.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/overview.txt b/doc/overview.txt
index 2a30e0b..244b4ff 100644
--- a/doc/overview.txt
+++ b/doc/overview.txt
@@ -138,12 +138,15 @@ Current implemented features:
 		operation status. Information on the Sim Toolkit feature
 		list can be found in features.txt.
 =

+	Supplementary Services
+
+		The Supplementary Services interface handles both recognized
+		supplementary service control string and user/network initiated
+		unstructured supplementary service data (USSD).
+
 Work in progress features:
 =

-	USSD
 =

-		User initiated USSD support is available, but not
-		network-initiated USSD support.
 =

 Not implemented features:
 =

-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3224892919790531240==--

