Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81D192582
	for <ofono@lists.linux.dev>; Fri, 25 Oct 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835784; cv=none; b=MQ3Zql8Gwqi1XLusnzCF599hG0ZncuG9fSSdQXAffuu25uDpzKwSXH/f6FYtyIulxragMAfBx4/kfd3bnsiJoOnAhOH8wT0YWq5Y+yfG1dH5Gw3TyRC6LjU+AVNd1dlnhiF4Zfk5cM1iErQq2+czU4RmULNTO9DUMcwvI1NtDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835784; c=relaxed/simple;
	bh=EQCe2sE55IFbeiNDg/1x+UDQAuRc9I/lta2l7q8Lico=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rupISa2lAB2HentrO/h3uPxq/p9xeg3Jnq2U/uRmRwLYufGoeHKu85VUd1uy5GHqMLDvQnbxeYbWsrOMkkicOXrSsRkoZ6/4NnmSuhpJpe0PFwqV+7kbap2oJueXHHSvWsbVJjBCtgN3lb2+zsty12524xP6G+kit2krSuNOj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jITpNGGV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jITpNGGV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5MER8f4azzfYHJ8o4u6vh73ov+u1Rl6xSVKPbCHPmLQ=; b=jITpNGGVJJ71Vz1iQNMz7lNTq5
	ih62OwpZflH+B0Bt1uT6KxMYDIr8Pcq2RdwRcJP+Mpl3FnaIlTZEs6EWHpC1+MK1h33Ch3CqdggoR
	9XzXnDlBpp6GhQjyQk2rs/4ExW2MsnekmpKJz8TPPTWzUAqhzt5NMWbQkIMfVDDwWglR3MhmbRK5a
	isyrC0xT356eX/3p2inxm7LUuezuzTMJV5elBdh0ErObCuUWzP16SxRLL5Nn3svjyxUHMl0pVhJdu
	jl3vwh2uPAtQwgO+vQiH2okhGzNsajOshO8Y/HixNGIMeM24ucLQ/GOfcfzyLVT4HwPDbUGwpa5yg
	DRDG+LRQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t4DIv-0007iV-Br; Fri, 25 Oct 2024 07:56:09 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t4DIv-0007j6-0r;
	Fri, 25 Oct 2024 07:56:09 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH] Revert "sim7100: create lte atom in post_sim()"
Date: Fri, 25 Oct 2024 07:55:56 +0200
Message-ID: <20241025055558.2563056-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27437/Thu Oct 24 10:33:37 2024)

SIMCom A7672E-FASE doesn't support initial PDP context (AT+CGAUTH=0,...
and AT+CGDCONT=0,...) which is what the lte atom is enables.

This reverts commit 8869b39c1e3a1b76637ffb13fc5de800d7f88c2c.
---
Kinda embarrassing sorry :)

 plugins/sim7100.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 215f4a28..b6389b09 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -24,7 +24,6 @@
 #include <gattty.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -105,13 +104,9 @@ static void sim7100_remove(struct ofono_modem *modem)
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
-	struct sim7100_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	if (data->model == SIMCOM_A76XX)
-		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
-
 	if (ok)
 		ofono_modem_set_powered(modem, TRUE);
 }
@@ -277,8 +272,6 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 		ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
 		gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
-		ofono_lte_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
-							"atmodem", data->at);
 		break;
 	default:
 		ofono_netreg_create(modem, 0, "atmodem", data->at);
-- 
2.46.2

