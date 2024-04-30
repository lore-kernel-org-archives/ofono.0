Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597213CFB5
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477984; cv=none; b=V4fzVkzKYuGofGlkti9zhuagKb6G+eM31dO2RaI3CwdAg0jp7vz+C6JobDtvoas5Y4f6+BygysZO7jwsWLaegqBrT+UJTwiO2H2MRxQkGkWD/4i6NpoXrCkOOba9zJZfH/cklz4qk5+tS66AyW6BCxAKFL/q+WPO2qiPODwmvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477984; c=relaxed/simple;
	bh=mT2GjgqPrEO98g0eJh1qPIS5koA61Bi7HprH0rcCS9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z905/j4kwhb6nNYmLM879xKUHlezP8ndbjJRJePPqrEYb8mcVOf37vVq8BPW/w9K3J3y7J2gA27mfhOJVxsArWn6/LAk6/kwwLWYXXzdfo4nlyT+pLNvVSIR/G3TZ0A6T6NTeeVgmv5PISuFMLU0oJKhBPiZHPESiCjc5X/Rops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QmSg3zqI; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QmSg3zqI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3zqAqdxtf1Gf0qkEKGTEiznEE2gKLuoc+1h9mGxqtgY=; b=QmSg3zqIX4XQwGjxzW3HPpRaLg
	jg+zxaA8F+WaOJzODQZA2sVaQFkwKI/IwWQaMQbZAJafNn6rLtEv9mxVqXPVxJk5jo6tZpqqfAMmW
	3w0vcX3OwAWWoyt2+gj/1P0cUM6oom1jNRl+cMMtPGutAbfr3gahx+seRmz//uITb6LOcVdZfkMzZ
	QhNRVjYaY7xRm4gAm+FYU4wQuCj7462gZDWuPQx72ADr+ISzA08uwnOaMZyuSM5zDgDXcgghOCE75
	+orRkaRNP77rZ0VCjNbaqUcUMPH9wNEI40CHITDEyf3gQPJwNFNMMgBGBjfWBYZ9Q4Cwnw3Xwg51W
	ibv9v7jg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GUG-7D; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2X-000LNp-2s;
	Tue, 30 Apr 2024 13:52:53 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 05/10] sim7100: fix going offline for A76XX modems
Date: Tue, 30 Apr 2024 13:52:28 +0200
Message-ID: <20240430115234.180185-5-martin@geanix.com>
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

When tearing down the PPP context, the SIMCom A7672 modem issues a NO
CARRIER event on the control channel, which is detected as an error when
processing the AT+CFUN=4 respones.

Make the set_online(false) call succed by ignoring the NO CARRIER event.
---
 plugins/sim7100.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index f4979ffe..2e9d0eb3 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -151,6 +151,16 @@ static void cgmm_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		break;
 	}
 
+	switch (data->model) {
+	case SIMCOM_A76XX:
+		/* ignore NO CARRIER on the AT channel when disconnecting PPP */
+		g_at_chat_blacklist_terminator(data->at,
+					G_AT_CHAT_TERMINATOR_NO_CARRIER);
+		break;
+	default:
+		break;
+	}
+
 	/* power up modem */
 	g_at_chat_send(data->at, "AT+CFUN=4", NULL, cfun_set_on_cb, modem,
 									NULL);
-- 
2.44.0

