Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19706176AD8
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378649; cv=none; b=Srrbet0uOj+pnPWqGO6HODTjIxIEKcnu/p4JLDSKfuOMFzJVvGEHfzokQnmobSQQ+sbfK1IyavCrzwwec9SLSnm4DmOLuOnzo6T22AASMxqvjoOaTKGrzHxNDKUFZzPsXC6Hyjs6FuRzqyqCslrAhfDxswnOCBQBhDawI++jPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378649; c=relaxed/simple;
	bh=O8rmXM+s4rS6l6NQIQfSglxf2KP9Ne51MGDWJ6lS86A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc7+w1PgyQSZWeMWrd8r3gLkvldF4JTZ9TjVtcYmYLZMmDnmYi94lRKSxmiwft5hFb+WkjjWhBCd3dzzXI4Tq9S5k2dGe6ztXINQIaFMR7VVfIjX7xM+SpPpCMXf1UDXfhlhfaHr7iysWnAJbRPQNJNVLsFxoIgjaXVvwM3PV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=XfSnOGVI; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XfSnOGVI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rACWDPq5ykK9ebWT99rHdkfMHS5UkPK9jr7cKXb5Dlo=; b=XfSnOGVI3zvJNUngGUSHvDvNeq
	rH8yNSF6C52fLbDWO0Fb5g6KJd3GvIM2vrget1+njAbd0StMwr0IRuvCZVAxQbEv0k/9hFoUROVAJ
	rXX+S4vGz6c7ucDs3SVtTXcBA5f/6HnOuIsJ/noUtq93ajiU2qJKdMiYbROi3OwpRthG0Bym+3JXd
	Mi8jXO/pqDbjF8zQWGVHqIkAOzJTl8VuBuCMjcd+Am56qlIZOcyyawdrv7btALQOA6UI+a11/0i82
	MYXn3JaWcpmQEiji3V4zaB8jmJrW5At0Sdu2t9Kq2HF8Ozy1VVV60GjUvBjR9l9aRamef3+DyKt7C
	059qDflg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6Ev-000MTN-3D; Tue, 08 Oct 2024 11:10:45 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6Eu-000P2R-2e;
	Tue, 08 Oct 2024 11:10:44 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH 2/3] drivers: simcommodem: query modem for available rat modes
Date: Tue,  8 Oct 2024 11:10:35 +0200
Message-ID: <20241008091038.1567406-2-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008091038.1567406-1-sean@geanix.com>
References: <20241008091038.1567406-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

---
Should we default to gsm, umts + lte if the call fails?

 drivers/simcommodem/radio-settings.c | 53 +++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
index 2a9dbaa2..2bb0d148 100644
--- a/drivers/simcommodem/radio-settings.c
+++ b/drivers/simcommodem/radio-settings.c
@@ -97,6 +97,46 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 
+static void cnmp_rat_support_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd = user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb = cbd->cb;
+	struct ofono_error error;
+	int index;
+	GAtResultIter iter;
+	unsigned int available_rats = 0;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		goto error;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CNMP:")) {
+		if (!g_at_result_iter_open_list(&iter))
+			break;
+		while (1) {
+			if (!g_at_result_iter_next_number(&iter, &index))
+				break;
+			available_rats |= r_mode_to_radio_access_mode(index);
+
+		}
+	}
+
+	DBG("available_rats %d", available_rats);
+
+	cb(&error, available_rats, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
 static void simcom_query_rat_mode(struct ofono_radio_settings *rs,
 				ofono_radio_settings_rat_mode_query_cb_t cb,
 				void *data)
@@ -169,11 +209,16 @@ static void simcom_query_available_rats(struct ofono_radio_settings *rs,
 			ofono_radio_settings_available_rats_query_cb_t cb,
 			void *data)
 {
-	unsigned int available_rats = OFONO_RADIO_ACCESS_MODE_GSM
-				| OFONO_RADIO_ACCESS_MODE_UMTS
-				| OFONO_RADIO_ACCESS_MODE_LTE;
+	struct radio_settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd = cb_data_new(cb, data);
+
+	DBG("");
 
-	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
+	if (g_at_chat_send(rsd->chat, "AT+CNMP=?", cnmp_prefix,
+				cnmp_rat_support_cb, cbd, g_free) == 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		g_free(cbd);
+	}
 }
 
 static void cnmp_support_cb(gboolean ok, GAtResult *result, gpointer user_data)
-- 
2.46.2

