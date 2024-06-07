Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C381553AB
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800482; cv=none; b=pL0QNKQCugVYw4B+GEIVSSgYRSq7qhaFgbyQcxlmy7ljyF/0ukW2nBKDJvcQ1XRhj81GWG8fUVJyxYystX0PtPRfhYpa6iAcql4w4np7heCKibqVbcy8tJOuHkz95JcR37umCDtd1M9NF4A5o3RfAM70p8KGwkhaowKCZl5EIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800482; c=relaxed/simple;
	bh=a5dc1W2R1a2IQ7RHphV/WlyZIPj8nXBrDlutdfs1d74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTS7QzWPEzBjO521YWM1dnJb25DBK0agy5KhGwUawcpWE72ovbRLd/Jl0omXiSCy6jyvZ918i0BdiA7gwx1L/9WHIRvW0SOgJxoRh5fSFp5eC8PodT5r8R0O5KD0WABgJybfcFBpFmbIegEvPQiotV8ZkqVPIyBh/p2VyrBAjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuzqtqIX; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuzqtqIX"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9778bb7c8so1398038eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800480; x=1718405280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyCIJnKyJpsGX4yoOyn1EbxkSavVDJBHh4nu2HBbiJw=;
        b=UuzqtqIXz6j7O7ZGRs7f69RhUFE2N4exOBxXgP76vcAdqpjhGSMLdItlFyIJOVlw6m
         WbXnQCnWPkNremx7GdGZGF61LY5D5Ws895ThSdWKgnowIpILrEyaz+KI1Ir6KVuxYjiP
         UPVgYz4Oj9a68GDxKqA/sbabtEro5PKIxQiQbsSDpC7SmY9Ep/SODNmHi40CTpJWn8OZ
         Ca2BV+hguW9TzMJJMfXLGn64yvLs/dYmsQhhhDgUUu5hqSxpFw88emiYFCaALjX6Guil
         GyXcZ+RQTBWrH3EZbWii2GMYlmyI3Xn7DLoFRLSgQDYRxV9sKdrckZyWJasiwM7K+dJ8
         vYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800480; x=1718405280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyCIJnKyJpsGX4yoOyn1EbxkSavVDJBHh4nu2HBbiJw=;
        b=RyRsncoUzPFi7qLBGIKdZz8IQ+Bo+YpvkVBGIlnpO87eH0cgdr7VHyzDkrMol5jsaH
         ohsqalYg2jG8KN8jeMORQdvg3Xd1pWa7gUsJ30Rk8HHZd9LiPoPXJRWGFSm0wGLvQzd1
         bDHRlAbv7rB1nudOXJF/Pyo74ysW5OMcczmfscmLgDjGbqd0Fj7PkJTV9eUFp5C0mJw8
         0/NC0bhiy+1nQ+Luh1bX1fMbk6YM18fKsnI0Y4vzydxB/EUKH+zH6yZqmVQtQPCvird9
         Gql6t2puA9v5C+6AlJEP+/XsqERijMYeOH2UVODOOJcHyVdskiir296ZUMFBycSrWL96
         VzTQ==
X-Gm-Message-State: AOJu0YzAT/CRXKFETkUhzIY3t0CKE+6VoaD2o9c2qjMZ8sXGG6h1zeSj
	AYj4ABbqru1SYld4XfDBEv/NJgv0ClC0R21BqIYSf3Ud6AW0ZHzfHxcSYg==
X-Google-Smtp-Source: AGHT+IHcEtunRIRo3LC/ZE9JwyLMjMyXh26ZmBB9I3u4Uo9C+tcNd9uO08qgen2mthFIFv4wOGugAg==
X-Received: by 2002:a05:6820:54f:b0:5ba:43ec:eb81 with SMTP id 006d021491bc7-5baae877527mr3855393eaf.7.1717800480475;
        Fri, 07 Jun 2024 15:48:00 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/23] qmi: ussd: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:14 -0500
Message-ID: <20240607224746.903769-14-denkenz@gmail.com>
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
 drivers/qmimodem/ussd.c | 41 ++++++++---------------------------------
 plugins/gobi.c          |  3 ++-
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index ec9b60ff1222..6637ae759c55 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -145,51 +145,26 @@ error:
 	ofono_ussd_notify(ussd, OFONO_USSD_STATUS_TERMINATED, 0, NULL, 0);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
+static int qmi_ussd_probe(struct ofono_ussd *ussd,
+				unsigned int vendor, void *user_data)
 {
-	struct ofono_ussd *ussd = user_data;
-	struct ussd_data *data = ofono_ussd_get_data(ussd);
+	struct qmi_service *voice = user_data;
+	struct ussd_data *data;
 
 	DBG("");
 
-	if (service == NULL) {
-		ofono_error("Failed to request Voice service");
-		ofono_ussd_remove(ussd);
-		return;
-	}
-
-	if (!qmi_service_get_version(service, &data->major, &data->minor)) {
-		ofono_error("Failed to get Voice service version");
-		ofono_ussd_remove(ussd);
-		return;
-	}
-
-	data->voice = service;
+	data = l_new(struct ussd_data, 1);
+	data->voice = voice;
 
+	qmi_service_get_version(data->voice, &data->major, &data->minor);
 	qmi_service_register(data->voice, QMI_VOICE_USSD_IND,
 					async_ind, ussd, NULL);
-
 	qmi_service_register(data->voice, QMI_VOICE_ASYNC_ORIG_USSD,
 					async_orig_ind, ussd, NULL);
 
-	ofono_ussd_register(ussd);
-}
-
-static int qmi_ussd_probe(struct ofono_ussd *ussd,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct ussd_data *data;
-
-	DBG("");
-
-	data = l_new(struct ussd_data, 1);
 
 	ofono_ussd_set_data(ussd, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-						create_voice_cb, ussd, NULL);
-
 	return 0;
 }
 
@@ -202,7 +177,6 @@ static void qmi_ussd_remove(struct ofono_ussd *ussd)
 	ofono_ussd_set_data(ussd, NULL);
 
 	qmi_service_free(data->voice);
-
 	l_free(data);
 }
 
@@ -298,6 +272,7 @@ error:
 }
 
 static const struct ofono_ussd_driver driver = {
+	.flags		= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe		= qmi_ussd_probe,
 	.remove		= qmi_ussd_remove,
 	.request	= qmi_ussd_request,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 4de5a915ba54..6dee928acdea 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -845,7 +845,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	}
 
 	if (data->features & GOBI_VOICE) {
-		ofono_ussd_create(modem, 0, "qmimodem", data->device);
+		ofono_ussd_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->voice));
 		ofono_call_settings_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->voice));
 		ofono_call_barring_create(modem, 0, "qmimodem",
-- 
2.45.0

