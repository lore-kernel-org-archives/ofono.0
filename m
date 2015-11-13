Content-Type: multipart/mixed; boundary="===============6924654280579215817=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/7] gitignore: Ignore rilmodem-cs test binary
Date: Fri, 13 Nov 2015 13:25:04 +0100
Message-ID: <1447417510-9368-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6924654280579215817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index b9c23a0..a433dad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@ unit/test-mux
 unit/test-caif
 unit/test-stkutil
 unit/test-cdmasms
+unit/test-rilmodem-cs
 unit/test-*.log
 unit/test-*.trs
 =

-- =

2.5.0


--===============6924654280579215817==--

