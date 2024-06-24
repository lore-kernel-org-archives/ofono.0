Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4262135A6C
	for <ofono@lists.linux.dev>; Mon, 24 Jun 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223473; cv=none; b=u0uf2SxujmnMH9A6D/Qb/eiX7FaGqc4xpKBYO+lz8oMnV40ICmTG7737qKqBE0JQmuh975IrrdYcta/HRwS/ndXHaiogF7LYchi3pXtPzZB5SyoRDZ/ayneqkHwJ2NyC3I6VRAIWCt2gZY5zUp/zYW5tiD7eRI5/hACqiWxHAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223473; c=relaxed/simple;
	bh=lZRTNa9vZcWH12+D9+DZdXs8bV9z7ySLe1UJHY5dkcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czEHv/SVS7spkpeKwLgZ8hnPvNGyGRkA6ox6igulILo/nxPpD3ogTIVJXCrCDyiSakgbDlSFNCnI7UI04MnWFQZIk+qAZfjWB4X6SGcHfDueuuJ4tRK3kFIcMngXyQJ2aDVop1oWADJtC0gu1x1H/+BrwfZ0izAlDQykCSIV8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KoNRkb1B; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KoNRkb1B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=/bcPBSHxZoJos1VFzWdELf8UnGqrLR54oYsDK7ILfc0=; b=KoNRkb1BNHta7GPb4SV4M0/DbR
	X9LOE5MGo//zETNUO/bfQwG9SRatcemcgkiL6geXOLw+dXSoCg6zCfBgUcu4LkoKQQlWlO3gB/4/E
	wFzeas9gqe0linNeWnkWfZ2JFWYGITLKCELPgP/pxoI5ZHpBZWiBJermCOmwyABtLriaKt4+ympfY
	l3DIoFOaD25PZiUUv+q4rmJrltMYtdTduMTYFtnfp02taQ7NED6b2vcP47rW80ZPBVZT4qs/acUe9
	zsAe0cvcN1/idHWXTemPgPJcxB4yS//xmfvvSTMtzTvrpZTawybtdpMUT7DA1YPG0/UKllRpHfln8
	efw1LRNA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sLgYh-0001yJ-5B; Mon, 24 Jun 2024 12:04:23 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sLgYg-000AH1-2E;
	Mon, 24 Jun 2024 12:04:22 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com,
	martin@geanix.com
Subject: [PATCH 1/2] udevng: use option driver for Quectel BG96 modem
Date: Mon, 24 Jun 2024 12:04:03 +0200
Message-ID: <20240624100406.1497226-1-sean@geanix.com>
X-Mailer: git-send-email 2.45.2
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
to gobi driver") ofono would choose gobi driver for the Quectel BG96
modem, as the driver is the match for the option serial devices.

add_device() is simply throwing away the found modem_driver as the
serial channels have been created using the gobi option driver.
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 864f9c12..0d018b37 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -2178,6 +2178,7 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0195"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
+	{ "quectelqmi",	"option",	"2c7c", "0296"	},
 	{ "quectelqmi", "qmi_wwan",	"2c7c", "0800"	},
 	{ "quectelqmi", "qcserial",	"2c7c", "0800"	},
 	{ "quectelqmi", "option",	"2c7c", "0800"	},
-- 
2.45.2

