Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EB423151
	for <ofono@lists.linux.dev>; Wed, 13 May 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677200; cv=none; b=tDHbajD6gtYMZo7T7xtgMf8DGrLBrN1LifD4bVA+M5sctI3gryagqHUDe6XFKRZ2Uf2wJUOmIw+JBNFjk3tbk+iCNZK6KlCFSjaK+GEUxYoK0IW7GrcdTWok0P7m/BJtDjGLTt+6DOvT2wMUj6tnieBJHExdwlveKVknKwEYxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677200; c=relaxed/simple;
	bh=sIg/DOQUrc9MwghzDQXnyTWQ9wd+hlDFJNhKl8vneK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjYoOJn4LiciwV4svaXz6cuJ4l1qyJRB2Dqshv/PwfY8ABaQ8D/ZiRAQ/q8m6kAlKtN22kBJ+8gt4u90oksdIf8BMSteE9lJ5NmXa9GawRfm8/X7ZYQWRWBN6tEAD6E99sjyHdLosRPX5sUHruxDlTaTdflK5fNka0Q9WWKBeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NKmjM3fu; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NKmjM3fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1778677178; x=1778936378;
	bh=qE4FKKsdVJTO3sYsaH+bESFOHJ5NBE8c4ndb1TMuIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NKmjM3fui/h4nXm0eHAv7XNaZ9A52nJz4sc57oifJqeecaQeGB603pbbPN7UZCetk
	 ZeB6tX9F9CowB+T90h8phjLcvQEYzvjTKXR9sUaYkRc2pxIM1C7hCA67J5SIcZMtYy
	 rI/+5XmXw9RXr782/SVZLl1Gvq0rZ+F9qVP5mNf6WryjfavnqstSiRf0HFiUTfTiOO
	 Jse15Z5T8XXdY1m24nHz5Yzsn3HvP+HYbRRSRqJ0V2E7XNXgVqI8IG7wj1Y03U7lnf
	 cY8JwbXTohMINqzB/Mfs2LtmoCTJhPke6pw05igJlcYrN6WxA1PztKgyk+Q+Au8rbV
	 ZhYfwivZTeAdw==
X-Pm-Submission-Id: 4gFtpF5xF2z1DF7K
From: Sean Nyekjaer <sean@geanix.com>
To: denkenz@gmail.com,
	ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/3] sim7100: disable IMS on A7671 during power-up
Date: Wed, 13 May 2026 14:59:21 +0200
Message-ID: <20260513125925.2164959-1-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SIMCom A7671 modems require IMS to be explicitly disabled, as the
A7671 does not support VoLTE.
---
 plugins/sim7100.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 7d4a9fd7..1e892007 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -137,6 +137,17 @@ static void ppptim_support_cb(gboolean ok, GAtResult *result,
 	}
 }
 
+static void ims_off_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
+
+	DBG("");
+
+	if (ok)
+		ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -151,6 +162,9 @@ static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		/* does the modem support reset of PPP state upon AT+CFUN=0? */
 		g_at_chat_send(data->at, "AT+PPPTIM?", NULL, ppptim_support_cb,
 			       modem, NULL);
+	else if (data->model == SIMCOM_A7671)
+		g_at_chat_send(data->at, "AT*IMSCFG=\"switch\",off", NULL, ims_off_cb,
+				modem, NULL);
 	else
 		ofono_modem_set_powered(modem, TRUE);
 }
-- 
2.52.0

