Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF0293C71
	for <ofono@lists.linux.dev>; Tue, 17 Jun 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152443; cv=none; b=A6A9lRm5Kni8NuV0e/MUvJM1PFAut47dwFLOCYccfs8kc/0k91h+I0uEG8peHeSUOeKnzY0Ct+3YnwI3VAIY74Ej5L6NbO2z61n+Y0X1EwyPwFgjt0oiEAGo1jdxdAlFs6twXxVFD+zcOxa6VsUiqY1HZdWEXxb8fv3j7cFyCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152443; c=relaxed/simple;
	bh=2ILh+fLVWX3m57QwjOYq4AKruJiF3qvKCb4NFav4asI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koY4AHQX56cW26JnT7yLkyoDc6lWnENyzvKQ9B9wb0iaKq0s//UHvwligiOs6RLbCzzXkj7FIHpQmGjD4ijthEtFpuXT64J3wGQduM0cS6i7MGReH1F2cuSy5bEXtl9CL9Lw/gWtuXKxF9YZHWm+CCrvnq41hoXG7cuqcNAY7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=k/RJ/tBs; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="k/RJ/tBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750152428; x=1750411628;
	bh=MyXD2M+VoPY1vm+tISBY2B9NveOwRHdvQR59gWjJozU=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=k/RJ/tBsZacsuJAa/HRtlW/abkMhXXEa40tGcJXclU2apnimFg42DLO5/eDEBe3e9
	 v6Skm2VfyH7FYDHauaCmqNdUdt2dNxuROe5nDmnYaFkZTPejoDMX+akqexqfjnidl1
	 EF56xI0yUzS0+SJpTSoNzPZJ+ocKtwKVgKd1Cl6EDJp+Iy+RKoocQo5WwdVOqZdqEZ
	 MXrqX+44HlvABjzWER+1CMt4hql6v5C+CXvbhsNbUdOSGjWVuTv/8SOBe6TMp/XJ+r
	 p3eV+0jRbLf7tJPEZnMYe/vMSjtYOJM2BUSRwPbgyj06U0QQmMTfi9n0a03cNxMbG1
	 3VoC5RCu2xUeg==
X-Pm-Submission-Id: 4bM1jQ4nxcz4x66c
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2] sim7100: query until AT channel is ready
Date: Tue, 17 Jun 2025 11:26:35 +0200
Message-ID: <20250617092656.1530528-1-sean@geanix.com>
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
Changes since v1:
 - removed double empty line
 - Remove timeout in remove()
 - Simplified open_device()

 plugins/sim7100.c | 64 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index b6389b09..4580bd2b 100644
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
 
@@ -154,6 +159,50 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+		close_serial(modem);
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
@@ -180,11 +229,11 @@ static int sim7100_enable(struct ofono_modem *modem)
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
@@ -192,13 +241,10 @@ static int sim7100_enable(struct ofono_modem *modem)
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

