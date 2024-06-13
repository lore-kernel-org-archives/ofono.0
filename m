Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF314659E
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314904; cv=none; b=C7XolvbMO1biCkTwOXTbzHx0y7m7g9Epq3TvP9RLY9KY7lzO4zRxaNaorGqHwXbKkkMGEVZUa1aTyw8zz6XiVCUJc3clOef/h/dKkz++M+zq43NErJi3K122meNQQglz0ach3E7/tFck/+hj1PzSUxSV2hu68YgqQyaDz1E5DHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314904; c=relaxed/simple;
	bh=yw9j6Ke1jitQxZ5FJckSf3kpQ9H4pDL+mAIx8YGPY48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX0YBPdMzI98qBjV8qghi3QLLE8XFfvMUDhQC0McslV+lquRTMH0TxS4YFmO2C5S0BiNwAqbUYpRHiibDoE+zSsCKB6SNuYnoyWQVHqjcQoSLz0gAWsq/4VT7vPLz7ZIK5FozY/7W/oRkr7aG4pGwEBRQ0gQnZjaNCHk8drOyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S38fcAH/; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S38fcAH/"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f98178ceb3so850885a34.0
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314902; x=1718919702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9YB2++cE8QMzvUCw1n7wUwm7KsJ2TiLsuLWQ9/yzZw=;
        b=S38fcAH/46HLY09oUKaYwdTIL5MZTbf2SXYgkNOMRqqOHmkNCJbYAdwyVmIWs1a63W
         F2yHQSvVK5OrtEmc8cBGddZ2QiUF61wMDpJ/u1lEtV8XdLydRWTVqFoVWIxiWXRK1Gbw
         J3IygTlIPL/+l9XrWeRlOknejZ764Gg20zjcjgO26lgl1+Dfto2WwoKFiVvpURi790sN
         s71yNaTEkBcXW83poDHnR+SMw3h7+aCSOGB1vYq8mT9DOdWGOjRPFlKyIHP0w2+rT/AW
         7TlWtAr5t7eFncCT8xBaUwJt5ok+J0cZpnVaxXwU9NzpX1mnx5p6kdlFFKRGhNmf5AOn
         LvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314902; x=1718919702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9YB2++cE8QMzvUCw1n7wUwm7KsJ2TiLsuLWQ9/yzZw=;
        b=fwuYAIr71EHXqd+2LDz0sIwA6mj3sMghbk/2z5u4EtbWk2MZkIb/30Uck6yHhTtWdT
         roZ1WJM9geHIezqaDiZtNWoshdtA450G6/QrTjAyBXWHdLA8sU/Cu5NI0WnjZ5J8QHg4
         6eRpMhBGAK6/XeKZHg2wm7/YPh3+BMGYUHQ2ce95WD47MMtSgnBkM2zAE1ArXBgQHsgc
         ZeS+ZXlp9cXtX2By1CfqoJqtql9vtkyPEMQpzZSB56rb7Waq6t/XBQJDsZHh51LJZAkc
         iCtnsFhXu454ND8tWqhyFm+/Nnn8tO5Yu2foZ8VxNvXu1mae6oG2gufrr6WUmZ8LgRuU
         Fygw==
X-Gm-Message-State: AOJu0Yz3YhmTj/Lno58ZqneeGjA5Y3+/3rWFBwttpp0TchIXur+7c3jr
	mREuHpiB5U/zw9bTHy/4qRWX+irdVXMSApjT/POKOk9IRRIfsJh73C9Zlg==
X-Google-Smtp-Source: AGHT+IF79Dtkp1xD1hy4jXXPJ5qAxBPK3vjwBJ//fCodJL8biZjE9VEwfGAwqQD36cvLkUJShfFhtg==
X-Received: by 2002:a05:6870:15d5:b0:254:b781:2f71 with SMTP id 586e51a60fabf-25842be93a4mr996286fac.57.1718314901628;
        Thu, 13 Jun 2024 14:41:41 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 08/23] qmi: devinfo: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:17 -0500
Message-ID: <20240613214134.1056517-8-denkenz@gmail.com>
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

Send qmi_service directly to the devinfo atom, which will clone it
during probe, obtaining its own lightweight handle.
---
 drivers/qmimodem/devinfo.c | 45 +++++++-------------------------------
 plugins/gobi.c             |  2 +-
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index b74e535aaeb8..2e514cfa3265 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -192,53 +192,25 @@ error:
 	ofono_devinfo_register(devinfo);
 }
 
-static void qmi_query_caps(struct ofono_devinfo *devinfo)
-{
-	struct devinfo_data *data = ofono_devinfo_get_data(devinfo);
-
-	DBG("");
-
-	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
-					get_caps_cb, devinfo, NULL) > 0)
-		return;
-
-	ofono_devinfo_register(devinfo);
-}
-
-static void create_dms_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_devinfo *devinfo = user_data;
-	struct devinfo_data *data = ofono_devinfo_get_data(devinfo);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request DMS service");
-		ofono_devinfo_remove(devinfo);
-		return;
-	}
-
-	data->dms = service;
-	data->device_is_3gpp = false;
-
-	qmi_query_caps(devinfo);
-}
-
 static int qmi_devinfo_probe(struct ofono_devinfo *devinfo,
 				unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *dms = user_data;
 	struct devinfo_data *data;
 
 	DBG("");
 
+	if (!qmi_service_send(dms, QMI_DMS_GET_CAPS, NULL,
+					get_caps_cb, devinfo, NULL)) {
+		qmi_service_free(dms);
+		return -EIO;
+	}
+
 	data = l_new(struct devinfo_data, 1);
+	data->dms = dms;
 
 	ofono_devinfo_set_data(devinfo, data);
 
-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
-					create_dms_cb, devinfo, NULL);
-
 	return 0;
 }
 
@@ -251,7 +223,6 @@ static void qmi_devinfo_remove(struct ofono_devinfo *devinfo)
 	ofono_devinfo_set_data(devinfo, NULL);
 
 	qmi_service_free(data->dms);
-
 	l_free(data);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index ea4d633c3406..1817f7b5ee2a 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -713,7 +713,7 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
+	ofono_devinfo_create(modem, 0, "qmimodem", qmi_service_clone(data->dms));
 
 	if (data->features & GOBI_UIM)
 		sim_driver = "qmimodem";
-- 
2.45.0

