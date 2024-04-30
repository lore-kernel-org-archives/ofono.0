Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91013D24C
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=nY49NDVCbM4QVhO495WVS0/E0kphHM0i9CHBQdNAp0ttwUO4jkYtE5y9f7lgI4xVt8j8eCztFs0Og2CsBGUbNadm5WxvqKDRIGePyvzDmN51L/hC1tDBehtgWVdFBlkaXV6tuPTkuZLVPtf6xPylNL8dNuMFc00Sj2xWSQRUjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=2SwFsq5OKSc3lEy9kyXrRU1N7ffuyKvH3LJG4NbmJrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JApWXStL5oLh/n9R+wDMakfm3agXQUiw6VaLswhknP1nikzzMKvdHEnZCMt8e6rTaT0J/DczkTbcJtQ3S0lmEFe8dA9Q5bGnbdsdslUB1SU5Ufy+az0Ug0VXPNzdF/HEpwj8vdOKOwwtnaaYrq3S+0YT+b+7HRIm4Yd7qxysj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WgA4c/il; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WgA4c/il"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OxSQ1g7pexeun+s6ZP2lcYHpQ5sxNa94NopqRBIxruE=; b=WgA4c/il0xfqfSh8tgqpLBvY1U
	tM3j6kQbOVh9QoD1lK6Oq+1/KV0dmkUrI4WDJGBchkd+rAfYhj2/97vI7qD89UXBq59JKrxqSIPmx
	08Z3Keos5BrGYEuv7t61Mp2d//+h54WqoRoFFCcfz6TcoxVQqwmdhg5KFpRFT8e76XCNc4eEgqShR
	q+xyls2zB0i8pQbfZ2t677ZbHbvvM6MGqlVSpMcUaCLEnj8AswshDCPGiV5Qwe3HirweGfpgUmogN
	799257YFwzUb/rhB8EiMYIBaROuTzZer/TtbkdJ9HlCD+9rUqQ+k7N3quQC/NgIH4Si2+j3gdSY/Q
	WJWylXvw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GUc-FU; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000LNp-0c;
	Tue, 30 Apr 2024 13:52:54 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 07/10] sim7100: enable A76XX simcom vendor quirks for relevant atoms
Date: Tue, 30 Apr 2024 13:52:30 +0200
Message-ID: <20240430115234.180185-7-martin@geanix.com>
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

Use the recently added detection of modem model to apply the even more
recently added SIMCom sub-vendor id when creating atoms.

The "old" SIMCom vendor id is shared between the sim7100 and sim900
drivers, and so changing the 0 vendor id's for the existing
ofono_*_create() calls might have unexpected side-effects. Avoid such
changes by calling the needed ofono_*_create() functions separately for
each model instead.
---
 plugins/sim7100.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 2e9d0eb3..192559d6 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -241,8 +241,19 @@ static void sim7100_pre_sim(struct ofono_modem *modem)
 	DBG("");
 
 	ofono_devinfo_create(modem, 0, "atmodem", data->at);
-	sim = ofono_sim_create(modem, 0, "atmodem", data->at);
-	ofono_voicecall_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
+
+	switch (data->model) {
+	case SIMCOM_A76XX:
+		sim = ofono_sim_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
+							"atmodem", data->at);
+		ofono_voicecall_create(modem, 0, "atmodem", data->at);
+		break;
+	default:
+		sim = ofono_sim_create(modem, 0, "atmodem", data->at);
+		ofono_voicecall_create(modem, OFONO_VENDOR_SIMCOM,
+							"atmodem", data->at);
+		break;
+	}
 
 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
@@ -260,13 +271,27 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 	ofono_ussd_create(modem, 0, "atmodem", data->at);
 	ofono_call_forwarding_create(modem, 0, "atmodem", data->at);
 	ofono_call_settings_create(modem, 0, "atmodem", data->at);
-	ofono_netreg_create(modem, 0, "atmodem", data->at);
 	ofono_call_meter_create(modem, 0, "atmodem", data->at);
 	ofono_call_barring_create(modem, 0, "atmodem", data->at);
-	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem", data->at);
 	ofono_phonebook_create(modem, 0, "atmodem", data->at);
 
-	gprs = ofono_gprs_create(modem, 0, "atmodem", data->at);
+	switch (data->model) {
+	case SIMCOM_A76XX:
+		ofono_netreg_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
+							"atmodem", data->at);
+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
+							"atmodem", data->at);
+		gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
+							"atmodem", data->at);
+		break;
+	default:
+		ofono_netreg_create(modem, 0, "atmodem", data->at);
+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
+								data->at);
+		gprs = ofono_gprs_create(modem, 0, "atmodem", data->at);
+		break;
+	}
+
 	gc = ofono_gprs_context_create(modem, 0, "atmodem", data->ppp);
 
 	if (gprs && gc)
-- 
2.44.0

