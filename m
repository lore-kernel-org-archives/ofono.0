Content-Type: multipart/mixed; boundary="===============5040205889625567071=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] todo: Add Location Service (AGPS) task.
Date: Wed, 17 Nov 2010 08:09:13 +0100
Message-ID: <1289977754-7530-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289977754-7530-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5040205889625567071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index bf2305b..dec43fd 100644
--- a/TODO
+++ b/TODO
@@ -496,3 +496,11 @@ Miscellaneous
 =

   Priority: Low
   Complexity: C4
+
+- Add Location Service API for providing basic E911 suport.
+  This will be based on the 27.007 defined AT commands using
+  XML for transport of positioning request and responses.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
-- =

1.7.0.4


--===============5040205889625567071==--

