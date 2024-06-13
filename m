Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A432143743
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314905; cv=none; b=H+9sfWfJlMVr+kuQUj6BPPdhqwlx8qG2PwX+mCu7kcRWMWG47qd73PDLCqzd78/0Wv0Men5CvWpFaccJWuEUlCTP5qsfRcPX+GKvKF0+yhZ5L/JsLP3H8G6SNahmhRJSTtwqAlhlmxjpjOFJ7w0j4Jn3Z05S1QDHQy91l/6JurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314905; c=relaxed/simple;
	bh=yOZ5qgCa69LvrotwRqxXLl+QInniKIJGduxndwKTOD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pucv0vlPu7W3Bee8DC122Ym2zTChmPxnkp1ruGEVOJCru2nRQ7mjJlZi0MUfwuQiT5ZGPtxflM75o8i4GYREYPo4aW6bwfH/KUFeVfXAplT2/cAT0lJd95/KY1UMCquKmbmb4bO2Xr5aBQHkZLm6B56JEbYkW/IS+NA2a+oU3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrtlrUJy; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrtlrUJy"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2550aa6f994so869022fac.3
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314903; x=1718919703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lYkf6fn57/GQfylP9IZu+t22XH6Ky/iy/H3F5euBuE=;
        b=SrtlrUJyRuN+H1W5efkdwQR9tPE0jEkVcgA7layqTXeDacTpPew4ue9BtW9AEerLhR
         iu3xnWyJ99Wh/8KbkAnZw8IcwAdIY733M2jD2q6grdDSejkGx8SxJLGYmzwni7KOiKA1
         pr2J8x2k/vu10xLQ0CzNM8dRfIsAnoSQ4AzUF6/bFh8yW7b8OGt0CrklLcrC1YlDbu4W
         t/ae54XYafRi4Uy2oOzJZ/WgL8IV+RAPEbNM4HohC/uuFlmrfgkO5LFutHmtps8bLqxi
         QBrjqtcZWBVRwfgyzYKUuOtnA7qxcgSxPX4VCYpxsVZH1qGxmDuE2U+EG/xWG5MDU6Xn
         hkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314903; x=1718919703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lYkf6fn57/GQfylP9IZu+t22XH6Ky/iy/H3F5euBuE=;
        b=h8EpRQdB5heiPGXmGXcDAYdRuuenaRvyhQbURHWuu/rYE+KcLFw+ez6kJrOB7WXOSm
         zQH5VoYQ5HmOzMTVlwuRLmEd+2UuIUsRzIY4RYVikjOeES8qrQwrD9vfmcYNeWOlkxAO
         wyD0ktHiZKJvhumpXhfYamG0i3bUg/LKlJ3RNEyblWTn/16eepPi2/Vbgst9a9X2uZzb
         yxRqgHEfKu2YRMYKd2t0kIdjmiXyVisXJYQasVgY1B/Ld1EpdkGcpJjcNlq6SpS8z3iz
         gYCWb+uQw4sRbyoCNRLQPg/3pcIzOJzUDm0XaVdA+muXIb9tZJ6uTj3Ny1aBEFKkycqU
         yGMw==
X-Gm-Message-State: AOJu0Yx6yQocljlDB5ByR2qMylc0lkcAFn/ds949OSBRveh+MH6GYWL2
	Toxa9eBfQxeMX5snQGI2xLTM+6ZvI57FX/HCue4BybOHseAyhCPz8/1k8A==
X-Google-Smtp-Source: AGHT+IHGX9lh8sbAg8UJ65oh/slkrsSOtOBicR9eZddFfWoFcfEukkJ7b4t0bQfWG/RUYjA7P0L5lQ==
X-Received: by 2002:a05:6870:b149:b0:24f:c055:fc3b with SMTP id 586e51a60fabf-2584288f3a9mr1047736fac.11.1718314903092;
        Thu, 13 Jun 2024 14:41:43 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:42 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 10/23] qmi: voicecall: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:19 -0500
Message-ID: <20240613214134.1056517-10-denkenz@gmail.com>
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

---
 drivers/qmimodem/voicecall.c | 40 ++++++++----------------------------
 plugins/gobi.c               |  3 ++-
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 6af85caa840a..c7a5230f9680 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -709,48 +709,24 @@ static void send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
 	send_one_dtmf(vc, *dtmf, send_one_dtmf_cb, vd);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_voicecall *vc = user_data;
-	struct voicecall_data *data = ofono_voicecall_get_data(vc);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request Voice service");
-		ofono_voicecall_remove(vc);
-		return;
-	}
-
-	if (!qmi_service_get_version(service, &data->major, &data->minor)) {
-		ofono_error("Failed to get Voice service version");
-		ofono_voicecall_remove(vc);
-		return;
-	}
-
-	data->voice = service;
-
-	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
-				all_call_status_ind, vc, NULL);
-
-	ofono_voicecall_register(vc);
-}
-
 static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *voice = user_data;
 	struct voicecall_data *data;
 
 	DBG("");
 
 	data = l_new(struct voicecall_data, 1);
+	data->voice = voice;
 	data->call_list = l_queue_new();
 
-	ofono_voicecall_set_data(vc, data);
+	qmi_service_get_version(data->voice, &data->major, &data->minor);
+
+	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
+				all_call_status_ind, vc, NULL);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-					create_voice_cb, vc, NULL);
+	ofono_voicecall_set_data(vc, data);
 
 	return 0;
 }
@@ -764,13 +740,13 @@ static void qmi_voicecall_remove(struct ofono_voicecall *vc)
 	ofono_voicecall_set_data(vc, NULL);
 
 	qmi_service_free(data->voice);
-
 	l_queue_destroy(data->call_list, l_free);
 	l_free(data->full_dtmf);
 	l_free(data);
 }
 
 static const struct ofono_voicecall_driver driver = {
+	.flags		= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe		= qmi_voicecall_probe,
 	.remove		= qmi_voicecall_remove,
 	.dial		= dial,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index deeccb7879f2..0494959dc838 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -722,7 +722,8 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 						qmi_service_clone(data->dms));
 
 	if (data->features & GOBI_VOICE)
-		ofono_voicecall_create(modem, 0, "qmimodem", data->device);
+		ofono_voicecall_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->voice));
 
 	if (data->features & GOBI_PDS)
 		ofono_location_reporting_create(modem, 0, "qmimodem",
-- 
2.45.0

