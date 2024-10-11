Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBF20FA8A
	for <ofono@lists.linux.dev>; Fri, 11 Oct 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641946; cv=none; b=q8b4PhEIoLbaDR0a4/0EiUNEUmL09eWt3Yqq2FtTbd7XlySvNcbZsnLdwuNGt8vR1j+Lx/cMOhEzprga/weidMnXi0snuIi9qDx0XzlipgdAWZqbBM9FWyqA6wm6us4NWgdd43jjeyVBtXo5+q21NWE6LIThP8ScJle3pnYjpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641946; c=relaxed/simple;
	bh=bcZU+8AqjZCKCscR+3Sz1dxR3utlizNSGXM+3vEjsLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAN7WUE/PCqeRFl6NN+iwrFV5IR/S//hGOMaE+E/sIaL2jNF73a7kiE/uw0xG6t9dx7dNNMN8j/za/LOHRbxN5+cX+zL28kQa7qQyyoeAqLI7AlFt2jSogqxnzQ6bcXzJuQkZeym/KQ2Raw5ryoQNs9su6/zyp6RJ1RwySpG8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=n11xfpoW; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="n11xfpoW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=//ilkU1/eqDAjtwlGbU9cRqNBq4c52QFtgopAGCnw7g=; b=n11xfpoW15U97puI5Fnndc0yjT
	7tAPaFcfpgyFStGY7cbk0dgL0chxVpk3dbzpmWxhrBBceBiuOT12KvF+qB/4nesMZc4hUdMIaFWr+
	b7uOv9w8yD4ELPHHcPVKvbLnM3ZR1slp8yFTLrQF1CC/VieVT1zb81KmWfDT2mf4u65DUFfdLc542
	dlwLVw4tK5nZ29Pg0IREwZHyYxN3lqeEAq7BSARgS0s3hCYXzJfvNKOt6y+Y8VHOkOrbFQwTYnJgd
	dS1YT2uOxvSF5F3j9tTGhcqyOko473qG1VboAnF41WuuIxl8MR4CFjsSTNF/71Ocfhk3dBdpk/v5w
	01IvfIcA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1szCjX-000FFJ-Oi; Fri, 11 Oct 2024 12:18:55 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1szCjW-0002Ly-1x;
	Fri, 11 Oct 2024 12:18:54 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH v2 2/3] drivers: simcommodem: query modem for available rat modes
Date: Fri, 11 Oct 2024 12:18:35 +0200
Message-ID: <20241011101839.3646442-2-sean@geanix.com>
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

---
Changes since v1:
 - Fixed codestyle issues

 drivers/simcommodem/radio-settings.c | 53 +++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/simcommodem/radio-settings.c b/drivers/simcommodem/radio-settings.c
index bf78c748..25a655ce 100644
--- a/drivers/simcommodem/radio-settings.c
+++ b/drivers/simcommodem/radio-settings.c
@@ -96,6 +96,46 @@ error:
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
+	if (!ok)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CNMP:")) {
+		if (!g_at_result_iter_open_list(&iter))
+			break;
+
+		while (1) {
+			if (!g_at_result_iter_next_number(&iter, &index))
+				break;
+
+			available_rats |= cnmp_mode_to_radio_access_mode(index);
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
@@ -168,11 +208,16 @@ static void simcom_query_available_rats(struct ofono_radio_settings *rs,
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

