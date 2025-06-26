Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F14219E0
	for <ofono@lists.linux.dev>; Thu, 26 Jun 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921155; cv=none; b=Qb3nARBiUykfmOJv9YmuDtv8dp/FcNQ2HkPrE0w/jmS/Gc/7zWn2l+K6yE5D36rakCqydRmh2LWQMAPL5CdyXSfd8Vz7UChDnSc/b3SpF2y48j++4XnHvlPeW6xlD5rGVwmseDdkxQctuk8h2m3UBGPpkZDjw8VlVyCz6Vn9O1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921155; c=relaxed/simple;
	bh=Z5FIIgIykEnNktOzkFhh8AiI5FWxMSpdIUcQAZTyD3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWyX4jIeVEPJ8TsMxW60E1TYmSxrA0RDvNuA9PEyKw43H+tTj1nr2bKu6ND+Whl+RyyhSGG+Zwvz55sP8ppzs6v8Nj4szCfxSO4gU0lgBBBvjaIpa1grR0J+AU/vJzw8tLbafmBcCh5iUzqGvkVZOTTFG7+MyMu/uN12+yme1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JsTXTmIh; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JsTXTmIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750921139; x=1751180339;
	bh=K/OX4Rmjmi5Ebxl0yaVA0ot80UKMpyVl5zXD1JRZ9co=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JsTXTmIhufbEJBq/uHV6Px3qYaKS1WHz8k/yruEOc7jigj33yoMrSNcWyd5Rst3Ab
	 Zr74nl4THflpU4cXrw9prLm2A4ZJk8NQE47IW6l/+/FVVRAOAMmQUcXMQPE4xCe97w
	 DqUNQ8/pE8vUFGpLwzKsEb/zoTtG+sITs+DWOFuui38ztGPGgAwQhbMvjnr4aYArG/
	 xUPsknOajRX+vERjRpNHKCW6qYAiNThbmz2CB81DSuB5hrPxmqIF+k4lssJJ6+Dkti
	 e/J3hbuFQP32ZDqjarY5Xnq+YR8YCSPkYjsmu0kRne3uxAD8FCe8Fqb4MP5Tuv3c7U
	 s+d7dAeZXLO8A==
X-Pm-Submission-Id: 4bSV0K4ZWWzNr
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3] sim7100: query until AT channel is ready
Date: Thu, 26 Jun 2025 08:58:52 +0200
Message-ID: <20250626065853.1357255-1-sean@geanix.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's seen that the AT channel contains unknown data upon power on.
Query the modem until it answers with OK. Create a timer to re-issue
the AT command at regular intervals until the modem answers OK.

plugins/sim7100.c:sim7100_enable()
plugins/sim7100.c:open_device() devkey=AT
src/modem.c:get_modem_property() modem 0x261f20 property AT
plugins/sim7100.c:open_device() devkey=PPP
src/modem.c:get_modem_property() modem 0x261f20 property PPP
AT: > AT\r
AT: < \r\r*A
PPP: < \r\r*A
AT: < AT\r
plugins/sim7100.c:init_timeout_cb() 0x261f20
AT: > AT\r
AT: < AT\r
AT: < \r\nOK\r\n
AT: > ATE0Q0V1\r
AT: < ATE0Q0V1\r\r\nOK\r\n
AT: > AT+CGMM\r
AT: < \r\nA7672E-FASE\r\n\r\nOK\r\n
plugins/sim7100.c:cgmm_cb() modem model: A7672E-FASE
plugins/sim7100.c:cgmm_cb() before CFUN
AT: > AT+CFUN=4\r
AT: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
PPP: < \r\n+CGEV: ME DETACH\r\n\r\n+CGEV: NW PDN DEACT 1\r\n
AT: < \r\nOK\r\n
plugins/sim7100.c:cfun_set_on_cb()
src/modem.c:modem_change_state() old state: 0, new state: 1
---
Changes since v2:
 - Avoid leaking timeout in init_timeout_cb()

Changes since v1:
 - removed double empty line
 - Remove timeout in remove()
 - Simplified open_device()

 plugins/sim7100.c | 69 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index b6389b09..cec3b35d 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -22,6 +22,7 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <ell/ell.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -57,6 +58,9 @@ struct sim7100_data {
 	GAtChat *at;
 	GAtChat *ppp;
 	enum sim7x00_model model;
+	struct l_timeout *init_timeout;
+	size_t init_count;
+	guint init_cmd;
 };
 
 static void sim7100_debug(const char *str, void *user_data)
@@ -98,6 +102,7 @@ static void sim7100_remove(struct ofono_modem *modem)
 		g_at_chat_unref(data->ppp);
 
 	ofono_modem_set_data(modem, NULL);
+	l_timeout_remove(data->init_timeout);
 	g_free(data);
 }
 
@@ -154,6 +159,55 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 									NULL);
 }
 
+static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	/* query modem model string */
+	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem,
+			NULL);
+
+	l_timeout_remove(data->init_timeout);
+	data->init_timeout = NULL;
+}
+
+static void close_serial(struct ofono_modem *modem)
+{
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	g_at_chat_unref(data->ppp);
+	g_at_chat_unref(data->at);
+	data->at = data->ppp = NULL;
+}
+
+static void init_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	if (data->init_count++ >= 30) {
+		ofono_error("failed to init modem after 30 attempts");
+
+		l_timeout_remove(data->init_timeout);
+		data->init_timeout = NULL;
+		close_serial(modem);
+
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_chat_retry(data->at, data->init_cmd);
+	l_timeout_modify_ms(timeout, 500);
+}
+
 static int open_device(struct ofono_modem *modem, char *devkey, GAtChat **chat)
 {
 	DBG("devkey=%s", devkey);
@@ -180,11 +234,11 @@ static int sim7100_enable(struct ofono_modem *modem)
 	if (err < 0)
 		return err;
 
-	/* ensure modem is in a known state; verbose on, echo/quiet off */
-	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
-
-	/* query modem model string */
-	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
+	data->init_count = 0;
+	data->init_cmd = g_at_chat_send(data->at, "AT", NULL,
+			init_cmd_cb, modem, NULL);
+	data->init_timeout = l_timeout_create_ms(500, init_timeout_cb, modem,
+			NULL);
 
 	return -EINPROGRESS;
 }
@@ -192,13 +246,10 @@ static int sim7100_enable(struct ofono_modem *modem)
 static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
-	struct sim7100_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	g_at_chat_unref(data->ppp);
-	g_at_chat_unref(data->at);
-	data->at = data->ppp = NULL;
+	close_serial(modem);
 
 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
-- 
2.49.0

