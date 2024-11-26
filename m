Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12191DFD86
	for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656431; cv=none; b=NYu3iLnljMYpqoJ1sFguyyWlQboJaSYUc7ery/bb8rHhYViLIuvTvTn+QkR9hHMysxxyUL7E7QLigms3AGSonxUfKYNhGHLXqbAPc5sReEJLHHaLrrdWZHEbw1d4tW5lIhYMn2m4oyhjq7GZIYif6Q39EQPl1PicGC7Fdx183xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656431; c=relaxed/simple;
	bh=Wj4RkngDgqWGj1rgQElelYBFGQvWldiYCQxTcDu67i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6NMmWrK+ZSM/sCXBsMAVB9ibZOwxwojFtDSPn4J0eYXuiwj5lyY3gDQsnGtZsTVVWjjKyrRkx9EmjcAsehtbL4j4WK5pRQYQDIh5o2gU1bVvgwLxrC5mXynUzBZFR3Ok+p8wx8DVyIsmBHeKmdPi/CO8C3SNTqZAVSOryg40q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQD32jQW; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQD32jQW"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea48624a2aso1451539b6e.2
        for <ofono@lists.linux.dev>; Tue, 26 Nov 2024 13:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732656429; x=1733261229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl7rFJByg1zjg1Y4HfDHhdriiWZ1Y7dMfChV3DmufY8=;
        b=nQD32jQWdX4y+69RqwIss4+RbtK9vHHXv4oZZemPNPR70QjQ5Z60D9x8nuZmg6i2BE
         6lKrnumHs7d+I7vxBNDrWeXitrWJemBfIwhgtlqG6U1UeDckFRIxeimZnEWX2fMxwKRu
         Q7wYIQZuEGo34gj8CS2z5VKVBLEg1inbX64sWwKWVVoETOKO8ryfqswGVAyW+D1DcCIC
         fvlqNm9un9xwe06VvPF7VngbnSUG5LCr2QapJmqyDy1vlJUo5nGgQIeCfK1ZerLIm+2O
         sI1VnSPA0C6X3kISbSksq9sDa8IUPpNmcLHyxRoaFWqEo1GfHfoimoB9TkOdSs471mrH
         4ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656429; x=1733261229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl7rFJByg1zjg1Y4HfDHhdriiWZ1Y7dMfChV3DmufY8=;
        b=FNJk7SxqtPWtFWVUhRdzkgdoh8T88hej8SqKU5wP2lK69dzpLEMmPesDR4M4eDDVGz
         tuzB5Bra5XTG925ioiV0BoBtbG8H+m7i4/5gsnMOvpgONtc1ubNWhMjvukoHfmPhoST/
         +3VEfpMEFcEGH2YGw8F7NVfKyhlgMw/tLCZy/Gypmg2S+zyVEDFbxju98ZLfFOYr3OM5
         zYJj43/aJPco73GQSzQKG7oFzv0UHL6af1ubJXcB9wrrAmfUS40kXrGCrgHsat5ageT8
         OKQaPpEmuHUDpraWffkcQRHuTYHLWC/8nf4Nj/Uq/mmmpbDLluQHDWBVNCB+nmUm6srX
         WqVQ==
X-Gm-Message-State: AOJu0Yz6B1zZJa6QymFHNvQMcawruPQxfzXZ6ajUlxz+YXu8a8oHUurP
	KjlR5KkOFSTRUOEJu13LT7TNZKB4qApgbdoNKUHzl0QFrujMIYsXGvkuEA==
X-Gm-Gg: ASbGncs6NslylDBOQADZCq2bNWT9G3DhBXFswwL26gZVwc79bJcNwM15aMZmECGp8CN
	eDqRF6+og7eARgOowxDA0ESTYTxGUjoM8kVScHgm285xTRBgg7y70Lnl5/K9HwyOVVOZXxyWhFp
	TKEQyFcGCUWFInTPnbJ85nIiWsIE8a8SFjiIUyI+gdazOx6V5LGH8eh0F+dw6wCO1xaoljLLl9r
	iOZJSnQKUZ7eGxWZXQatLHtTzkoHSNsdBpKkQZ/GERJotVVF012wwHYhXyzxKtbBqLQ6Smn0SAy
	aiPk9AKo1TYBWscjDdNm7NCm
X-Google-Smtp-Source: AGHT+IG/yAisp9KsHAuDDQFqtTtTHEX0dJXtiWyyoSfFewZOEjRQJG89ydGsRM4CnpKNC5VBndnNcA==
X-Received: by 2002:a05:6808:d53:b0:3e6:580e:f12c with SMTP id 5614622812f47-3ea6dbc3f00mr967031b6e.10.1732656429004;
        Tue, 26 Nov 2024 13:27:09 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e835e2sm3177531b6e.13.2024.11.26.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:27:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] qrtrqmi: Manage main netdev as part of .set_online
Date: Tue, 26 Nov 2024 15:26:18 -0600
Message-ID: <20241126212703.196003-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126212703.196003-1-denkenz@gmail.com>
References: <20241126212703.196003-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mhi_hwipX interface is created with IFF_UP not set.  It must be set
IFF_UP when the modem is brought into online state, otherwise packets
will not flow properly.  Similarly, when bring the modem into offline
state, bring down the main network device for consistency.
---
 plugins/qrtrqmi.c | 73 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/plugins/qrtrqmi.c b/plugins/qrtrqmi.c
index 8bfbb11d167e..7065419c34f7 100644
--- a/plugins/qrtrqmi.c
+++ b/plugins/qrtrqmi.c
@@ -61,6 +61,7 @@ struct qrtrqmi_data {
 	struct rmnet_ifinfo rmnet_interfaces[MAX_CONTEXTS];
 	uint8_t n_premux;
 	int rmnet_id;
+	uint32_t set_powered_id;
 	bool have_voice : 1;
 };
 
@@ -152,6 +153,12 @@ static void qrtrqmi_remove(struct ofono_modem *modem)
 	}
 
 	qrtrqmi_deinit(data);
+
+	if (data->set_powered_id) {
+		l_netlink_cancel(l_rtnl_get(), data->set_powered_id);
+		data->set_powered_id = 0;
+	}
+
 	l_free(data);
 }
 
@@ -390,25 +397,75 @@ static void set_online_cb(struct qmi_result *result, void *user_data)
 		CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 
-static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
-				ofono_modem_online_cb_t cb, void *user_data)
+static void powered_common_cb(int error, bool online, struct cb_data *cbd)
 {
-	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
-	struct cb_data *cbd = cb_data_new(cb, user_data);
+	struct qrtrqmi_data *data = cbd->user;
 	struct qmi_param *param;
+	ofono_modem_online_cb_t cb = cbd->cb;
 
-	DBG("%p %s", modem, online ? "online" : "offline");
+	data->set_powered_id = 0;
+
+	if (error)
+		goto error;
 
 	param = qmi_param_new_uint8(QMI_DMS_PARAM_OPER_MODE,
 					online ? QMI_DMS_OPER_MODE_ONLINE :
 						QMI_DMS_OPER_MODE_LOW_POWER);
 
-	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE, param,
-				set_online_cb, cbd, l_free) > 0)
+	if (qmi_service_send(data->dms, QMI_DMS_SET_OPER_MODE,
+					param, set_online_cb,
+					cb_data_ref(cbd), cb_data_unref) > 0)
 		return;
 
 	qmi_param_free(param);
-	l_free(cbd);
+	cb_data_unref(cbd);
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void powered_up_cb(int error, uint16_t type, const void *msg,
+				uint32_t len, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+
+	DBG("error: %d: %s", error, strerror(-error));
+	powered_common_cb(error, true, cbd);
+}
+
+static void powered_down_cb(int error, uint16_t type, const void *msg,
+				uint32_t len, void *user_data)
+{
+	struct cb_data *cbd = user_data;
+
+	DBG("error: %d: %s", error, strerror(-error));
+	powered_common_cb(error, false, cbd);
+}
+
+static void qrtrqmi_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+	struct qrtrqmi_data *data = ofono_modem_get_data(modem);
+	struct l_netlink *rtnl = l_rtnl_get();
+	struct cb_data *cbd = cb_data_new(cb, user_data);
+	l_netlink_command_func_t powered_cb;
+
+	DBG("%p %s", modem, online ? "online" : "offline");
+
+	cbd->user = data;
+
+	if (online)
+		powered_cb = powered_up_cb;
+	else
+		powered_cb = powered_down_cb;
+
+	data->set_powered_id = l_rtnl_set_powered(rtnl, data->main_net_ifindex,
+							online, powered_cb,
+							cbd, cb_data_unref);
+	if (data->set_powered_id)
+		return;
+
+	cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 
 static void qrtrqmi_pre_sim(struct ofono_modem *modem)
-- 
2.47.0

