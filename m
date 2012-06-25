Content-Type: multipart/mixed; boundary="===============1556736922544383310=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/7] control: Fix empty sender checking
Date: Mon, 25 Jun 2012 16:37:57 +0200
Message-ID: <1340635083-5877-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1556736922544383310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control.cpp b/src/control.cpp
index ee1e7d8..27910c2 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -339,7 +339,7 @@ void ControlWidget::sendCBM()
 =

 void ControlWidget::sendSMSMessage()
 {
-    if (ui->leSMSClass->text().isEmpty()) {
+    if (ui->leMessageSender->text().isEmpty()) {
         p->warning(tr("Invalid Sender"),
                 tr("Sender must not be empty"));
         return;
-- =

1.7.9.5


--===============1556736922544383310==--

