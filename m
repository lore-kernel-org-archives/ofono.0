Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76217C7CC
	for <ofono@lists.linux.dev>; Tue, 10 Sep 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952962; cv=none; b=htdl4AzvtUVmpn82oj2L2M4jcc82+ho+SHoINWiEeoN7IRF1FIrAWNtVCpz3C/pA+JeqmvR9pHTUw9SD6/e3plVwxmpIhd0Qv/trJ4pNWq0mqFslQvXoNHghfqZq4f5/Ttvv6+CvQYNiojXl5IpFKeg4/OZPEj9aV+NRnT50SOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952962; c=relaxed/simple;
	bh=L9K1t1roO3PoMRgJvykn3rcSj0z9+04ojq69zJMwhtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHxtKCag9OdbWYtgpyVzP9q4gXGw7YcvAqiFOOa25tTCtdNzpJKzhnN3bjl7RlqEDCJvFjCOTxPnA3PO28ijZxmEeQsfvPvH65nBbt8agMDw9DgdwtzMq/I1/gR/jJDPunQ5XA1+5TpslUDs1eaN8Onhkn67tF65yMUx+N9jk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=GB/2FtgS; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GB/2FtgS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7RLmvzZlh2kHJ2OpOd8BfuErRAnoJ7HCpq5iEp9/YXc=; b=GB/2FtgSJ4BbY3IAGSi8RZu3gr
	TY+DwYDjcgKu9799d3ry3sz8N+nZpGodUSTMTn9KfqKU3LpGHc43sq76s4Fv5M5JwPH/fTRNHo+wg
	Q9XvMFQZ0bgtq/G98fNaOWNsc+YUCI7eZgtn1ueCrh5ycUfahk6JjKJwaHxXsN+EYWreT8yfgoZCZ
	oFWHj4IU6HPVR8Vf6wRHgvkaEJgVIyqY2SYKxL9ZfENXKyF+s3pc+/MS35dOGpfZVO9+ibqaDm3BG
	d003zwDpqgvE2xZgO+vh/fc0wQ70yAHq7Cn9gjfcKoan3zaJ6kakABwfO5JKZuTOcyOkKg96FmOYZ
	qlS1PwtA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCv-0009Yb-99; Tue, 10 Sep 2024 09:22:37 +0200
Received: from [185.17.218.86] (helo=benjamin-ThinkPad.geanix.com)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <benjamin@geanix.com>)
	id 1snvCu-0005mq-2J;
	Tue, 10 Sep 2024 09:22:36 +0200
From: "Benjamin B. Frost" <benjamin@geanix.com>
To: ofono@lists.linux.dev
Cc: sean@geanix.com,
	martin@geanix.com,
	denkenz@gmail.com,
	"Benjamin B. Frost" <benjamin@geanix.com>
Subject: [PATCH 3/3] atmodem: Support for Quectel EG916Q-GL modem
Date: Tue, 10 Sep 2024 09:22:10 +0200
Message-Id: <20240910072210.2618396-4-benjamin@geanix.com>
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

---
 drivers/atmodem/gprs-context.c         | 3 +++
 drivers/atmodem/gprs.c                 | 1 +
 drivers/atmodem/network-registration.c | 1 +
 drivers/atmodem/sim.c                  | 1 +
 drivers/atmodem/sms.c                  | 2 ++
 drivers/atmodem/vendor.h               | 1 +
 6 files changed, 9 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index da63fa1c..7d4bd094 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -455,6 +455,9 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
 	case OFONO_VENDOR_SIMCOM_SIM900:
 		gcd->use_atd99 = FALSE;
 		break;
+	case OFONO_VENDOR_QUECTEL_EG91X:
+		gcd->use_atd99 = TRUE;
+		break;
 	default:
 		g_at_chat_send(chat, "AT+CGDATA=?", cgdata_prefix,
 						at_cgdata_test_cb, gc, NULL);
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index fa82878c..37b67405 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -668,6 +668,7 @@ static void gprs_initialized(gboolean ok, GAtResult *result, gpointer user_data)
 						NULL, NULL, NULL);
 		break;
 	case OFONO_VENDOR_QUECTEL_EC2X:
+	case OFONO_VENDOR_QUECTEL_EG91X:
 	case OFONO_VENDOR_QUECTEL_SERIAL:
 		break;
 	default:
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/network-registration.c
index b7a66c4d..46b8512a 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -2103,6 +2103,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *result, gpointer user_data)
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	case OFONO_VENDOR_QUECTEL_EC2X:
+	case OFONO_VENDOR_QUECTEL_EG91X:
 		g_at_chat_register(nd->chat, "+QIND:",
 				quectel_qind_notify, FALSE, netreg, NULL);
 		/* Register for specific signal strength reports */
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 9eb29cc0..809d405d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1211,6 +1211,7 @@ static void at_pin_retries_query(struct ofono_sim *sim,
 		break;
 	case OFONO_VENDOR_QUECTEL:
 	case OFONO_VENDOR_QUECTEL_EC2X:
+	case OFONO_VENDOR_QUECTEL_EG91X:
 		if (g_at_chat_send(sd->chat, "AT+QPINC?", qpinc_prefix,
 					at_qpinc_cb, cbd, g_free) > 0)
 			return;
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 34968d9a..d994856b 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -324,6 +324,7 @@ static inline void at_ack_delivery(struct ofono_sms *sms)
 		switch (data->vendor) {
 		case OFONO_VENDOR_GEMALTO:
 		case OFONO_VENDOR_QUECTEL_EC2X:
+		case OFONO_VENDOR_QUECTEL_EG91X:
 			snprintf(buf, sizeof(buf), "AT+CNMA=1");
 			break;
 		case OFONO_VENDOR_QUECTEL_SERIAL:
@@ -835,6 +836,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_opts,
 	case OFONO_VENDOR_SIMCOM_A76XX:
 	case OFONO_VENDOR_QUECTEL:
 	case OFONO_VENDOR_QUECTEL_EC2X:
+	case OFONO_VENDOR_QUECTEL_EG91X:
 	case OFONO_VENDOR_DROID:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 20768832..faceede1 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -33,6 +33,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
 	OFONO_VENDOR_QUECTEL_EC2X,
+	OFONO_VENDOR_QUECTEL_EG91X,
 	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
 	OFONO_VENDOR_XMM,
-- 
2.34.1

