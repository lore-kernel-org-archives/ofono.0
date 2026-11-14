Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=136.144.136.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636379;
	b=272kD0NzrqVg1BYSi7ORFgWFmInHtrjslSmArFPyg9+/D1YwW90jWRs8pKEYgDY/9kZ0
	 KImzi6RlnHDemLHfvOjvBdfsK7n9oLMZITj6nv4jJirvXNfY21y/l9xeSU+eUmMnocwPI
	 KLqUcC/hLPmQQqd4xIX1ExuNN/RSQPIxZsZmPeqnKh3TF8AXBbfteWskpLf23d11omoNq
	 GrvlK6u5yg953fZvquMPrGTVS3iwHhMb44vixVY7wT5OAV2wtx1ChlLTf9lf/ZUZijF65
	 FvBs0dy31059/76UoX9phGgWnrcAokWBNuA1nXpC3rmaRACByyvJFNlgFEog2/NM/ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636379;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Scanned-By:
	 DKIM-Signature:X-Report-Abuse-To;
	bh=YKvW3ik3SnaKff9W7rc6p2+Nr96/MJ215w0sIXXs2eQ=;
	b=R6KOkeKqeGJqCjxARluEO7ZQB+iwGVIPmn+7EOVFrJ5iTXKgNfiVg3kSzQfGPNLmSkA/
	 mRcRhpchvfPFAiCipB9kHeNzlCl75aDTB/wwQurBcdgqZUlSqTeFPjAVevefWXhNFRsO8
	 izqLfgpkkgD9/tH/2TIe+PQ2rLKXzBvs1jdWrWgLJRIc6I1inCX3GQEgsx6fcc+UZ2A0h
	 9dossT2ZVcS7InRCDYGezkhOZKz3PEPpSwRi7xWx0un+WeX4+FxHm/5kpCffcD/FpiKmE
	 VfjXhIdZk10S6vdrCeuHvWq2wBfR7T6cMrupBGUvl8FqPHR4iR+riEOIsWgAMDro+Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=herrie.org;
	spf=pass smtp.mailfrom=herrie.org;
	arc=none smtp.remote-ip=136.144.136.8
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC9606A323
	for <ofono@lists.linux.dev>; Sat, 14 Nov 2026 06:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBC9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission7.mail.transip.nl (unknown [10.103.8.158])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4jRNsr1yNJzY75PZ
	for <ofono@lists.linux.dev>; Sat, 14 Nov 2026 07:06:08 +0100 (CET)
Received: from herrie-desktop (150-83-201-31.ftth.glasoperator.nl [31.201.83.150])
	by submission7.mail.transip.nl (Postfix) with ESMTPA id 4jRNsq4sbrz3fqYsS;
	Sat, 14 Nov 2026 07:06:07 +0100 (CET)
From: Herman van Hazendonk <github.com@herrie.org>
To: ofono@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH phonesim] callmanager: End calls when the radio is turned off
Date: Sat, 14 Nov 2026 07:05:54 +0100
Message-ID: <20261114060554.4104107-1-github.com@herrie.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission7.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1794636367; h=from:subject:to:cc:date:
 mime-version; bh=YKvW3ik3SnaKff9W7rc6p2+Nr96/MJ215w0sIXXs2eQ=;
 b=j0hpPKrh963KMsakXUmo2pB5WDG2SUMEcnaMGxyei4OYZkNlBpm1wRAyaCB8DEX6gX779r
 RlPOgPgFi6RksudkdoPNfu4ZIH2YD2maRr1EwJbZouzpGi7us+bDHOGkCLSl+G76Ue8+MK
 /vxXFtf81NE/WVUxzQvm3R/DhqIbQPB9kEH/Andb5hhaIbDwFUwUmO4Kt+Rjgb3vMfaysf
 y9Zeiv+l4XeY24os1yTpYqr+kTniJff5vEOFepTnMdMByWAVhLyanY9jFWoExsqQYRK0+I
 2PfubnTkacY6tt4vA0NpQYzyQh3lOhbQg+Mke1bwGJV5c4ozc+MwTPj6AAlY7A==
X-Report-Abuse-To: abuse@transip.nl

AT+CFUN=4 only switched off registration, so calls that were up stayed
up with the radio off.  A real modem ends them, and oFono does not end
them on its own: it waits for the modem to report it, so it went on
showing calls that could no longer exist.

Once a rule has answered an AT+CFUN=<fun> with <fun> other than 1, hang
up every call from the network side, the way the GUI's remote hangup
does: *ECAV with the call ended and NO CARRIER for each, after which
oFono queries AT+CLCC and drops them.  The rule's response has been
written by then, so the NO CARRIERs follow the OK and are not taken
for the final response to AT+CFUN.  AT+CFUN? and AT+CFUN=? are left
alone, and so is a CFUN no rule accepts (default.xml has none for
CFUN=0).

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 src/callmanager.cpp |  6 ++++++
 src/callmanager.h   |  3 +++
 src/phonesim.cpp    | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 40f9b3b..f1c0385 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -478,6 +478,12 @@ void CallManager::hangupRemote( int id )
     }
 }
 
+void CallManager::hangupAllRemote()
+{
+    while ( !callList.isEmpty() )
+        hangupRemote( callList.constFirst().id );
+}
+
 bool CallManager::acceptCall()
 {
     int id = idForIncoming();
diff --git a/src/callmanager.h b/src/callmanager.h
index a39f484..93381db 100644
--- a/src/callmanager.h
+++ b/src/callmanager.h
@@ -109,6 +109,9 @@ public slots:
     // Simulate a remote hangup.
     void hangupRemote( int id );
 
+    // Simulate a remote hangup of every call, as when the radio goes off.
+    void hangupAllRemote();
+
 signals:
     // Send a response to a command.
     void send( const QString& line );
diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 89d5e9d..994031c 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -1182,6 +1182,17 @@ void SimRules::command( const QString& cmd )
             respond( "ERROR" );
 
         }
+    } else if ( cmd.startsWith( "AT+CFUN=" ) ) {
+
+        // A real modem ends every call when its radio is turned off, and
+        // oFono waits for it to do so.  The rule has answered by now, so
+        // the NO CARRIERs cannot be taken as the final response to AT+CFUN.
+        bool ok;
+        int fun = cmd.mid( 8 ).section( ',', 0, 0 ).toInt( &ok );
+
+        if ( ok && fun != 1 )
+            _callManager->hangupAllRemote();
+
     }
 }
 
-- 
2.53.0

