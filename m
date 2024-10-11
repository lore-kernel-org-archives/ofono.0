Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF25210C05
	for <ofono@lists.linux.dev>; Fri, 11 Oct 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641945; cv=none; b=WSnkUEQRyZmoZyQUuAwmyjjk6qsvozdr6J9haKC392MII9V4p3QdUNxHHORsgLm2eLdAucz8Oys5BcecMyWAkQYYtXcCYd9iZ0EU1IDKm2epCqYLLaNoLcFtCAtRf0VcQxyRR/Hnly7/KaKlwYUBQNgKjZ9bqSFam4tfPWwD2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641945; c=relaxed/simple;
	bh=uc/hanB3RKz2ahsBgM+Yg3ovZBYPoXy39RS0UK3+qmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRUflUigcoe/2Hnmm5rXXvjMlelSeIBZn9ee+yGWIGw+ypSbvdKuGQZtLrzOaJj5UnN9g0AZYd4+GJdp1soeuLKgJ9ZWMmAy6svTWdyHi6KAQpsep0uudlav/ySVEltw0U4jlOasEttRBRGAVyogBxGDxue6N+FAfNpHXu1MPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=OHUnAQzv; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="OHUnAQzv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5/CXY8Uivqf3YkVgq1TkXQxTG5oGG2yfse1lyAVCrwk=; b=OHUnAQzvRaRBS8KKu792JpRFfo
	B8stbrHs5bj8XEz+C4Y+xyrmR/qY1X6q0CcM5yoQDDgiC6Tol06ZgX4U35mG27jy9jcxVGuDQlzUa
	m0dQrQaUbBSH7ngcKPCp6kKy7pdBm0MdM58gMpEb7aV1XmMSMNfT7sqNcNKB2kbYg/KKiZox5X++6
	Xy4FEPSZp1ArNVmDS5zIIffHr/tG58n4gt3ZRfnWNszoLo4w76FmfO99DaVYt01UPvvODUmJ+jzdr
	1zhnIkbJXYXno3K1UgumB3OEn47ANTeCn4bdWM6Rk9Q6JjNXGIR/bhvB8xkJXfcZUnhKgpiTX8nqX
	KBdkZiZw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1szCjX-000FFK-QQ; Fri, 11 Oct 2024 12:18:55 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1szCjW-0002Ly-2X;
	Fri, 11 Oct 2024 12:18:54 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH v2 3/3] sim7100: create lte atom in post_sim()
Date: Fri, 11 Oct 2024 12:18:36 +0200
Message-ID: <20241011101839.3646442-3-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011101839.3646442-1-sean@geanix.com>
References: <20241011101839.3646442-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27424/Fri Oct 11 10:30:09 2024)

Enable LTE functionality for SIMCom A7672E-FASE
---
 plugins/sim7100.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 9413a8af..eb5a4dbe 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -24,6 +24,7 @@
 #include <gattty.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -104,9 +105,13 @@ static void sim7100_remove(struct ofono_modem *modem)
 static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
+	struct sim7100_data *data = ofono_modem_get_data(modem);
 
 	DBG("");
 
+	if (data->model == SIMCOM_A76XX)
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	if (ok)
 		ofono_modem_set_powered(modem, TRUE);
 }
@@ -272,6 +277,7 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 		ofono_radio_settings_create(modem, 0, "simcommodem", data->at);
 		gprs = ofono_gprs_create(modem, OFONO_VENDOR_SIMCOM_A76XX,
 							"atmodem", data->at);
+		ofono_lte_create(modem, OFONO_VENDOR_SIMCOM_A76XX, "atmodem", data->at);
 		break;
 	default:
 		ofono_netreg_create(modem, 0, "atmodem", data->at);
-- 
2.46.2

