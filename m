Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123F13D247
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477985; cv=none; b=UFW9MN+5S03NvvLNfCAW7AaMqWIJ5Aqt8hD8bibHtPeDdjpRj2Avu6IA7RHMshN261SlVa0r3ZkQv75W0hN0AVbVsEDu80n7mTIk4Vs1YjRkgHMXHc9Yr8YtJwPRsLxrgpBEHsnZdrtaE2xOI0QK6HgUprEUQ15gZ0mPmJ6Lbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477985; c=relaxed/simple;
	bh=ObNxtuuMi5f5pe+DgyLzpgn9J2c3dw+c/YvWwg1R0vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVKSF70NK1cOZDBrrx1XeHQ5DZtH5DBlctubRs52QuPYDD16nVSS6jJ+nwptVTT5Wsdn80pGh88GoU2/9O/PJd3xFs5z7zAZ7gG7Wn0xNBU9EOjFy3VtOpRBxY/FsFqUQbS1lGtcJeP9abbrCoXy9vUil21LK9VfRnp1FpVekTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=o56f0B8L; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="o56f0B8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V69CtUYvXXuu5cBNQ5Cz1uIa+B9gRFbCbvjaVe8pHvY=; b=o56f0B8LWqXG1aEnYqAVkF4Jht
	JV/eqo2iIGLIEsaVR5g7rYu6N6nfmF11qLi7Hzh5crP8hc9KQ4SlQCEaWjPR3+Uu0/96fUfTZDtS7
	RubbsO/ssU2qW/KGBfG4sOn07ZMp9WuzUVT8ngHEXsDwzVbPN28+4i6K/FNHz+ffzSVV0DT46EXe/
	QMuKRj2qKhSVgZ2rbAmt/wqH6IYjXp07CrT49gtSWkfnGFp/XKfwiLAt+MakHpbCbzEi69u1ArstN
	OwTOIxugCQEWhjNwl3EJ8Lz8AFap2CnottWeDJ60h7xpJwEc4p0mZw7Sv01uXpH9Aekh9jlQX9J27
	yuIz6n7g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000GUS-Dg; Tue, 30 Apr 2024 13:52:54 +0200
Received: from [185.17.218.86] (helo=martin.geanix.com)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s1m2Y-000LNp-06;
	Tue, 30 Apr 2024 13:52:54 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	MaxLyubimov <m.lyubimov@aqsi.ru>
Subject: [PATCH 06/10] atmodem: introduce SIMCom A76XX vendor quirks
Date: Tue, 30 Apr 2024 13:52:29 +0200
Message-ID: <20240430115234.180185-6-martin@geanix.com>
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

As a preparation for adding support for the SIMCom A7672 modem, certain
quirks are needed in the atmodem driver. The OFONO_VENDOR_SIMCOM enum is
already shared by the existing sim7100 and sim900 drivers, so a new
"sub-vendor" enum is needed.

The new sub-vendor enum allows adding A7672 support to the sim7100
driver without changing behavior for other devices already supported.

A few of the existing simcom vendor quirks are replaced by the new
sub-vendor enum instead of making them apply to both. These places were
introduced in commit c3da88e1
("drivers: adding support for the SIMCom A7605E-H"), which should apply
to the A7672E modem too.
---
 drivers/atmodem/gprs.c                 | 4 ++--
 drivers/atmodem/network-registration.c | 1 +
 drivers/atmodem/sim.c                  | 4 +++-
 drivers/atmodem/sms.c                  | 1 +
 drivers/atmodem/vendor.h               | 1 +
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index e0441545..8ff9d796 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -675,7 +675,7 @@ static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user_data)
 		g_at_chat_send(gd->chat, "AT#PSNT=1", none_prefix,
 						NULL, NULL, NULL);
 		break;
-	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIMCOM_A76XX:
 		g_at_chat_register(gd->chat, "+CNSMOD:", simcom_mode_notify,
 						FALSE, gprs, NULL);
 		g_at_chat_send(gd->chat, "AT+CNSMOD=1", none_prefix,
@@ -805,7 +805,7 @@ retry:
 
 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
 
-	if (gd->vendor != OFONO_VENDOR_SIMCOM)
+	if (gd->vendor != OFONO_VENDOR_SIMCOM_A76XX)
 		g_at_chat_send(gd->chat, "AT+CGAUTO=0", none_prefix,
 					NULL, NULL, NULL);
 
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index 2697d3c5..3ceca12d 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1936,6 +1936,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *result, gpointer user_data)
 
 	switch (nd->vendor) {
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIMCOM_A76XX:
 		/* Register for CSQ changes */
 		g_at_chat_send(nd->chat, "AT+AUTOCSQ=1,1", none_prefix,
 				NULL, NULL, NULL);
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d75a09c2..6fe5efce 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1199,6 +1199,7 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 			return;
 		break;
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIMCOM_A76XX:
 		if (g_at_chat_send(sd->chat, "AT+SPIC", simcom_spic_prefix,
 					simcom_spic_cb, cbd, g_free) > 0)
 			return;
@@ -1355,6 +1356,7 @@ static void at_pin_send_cb(gboolean ok, GAtResult *result,
 	case OFONO_VENDOR_ALCATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIMCOM_A76XX:
 	case OFONO_VENDOR_SIERRA:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
@@ -1647,7 +1649,7 @@ static void at_discover_apps(struct ofono_sim *sim,
 	 * command with SIM cards of some operators
 	 */
 	if (sd->vendor == OFONO_VENDOR_QUECTEL_EC2X
-			|| sd->vendor == OFONO_VENDOR_SIMCOM)
+			|| sd->vendor == OFONO_VENDOR_SIMCOM_A76XX)
 		goto error;
 
 	cbd = cb_data_new(cb, data);
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c69fe947..be0c7ada 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -846,6 +846,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_opts,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIMCOM_A76XX:
 	case OFONO_VENDOR_QUECTEL:
 	case OFONO_VENDOR_QUECTEL_EC2X:
 	case OFONO_VENDOR_DROID:
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 82284e44..90446943 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -41,6 +41,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_SAMSUNG,
 	OFONO_VENDOR_SIMCOM,
 	OFONO_VENDOR_SIMCOM_SIM900,
+	OFONO_VENDOR_SIMCOM_A76XX,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL,
-- 
2.44.0

