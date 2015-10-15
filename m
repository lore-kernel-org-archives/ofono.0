Content-Type: multipart/mixed; boundary="===============4931579552911199091=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 10/10] gitignore: Ignore rilmodem unit tests
Date: Thu, 15 Oct 2015 18:47:03 +0200
Message-ID: <1444927623-31141-11-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4931579552911199091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index b9c23a0..351fa8f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,9 @@ unit/test-mux
 unit/test-caif
 unit/test-stkutil
 unit/test-cdmasms
+unit/test-rilrequest
+unit/test-rilreply
+unit/test-rilunsol
 unit/test-*.log
 unit/test-*.trs
 =

-- =

2.1.4


--===============4931579552911199091==--

