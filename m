Content-Type: multipart/mixed; boundary="===============0879638909604372521=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 13/13] Use bool literals
Date: Tue, 12 Nov 2019 22:37:19 +0100
Message-ID: <20191112213719.9309-14-jbb.prv@gmx.de>
In-Reply-To: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0879638909604372521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Done using the modernize-use-bool-literals of clang-tidy
---
 src/qsmsmessage.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/qsmsmessage.cpp b/src/qsmsmessage.cpp
index 1d0f733..06845bf 100644
--- a/src/qsmsmessage.cpp
+++ b/src/qsmsmessage.cpp
@@ -1565,7 +1565,7 @@ bool QPDUMessage::bit(int b)
     if ( needOctets(1) )
         return (mBuffer[mPosn] & (Unit << b));
     else
-        return 0;
+        return false;
 }

 unsigned char QPDUMessage::bits(int offset, int len)
--
2.24.0

--===============0879638909604372521==--

