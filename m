Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EE26B0A9
	for <ofono@lists.linux.dev>; Sat, 28 Feb 2026 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270161; cv=none; b=J7c+HsLqlpV3avf9JJFBQ+6lkqT1ekpqaiLCwXrffJEiFezPIXIRNJ9ceQnK1Nmkt2Y8RmtO6tuXxv4ZqNT7J4g+2osKCXEr/46o08jXt9XJ2vysgtqYeAOpG9SVFRuZqZ8vNK1N0MX44GhZofGWSQsVtpStWA7tz2zts8l6ckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270161; c=relaxed/simple;
	bh=RhuplgMXqJCu5xkMUuai9S0Ws4omZS0g9nhDslwfdJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=XpHC8+LFXsdrTzbJ5BJiS24cjk/gGqVOV0tVjq4dYvO1DAaSDVrkQ8Sx507/sJlk2CMe0dkW0+Pa6nLgLEzVUtYsDmzFCJh3qw3Ez1lzcH836U61zIXI3cr5NPBSnyuytHVTE/+ebkiJIUS8IyAQqs3/S23Z9D5x8N0cd6jekoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 0D03F113824; Sat, 28 Feb 2026 04:16:00 -0500 (EST)
Received: from 5400 (unknown [172.56.160.155])
	by spindle.queued.net (Postfix) with ESMTPSA id 976F111381E;
	Sat, 28 Feb 2026 04:15:58 -0500 (EST)
Date: Sat, 28 Feb 2026 04:15:57 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Cc: jbb.prv@gmx.de
Subject: [PATCH phonesim 1/3] Fix compatibility with Qt6
Message-ID: <20260228041557.16eaa9d1@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
In-Reply-To: <20260228041213.45bc0030@5400>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

From: =?UTF-8?q?Jonah=20Br=C3=BCchert?= <jbb.prv@gmx.de>

---
 src/control.cpp  |  6 +++---
 src/phonesim.cpp |  2 +-
 src/qwsppdu.cpp  | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index 817a0b2..b06dbc1 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -337,7 +337,7 @@ void ControlWidget::sendSMSMessage()
         return;
     }
 
-    if (ui->leSMSServiceCenter->text().isEmpty() || ui->leSMSServiceCenter->text().contains(QRegExp("\\D"))) {
+    if (ui->leSMSServiceCenter->text().isEmpty() || ui->leSMSServiceCenter->text().contains(QRegularExpression(R"(\D)"))) {
         p->warning(tr("Invalid Service Center"),
                 tr("Service Center must not be empty and contain "
                    "only digits"));
@@ -386,14 +386,14 @@ void ControlWidget::selectFile()
 void ControlWidget::sendSMSDatagram()
 {
     QString dstPortStr = ui->leDstPort->text();
-    if ( dstPortStr.contains(QRegExp("\\D")) ) {
+    if ( dstPortStr.contains(QRegularExpression(R"(\D)")) ) {
         p->warning(tr("Invalid Port"), tr("Port number can contain only digits" ));
         return;
     }
     int dst = dstPortStr.toInt();
 
     QString srcPortStr = ui->leSrcPort->text();
-    if ( srcPortStr.contains(QRegExp("\\D")) ) {
+    if ( srcPortStr.contains(QRegularExpression(R"(\D)")) ) {
         p->warning(tr("Invalid Port"), tr("Port number can contain only digits" ));
         return;
     }
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 89d5e9d..1b826ed 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -346,7 +346,7 @@ bool SimChat::command( const QString& cmd )
         else {
             int index = value.indexOf( "${*}" );
             if ( index != -1 ) {
-                if ( wild.length() > 0 && wild[wild.length() - 1] == 0x1A ) {
+                if ( wild.length() > 0 && wild[wild.length() - 1] == QChar(0x1A) ) {
                     // Strip the terminating ^Z from SMS PDU's.
                     wild = wild.left( wild.length() - 1 );
                 }
diff --git a/src/qwsppdu.cpp b/src/qwsppdu.cpp
index d636b5c..9798374 100644
--- a/src/qwsppdu.cpp
+++ b/src/qwsppdu.cpp
@@ -707,7 +707,7 @@ QString QWspPduDecoder::decodeTextString()
     if (o == '\"')
         o = decodeOctet();
     while (o != 0 && !dev->atEnd()) {
-        str += o;
+        str += QChar(o);
         o = decodeOctet();
     }
 
@@ -722,7 +722,7 @@ QString QWspPduDecoder::decodeTextBlock(int length)
 {
     QString result;
     for(int i = 0; i < length; ++i)
-        result += decodeOctet();
+        result += QChar(decodeOctet());
     return result;
 }
 
@@ -815,7 +815,7 @@ QString QWspPduDecoder::decodeContentType()
             // Extension-Media
             o = decodeOctet();
             while (o != 0) {
-                type += o;
+                type += QChar(o);
                 o = decodeOctet();
             }
         }
@@ -838,7 +838,7 @@ QString QWspPduDecoder::decodeContentType()
         // Constrained-encoding = Extension-Media
         o = decodeOctet();
         while (o != 0) {
-            type += o;
+            type += QChar(o);
             o = decodeOctet();
         }
     }
@@ -988,13 +988,13 @@ QString QWspPduDecoder::decodeParameter()
         p = decodeTokenText() + "=";
         octet = peekOctet();
         if (octet <= 31 || octet & 0x80) {
-            p += decodeInteger();
+            p += QChar(decodeInteger());
         } else {
             // Extension-Media
             p += '\"';
             octet = decodeOctet();
             while (octet != 0 && !dev->atEnd()) {
-                p += octet;
+                p += QChar(octet);
                 octet = decodeOctet();
             }
             p += '\"';
-- 
2.51.0
