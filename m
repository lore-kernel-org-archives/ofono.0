Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869B14658C
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314908; cv=none; b=WQyI7OqCePjq+LxGnOFFI+uSpIJddRFyV7ShlW3ipYUNqtMo6pQk6dPSXVaD1txkfZFnYoKuIqg9uQlxlkbsqy9+TTPUYbpJFph/H7tZJaTGpX8jymo1Rs+LSjAxiqwluktamdF8qwwEP4UR6J+fTjpkavp827Wyydi7pxd7NK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314908; c=relaxed/simple;
	bh=Pv/eQ5BDg2gMSZ9lPotfJwamH1HCd62X9tq7yc5FW5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5lqPcl6SHxBRHH4B6Yu7M5ah0r+4DA8nakUAnFNmWNCfgotp/1qIFz9UrDYS2vvdwZ1uWbPPz9Ffdm+/sdAbObT2zh0c1mLdxMkNuvl+FhqAEctZhATzgnzlvsKAniVw7uS2P1HL/ijW4E1isXf4JN9pOvcuDBGf7eMpq1EVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFHYTXZg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFHYTXZg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c9f630e51so711992fac.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314906; x=1718919706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAaJqmNisulnG7dmipuBrlZ2Lh6VNCRWfL30YlOXBmU=;
        b=aFHYTXZg6lyqGc2hGf11gpOTMIOEIu16EEpbmh1jA9lnSQDKDvYt1L0+oWFjHcBfPr
         vylTVjFG1BqEXhdF6YPmJDk+PaadGHkggjEZ9dx6BEIzdlHUOm52cEsN/f/tdJbvfCT4
         u1opg/f98Qvp5wQ7oHYaJ4JLdRKircKaWpUfuTXU8L7u3xsmCe4aeUJSofoU1PX3t7P5
         LR4TJx6dawLI46QliQWdWr+An/3XjCzwj2Y4N5K52RQYAbhgyimzNdb3ITLWyPtxWELz
         Obpyvbz5IfGJe5866CF1Hgj8wQ124r0vsts4CB6COCtT+LRkCZdzOso6wpicYZgBuZTf
         UATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314906; x=1718919706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAaJqmNisulnG7dmipuBrlZ2Lh6VNCRWfL30YlOXBmU=;
        b=YoalsGLzK/aa7DzroNQa6dCWPyNiNenrMQxHpyrogMdQ2cB5x/NEgBgaAUxbP23auC
         32y5f1XEdH7rifrgEgfau/h8qiePYBRXXqIlVmIqoUrV1AHC1HU7lO4F9/m0y3o6NXcH
         bWCJVVgstoNXN8myK6hisfwHiWXzkVzGQk85aZGgHe/r2jK+njs+AK+h5XcjsO9Z1W/K
         qou4QTM1KJtg9AJo6K0mR5tm+D8uBccRo3UcxU44LVGO3nizSRHzDy+Q/kJNSouEWKhe
         oIO9te8sCW6Pj0qhb0Sc/cHtotGxQcjrJRyJ/f0epL6muO8MWNJlwzq7nYY39ZMRQsud
         aF5A==
X-Gm-Message-State: AOJu0Yyn3FPLHfi+ZwFJxwbsLn1wszEOA5wYhCQQKOY1IOkrZGMkVegg
	mX0egtieUmpch/qsvExa08Yvu91Vb0/tKQ+SCKTak3D5r43ogtL++H6RDA==
X-Google-Smtp-Source: AGHT+IHlGlbeydfynnHANMYKk02ms9FHgqhtohDNroB4OSjfGyhwnUN0sTMS2AxgIS7Zc187idCGxQ==
X-Received: by 2002:a05:6870:459f:b0:24c:4c82:4f15 with SMTP id 586e51a60fabf-2584297b8a4mr1021897fac.24.1718314906065;
        Thu, 13 Jun 2024 14:41:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 14/23] qmi: ussd: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:23 -0500
Message-ID: <20240613214134.1056517-14-denkenz@gmail.com>
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
index 17160354c273..456a5d2363eb 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -833,7 +833,8 @@ static void gobi_post_online(struct ofono_modem *modem)
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

