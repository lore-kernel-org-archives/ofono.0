Content-Type: multipart/mixed; boundary="===============5282399611976360376=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/9] test: use python3 for set-ddr
Date: Fri, 26 Oct 2018 12:13:11 +0200
Message-ID: <20181026101319.27709-2-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5282399611976360376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/set-ddr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/set-ddr b/test/set-ddr
index 5d061b95..33631f31 100755
--- a/test/set-ddr
+++ b/test/set-ddr
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
-- =

2.17.1


--===============5282399611976360376==--

