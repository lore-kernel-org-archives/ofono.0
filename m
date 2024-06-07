Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8D155727
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800482; cv=none; b=tw74dIeXjLf7vn3IxuxdoZyhUdYgpJj8wdfwXEdhDxTIjwwmBnnABIUWuPqytLwdFh+h2Bjk1evgThdfiptxLB4jBpTa9eu1V9q8WgQvFmKhfxrBTyVKiPXvrUmhUlcjgTyhAlM5kWtOWfCRW8NjujWVZZb5T/CQcL4YgKh5nME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800482; c=relaxed/simple;
	bh=siDrpa8gm1awcmj0KzuO2o9KW04FpcbJUO5VklwRVTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFlzpal+MDR+1o1iBu82ef8xuLAq7PIFzlkZHGVO5JS7aRHveJsC9nYHEmGxDdSLYzSmu2aA4P1EvNcOF4OnQqWloZ+8zYCffpTH/+yq/OSJbiZpOu6da84Rc1ZIJi45hdXWUd8X6v0uYGxO93GJ3uPJ7DXMIcFe6z3EcXDepqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U276phjs; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U276phjs"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b5254f9c32so1378034eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800480; x=1718405280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bewc5clYHNOPtiyuKgcU7HWxVqdgFmxIy8K/Qr06ngI=;
        b=U276phjsgxKGashS+xp4zyZoGiyzVycQ9TWm/kogFKuYmC7exwpER9S8rEyfuWGaoD
         ptPX2tppbMkSJec9wGHMDzXc6HDUDmWNnrTZm5Yc4rGbrbHUftJHkdYHCWxelCXty+oi
         Usdvw0ENxJaKpf9BaI1DbZsId4WVIcsg84Rr2Dlu5P1AtSHJw885mfEx5oF5XgXMdph7
         lBiAbIAJWJVPM73+Xfxe68YdRNlyhohvTxpjyvfeHmnN8w1fCKi2nS7i+JrQ+FQf/TJN
         PD2WZrvASkI3DK0XpMFi47cHoGtfqI+TlWbvRraXD9oGrZ6sq6LpkTV/rbqk4WRwOeuB
         ZkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800480; x=1718405280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bewc5clYHNOPtiyuKgcU7HWxVqdgFmxIy8K/Qr06ngI=;
        b=aDYl3T6iRjA6hT2XTYODUQnfKIhf3AOvqKNn8vzBRhKj3yme/K0jXR8as8P8Pd7luu
         d0ovrijnoWmNyb8TokJ7GMEAikC1TM3aV3HRDJNzGVED+Ih3DxGcwrzrwlaAOYBLXUKg
         Sm7Ha37UBhAyktbqdrvewyBYaq6mV2M3Wngb/b5wvCxLhlyXyLfC7PhT0Rz29x9Ktaak
         4jkKb5JkiqYzsPeYSn/eHwL6j7goU8dkJpBtIPu95gIUBi7K60/8Av2QW5Fu+X+C2jaX
         +nrCpD3zqdcLiF2m1NdttQKZlxAVSlY4/ixqYhyyQswzM/WJCJJbuOmF9Q6/vVujapSa
         Y7Bw==
X-Gm-Message-State: AOJu0YyEWWiMmIwjLdz/QbUcjpbJ/7PN5aXNjoGoIQafcR8wNBhf0/IU
	LwBHhPPrrZwki40SsdZwZ7c3tWSIBa6SsH7MPdbsu28dSfNf/H7EpvwQrg==
X-Google-Smtp-Source: AGHT+IG8Y/SwqMW5UmwMxslLt51I3tzDYAFyG/ORqNHiKjILZJXCHi9hICZrslgHu/ZET4xJUXgUhQ==
X-Received: by 2002:a05:6820:1504:b0:5b9:de1d:38ef with SMTP id 006d021491bc7-5baae89c539mr3762756eaf.9.1717800479805;
        Fri, 07 Jun 2024 15:47:59 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/23] qmi: call-settings: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:13 -0500
Message-ID: <20240607224746.903769-13-denkenz@gmail.com>
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
index ff6d7553f851..4de5a915ba54 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -846,7 +846,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 
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

