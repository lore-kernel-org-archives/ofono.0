Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4913B293
	for <ofono@lists.linux.dev>; Sat, 25 Apr 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152443; cv=none; b=FvUd8AeVtD6YBYBki0uxC8WuzKMXTI36vYETq8ZMoqX4jG8ooEgiCPm4h7xQQzh3fwUgFJv8qxZlZQ/3PqecPgmY6HHWHEgXyI9SQsq8L8qtalBVIaew1QT5IKhdvoO6eAbFA08vQRLmvjECL9G2b43Ref6/+KievtmMQNFLcO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152443; c=relaxed/simple;
	bh=ccwyTEzdn3I8skgMOK+3Z0FZGYRvOvvw1ZD4SM7d8I4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=SHsQeILWzcSSooc1w5qoZnWp6xqwXyXtQkhTtHezXRVluvbe+TtMcvvh1SfP/g/sPTA/rQpYiRaO6kFnlRztM1v3Uxf8euYp+0/86YDRZp0o0hZrHEJ/Nz0J6ijK4RnQl/xiVjWA8xBnfHK/fe92XtQ203A2lHvvJictM3oqxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 7420011B37E; Sat, 25 Apr 2026 17:19:48 -0400 (EDT)
Received: from 5400 (unknown [172.56.35.236])
	by spindle.queued.net (Postfix) with ESMTPSA id 258AF11B372
	for <ofono@lists.linux.dev>; Sat, 25 Apr 2026 17:19:48 -0400 (EDT)
Date: Sat, 25 Apr 2026 17:19:44 -0400
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Subject: [PATCH] callforwarding: fix missing prefixes in PropertyChanged
 property names
Message-ID: <20260425171944.18590822@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

A qofono test I was running hit a failure due to unexpected responses:

task-0: method call time=1777146276.985742 sender=:1.6 -> destination=org.ofono serial=23 path=/phonesim; interface=org.ofono.CallForwarding; member=SetProperty
task-0:    string "VoiceUnconditional"
task-0:    variant       string "12345678"
task-0: method return time=1777146276.991119 sender=:1.1 -> destination=:1.6 serial=159 reply_serial=23
task-0: signal time=1777146276.991146 sender=:1.1 -> destination=(null destination) serial=160 path=/phonesim; interface=org.ofono.CallForwarding; member=PropertyChanged
task-0:    string "VoiceUnconditional"
task-0:    variant       string "12345678"
task-0: signal time=1777146276.991165 sender=:1.1 -> destination=(null destination) serial=161 path=/phonesim; interface=org.ofono.CallForwarding; member=PropertyChanged
task-0:    string "Busy"
task-0:    variant       string ""
task-0: signal time=1777146276.991181 sender=:1.1 -> destination=(null destination) serial=162 path=/phonesim; interface=org.ofono.CallForwarding; member=PropertyChanged
task-0:    string "NoReply"
task-0:    variant       string ""
task-0: signal time=1777146276.991196 sender=:1.1 -> destination=(null destination) serial=163 path=/phonesim; interface=org.ofono.CallForwarding; member=PropertyChanged
task-0:    string "NotReachable"
task-0:    variant       string ""
task-0: signal time=1777146276.991212 sender=:1.1 -> destination=(null destination) serial=164 path=/phonesim; interface=org.ofono.CallForwarding; member=PropertyChanged
task-0:    string "ForwardingFlagOnSim"
task-0:    variant       boolean true

Other places in the code and call-forwarding-api.txt document that those
property names should have a class prefix like "VoiceNoReply", instead
of just "NoReply". This fixes the lack of prefix.
---
 src/call-forwarding.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 9aca1f03..12bc463f 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -395,9 +395,13 @@ static void set_new_cond_list(struct ofono_call_forwarding *cf,
 				number = phone_number_to_string(
 							&lc->phone_number);
 
+			snprintf(attr, sizeof(attr), "%s%s",
+				bearer_class_to_string(BEARER_CLASS_VOICE),
+				cf_type_lut[i]);
+
 			ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_FORWARDING_INTERFACE,
-						cf_type_lut[i],
+						attr,
 						DBUS_TYPE_STRING, &number);
 		}
 
-- 
2.53.0

