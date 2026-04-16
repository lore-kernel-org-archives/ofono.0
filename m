Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409E1F4C8E
	for <ofono@lists.linux.dev>; Thu, 16 Apr 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345419; cv=none; b=JpyxxnTr+N2p26KtwXx6voCkzc7aQHJyXVEYLtgQVHvY/ZPBlt2W7Nmc1RSxHlxsCSu02lW3/g/p4+ce46JSvN0wP7+a46wkcX/GHCpVF/02qQR1xGMCBuBg9RdPIopqKYvov4tRuOGxpjyIwpu0tCynx3sALPM9/oW2s/JhgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345419; c=relaxed/simple;
	bh=co1Owppaet9LIRlwK+xb0gt9sk4ggp27zoy4UIG9dx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTOZ4ll2rJH4y2zEdELUnm6szJaFZZS6CZwob5094+vOX2C2LGqEko5yF/AUs4AMtiG3mxlLbI3E9YXE79jQzYFdvn0PzDTT9036Gkw6hCB79pzLwxZ55CDAIv4zEg2o8bYkACZAzFnEe1ScBnHl1uCKr1kXb2o+z65YqhdZdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fegJwkJL; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fegJwkJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1776345414; x=1776604614;
	bh=zzkj0cardck6P5SzJ6H8n0PjcZ793rcnCw0Wm6AxJ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fegJwkJLfyTZmwxJ6+hAzN0mq4Mo6Yt48uPffjwvVGZ0DlUUp2tZ7SUaB7b9q3eu+
	 Bp5NMIeJcfqnyPE/w1ILPcxPyh6qIiSb81ZP8FG7euGXqz6KEmr71g8W6KZQrd4k/3
	 VfMwu+xl2rYoaeCvhCh9ZFlSXV/TKRW97UeTsCHf7L8mKLroIFV5rovy0Ck0ihu45e
	 vz5oyxkyP1jDxLntggCtYSbSYFrlc4OeSI84g5d7qeWS1PJknLfY22SuH/m/KRT9O1
	 vlzx/b6MjRyxL4NuebN7YP+eTKEEU4MC1PbLLEJqBFTeuzREPfCSoLuz02SQyNFP65
	 h7bODE/7RlIZQ==
X-Pm-Submission-Id: 4fxJSh66XWz2ScmT
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 2/2] sim7100: fix AT chat leak on PPP open failure
Date: Thu, 16 Apr 2026 15:16:48 +0200
Message-ID: <20260416131649.2151345-2-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416131649.2151345-1-sean@geanix.com>
References: <20260416131649.2151345-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If opening the PPP channel fails in sim7100_enable(), the previously
opened AT chat instance is not released, resulting in a resource leak.

Fix this by unref'ing the AT chat and clearing the pointer before
returning the error.
---
 plugins/sim7100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 4148e0b2..169b6b47 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -272,8 +272,11 @@ static int sim7100_enable(struct ofono_modem *modem)
 		return err;
 
 	err = open_device(modem, "PPP", &data->ppp);
-	if (err < 0)
+	if (err < 0) {
+		g_at_chat_unref(data->at);
+		data->at = NULL;
 		return err;
+	}
 
 	data->init_count = 0;
 	data->init_cmd = g_at_chat_send(data->at, "AT", NULL,
-- 
2.52.0

