Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA720263C
	for <ofono@lists.linux.dev>; Fri, 18 Oct 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248727; cv=none; b=dihWSDNJVAsrgPUqRN87baSceaXPMYeYavATygOaSJMa+xDxDrTGHbVEebq77w1zev1Nardx/GVRLPzY4UHepQNXadUxKNoyv5BX9UGh0sqKxPrf9juE7AOvB519HfiJgqrfUrU4gBY5IMGzmyf3UTa7f+NgzDdjzopKVPejwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248727; c=relaxed/simple;
	bh=sa5MY/4qnjIlTcM26OTaQRH6io2F4KztGEzbvE2uq+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0VMajhOx9kn22f5x7nVVUEYX7wotlOqXeRCS4ZV7p2vXAsGuklDxx3HgXJypuoSn+XYDos2rJLZjV1/1SGeY1BIodLiE0pBOOM44/ZXxw+v6S4KiicctYx23c2xRH4rzUeGeIwhOBfxYHjEYC+gAatIxrnn9z0olZp1rs2DDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=a0Za4qTY; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="a0Za4qTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XbFjmkw0cbAgczo6aUjzlss3Z+fUKa2PBGSTTKpikow=; b=a0Za4qTY7SzyRrixB4bJpvaSQT
	ZRLlBRxJW0TYopxdN6TpsIcYIobFqDoo1UbfjwGP7GTJ72LEovKDUfKEyqmw2qpjoIXKHKOtiZF+q
	Ekl7JDQx8BFOcm9gQKVdh4YKEjOZ5eSn/i/lmiXeUt7f2udelVOh1uTcQ/hHFgeB6zQkMUty0YL6M
	3bkorHoEG2qnMIhvsllcLc6BJZFQ/YYmi/V6KeqDYNO0qDZfiNKuFHVAxNTieYu/d4cvrIf76tDLS
	RHyTYKLqHn0ru8G77hbjxBqdXxUMVAkTHnxleCyJvoJvJTgPdEptK/pTdDAjM4Q2tLrVAKx1+2oC2
	w9rbIOnA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t1kaQ-0005yx-Li; Fri, 18 Oct 2024 12:52:02 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t1kaQ-000E0u-1n;
	Fri, 18 Oct 2024 12:52:02 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH v2 2/2] gprs: allow attached updates and status' on eutran networks
Date: Fri, 18 Oct 2024 12:51:45 +0200
Message-ID: <20241018105147.1382861-2-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018105147.1382861-1-sean@geanix.com>
References: <20241018105147.1382861-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27431/Fri Oct 18 10:53:06 2024)

SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
6 registered for "SMS only", home network (applicable only when E-UTRAN)
7 registered for "SMS only", roaming (applicable only when <AcT> indicates
E-UTRAN)
+COPS supplies the <AcT> = EUTRAN
---
Changes since v1:
 - removed switch cases in favor of L_IN_SET

 src/gprs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 46668820..3c71f808 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1627,9 +1627,11 @@ static void gprs_attached_update(struct ofono_gprs *gprs)
 		 */
 		attached = have_active_contexts(gprs);
 	else
-		attached = gprs->driver_attached &&
-			(status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-				status == NETWORK_REGISTRATION_STATUS_ROAMING);
+		attached = gprs->driver_attached && L_IN_SET(status,
+			NETWORK_REGISTRATION_STATUS_REGISTERED,
+			NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+			NETWORK_REGISTRATION_STATUS_ROAMING,
+			NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN);
 
 	if (attached == gprs->attached)
 		return;
@@ -2637,8 +2639,10 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
 	if (gprs->flags & GPRS_FLAG_ATTACHING)
 		return;
 
-	if (status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			status != NETWORK_REGISTRATION_STATUS_ROAMING) {
+	if (!L_IN_SET(status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+				NETWORK_REGISTRATION_STATUS_ROAMING,
+				NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN)) {
 		ofono_gprs_detached_notify(gprs);
 		return;
 	}
-- 
2.46.2

