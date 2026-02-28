Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0326B0A9
	for <ofono@lists.linux.dev>; Sat, 28 Feb 2026 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270213; cv=none; b=I/doVe76k6XxgLTSvoCVa7nOOuywpuofY0SI5uD2iNEarDDrY4WvHvhhgK5gc9f4Aj1rQ2lsWCMO9TEz8/xtWpNs4llVZfLafO17Eji1aZjTjTRuSojy/oAjNoCmgt6ptNC/iZBuW270gFgUld3xfZi0us6LCMBrhXqGbxC1jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270213; c=relaxed/simple;
	bh=yw3GfIW3Nrng72UVWG5JnGMHn1a4CE3yEX8TcbQ9O/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=cUFESqsm0aRFDon9UNB8s8yKZjuNSobmwb4FtLrsAGLqc/jGyRjtVkkByZPrjXEC0yVK5iThm/c6OVouUoNsXczg3CEv63S2e5S+N7WUok/2JhWeiK9avvsVmiP/Ix/+buTY0FR4v/dUqhfjFzzUoRAIF9vwyGQxLsqkK1TIwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 051A811383E; Sat, 28 Feb 2026 04:16:52 -0500 (EST)
Received: from 5400 (unknown [172.56.160.155])
	by spindle.queued.net (Postfix) with ESMTPSA id 882E9113824;
	Sat, 28 Feb 2026 04:16:51 -0500 (EST)
Date: Sat, 28 Feb 2026 04:16:50 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Cc: jbb.prv@gmx.de
Subject: [PATCH phonesim 2/3] Only call QTextStream::setCodec in Qt5
Message-ID: <20260228041650.37231ae6@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
In-Reply-To: <20260228041213.45bc0030@5400>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

From: Andres Salomon <dilinger@queued.net>

Qt6 defaults to UTF8, and setCodec was removed.
---
 src/control.cpp | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/control.cpp b/src/control.cpp
index b06dbc1..66a65ef 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -700,7 +700,9 @@ QString Script::Run(const QString &name, const QDBusMessage &msg)
     }
 
     QTextStream stream(&scriptFile);
+#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
     stream.setCodec("UTF-8");
+#endif
     QString contents = stream.readAll();
     scriptFile.close();
 
-- 
2.51.0

