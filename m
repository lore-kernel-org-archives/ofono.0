Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B9134403
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=ff7moqQBlxLdD9YNUg4DfsZGGLv3Ou4GUUxpAb4E2dTU/FgaOG+Z5C9YEYmPlgYGNX9vlGbz5Z5g6tk/1UFLa/FSHzdb5QgxPZEJaseh/Q+V2zAG1HKsyRHT1352OG6XiFryZLhg0G7FOhT7ZRR8Err2L4NrjDxTA5MhJNrX/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=5IshX65bbZbSBYgTgbCX54m5k0jZlPDcNH7HLK+ZKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e489LFSeIXcUcnpvPTbzZsAf+A3OVJcI7avJdS+4S26mt8XDP/fYzlwt2WqNp6MqUBfR9qLiV9ylBS0Y+XFug856vzDTri9wt/s/U3o3aQEh+4M9tkX5MWs6kl6vLLBcTVqk8f6NAit3WMUzMSmif9mx7Ipe9vxE4pNTK8InETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=gZdJNwJ6; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="gZdJNwJ6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ooarV3S23MeFyEO89PgDBgJT+3VvB4BRufPC2ySee6w=; b=gZdJNwJ65hA6aYvJj3RkWp91ho
	IF24QNFG4RyqlLVFsnmHJyKApAF3itIUOwDrmtAW+6yUSI3FdQ87SE5/7sTmWD2pg6X0/py16bSGR
	DBIdfcoi9hPfOIpOdB9tDoXEerOX98WagGLpDofzKkcZrDEuJw3ZlNYWmGbAxc/2wDBCOyJtPETYK
	Xp08HEU9w+YIuo8kXy8KE1/B0ozAWHLDpPf70BaphkJFA9T3fLWXatr1g6xnTp2JosgmwBLJ2hqFU
	nRd/2F6FY4uMSBuvemDRM+fwmfcTAFoYqOtOYow3AVq0Px6Wda/VXSn8SVYZvMavi9+1GWMTkTf1n
	A+Ze14ug==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GU9-2R; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000LNp-2O;
	Tue, 30 Apr 2024 13:52:53 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 04/10] sim7100: implement set_online()
Date: Tue, 30 Apr 2024 13:52:27 +0200
Message-ID: <20240430115234.180185-4-martin@geanix.com>
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

Enter pre-sim state using AT+CFUN=4, and move the AT+CFUN=1 call into
the added set_online() callback. The modem (at least the A7672E variant)
generously issues unsolicited events between the CFUN command and the OK
response, so match on the +CFUN: prefix only in set_online().
---
 plugins/sim7100.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 1c80f4ba..f4979ffe 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -59,6 +59,8 @@
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
 
+static const char *cfun_prefix[] = { "+CFUN:", NULL };
+
 enum sim7x00_model {
 	SIMCOM_UNKNOWN = 0,
 	SIMCOM_A76XX,
@@ -150,7 +152,7 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	}
 
 	/* power up modem */
-	g_at_chat_send(data->at, "AT+CFUN=1", NULL, cfun_set_on_cb, modem,
+	g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb, modem,
 									NULL);
 }
 
@@ -265,11 +267,42 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 		ofono_message_waiting_register(mw);
 }
 
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_modem_online_cb_t cb = cbd->cb;
+	struct ofono_error error;
+
+	DBG("ok: %i", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void sim7100_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	char const *command = online ? "AT+CFUN=1" : "AT+CFUN=4";
+
+	DBG("%s", online ? "online" : "offline");
+
+	if (g_at_chat_send(data->at, command, cfun_prefix, set_online_cb, cbd,
+				g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
 static struct ofono_modem_driver sim7100_driver = {
 	.probe		= sim7100_probe,
 	.remove		= sim7100_remove,
 	.enable		= sim7100_enable,
 	.disable	= sim7100_disable,
+	.set_online	= sim7100_set_online,
 	.pre_sim	= sim7100_pre_sim,
 	.post_sim	= sim7100_post_sim,
 };
-- 
2.44.0

