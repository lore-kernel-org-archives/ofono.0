Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE913E03B
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314907; cv=none; b=rRA4KqKsQkqr8ssTfSmgO5klNYd5JeeUCMmt/RqhuNkySyIurt+wHLy3bfsILk1HIkojYjiKbSrSH5EnnqUPF3D+Y+iB2t1OmJ1SIihlEdjZuWR9VmNMz7x8tgJtJ8pcy2HFSY0E/rQrgxQG5SHG/sy4/d99aO0+xW96GN1QUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314907; c=relaxed/simple;
	bh=gzLBEpSAHCybQcTakVHxzqn69rkLSZ1ITihpkdjlCpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtcdIVvNqv0f8AMsiyFj0CGz3kKw4G5env41ZTX1SyYsi3RdWT3lbFviuzutTOZOvxXgRJAQYsOsrJgrrqYf6CbYG6xC9aRJJSruvAYWodbygpjrkhGXynmBGD14/Mywy/9FSF4xu247K8ktQ/kolfmhS8yG1zI0/TzC2qCWFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/EbQVCE; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/EbQVCE"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c0dbd2866so761875fac.0
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314905; x=1718919705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IY/ZcEs08PB6xtvTE/xTtDyIm+yj5UsAZKTdlTcSgc=;
        b=a/EbQVCEvGtQpVKXJ21EPwRLSOUDvrwkPvW2ltfB1RBuYRE/CCaOJZh39cbT/T0GVE
         7jcyJofQ23erOVM9FqJbKcvakGMVeqbqTiJsQahdw3MvkLASQQ85NMk5XZjK0HU1pRgM
         frd1hBBB9gTznLRziDzzLOw0NnyiVxD4D/5kttusmNkDFsUeWqhqXQte5A9VeWNOolEd
         clU3EWn7AF8uK2ieGsMtQgANZj+/zVRd5PGGX1zlTyoSRCfLyhJO6pkOV20HDBQb2u4j
         XSoxKSzl3lTEzxBILqSB6C2Ybmyqbxk/H4CVQjXtYTHRjolOOLdo7XX0auFEwX5mrhtX
         lhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314905; x=1718919705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IY/ZcEs08PB6xtvTE/xTtDyIm+yj5UsAZKTdlTcSgc=;
        b=YJoPOj/NoaLs2Ls+T8m/umO+63to7/njUCJxU5Ao0X8N+nfJFcO+sCilTp1H6fGcq/
         qCA1Eoz8gnH0WZCSWmE+Z+fHZCAQmxwq8Lr2iKR3zDsh1ip2C0ZUcqBYlwVO933p2vtA
         /2xE28l04kqspvhXlVzjEpGyRuEh/cWth6WrZcHBGYoir/JY3KFboPF2HeasYbHzYkIp
         vua3NpkNz1ory+MXkFfVk5ADUQkbTlJAauQw090YHFX9NYGcYnato9mUzkzIbTQJSI96
         V6WEFLCNO1wbpZoqLpzHX8rQeu4GFY8BCsVA0e9iZWsMlzkzRJZArW5tPqswYFCJaxe9
         UsWg==
X-Gm-Message-State: AOJu0YyMdSyGwV7l+/4K3g4lL0KfE0ZGWr+EDcjzHDYRJd3klv6B1JMI
	C3yg91RC+gs90Oe5LLQQpLDWn/jSnpku4ARcg0g7YGVCuM51FXbOVXAq3g==
X-Google-Smtp-Source: AGHT+IE04vhasmZRc9T795vSj6wBBpnZSuQNiFRTT/p7FlMUX3jxgD55/VMpu8zjqqZdPzXvYd81XQ==
X-Received: by 2002:a05:6871:b28:b0:254:9ded:a3bf with SMTP id 586e51a60fabf-25842ba0b61mr910721fac.45.1718314905434;
        Thu, 13 Jun 2024 14:41:45 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/23] qmi: call-settings: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:22 -0500
Message-ID: <20240613214134.1056517-13-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613214134.1056517-1-denkenz@gmail.com>
References: <20240613214134.1056517-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While here, drop 'sups_ind_id' member.  Explicitly unregistering from a
an indication is not required.  All indication registrations will be
automatically dropped when the service handle is freed using
qmi_service_free()
---
 drivers/qmimodem/call-settings.c | 37 ++++++--------------------------
 plugins/gobi.c                   |  3 ++-
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/qmimodem/call-settings.c b/drivers/qmimodem/call-settings.c
index 676b39aaf487..3611c98894a0 100644
--- a/drivers/qmimodem/call-settings.c
+++ b/drivers/qmimodem/call-settings.c
@@ -21,7 +21,6 @@
 
 struct call_settings_data {
 	struct qmi_service *voice;
-	uint16_t sups_ind_id;
 };
 
 static void query_status(struct ofono_call_settings *cs, uint16_t message,
@@ -262,41 +261,20 @@ static void sups_ind(struct qmi_result *result, void *user_data)
 					clip->active, clip->provisioned);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_call_settings *cs = user_data;
-	struct call_settings_data *csd = ofono_call_settings_get_data(cs);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request Voice service");
-		ofono_call_settings_remove(cs);
-		return;
-	}
-
-	csd->voice = service;
-
-	csd->sups_ind_id = qmi_service_register(csd->voice, QMI_VOICE_SUPS_IND,
-						sups_ind, cs, NULL);
-
-	ofono_call_settings_register(cs);
-}
-
 static int qmi_call_settings_probe(struct ofono_call_settings *cs,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *voice = user_data;
 	struct call_settings_data *csd;
 
 	DBG("");
 
 	csd = l_new(struct call_settings_data, 1);
+	csd->voice = voice;
 
-	ofono_call_settings_set_data(cs, csd);
+	qmi_service_register(csd->voice, QMI_VOICE_SUPS_IND, sups_ind, cs, NULL);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-					create_voice_cb, cs, NULL);
+	ofono_call_settings_set_data(cs, csd);
 
 	return 0;
 }
@@ -309,15 +287,12 @@ static void qmi_call_settings_remove(struct ofono_call_settings *cs)
 
 	ofono_call_settings_set_data(cs, NULL);
 
-	if (csd->voice) {
-		qmi_service_unregister(csd->voice, csd->sups_ind_id);
-		qmi_service_free(csd->voice);
-	}
-
+	qmi_service_free(csd->voice);
 	l_free(csd);
 }
 
 static const struct ofono_call_settings_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_call_settings_probe,
 	.remove			= qmi_call_settings_remove,
 	.clip_query		= qmi_clip_query,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 85ab427e9de5..17160354c273 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -834,7 +834,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 
 	if (data->features & GOBI_VOICE) {
 		ofono_ussd_create(modem, 0, "qmimodem", data->device);
-		ofono_call_settings_create(modem, 0, "qmimodem", data->device);
+		ofono_call_settings_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->voice));
 		ofono_call_barring_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->voice));
 		ofono_call_forwarding_create(modem, 0, "qmimodem",
-- 
2.45.0

