Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4055146A8A
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314907; cv=none; b=kT5rU9QA5cB91p/olQVUOHB95bbVKetC/3dFeqvcfZv+wA/qbGngcNInMSjExw92PCge8jzwLiGPaZ3+bW2hcn3xPp2exPChztY9VWhSEnr8YAlhn71AvCQKS8m2N+DxsdiaSreQTmqdMOTRk7jkEczFvDuJcyjSuoOkqOcLRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314907; c=relaxed/simple;
	bh=kBwyX8yEIIcD4snjHIDaz6qoC4OJqKDg5x3mIFk6FdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhUepulISzksvI5mZCdleLDXyU5ambm0+alL5PxAPmGdSSjmwaGblUHT0WsKDmuQO32dmoJD8im57CbpLy64L5LqrHrVhzf98rjtdXVm9tgCfy5nCxOZCmldp7yKpg/yTfbKf7QNhxfk7n/IDnln2C443bspfXEvq0bDqHBXzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtDJ92Ak; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtDJ92Ak"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254c8e27c80so779843fac.2
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314905; x=1718919705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDMY6Gv4vpIDjPQoiVLMdXZvuXP0bXGRAjAjXkvohVo=;
        b=jtDJ92AkXQ+owFDVlXTESo0GHCslRII9aWFRnY8WLJz2GKBwYGIanaL8G7B0ZQPfs3
         reeQTKyQqqXJ0nQCT6psfu+xEf5Rg5jAh9ua5OFyiX9T2RI23TQpAHTsQhip6WuaFm56
         hpIgb1j2qflaeBQCV8ldGq1O674iO44mQyLHsg1bsBokY9XvPj9W8KvWqRtu/b73GmlP
         ri74cAd/AEiDCnwI1A2Q+K+O0p5wDHO5k4c9jx+x/HM27R9rj0/6xIAzHzrS3WXEr7VE
         xuiHueIYJq5MXRcWmZKh17qif0VGmSCP1n59pWGXjQc5ZhE+9rGlEJ1UZ9lKFHwS0XG/
         QW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314905; x=1718919705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDMY6Gv4vpIDjPQoiVLMdXZvuXP0bXGRAjAjXkvohVo=;
        b=uohPpylC5Qj6l6oqSd4RL9mTV4qhslmTFbsMcbh5gsWWh77ajXgbCill8nIb/MKpCv
         rZpBgg+xfSLr+3ATe1sXO3EyqPWAe1U8E0vZSdjpxJUUMb5Zls5YJixhrtqp3CQ0gWmR
         ltN+xx/O8I2+Gza3H7KlNGUwBA1kqXdO9EdPgeeJ01RMEk2oAdL6riYecLBwO11Lg8vA
         ZrFWluMDjR3Ia+zX1ANFRTeBK6sfUNsLla0Z+LLb78ubL4LHaD8swOSvDAHbX6smKncf
         8hvUwVc9vplOiFTqW8pg/vP9ov9aP6xfAp6naxXjp+r7wOUoWqA5EFnUNhkEtPfRoApg
         FTqw==
X-Gm-Message-State: AOJu0Yx4oU7q+PMXz9rAo8PpREo+ClTIbWOWjDdayOFQjKAWzpOjQGNE
	CD6/Y247xviE/ea55Wqp/KzCFCO4Y6NsV44RGQpJ2NuerIOJrP4oZq4saA==
X-Google-Smtp-Source: AGHT+IHIZcnEUoeaZlLF9KUXSvkXbly2nC4p7TU/yHbviZdVYfAU1mWYfCJrETGN44+nyNDo8wmUzw==
X-Received: by 2002:a05:6870:6122:b0:22a:b358:268 with SMTP id 586e51a60fabf-258429987eemr956037fac.25.1718314904723;
        Thu, 13 Jun 2024 14:41:44 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:44 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/23] qmi: call-forwarding: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:21 -0500
Message-ID: <20240613214134.1056517-12-denkenz@gmail.com>
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
 drivers/qmimodem/call-forwarding.c | 29 ++++-------------------------
 plugins/gobi.c                     |  2 +-
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/call-forwarding.c b/drivers/qmimodem/call-forwarding.c
index 191f3db75645..e7ae35153b09 100644
--- a/drivers/qmimodem/call-forwarding.c
+++ b/drivers/qmimodem/call-forwarding.c
@@ -276,39 +276,19 @@ static void qmi_erase(struct ofono_call_forwarding *cf, int type, int cls,
 	qmi_set(cf, type, cls, QMI_VOICE_SS_ACTION_ERASE, cb, data);
 }
 
-static void create_voice_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_call_forwarding *cf = user_data;
-	struct call_forwarding_data *cfd = ofono_call_forwarding_get_data(cf);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request Voice service");
-		ofono_call_forwarding_remove(cf);
-		return;
-	}
-
-	cfd->voice = service;
-
-	ofono_call_forwarding_register(cf);
-}
-
 static int qmi_call_forwarding_probe(struct ofono_call_forwarding *cf,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *voice = user_data;
 	struct call_forwarding_data *cfd;
 
 	DBG("");
 
 	cfd = l_new(struct call_forwarding_data, 1);
+	cfd->voice = voice;
 
 	ofono_call_forwarding_set_data(cf, cfd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
-					create_voice_cb, cf, NULL);
-
 	return 0;
 }
 
@@ -320,13 +300,12 @@ static void qmi_call_forwarding_remove(struct ofono_call_forwarding *cf)
 
 	ofono_call_forwarding_set_data(cf, NULL);
 
-	if (cfd->voice)
-		qmi_service_free(cfd->voice);
-
+	qmi_service_free(cfd->voice);
 	l_free(cfd);
 }
 
 static const struct ofono_call_forwarding_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_call_forwarding_probe,
 	.remove			= qmi_call_forwarding_remove,
 	.registration		= qmi_register,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7c6885b79c7c..85ab427e9de5 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -838,7 +838,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 		ofono_call_barring_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->voice));
 		ofono_call_forwarding_create(modem, 0, "qmimodem",
-						data->device);
+						qmi_service_clone(data->voice));
 	}
 }
 
-- 
2.45.0

