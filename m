Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60080BEB
	for <ofono@lists.linux.dev>; Wed, 31 Jan 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709467; cv=none; b=eGrl3Z0646Os79se84Ut8HVhdZ2dkSwWUkHL+XOWebuULxjFiN14qaO9BthZ8Dcap6hRuWcZN3RcV6M8yrpqO9bMs8eyuws7PxbDKJBvDBGSeS2l6GLC+t6AmfbRf01Kok6R99dJS85UGwbTxdi67Y/h1ckbBJ3lrUQHm3aKjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709467; c=relaxed/simple;
	bh=e23G4lgT1PzqLfH5G9PQEWRu+eeoyiYq2bYQKmZ7dI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFz3q0dsoesEMufQCLiocbe/ZImwUBUGu3+a9mEoMW5zHYBgodtWK6f+97w1F3DxQwJXfzfjrUcMtRXIgMfSPqNRyNvckLTKZW68Scyrk3XxIDWX+49OxxqIZYydY3UDCljMztVhTqNCiQcxGO9F1a5l3gX5thUNXPcXLJ+2Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=NobsHL9B; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="NobsHL9B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=FT4k7IHn+M+GkGCCnGWaozO8laEjkhd290aPO37Ssc4=; b=NobsHL9BOZOHmQCPNxeuiwbjXQ
	rqhKZUVGDIQC4XYW/VohjByI8NQweDpw7MPsdLHkz306LgWowTHbqufqHGEXYPC/d+d4mnO0GkUTn
	ZgvmLp+fkev/Aq1WC1ucWQ1IhT0riSRjMaIm7cPCOig2/p8U5BOqOBIZck8n3dFo4+He2P01pPyXe
	OcZLfp9MkK40YFByGDXlO3O0KzShZPbycx8cNpkeafc8MkdawJ7O32JytLR6vJs8IQ17ffZdmGV4u
	USAYxjxnk1HNLKx18GH4yQ803z0QZwtFaclkF8dwFDUTr6QtL7kPPlZWKMbZ/HIY3w3XUit5h/X4n
	XAwhINmw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1rVB5x-0007ff-6X; Wed, 31 Jan 2024 14:57:41 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sean@geanix.com>)
	id 1rVB5w-000Hav-Uk; Wed, 31 Jan 2024 14:57:40 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: martin@geanix.com,
	Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] udevng: Add support for Quectel EG96 modem
Date: Wed, 31 Jan 2024 14:57:28 +0100
Message-ID: <20240131135728.3100070-1-sean@geanix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27171/Wed Jan 31 10:46:17 2024)

---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3458fe89..6fc98c3f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1839,6 +1839,8 @@ static struct {
 	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
+	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0195"	},
+	{ "quectelqmi",	"qcserial",	"2c7c", "0195"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0296"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0296"	},
 	{ "ublox",	"cdc_acm",	"1546", "1010"	},
-- 
2.43.0

