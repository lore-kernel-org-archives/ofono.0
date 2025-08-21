Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7ED1DF756
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775472; cv=none; b=YZEv1L67QIcY6Fb8LYzNmBLfDcxG6e1iI4PXzsacRsI2G/JSecvo4+B1BQoB9m55Ivpft8qvzmXb+q1lX9IOGPWGWZkpq5CQ8i6S2gQtaSlQINOQHYIV4F2PsqhFbUCDx9WdpLU/5ummUfWlEiZzXAtHyit5nY8EmR321sHJjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775472; c=relaxed/simple;
	bh=3nRifppznURpWncV8h1f2zN4ZC/ukDK5QYKDHQHnj/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=RgQRIqfWviBbLFS7lvVSE15E5lU9d4g9MDl9JDXwJvW4pNCRvLiZNito6gVWpvoyucE36wbz2RpTbJwQ30pT/wzpzrc9nZbxNbDfiRHf9klCR2PTji2rSygbaeo3nL32Fj413z12+YJBEgP3dxfyJF9hosnOOGY3G+kMo/Kf9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=VGj5TK87; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VGj5TK87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775462; x=1756034662;
	bh=i21AFWOXUXi6gEZeg5ARa6asU4+HVBG9yhjYYxjbwYw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VGj5TK87a8vLHdHDtzMdA/6uxtuwzvvIzcZMJF+SU4I+6wyOqyF6Ms8j5CW6f6uJP
	 V4fHzjOMNDKVRQDYma/++TXg7P32FH6Y77wZZfqZUijE4TLwpMQdGdrBS8taRVx7K+
	 Nr6u1SKm2cIq3WxARb6mIAmbTFCQqYbMC6/Xg8Ju6NUueMy1AvNbNwe1lzCvaLScqz
	 deMbCbPJY4Ni40j4wg7ebAwiwC+mAAoC5l9PQk3GFnpW29S4+YiDx8yQbz24oCAveZ
	 bVIIA3FPBiEZE7Z47+QJ3418mfZti13ls1OqEBIh+d+ojvFfmzDzw1RWyDIHgVSq6y
	 19C4CmFSL3Hhg==
X-Pm-Submission-Id: 4c71Dh6ht3z1DDs0
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 21 Aug 2025 13:24:11 +0200
Subject: [PATCH 3/5] atmodem: also handle EUTRAN networks in creg_notify()
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-simcom-v1-3-6c794c5573c3@geanix.com>
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

SIMCom A76XX shows attached on LTE with +CREG <stat>
so add more values from the network_registration_status enum.
---
 drivers/atmodem/network-registration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index e13ea5b2405769825e8535648b1b0c283236f08e..8087543117b7abfce87240940e47264283f95234 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1575,6 +1575,8 @@ static void creg_notify(GAtResult *result, gpointer user_data)
 	switch (status) {
 		case NETWORK_REGISTRATION_STATUS_REGISTERED:
 		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
 			break;
 		default:
 			goto notify;

-- 
2.50.1

