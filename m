Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E51DB92A
	for <ofono@lists.linux.dev>; Thu, 21 Aug 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775471; cv=none; b=XMThGCAdP6FlCR9idHoB79W5dCeSnZ+0QmXT6V+tdMPdkudiKnfFNbPQN29kMZcnPMNAngdYVwjquJbvYq6yTtD3eXvwvhGnlAL4/7ZU54FqH1diArow2xF5eeBCjum6cqD9pWKgEvF/C6sQzCe1X59F6yegxQmbMK4a3+a9vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775471; c=relaxed/simple;
	bh=ifjxzB8pWjuzurmMvhMLPVDP6Cd+6dqgenh6SZNcFXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ZFs7Ypw2Ac+Xs2xSHysPnDa+9XQbnY7OKRkehmajXANuQNy4+IPrFst2Z9CfmEG6BJDJZWTMiRZJLD4GCSO3ZvAVulm3RxwcSizMqm5cSPB8eJYCD4vo2ZVjYDX4KK8DPKbGqVYr1+H0ZyPHAeU3EdfxSbR3EUWwx1EGuocWhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QW8zGHgK; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QW8zGHgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755775461; x=1756034661;
	bh=GzeXbwWm4PZxhqXW/2zF7emaCbzqU3aq2erAMnR/dkQ=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QW8zGHgKWyoLA6FC7D/mBn15ZjJcWM6DpXbcUufI8c6iP9QgywsLLj8TnWUjMfcPs
	 YTpegAJPzDlyFkBRzMcLdody6ShkYjcMpkOohmET29390Mupk5LhQEN5vg1O5oIkAq
	 4OrOHKi4AJ6R9iT9wDwVbbPf7wEwzLobBKouDX2AFHZ1YfQRJf3N3xq1ekepYcdVWH
	 JrhDaRzQqIUBDyi2R2EwAK2ZpI5O8RyihsIPulStPa7eL6K7kLnHxNY6mo44iXDaLu
	 wjT05LDixFiSFFbdgXfYBmg+2DS5YskBg34EzhrlDMmELvdLfpeWK/XWlXMWhRxb6i
	 SNvb7wLEjqSpg==
X-Pm-Submission-Id: 4c71Dg6kN4z1DDrv
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 21 Aug 2025 13:24:10 +0200
Subject: [PATCH 2/5] atmodem: add explicit handling for netreg status in
 creg_notify()
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-simcom-v1-2-6c794c5573c3@geanix.com>
References: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
In-Reply-To: <20250821-simcom-v1-0-6c794c5573c3@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

Modify creg_notify() to use a switch statement with the
network_registration_status enum.
Previously these statuses were checked using a conditional
statement, which was less clear.
---
 drivers/atmodem/network-registration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 18e56f2bf9e2dbd6c96947ac57f66ddf0125391e..e13ea5b2405769825e8535648b1b0c283236f08e 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1572,8 +1572,14 @@ static void creg_notify(GAtResult *result, gpointer user_data)
 				&lac, &ci, &tech, nd->vendor) == FALSE)
 		return;
 
-	if (status != 1 && status != 5)
-		goto notify;
+	switch (status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+			break;
+		default:
+			goto notify;
+			break;
+	}
 
 	tq = g_try_new0(struct tech_query, 1);
 	if (tq == NULL)

-- 
2.50.1

