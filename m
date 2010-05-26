Content-Type: multipart/mixed; boundary="===============0876307373243957926=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 01/13] Update .gitignore to ignore cscope databases and
 backup files
Date: Wed, 26 May 2010 12:49:15 -0700
Message-ID: <c46927ad93ad4b85ce6ace5c44af1bdc13414b68.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0876307373243957926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1ce7067..d7e9254 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+*~
 *.o
 *.lo
 *.la
@@ -16,6 +17,8 @@ config.sub
 configure
 depcomp
 compile
+cscope.files
+cscope.out
 install-sh
 libtool
 ltmain.sh
-- =

1.6.6.1


--===============0876307373243957926==--

