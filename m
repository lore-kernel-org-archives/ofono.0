Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596F17C21B
	for <ofono@lists.linux.dev>; Tue, 10 Sep 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952963; cv=none; b=e5z7RrZt0YxXbG1RK2L8Wv2jItOr0SW7pN9vtejVDB7qPJGnC9dY50nNFp5ZDilXAl1w4cUOZykzWOvwXstS62L5A2PYVZBU0e4lPxUoc3GQCip+ewDdi6LPvsH4+rlWKD3WhgNXiPzLfh/uLkdzmaKl9C8QnM7uTFxjKJxQ7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952963; c=relaxed/simple;
	bh=dEky0TYNdx5gJYwke/GnD3xoseyE/jormLGfQ38QhHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9r2Pq7mVut2oDOLYWt83yVkDzSJspDuqyoZ4LRsocLfV/tCiTsBeDr7tq6Sg3UuFBsN/JYuZ1RKXV2XbW73Nv3JfzGYIAbFKF0+MAEg6i4gnTtsvtm3ywxhTp/XqyZpD/w3VPXD9BMB9xRnglegMBva3qDRCD51f074FU6pDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=U/LVi0iF; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="U/LVi0iF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VmqFQLfGXm6unnGLVeyM2KaoTnJ5akjy/f9TxlrGn60=; b=U/LVi0iFRuj6mhI9xEmRcuNTEs
	FOFZRw9JCxtpmZbWXzD4Eeev32xw2dmJlII365voUuYkAY98ZrZljd3BctSZvo1i840wyx8usze3V
	FjYTLZXwsP4zx2eaJtwlYQAxsCzCNTsyOV/q9foFHalTmpv/ei458/aVtATLPVPOaWVeqzBel2HCZ
	7Rvxve2MME7OYPU6wxyXI2QSL3q4oA7QutdNhheZ6JE8xm5DcJ2/3Gs1IgMQqG+2IefNZemTodddU
	N1z70kuwF372GtYykVPPbdbeBwVmObCg4OLJgaSXQ0bG8o7et3WU5Z1/qY8wY03TU8+DRYS9j2tec
	qJhr7q6A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0009YT-Ud; Tue, 10 Sep 2024 09:22:36 +0200
Received: from [185.17.218.86] (helo=benjamin-ThinkPad.geanix.com)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0005mq-1G;
	Tue, 10 Sep 2024 09:22:36 +0200
From: "Benjamin B. Frost" <benjamin@geanix.com>
To: ofono@lists.linux.dev
Cc: sean@geanix.com,
	martin@geanix.com,
	denkenz@gmail.com,
	"Benjamin B. Frost" <benjamin@geanix.com>
Subject: [PATCH 1/3] udevng: support for EG916Q-GL using option driver.
Date: Tue, 10 Sep 2024 09:22:08 +0200
Message-Id: <20240910072210.2618396-2-benjamin@geanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910072210.2618396-1-benjamin@geanix.com>
References: <20240910072210.2618396-1-benjamin@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: benjamin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27393/Mon Sep  9 10:29:16 2024)

add Quectel EG916Q-GL with product id 0x6007 to vendor list
---
 plugins/udevng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1c56e2ea..f4266f39 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1045,7 +1045,8 @@ static gboolean setup_quectel_usb(struct modem_info *modem)
 			mdm = info->devnode;
 			if (aux != NULL)
 				break;
-		} else if (g_strcmp0(info->interface, "255/255/255") == 0) {
+		} else if (g_strcmp0(info->interface, "255/255/255") == 0 ||
+				g_strcmp0(info->interface, "255/0/0") == 0) {
 			if (g_strcmp0(info->number, "02") == 0)
 				aux = info->devnode;
 			else if (g_strcmp0(info->number, "03") == 0)
@@ -2145,6 +2146,7 @@ static struct {
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
+	{ "quectel",	"option",	"2c7c", "6007"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0121"	},
 	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
 	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
-- 
2.34.1

