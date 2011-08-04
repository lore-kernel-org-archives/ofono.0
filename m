Content-Type: multipart/mixed; boundary="===============3885843827301912707=="
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [PATCH] Add missing PreferredLanguages property to SimManager
 documentation
Date: Thu, 04 Aug 2011 16:30:09 +0300
Message-ID: <1312464609-10649-1-git-send-email-alex.kanavin@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3885843827301912707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 22fe22b..ba8fdb1 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -114,6 +114,11 @@ Properties	boolean Present [readonly]
 			Contains the list of subscriber numbers.  This is
 			usually stored in the EFmsisdn sim file.
 =

+		array{string} PreferredLanguages [readonly, optional]
+
+			Contains the list of preferred languages from the SIM,
+			if available.
+
 		dict{string,string} ServiceNumbers [readonly, optional]
 =

 			Contains a dictionary of service dialing numbers from
-- =

1.7.4.1


--===============3885843827301912707==--

