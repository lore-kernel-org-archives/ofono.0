Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243E13D244
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=cXuoz9DairPG2pSWyi0JvLR5ozgtcSSJlQ1G6raPgxTnshmuDE3Is12EmKv8+EX4vSKjfMLc3X7AkPAMHv35rPSBT0fQbQ5ZyD4xKyW2UkqVdjRNe3KzixtyVQZk419Xa/5L0MOe6TdgdTlU0+oWSW2e5tED6YhhrXveGK75aJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=SaUbt63thWBnA3Oba5KoK8PppU8qE5nUWPDPJXNT8cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUouzt7Vz3lN7z+tRfFQNi8qa/U+qYm2ZXF+BwnPPi8bmzixiBeW8Q3bnuI7UzMEnSiEDXLfILNqPWtAVe14j3b+Wc8wzMJoQIp/MP/73M9zw6Q0GMbBzkq3AtoH/obhHr9s2hJLnyXiWWHrGLa9V5N8+4cnrVW+B2dXP3T3eT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FPJ0mMON; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FPJ0mMON"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+QWHZqqYHx8GsZDXPfX/n/xrJowx9aa63O4q4DAeefQ=; b=FPJ0mMONN1de5lQj1Bq+GbGUCG
	c+shIU6qgOCPzY4QRYI9f8ICkP11Lolrg/oI/ujuRYIDFbrn82bTyCQjw7FDgdhPUqeEVraS32iJC
	JUDaeKGb4cpD3VAGwCkmYeHFZ9MI5UHJmrJOw0oLVapWXS+sIQzviJXeptY52zsZWsuW0nQV8owvh
	i0iVML1KKYWoizPu9TzgT/q0Ojh9kvWu/cXBGiWIdx+gTFrx/8twd24bi6hTdcAVw0WdU7CIY4rX8
	FFLFowToBqtM8lw5SGFxLF2ItSyaQzGFBEiPqhIDK3mCNfs3JZYcJUqSl4e91FWsLjkfbG7rt0RI7
	+ZLoJM0Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2e-000GV0-2F; Tue, 30 Apr 2024 13:53:00 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000LNp-28;
	Tue, 30 Apr 2024 13:52:54 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 10/10] sim7100: create radio-settings atom for A76XX modems
Date: Tue, 30 Apr 2024 13:52:33 +0200
Message-ID: <20240430115234.180185-10-martin@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430115234.180185-1-martin@geanix.com>
References: <20240430115234.180185-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27261/Tue Apr 30 10:23:42 2024)

---
 plugins/sim7100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 192559d6..90f97742 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -49,6 +49,7 @@
 #include <ofono/message-waiting.h>
 #include <ofono/netreg.h>
 #include <ofono/phonebook.h>
+#include <ofono/radio-settings.h>
 #include <ofono/sim.h>
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
@@ -281,6 +282,7 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 							"atmodem", data->at);
 		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
+		ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
 		gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
 		break;
-- 
2.44.0

