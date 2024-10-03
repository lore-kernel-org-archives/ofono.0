Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586112CDAE
	for <ofono@lists.linux.dev>; Thu,  3 Oct 2024 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959679; cv=none; b=gmW3eLAga2itBo1seQb79TMrACzlLhEf9uAwRutPitiAQ8EZDZF3LTmZZvO8im57gS2zJ8ypec5r8gPuCPlVuNdX1MGi+fr9Hxr9o4CFHkmCATg43nh+hRx6MysS0RDCZUG0/yQyu7GvMt2xBMVPz/FCtfN+Q2T5idcsueQatwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959679; c=relaxed/simple;
	bh=5VDLj2E3DCN2q9Qdw5aid449W+lyxws/51TNOGyhJ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYEURVAH/ASD/HMutp224XUsDeeP/kvJBLcChM07pughQaju404LHzKPhtuHUckl6dO+POQnUwP6yyaioI25aEZtW4NKu6dTOKCP8PEQklHDtvbaVTKmfGu6Ze5Cj5giqqaD0RoFQbM1b9v6jf3WbEngw4YfR3BTZqmxsHQePcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pZMfG9w/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pZMfG9w/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4CxqZIe+dJSIYAkYocYvbJ34yGilPnX3AylUyyYxBtw=; b=pZMfG9w/J+m7e/Ht5RAuoXSwsa
	K+7eb2QjVzTnIsC3e4s0n/3YWsD3mqWkZooyahBovwTmOK9aTx++GnShRnpSPUvydbcuBQy4vGMKI
	r8ouGY2bFa4fhA10Ke5MPjZY7geShqiWZVjXV9H77bFADfds27A6MJtArHNCJis6ZvPrTDs+5aBfW
	CLiSGpUxVFQl+6LqoPKxPY4zlaqKvkwCKOia/Ae5PTDDAr6VgjFRxGU1+nVuHPiSTH36r/4zQSvp5
	PnAR6Af1Yr/9yRE9Veza/Rf6AmTTrhJwFz1rIv5OeJ4U775icnTkILoCdZDlLbaO6JhH67m4moTFC
	5bFuJ1tw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1swLFG-000Oli-Fc; Thu, 03 Oct 2024 14:47:50 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1swLFG-0005rp-0Z;
	Thu, 03 Oct 2024 14:47:50 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH] gprs: allow attach on eutran networks
Date: Thu,  3 Oct 2024 14:47:34 +0200
Message-ID: <20241003124737.666419-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27416/Thu Oct  3 10:37:25 2024)

SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
6 registered for "SMS only", home network (applicable only when E-UTRAN)
7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
+COPS supplies the <AcT> = EUTRAN
---
 src/gprs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 97d6f382..46668820 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1731,10 +1731,12 @@ static void gprs_netreg_update(struct ofono_gprs *gprs)
 	if (gprs->netreg_status < 0)
 		return;
 
-	attach = gprs->netreg_status == NETWORK_REGISTRATION_STATUS_REGISTERED;
+	attach = (gprs->netreg_status == NETWORK_REGISTRATION_STATUS_REGISTERED) ||
+		(gprs->netreg_status == NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN);
 
 	attach = attach || (gprs->roaming_allowed &&
-		gprs->netreg_status == NETWORK_REGISTRATION_STATUS_ROAMING);
+		((gprs->netreg_status == NETWORK_REGISTRATION_STATUS_ROAMING) ||
+		(gprs->netreg_status == NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN)));
 
 	attach = attach && gprs->powered;
 
-- 
2.46.2

