Content-Type: multipart/mixed; boundary="===============2104574317164836140=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Update overview.txt: add SIM retry counter support
 information.
Date: Mon, 28 Mar 2011 15:54:21 +0200
Message-ID: <1301320461-3001-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2104574317164836140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/overview.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/doc/overview.txt b/doc/overview.txt
index 6b53f14..1924875 100644
--- a/doc/overview.txt
+++ b/doc/overview.txt
@@ -109,7 +109,8 @@ Current implemented features:
 	SIM PIN handling
 =

 		SIM PIN locks, network and service provider locks are
-		supported.
+		supported. The SIM Manager also handles retry counter for PIN,
+		PIN2, PUK and PUK2.
 =

 	Cell Broadcast
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

--===============2104574317164836140==--

