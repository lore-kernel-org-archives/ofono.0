Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E780155739
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800489; cv=none; b=YUdn8JfHei4v00r4/QDk4LfaK8RmIO7gcxcRDsWwWUqayqSQY/WQrQbbknxQib3uPFr/XKXcwidhYMiCny1TeA+wOv9vnhz60nGNuAV4IE5S7bTYppDpRKP2euyqw1fsIOhOoICZCyjTfwyZZ3V+X00yMp/l7cmDqYtE4/aqhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800489; c=relaxed/simple;
	bh=Pp8P/c6/5sdHVv8oFpdDhrCl3LhH8d/dNx8eVANIDhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB6cAVtyp7YbkT6R4KctOsj+3Y1jzdQmeEJRAcMvUuKxKl59gl7GxiSXWYaQ9IFH09oi/GILduNH+8BYLylD8eX6O4lcA+zCtmvVno8nNZeWrCz0JZZqJAgck702F1ZzZjiGAkaoLpEhR8FIY9p36pcVs/MlPpqZrpxiDUnMwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY8Jrrnu; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY8Jrrnu"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso1192882eaf.0
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800487; x=1718405287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF/6GddWOqxS7yf6OLz866Lt+WuomuZF4pEEHEJcuAQ=;
        b=kY8JrrnuQQobb1/XNNciuWBlMlMykMcdtcA76s8wE5eScHHZr77CYIfpDYHVTKjXR0
         Vrg4eXBpo2ggF/eXAwe7ip/6UiqoEhLAkbO/v++Nn06SpwtZMYZbX24LrdLzbD9XnGeX
         r2KcADgZ2qDHHf58pbYEnw1DJBAddQ5tSzRXJ85Z3srPMRWxmady4GWQK1YOZv9aY6L4
         Z6GpWBqJKL6hSGPznypFkGeUm6nkl+1mSlDf1Ma9M0B8X1TPGHhcUpmiPwahYdx1uzcN
         4l3wkJNHfBZfJQ0vOnWMCuyN8199UTt6NsaaT3NIajLQGWK60CiDB5N/gHbcJhYcOOdN
         h48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800487; x=1718405287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF/6GddWOqxS7yf6OLz866Lt+WuomuZF4pEEHEJcuAQ=;
        b=ogfUhP8tt4foq80Qn4GSlR6LZhhe9LlxKKmmHrA9CdaDvJMBddtGYmr3oZC7P2i9RB
         8MoMwwJsIjRUs3SeIl7fsurR7D7lymg86BqqlDp1XSAt+ouQh8ZM57Mvn5t/kEe0qZnM
         AieobgEV0iH2+qKhOPi4OWFRdSFDPiIpTY1+ZqU8J54Gsg3VlzF9Vg7Zv/eiM3//js3Z
         KVYkn49riupH4Nq9zv9acgdmaIMMmnTAWQiNbzjQ9BDpV1urMEFuOC0D+yYcCDzg7mNH
         3G/I/drnSUtwI0F2Effiq8x5kt6ijFKpkCEZ7bqtmDwfY+rR4bfOj3NTOaXuuKyZ2xHC
         lKHA==
X-Gm-Message-State: AOJu0Yyi/1vbnVDHdRntr5R2+HrHv3mJKteFUg5I1zSy4LjdQrzLinO0
	J2L5CovJ7+DPFRyojHe9IGelX2y42Qax30H6xJu72JoEC9jyRC75DxzEuQ==
X-Google-Smtp-Source: AGHT+IH9Nsac5xdqhd27euD3idIiF8S72hbEz5NlU4FHsnM3Gm/YGEbx0rMWKQNbeP5ZuDua48NKkg==
X-Received: by 2002:a05:6820:1609:b0:5b5:3d56:287b with SMTP id 006d021491bc7-5baae7520bemr4528705eaf.4.1717800487013;
        Fri, 07 Jun 2024 15:48:07 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 23/23] qmi: radio-settings: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:23 -0500
Message-ID: <20240607224746.903769-23-denkenz@gmail.com>
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
 drivers/qmimodem/radio-settings.c | 56 ++++++-------------------------
 plugins/gobi.c                    |  4 ++-
 2 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index 2e428b9d0c2e..8463c84bf1ed 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -198,59 +198,22 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 
-static void create_dms_cb(struct qmi_service *service, void *user_data)
+static int qmi_radio_settings_probev(struct ofono_radio_settings *rs,
+					unsigned int vendor, va_list args)
 {
-	struct ofono_radio_settings *rs = user_data;
-	struct settings_data *data = ofono_radio_settings_get_data(rs);
-
-	DBG("");
-
-	if (!service)
-		return;
-
-	data->dms = service;
-}
-
-static void create_nas_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_radio_settings *rs = user_data;
-	struct settings_data *data = ofono_radio_settings_get_data(rs);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		ofono_radio_settings_remove(rs);
-		return;
-	}
-
-	if (!qmi_service_get_version(service, &data->major, &data->minor)) {
-		ofono_error("Failed to get NAS service version");
-		ofono_radio_settings_remove(rs);
-		return;
-	}
-
-	data->nas = service;
-
-	ofono_radio_settings_register(rs);
-}
-
-static int qmi_radio_settings_probe(struct ofono_radio_settings *rs,
-					unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
+	struct qmi_service *dms = va_arg(args, struct qmi_service *);
+	struct qmi_service *nas = va_arg(args, struct qmi_service *);
 	struct settings_data *data;
 
 	DBG("");
 
 	data = l_new(struct settings_data, 1);
+	data->dms = dms;
+	data->nas = nas;
 
-	ofono_radio_settings_set_data(rs, data);
+	qmi_service_get_version(data->nas, &data->major, &data->minor);
 
-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
-						create_dms_cb, rs, NULL);
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-						create_nas_cb, rs, NULL);
+	ofono_radio_settings_set_data(rs, data);
 
 	return 0;
 }
@@ -270,7 +233,8 @@ static void qmi_radio_settings_remove(struct ofono_radio_settings *rs)
 }
 
 static const struct ofono_radio_settings_driver driver = {
-	.probe		= qmi_radio_settings_probe,
+	.flags		= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
+	.probev		= qmi_radio_settings_probev,
 	.remove		= qmi_radio_settings_remove,
 	.set_rat_mode	= qmi_set_rat_mode,
 	.query_rat_mode = qmi_query_rat_mode,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index b7a8240edd3c..549ccc6c9d7b 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -820,7 +820,9 @@ static void gobi_post_sim(struct ofono_modem *modem)
 					qmi_service_clone(data->wds));
 
 	if (data->features & GOBI_NAS)
-		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
+		ofono_radio_settings_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->dms),
+					qmi_service_clone(data->nas));
 
 	if (data->features & GOBI_WMS)
 		ofono_sms_create(modem, 0, "qmimodem",
-- 
2.45.0

