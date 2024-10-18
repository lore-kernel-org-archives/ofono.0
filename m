Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC0187322
	for <ofono@lists.linux.dev>; Fri, 18 Oct 2024 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236472; cv=none; b=g61T/vyHgqyRhLJKv7TC5iX8mGMzUgvWfrSp5DZxd2+8/H4hX8Erp3rzHQxt4Cvq9VBouz5A7exx52JbW4EmEILUWUjunO3swEPNP6cziTfOV3uv17B3mEy4LTrRgFXjsPEM3zY5IWPB8aEaMx3Wrr7Ksr/UE7rDXaEiljJED5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236472; c=relaxed/simple;
	bh=UgBkhAGXmNN0dtUWT57SBaiz32qxQI9MhNxsxaDSrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ9GoyPW3mPuPwR+XJkdGF0+kCWmWlkhGBptQvC6yxyCwIptFZPB5gm0DIh0N/gkdt/x5pfSRTcTfMw1QsEwU0zDmNr42wj5iIPUET+l9/FcoSQcVmiGNNXb0UsUXjFUediOkH1bSAC2VPV3vAojvPr0uqRYdYVuuUcOHHm+A5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CD4om4+g; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CD4om4+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=9YKM5S3uz/IRGPRuz6PU2jhJh9zwMHM1OTsmt1zmdqg=; b=CD4om4+gHgb1agS4ldyMS1TPib
	IqtHDJxAEDN67tXzwShbyxbZey4GpoL+SshoJx4FuEuaPjRHrTOso/l6DL4nLJ7Tj9Cqhc0qYCN++
	a0pzwRbLeEHCVsm6v2cI4mJ+9sHiS7YJh7CsQk07dZPljXDV3crCg2JqNyEXCo6EdqJh43Nn4zUoc
	EtoLF3d6LcBbZurjN54JJ9q16uoHQJGcZ0NI5oxQ0hdyzKhnHuWboHgpjdgkkI47pDb/v8zYbhSNV
	1jd9jLNxdr3G6KKPGTiYNLEYA2kE7gJsurUReGvlemi4T8OowQik4z4Y1d5aBNeQhPbFW4gjtEzXn
	fYKGdaXw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t1hOe-000Hbp-Bt; Fri, 18 Oct 2024 09:27:40 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t1hOe-000Kj1-1K;
	Fri, 18 Oct 2024 09:27:40 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH] atmodem: let +COPS: report access technology for SIMCom
Date: Fri, 18 Oct 2024 09:27:35 +0200
Message-ID: <20241018072737.1343332-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27430/Thu Oct 17 10:33:26 2024)

When using the SIMCom A7672E-FASE in gsm mode, gsm is never reported as
access technology.
SIMCom modems is showing the current technology via +COPS.
---
 drivers/atmodem/network-registration.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 46b8512a..c841bbf7 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -353,6 +353,11 @@ static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	op.status = 2;
 	op.tech = tech;
 
+	/* SIMCom modems shows the current tech via the +COPS
+	 * not like other modems where it's shown via +CREG */
+	if (nd->vendor == OFONO_VENDOR_SIMCOM_A76XX)
+		nd->tech = tech;
+
 	DBG("cops_cb: %s, %s %s %d", name, nd->mcc, nd->mnc, tech);
 
 	cb(&error, &op, cbd->data);
-- 
2.46.2

