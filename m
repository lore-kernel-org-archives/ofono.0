Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB016BE2A
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378649; cv=none; b=pqNcywJGS7ExD4qhAZhBorZimFLFB//+l4oeeMRU/XU0SHqSNhSMlRNpau41C6PM1kNZVNAo60x9clqDkp3O4LRiKBzzCf39S6hcs699M49lW2RDX5efbYihiyeG2OCGKJZqbq9eZoEdbe4VIstSDvtvmhZ3V+wrctery513fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378649; c=relaxed/simple;
	bh=uc/hanB3RKz2ahsBgM+Yg3ovZBYPoXy39RS0UK3+qmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBU0HcLN4KLs8UiY5mXsz5I9ZOdehVXuLP9P3RrLndPAZvx/s29Es7y2VjjmGSBodYA6T7HT5Ame2p7XLPdIVLz6EvqIkU1ux6ScD//jySCaAaQqnjOBKbdg3hEozSX9mx43IXufQXE0OZ1iMkorRIcGWIEw4b/+2PMoXewMKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LSP95l28; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LSP95l28"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5/CXY8Uivqf3YkVgq1TkXQxTG5oGG2yfse1lyAVCrwk=; b=LSP95l28okaaKy74Tgfg2ddAm4
	uXUx6hVE21RmldKp3fGN1tskfjUDDfWQTobLZbcossEVGhYYcNWKxFb4xyaZ6dCMMhW6yp1ZpZ2S2
	8gAe3WmF4MI6pF6DQ5obxJdB9xtJkxa6W0ccY7XXkc4rn/A+XgicXLQhpsSgg6FPsXDMsCJtbv0XW
	QAdrx8hn4O0BIN+yHAj/jERYQ32+7AxwuywXwu6zyvN8uT8rzV+vy15p2aKZn5fY34WzbW2G4sOFm
	hSxfeAWgEl7CwoG5HzI640vJXST9IFWWrR3GzAXvnrdlgjNseb+LeW+D0cuaWRIsnwNtcQI8Gz0o/
	YzbLCC3w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6Ev-000MTR-8q; Tue, 08 Oct 2024 11:10:45 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6Eu-000P2R-3C;
	Tue, 08 Oct 2024 11:10:45 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH 3/3] sim7100: create lte atom in post_sim()
Date: Tue,  8 Oct 2024 11:10:36 +0200
Message-ID: <20241008091038.1567406-3-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008091038.1567406-1-sean@geanix.com>
References: <20241008091038.1567406-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

Enable LTE functionality for SIMCom A7672E-FASE
---
 plugins/sim7100.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 9413a8af..eb5a4dbe 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -24,6 +24,7 @@
 #include <gattty.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -104,9 +105,13 @@ static void sim7100_remove(struct ofono_modem *modem)
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
+	if (data->model == SIMCOM_A76XX)
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	if (ok)
 		ofono_modem_set_powered(modem, TRUE);
 }
@@ -272,6 +277,7 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 		ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
 		gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
+		ofono_lte_create(modem, OFONO_VENDOR_SIMCOM_A76XX, "atmodem", data->at);
 		break;
 	default:
 		ofono_netreg_create(modem, 0, "atmodem", data->at);
-- 
2.46.2

