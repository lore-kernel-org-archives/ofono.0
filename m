Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4E4437C
	for <ofono@lists.linux.dev>; Fri, 23 May 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006254; cv=none; b=GnlbI4qX/P63mnVU6ler5drwAUBqwCPa+ilFK57HR4OtDUdA94x0CHaKhuAv2O660Yy9LOoSOfE+CxbixoyFyGfFQg6iMSo+igrdLyf44qqFSjRD/ddSn3n/9PF1aJFxt7XYOb1gPYvsX2G93Dh+Kt8DMQlGjahHH9arHH2M1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006254; c=relaxed/simple;
	bh=SJ5aGBpz6N4mnjhvEoJRajZhPVZLCbuy4ZchR8CFiHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVVrlWg4UhLmm3F2q/VAeL/a9M8nxyomFxd+2YR0/x2PdzKG5FPgUkDXP4mP1GRIsgtrxRXCZ0OMsirg45FEN6jlNL0x6IQivlaiLxHsa4Tjj8AUTL2PbLodoFumrL8vlS+R2zoUA/fNLE2KNOupqULa36XLyOexPooZfIq0QHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=vZOXRTPw; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="vZOXRTPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748006238; x=1748265438;
	bh=zCEyjrjbYJR73ylRTeLiFWO+f4qsPS0EC5PWTOvjwQk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=vZOXRTPwwB0YXfhDNewCIOLCmJitNLUpjUdscnDOCv07lf00wugzU2uI6xpfUThFj
	 aCc+/+8wwgVStOh0/D89HP+cKXXOHEdHfar6TENWd5w9yz8jAbOlaVXjIFYvnU6voH
	 ychBtIlhzy3o56s/HfjJ+6THzSb+IlpZPdvJB4rJHS91J8b3MrtAoyRhm9ZmAV8eTa
	 2PdSwObD0GJweY79AiobTdt4Xe8+TGlizEkK4OHKi0zi3BdiyDLAlDVzfINGFtql8t
	 dKXuX6bfoDyFNz5gFCgO9nSvahrvhE+DtuODJm72GLSL7Rc4yIw5SGGHd3dVEpYZmM
	 sx8xI/bctMBYg==
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] sim7100: query until AT channel is ready
Date: Fri, 23 May 2025 15:17:06 +0200
Message-ID: <20250523131708.2225801-1-sean@geanix.com>
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

Is this the way to do it? It's quite weird that the serial channel
doesn't respond in a sane maner after power up.

Before this patch ofono would get stuck in enable and transmit CFUN=4,
our software would then restart ofono and everything would be fine
again.
I have done nearly 50 power cycles with this patch all being successful.

 plugins/sim7100.c | 75 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index b6389b09..d52e5b92 100644
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
@@ -154,6 +158,47 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 									NULL);
 }
 
+
+static void init_cmd_cb(gboolean ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	/* ensure modem is in a known state; verbose on, echo/quiet off */
+	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+
+	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
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
@@ -172,16 +217,22 @@ static int sim7100_enable(struct ofono_modem *modem)
 
 	DBG("");
 
-	err = open_device(modem, "AT", &data->at);
-	if (err < 0)
-		return err;
-
-	err = open_device(modem, "PPP", &data->ppp);
-	if (err < 0)
-		return err;
-
-	/* ensure modem is in a known state; verbose on, echo/quiet off */
-	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
+	if (g_at_chat_get_channel(data->at) == NULL) {
+		err = open_device(modem, "AT", &data->at);
+		if (err < 0)
+			return err;
+
+		err = open_device(modem, "PPP", &data->ppp);
+		if (err < 0)
+			return err;
+
+		data->init_count = 0;
+		data->init_cmd = g_at_chat_send(data->at, "AT", NULL,
+				init_cmd_cb, modem, NULL);
+		data->init_timeout = l_timeout_create_ms(500, init_timeout_cb, modem,
+				NULL);
+		return -EINPROGRESS;
+	}
 
 	/* query modem model string */
 	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
@@ -196,9 +247,7 @@ static void cfun_set_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
 	DBG("");
 
-	g_at_chat_unref(data->ppp);
-	g_at_chat_unref(data->at);
-	data->at = data->ppp = NULL;
+	close_serial(modem);
 
 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
-- 
2.49.0

