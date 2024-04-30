Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1913D246
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=hceZ1ueLRngQM9IOtVAK7sxxmVjip/k1a8lTmtxgLrvsxHJXfiSclu2ExGVjAcYEye1hOz8MVbXklN3hUtdZv4H8uszZj+cutY0c40T7mOUOLFmOAoChSsbMx1XNE1uG6eBl6VEorm3ZLCjWv8zCJ3MZnQNps3X7rBtZbbXAGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=3c+n6xwMM520zFicEMVLZPd+kQxh/Wqj5HipL4u6N+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGGG90DV3d8gSQLOw0xidg2QOjdkCB4tZCDS385t3hlIVwH4CWgLrHEB0HdXgSsul8rn5hIIS9VimXvTyyou3DUkNuykawvV9Kv7XKK9cHLwDYtgl2gZz6XE5yt2gEKZiY3WTbBA+arDIY0tr0TDHcmy+RD3BqX2tW9WjWNq5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0cwAoAhM; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0cwAoAhM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rOkubSj53sIU+NZu0Sk++2KdxSNEz+Rh6p5AoeBEYNA=; b=0cwAoAhManQuNEhJpmam4WLIXO
	BwDE7OAXIcAyQl8cyamXRptlKdoAvqYBeO09t5DQWzdO92se1dEvrkV4E8fJMuK0jetQU5ShLtwyl
	Qyad6i058bw9rspQDvruIk/DQLWou0T5uB+IdOo86NKGGBuY3lHamxcmBXFUAJACo7zd6vxEgjCAY
	SL5irNPqVQkwO7i2M5jFgU2QcyK5dkF36V8TZlPi4yNdtyQtnzH3Jin/PH6XD5i8AoL9YF/IdQZgF
	o/qedJc+uWcBKdXeIDI+vsxM7UcMxbwxhmiCrTBS2aIlOCaXvCCxHl2fyYrr0zM7u6TI5j2pBbttk
	Wb7hYDWw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GUv-Ov; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000LNp-1c;
	Tue, 30 Apr 2024 13:52:54 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 09/10] Makefile: enable build of simcommodem radiosettings
Date: Tue, 30 Apr 2024 13:52:32 +0200
Message-ID: <20240430115234.180185-9-martin@geanix.com>
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

This change was missing from commit c3da88e1
("drivers: adding support for the SIMCom A7605E-H"). Add it now to allow
radio-settings support for SIMCom A76XX modems.
---
 Makefile.am | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 36319d98..44fb7b1b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -532,6 +532,9 @@ builtin_sources += drivers/atmodem/atutil.h \
 builtin_sources += drivers/atmodem/atutil.h \
 			drivers/quectelmodem/radio-settings.c
 
+builtin_sources += drivers/atmodem/atutil.h \
+			drivers/simcommodem/radio-settings.c
+
 if PHONESIM
 builtin_modules += phonesim
 builtin_sources += plugins/phonesim.c
-- 
2.44.0

