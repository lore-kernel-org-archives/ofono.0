Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A681553AB
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800485; cv=none; b=JAjzkmw4jpHX+VnMr67get3xFL45sxnUbidM/rXE1A0+fAvvJnvyYPxvp8Qe2IkQ0Dqt5QDpbqzEMictqs9IqQEk3NW3tEyiJb9V+/hu0Q8zXfyN42T+l73Bhc6dqxGL8aEEULkXPdFkzaqYn5kSq4WD7KJ/YMZva1aLXIZ77U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800485; c=relaxed/simple;
	bh=+op+uupI5WOCZV3YJ/eLL9mCHw61ZrwuE5eaBWHdz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKTLMadeINjrfbAvAWfz+LGJ5lNkUxY/SGKiiNrHtEzSMwFBffhSE17u+tNP4T9dWc9s7DcBCIDm+p7LfBzhnNy5ZBDw4/2Ng3o/eZa8TMw6PIKLBRgpmueU6bcvxJIZXVZ8DWfMJJgBU37BM0Wk6/dJCTBVv6prKaS8nu0GAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbSB4lfi; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbSB4lfi"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b9794dad09so1266883eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800482; x=1718405282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/1FS0M3pvKtU7IvsYpFzPw2W2IqT7t5DFSZkI/x9Js=;
        b=QbSB4lfiZaeXTD0rMbJSn30aogr7rRmMblzPVoXSMwdhe27fVYbcz9Uxvd6qBYKGCT
         NuUbGsnRc6qQN2AlSMuKJpNRW7fN3kPJ6aqeADYrazqcP6/iu1XsfhL8caGX9Fgxw4AK
         U9u44lW1bYCBasCyaxIGR3FGgj1UT8golHxrCP10nwk5CEymNf5i67dHMJlD332arfLy
         ykJ+YjtPsoRAeRgue8RGJHawrEX7zToic2bn8TKzdZNVeh41xaGF1K+lhh0yS/s0SADG
         PgrUPMzRMQLv+qhIPZmvUCbucgoqgERfBnb1/NdWsLXJ31vpu5oZ+w5prZJ+YFl5E12j
         P8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800482; x=1718405282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/1FS0M3pvKtU7IvsYpFzPw2W2IqT7t5DFSZkI/x9Js=;
        b=lzwUP5hx1S1aJwWnaNiYt24yhiC4ZDncdTTvLXgxoUH10t9SUnPX7iiV18gM2NKX3A
         msaeCZE8ymqTM4Hx8Yp7lx4ko7rcG3bHSeRh0VeP42k7G2Aii7xBWJzp7QqMovNY9YgI
         SJqm3ciYVkef/z3ZbqAw+idoPHcOEgVBrNPDrMgDu1BPeX+CTTUBdiRvn7MVgSQxgINa
         ovvt0rN9niicreStFRZsRVxKONY7OdTupvEhB+i8ZzwjZ0rSDccEjN32oacOy8yjU0ar
         VHHMQy0VuxwyWrVeRybfwAWa2d08VcbZtUDnwR3u0ArKB9Mmr7H95qGhNKoSpu5Aor6p
         wGPA==
X-Gm-Message-State: AOJu0YyumE4MFCeY1HfCGLIHZ/n3q2BMjMd2hzyY2rXVP8fHR6x+nLa4
	LW8GH4GpqC87rd4qPNs5bHEW94zjC0TmLTsa/EniJmDeS1dDPbSsyDNEMw==
X-Google-Smtp-Source: AGHT+IG0y2QMsqJ2qI65lW0D38hbJ+/x1iBo3/3K0VVAl+qlxE9NX+tXn/fHZvO1TX2tPDbUcEZQTw==
X-Received: by 2002:a05:6820:54f:b0:5ba:6b7c:82af with SMTP id 006d021491bc7-5baae8967a7mr3812776eaf.7.1717800482009;
        Fri, 07 Jun 2024 15:48:02 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 16/23] qmi: sms: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:16 -0500
Message-ID: <20240607224746.903769-16-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/sms.c | 56 +++++++++++-------------------------------
 plugins/gobi.c         |  3 ++-
 2 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 65909c6a71f6..4238665a5e8d 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -725,58 +725,33 @@ static void set_event_cb(struct qmi_result *result, void *user_data)
 	ofono_sms_register(sms);
 }
 
-static void create_wms_cb(struct qmi_service *service, void *user_data)
+static int qmi_sms_probe(struct ofono_sms *sms,
+				unsigned int vendor, void *user_data)
 {
-	struct ofono_sms *sms = user_data;
-	struct sms_data *data = ofono_sms_get_data(sms);
+	struct qmi_service *wms = user_data;
 	struct qmi_param *param;
+	struct sms_data *data;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request WMS service");
-		ofono_sms_remove(sms);
-		return;
-	}
+	param = qmi_param_new_uint8(QMI_WMS_PARAM_NEW_MSG_REPORT, 0x01);
 
-	if (!qmi_service_get_version(service, &data->major, &data->minor)) {
-		ofono_error("Failed to get WMS service version");
-		ofono_sms_remove(sms);
-		return;
+	if (!qmi_service_send(wms, QMI_WMS_SET_EVENT, param,
+					set_event_cb, sms, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(wms);
+		return -EIO;
 	}
 
-	data->wms = service;
-
+	data = l_new(struct sms_data, 1);
+	data->wms = wms;
 	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
 	data->msg_mode = QMI_WMS_MESSAGE_MODE_GSMWCDMA;
-
-	qmi_service_register(data->wms, QMI_WMS_EVENT,
-					event_notify, sms, NULL);
-
-	param = qmi_param_new_uint8(QMI_WMS_PARAM_NEW_MSG_REPORT, 0x01);
-
-	if (qmi_service_send(data->wms, QMI_WMS_SET_EVENT, param,
-					set_event_cb, sms, NULL) > 0)
-		return;
-
-	ofono_sms_register(sms);
-}
-
-static int qmi_sms_probe(struct ofono_sms *sms,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct sms_data *data;
-
-	DBG("");
-
-	data = l_new(struct sms_data, 1);
+	qmi_service_get_version(data->wms, &data->major, &data->minor);
+	qmi_service_register(data->wms, QMI_WMS_EVENT, event_notify, sms, NULL);
 
 	ofono_sms_set_data(sms, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_WMS, create_wms_cb, sms,
-					NULL);
-
 	return 0;
 }
 
@@ -788,11 +763,10 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 
 	ofono_sms_set_data(sms, NULL);
 
-	qmi_service_free(data->wms);
-
 	if (data->msg_list)
 		l_free(data->msg_list);
 
+	qmi_service_free(data->wms);
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index f27d6c23e34a..ce43213a86a1 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -817,7 +817,8 @@ static void gobi_post_sim(struct ofono_modem *modem)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
 
 	if (data->features & GOBI_WMS)
-		ofono_sms_create(modem, 0, "qmimodem", data->device);
+		ofono_sms_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wms));
 
 	if ((data->features & GOBI_WMS) && (data->features & GOBI_UIM) &&
 			!ofono_modem_get_boolean(modem, "ForceSimLegacy")) {
-- 
2.45.0

