Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422D135A5B
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223474; cv=none; b=SIPPFAvLmOz41wp6UfZaP8HBxmY35WHLigDLMeWFsyO0oHxgxHKS0tGP2lGq1Q6Fy8Ad9O1ggrP7v+n5gaDR3Uzl7MAYqKQWCBW56PpgF6QiXNV0efrK2N/NfIs1nCDdQxtPzt31VMyVV9rwOTVz9299l6ivcOMd+tIxkeeyVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223474; c=relaxed/simple;
	bh=UYwe8f8TMMROUNXQ8Y6mq4sCwewAgZ/rdLgUd16VJbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3XtuqJAwSzZVWFsi4xV37qGtHZHE4Mbxkmvslqq5S/eIgK2f9tcK8sptCmpu2/7eT8KZ638Tk48dxXKXS60f4QSrDN5LRw0U9AAQsiveNg0AVAHRj9bmbrySE08jXpKCGGRQTz1rp/3xoyjX3e/k0qT3yGLVBZyBurQ6QRzkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FXZAz8/+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FXZAz8/+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jwbSuy6HMrU/HO3mUrRfbIJW43hV7Wc+ynJothyRGps=; b=FXZAz8/+DYm+Q5CvcaPxqSoy+U
	t5yMzKbqYgP7Y12xWpCtGsNJ12F0wd2OGcir7eto++OFPNYhkH+ctscmOyfFPv6/7NKQU+0JLVxJN
	gGtO1QAByUN3VY25Jqt3qvw5vZ5X61hqZXhqGj1QT79UKEBlCcsCamDjcyIgvynd2D5T2CTL2kj9F
	icLDbwjHuxLnZVAhwNwk22Hzp5lxhkT0mSXhqbhOFhD0zHe1PwLPhy7Cb2pOgSiUuvQuKSHqqxQBU
	sRs60CxvpQqgl2IB5NYqILcCFO51NSLN7WQ5s6Id7BCIQOXfzFj15zwzWVCt+bgN1oP63CJJviS1b
	3HqpLwFQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sLgYh-0001yK-BR; Mon, 24 Jun 2024 12:04:23 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sLgYg-000AH1-2i;
	Mon, 24 Jun 2024 12:04:23 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com,
	martin@geanix.com
Subject: [PATCH 2/2] udevng: use option driver for Quectel EG95 modem
Date: Mon, 24 Jun 2024 12:04:04 +0200
Message-ID: <20240624100406.1497226-2-sean@geanix.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624100406.1497226-1-sean@geanix.com>
References: <20240624100406.1497226-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27316/Mon Jun 24 10:26:29 2024)

After commit cb4f0876 ("udevng: Add "option" module managed ports
to gobi driver") ofono would choose gobi driver for the Quectel EG95
modem, as that driver is the match for the option serial devices.

add_device() is simply throwing away the found modem_driver as the
serial channels have been created using the gobi option driver.
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 0d018b37..789592e6 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2176,6 +2176,7 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0195"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0195"	},
+	{ "quectelqmi",	"option",	"2c7c", "0195"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
 	{ "quectelqmi",	"option",	"2c7c", "0296"	},
-- 
2.45.2

