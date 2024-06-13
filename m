Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B499149DFA
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314914; cv=none; b=OYQMu/yVZ7FRYOUD0gbMBgVxIP+BiCyVnBfVXa62IdyNMQEHbt+e3fiNo4Rs72KX5t95FjdvUk35CnOS8/hXuxfJVtX/hZWWsuDzK77G/XNVysTNICuh1ybatlFJV7MCeFj7Oqp0fBsQ9WDyyD5AkNoSRihhypeGkROTi0W+Hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314914; c=relaxed/simple;
	bh=isa3czjh/e+xPdF5+OkrJWpJ/jxtiJ7rJloXoPFCLqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2GNkssMbxiiNOFrNUGiR5M7QFKOCrmJg/MmSbFNt93I+crXZL2dh2z7qUOI0zxuJEQJk22kVhWQ1moIUOo+Wbqs+2D1QB2eRJRUVS9Fozi2F0/pwwdOtMmJJq+AhKaeutdHyiAibFcvu/yXQo+EwVkn6OWvhrGCDmwe+Gl8D0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkfyaMUo; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkfyaMUo"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-250c0555a63so755734fac.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314912; x=1718919712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT1g+0cCov0gjryw82CAVve6oNmT4iBbWPPSMobdXeg=;
        b=fkfyaMUoMRJapTg+HmbVfaNZOGYiSkichDVRxGNQKMYbt4QI3v8Qb+V6xxz2X/5/fh
         MDl6QKAykZ0ncJ5HyOR682p5H+NuBooiQiafIKM+iz8Y7ZYSWsoH3ZkHjag5EFGJbylX
         U/mw6F8Q1WorU0AgxmREeQSragSpYh1nrtrF4PhPPTr8jMpeAf2yNqODPJaEH7ChOzPW
         ZxWisRAstsg9Mu6fvNGmQOlzTY+mrsYh/syzZMYQf8dFfKs47Pxq/w9AEXNu1Sg3bksl
         szPBYIXbMrDNxg9ARw9v8a6930E1e++a1VjrTtDSHQ7C8NwAMjNTRHYtIY3pO5ZMIc7W
         Stqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314912; x=1718919712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT1g+0cCov0gjryw82CAVve6oNmT4iBbWPPSMobdXeg=;
        b=uDtITa1AXX7VtbgEQ982+MZN3QX09/Cx6PfUD3wnmFAjSVow1saals4TriPdA6to+j
         BasinFgdhlAhb/q+Q47M2oQnmAO1ExmvWo6fTgap4rb2KiCOtI4TXsU8I3TxCaehwtSA
         J8nuq4PyBDRyRFajIkA66ZDYmfOF+zQn4LcGQ/GuNHXlXGD5ZKsdxpEWuGSj6dbbxQoh
         3Y+IvuvjFLYBpAP9dWrWlPMYxla7q5sXFGTzpsRG5PLKPvFUZWuzTPnen7Dp4mYTaelk
         XDpEeatv379Koh8D8oXLp19I1etx79RsHAcR+Rou69bVzY+mo6sUrggQkzZpyaaieq9T
         m0Kg==
X-Gm-Message-State: AOJu0YwC4SVVd/uywqqItr7REUrU/7ryy5NNLeg3B2s69gAc0zUGM6Ia
	uR1eIbjQsI8ecWNqqLMA7YFJz5rNskCsaRQSbJMhI73OhstuqEAwvEKXiQ==
X-Google-Smtp-Source: AGHT+IFw3G9Qj7gC8OywYORFoNE8i2Zeq9kyaOD11HyG6BSBpHeCvfGi6nS6NIhNQjJMBgNdUyssvA==
X-Received: by 2002:a05:6870:c1cf:b0:254:9d28:648 with SMTP id 586e51a60fabf-258428de92bmr894342fac.16.1718314912387;
        Thu, 13 Jun 2024 14:41:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 23/23] qmi: radio-settings: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:32 -0500
Message-ID: <20240613214134.1056517-23-denkenz@gmail.com>
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
index 1a866490d41c..5402bedcc22e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -809,7 +809,9 @@ static void gobi_post_sim(struct ofono_modem *modem)
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

