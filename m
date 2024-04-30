Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F5134412
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=UXIBULWxBiZyEfO6t9Wl/qUcccFBUCdTLAlqf3t23DBeJBNMjZ5wD0WCw/PeYy+m8+OgfEIgkE/4h7pfJti+ptS+/Z4t+5CrOFa9HVIrlmiRmplon2REmN7w7Kx8Cn4eH8KfOF3nYweHo5F3t1ZIgzuv/J+lcRoEnJ4YU6vKSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=hurTair7Hlv5kROI/p+kSfPv+cn4cEuVf3IIrY4NZOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu93iPf/xEZjpt13K2/g5/gSY7cihlX6Nb9pay5OsGZzs+WWeZO6MXXe7VV0O9PVDDj/FGlwQCPVvEItc2Mld7Pmo5CwpmhBF9Q+iwYrCIfn9Tu5/1dr/q8FZlTq/AFbWIFtW5L+BjTS1z2A+9I9/8qfkytfVyztnjar2p3iX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Ndien5In; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Ndien5In"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Gk4hQeU3TVPpll7cZ5Kd1YZyGdIGZtoYHxlbCTsTwvA=; b=Ndien5InSKv3Qv5I1Akr+Vf+hl
	zh53KiTgvqilxmdP+6WjxC+/QsV7gUa+cCEMV/HZg7CcYquMgbvxjh5eeruCjtGo33cH37ANVvAKd
	jykTftmUdiOPjmlzgHMfmp1wum9qbL7piVJ9kz7lSUkIpB42pKWU5FbypviisJasOuc/a6VXEstCJ
	h3mDTFbhmW7n55Wzvxm0ww2BBILU1SvOZfg0KBZS1Y9EHRT1+o4UBlaX9QJcAMviiy48miCIM4tal
	Z/EKHfKLqXcZZrmJgDINq5YopjdlPkXNdsPpZnl4nQL3zn4P4uldeYxumq3N1YdsPQUXVQhewvanL
	ageYMnYQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000GTw-U2; Tue, 30 Apr 2024 13:52:53 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000LNp-1t;
	Tue, 30 Apr 2024 13:52:53 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 03/10] sim7100: query device model during enable
Date: Tue, 30 Apr 2024 13:52:26 +0200
Message-ID: <20240430115234.180185-3-martin@geanix.com>
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

Adding support for more simcom modems in the sim7100 driver requires
certain variants handlings based on the present modem model.

Default to an "unknown" variant to keep the existing behaviour, and
introduce the A76XX model to use when later adding support for the A7672
vartiant.
---
 plugins/sim7100.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index b5e65891..1c80f4ba 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -59,9 +59,15 @@
 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
 
+enum sim7x00_model {
+	SIMCOM_UNKNOWN = 0,
+	SIMCOM_A76XX,
+};
+
 struct sim7100_data {
 	GAtChat *at;
 	GAtChat *ppp;
+	enum sim7x00_model model;
 };
 
 static void sim7100_debug(const char *str, void *user_data)
@@ -116,6 +122,38 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		ofono_modem_set_powered(modem, TRUE);
 }
 
+static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+	GAtResultIter iter;
+	const char *model;
+
+	if (!ok) {
+		ofono_error("%s: failed to query model", ofono_modem_get_path(modem));
+		ofono_modem_set_powered(modem, FALSE);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, NULL)) {
+		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
+			continue;
+
+		DBG("modem model: %s", model);
+
+		if (g_str_has_prefix(model, "A7672"))
+			data->model = SIMCOM_A76XX;
+
+		break;
+	}
+
+	/* power up modem */
+	g_at_chat_send(data->at, "AT+CFUN=1", NULL, cfun_set_on_cb, modem,
+									NULL);
+}
+
 static int open_device(struct ofono_modem *modem, char *devkey, GAtChat **chat)
 {
 	DBG("devkey=%s", devkey);
@@ -145,9 +183,8 @@ static int sim7100_enable(struct ofono_modem *modem)
 	/* ensure modem is in a known state; verbose on, echo/quiet off */
 	g_at_chat_send(data->at, "ATE0Q0V1", NULL, NULL, NULL, NULL);
 
-	/* power up modem */
-	g_at_chat_send(data->at, "AT+CFUN=1", NULL, cfun_set_on_cb,
-								modem, NULL);
+	/* query modem model string */
+	g_at_chat_send(data->at, "AT+CGMM", NULL, cgmm_cb, modem, NULL);
 
 	return -EINPROGRESS;
 }
-- 
2.44.0

