Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AA18DF8D
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378670; cv=none; b=A0R2PVK4KnVsS7aMKGbGbYw4sFGTP1WxoS1kifVIL+Jo9vNls0Y3SAtqt05rL0lBtwJ2JkwZJtnww8XtCgU2AUeM1hZuzQgWnzOVCJMPRvowGfBkDut1XPeT9F/nMEREfqddIrs7I+ZeauKQ29ZcjEM8ykBU+6g1TAJW7jzNvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378670; c=relaxed/simple;
	bh=lNlf1EWEj3MkM8TGZyXJ4eLiuasOfhkjOr4Spk4AwjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUhCBQWFs/nvAAY+NLX7m/+BKcx2zg9qRyNdpDxVq/8sM3gaMFt4y7jssPsO3cpgSPMMc7tliLTMYOtCz3uvFYTDhsNIZp4cUaGaEPfRWgACtH1BVVqeE2zIfr+4mr0evd5nG/M1jPdEc4YJf7Imkw3nWemTNLKSOKcDyW3RnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=X8PagcTP; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="X8PagcTP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sNzP8QSp1LsA7pMy/DT2dg9G0/nPq+Q5KUkLrnXeS9w=; b=X8PagcTPlNow/RXJ/TW2o1ML+Q
	jnMJCsAfPXnwWLS30flyDidYhqwcPWM+WKnkBXYcLz+RiTv2olC0WhPG0ixpbIcup6VpjJ/pyja+t
	irDUkIo+e+uL9qazPLYOnTbvW5TRtvpoO+TBfrW1zjS8guZ0PBZeUymGPIpL2IgStRyV2OkxSVkLo
	2HltNBn71nFlgbq4MVbykp3nw/GkHFLlbBDVg96KClXOL7Bvng8JjJIRXkRmZA6XLALctd3vTcWqV
	bu142O/h7Z59XMXrwoq1MwQw2YwUdKsPj8GjgT00kuecZw/3Appv8MOsKRI9c4UY9ejiWRkiY/ZNU
	DE7+AYIA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6FG-000MYJ-VR; Tue, 08 Oct 2024 11:11:06 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6FG-00025v-27;
	Tue, 08 Oct 2024 11:11:06 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH 2/2] gprs: allow attached updates and status' on eutran networks
Date: Tue,  8 Oct 2024 11:11:02 +0200
Message-ID: <20241008091104.1567517-2-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008091104.1567517-1-sean@geanix.com>
References: <20241008091104.1567517-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
6 registered for "SMS only", home network (applicable only when E-UTRAN)
7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
+COPS supplies the <AcT> = EUTRAN
---
 src/gprs.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 46668820..59beb6a9 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1613,7 +1613,7 @@ static gboolean on_lte(struct ofono_gprs *gprs)
 
 static void gprs_attached_update(struct ofono_gprs *gprs)
 {
-	ofono_bool_t attached;
+	ofono_bool_t attached, netreg_status;
 	int status = gprs->status;
 
 	if (on_lte(gprs))
@@ -1626,10 +1626,20 @@ static void gprs_attached_update(struct ofono_gprs *gprs)
 		 * result in detaching...
 		 */
 		attached = have_active_contexts(gprs);
-	else
-		attached = gprs->driver_attached &&
-			(status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-				status == NETWORK_REGISTRATION_STATUS_ROAMING);
+	else {
+		switch (status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+			netreg_status = true;
+			break;
+		default:
+			netreg_status = false;
+		}
+
+		attached = gprs->driver_attached && netreg_status;
+	}
 
 	if (attached == gprs->attached)
 		return;
@@ -2637,8 +2647,13 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
 	if (gprs->flags & GPRS_FLAG_ATTACHING)
 		return;
 
-	if (status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			status != NETWORK_REGISTRATION_STATUS_ROAMING) {
+	switch (status) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+	case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
+	case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+		break;
+	default:
 		ofono_gprs_detached_notify(gprs);
 		return;
 	}
-- 
2.46.2

