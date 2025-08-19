Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC02749DF
	for <ofono@lists.linux.dev>; Tue, 19 Aug 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600442; cv=none; b=UBFYJ7cF7VZg80s7YMs5YJFtNCh8BvdJmydpmrNdQZ/JpOfrvO5sFPsYw7HYxtQ+JGAk+vUwxRFjGoDmoQVZk2VnNFZWZNUboN/xC+xdw8HLiSFVHFobHqVOxefmpzwTvItuuSEvll+uhBK4gwAVP/0Pt8C5KmebGLl+F87gIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600442; c=relaxed/simple;
	bh=Wxl+HlxiM9yicoWjAq3NRXmPH9KpugTAxqhOZrFMobg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwdaX7Ya/UU23PWmUcERxtXmsSstRmmSeGkDh+nm8ZircYSD27FbleMrFLPZImT3p0449XDv0CzrxCZc697SR4O7xaLodfRwoFur/+bfsAOlQhKZlWbNVGASxsfR7fOakSuuRpJt6iBvqzsmxV2Vwj4kW0n15CsQlv7tPOQ/9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bIVXXFFo; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bIVXXFFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1755600426; x=1755859626;
	bh=DUEdGJpKUxA/IFXDKhV4JbD3Cp05qmBKCEhxkxF/Pns=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bIVXXFFoPCu6OS2DYmeZIrOo/XouV1zY84ZiXeExtns5cMYe77srdvmUyGmkcBg5h
	 ReeKg+HBHX7loNo+STSzd8HfS5pVfaiQ/1rAsPZZLrxoi/0ZyU4YO9m37o/VKyncUS
	 bYUqMjgMT2qPLhnIVyve+4wEa+pdMz2cnzp962sLUVNe64Ma2GJmfg5wj3MWv3mMWE
	 b08+c8q3pBxm0JfzbdwWRYlUsfuQwH4plULQRt08yCOoZ7wAINtCWqUQK0tUgh5hMt
	 eoYw9u+0EwHlyWI1/A4/fo9cf82chcJgRxNPm99IVcdy4aNDoSixAcXIabdnK+hCQz
	 aw1gg9P8p7ECg==
X-Pm-Submission-Id: 4c5mVc4pQRz2ScXr
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] sim7100: enable ppp-reset workaround
Date: Tue, 19 Aug 2025 12:46:59 +0200
Message-ID: <20250819104700.1027172-1-sean@geanix.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement AT+PPPTIM command handling for A76XX modems to enable PPP
state reset when powering off (AT+CFUN=0). This is needed because the
internal PPP engine doesn't shutdown when powering off and makes it
impossible to create a new PPP session before the old have timed out.
(15 sec)
---
 plugins/sim7100.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index cec3b35d..02f5b537 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -106,13 +106,49 @@ static void sim7100_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 
+static void ppptim_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+
+	DBG("");
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
+static void ppptim_support_cb(gboolean ok, GAtResult *result,
+			      gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (ok) {
+		/* enable reset of PPP state upon AT+CFUN=0 for A76XX modems */
+		g_at_chat_send(data->at, "AT+PPPTIM=1", NULL, ppptim_cb,
+			       modem, NULL);
+	} else {
+		ofono_warn("modem doesn't support ppp reset on disable; is the "
+			   "firmware up to date?");
+		ofono_modem_set_powered(modem, TRUE);
+	}
+}
+
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
-	if (ok)
+	if (!ok)
+		return;
+
+	if (data->model == SIMCOM_A76XX)
+		/* does the modem support reset of PPP state upon AT+CFUN=0? */
+		g_at_chat_send(data->at, "AT+PPPTIM?", NULL, ppptim_support_cb,
+			       modem, NULL);
+	else
 		ofono_modem_set_powered(modem, TRUE);
 }
 
-- 
2.50.1

