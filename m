Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961C1553A6
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800481; cv=none; b=fIYnduMdY+YYmGWHSiSi+4+rX8T48OjX31M/lc4rY7lCKMHIpsNglbCUcAn8bR3UqDarZ8WAbZVj0NK6WF1Sk4pgulztGU+ikrybNNYkSXwcOutore3sxP3fOqI0ADzAczBy5C7hfFSWYnjr/uJL6eXHr/4hcpjt56wTlJdx+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800481; c=relaxed/simple;
	bh=iKy9R28icw+U7LEPrqe8aDb4tRGC/IUXmWKTva9Eu/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnBprmeBZihAuK6gUp6StWxAVtw3W02gJoDjvTucVWA63ZyZGoIb5A0NP8ayhiPduR5nRl+2C5oGSyp25k8HBlJTBbUWy4cLIujVCwBHrf5iF/S/eJ100H6FjDLxijKbCVm+qw6rnIjfrp+4ZiIcuUftMFTUC0PCsLTcU7DIo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtR5sSCk; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtR5sSCk"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b9778bb7c8so1398033eaf.3
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800479; x=1718405279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fRRhZG6wipDEWz7aRdDtPXrNzxjOff4i1UJVqh+B4I=;
        b=PtR5sSCkuUq0RRv34DZjrMPdCnLzkr1ctozKttOw634WXvfEMgnJlSB3dg8KmjuM3m
         LdbPBSY+JrWl8Lj4P2CDsBxwYtQEFtFrUfkhyS4g997YLmBn93/q1TZR/b5j9OVRioJk
         GaGuqzzO160KaBA+mi3WpVE5+eusM49hfGEcyPrIxiZkmj58Ay9o0mngHCsTQHjlqQ44
         EpXDdv8n9Pmnmmhqd5bmXkMC0dA1jc8/Ajy7P7SwbWmYhhoXkKDwmvyJbPde7npHGqr2
         Q0Qpy/GoiaofLS79ppi1rNoK7HYz5K1atihr7lZVjXVFIEANoZj5aU4O74YCPOy5BrYP
         PxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800479; x=1718405279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fRRhZG6wipDEWz7aRdDtPXrNzxjOff4i1UJVqh+B4I=;
        b=CUqr5J20dw4nxteHwok1bwVu42tciuxo/UPsHR8mi8kUqwfuEgdt1lEoqFWJgqgH8A
         Ly2lvnXsp4au2CKK0WhjnEfgIIO2RJ9zk+HgX4YruNjzaIlIJZ1lH5gvF+rONnUAsXdX
         j0w4S8M9ox0dWAJiZGkTtIW4RlTC5LEhdANUUS0APGY9CLLJ2CmgX1qu0kO2EYlrUMRb
         iwQVTAJxUL6wAX1JqRheOdba0rIGbGLYo5kHbNg/5tCZwyKAz6d0b+ngyKKpBoY48PW6
         HGNS5e+uL1lKyi5ZtO3LZRnrXbtQNn0pSNMbFH+jRLNXlPsVFUkj1h19pZQsxWwr/hng
         HsOA==
X-Gm-Message-State: AOJu0YzDHyOqwdHpPUBEnvypINgDzxUGz1DykbIijtzys47rr7o0U+Rw
	2y0F2XSjL54IFVvhOOL18BGEZrokxGxTlWWSdQRN9FgSSPjQvuN7cnEraA==
X-Google-Smtp-Source: AGHT+IERux48+31oBf2Kg3GvXxLRdQW5pyuZyl1ybVxksbyU+5bxXpVt9Z+Qnl74H+q8GN9VVaa40A==
X-Received: by 2002:a05:6820:1ad3:b0:5b7:3502:653c with SMTP id 006d021491bc7-5baae75722fmr4590250eaf.4.1717800479071;
        Fri, 07 Jun 2024 15:47:59 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/23] qmi: call-forwarding: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:12 -0500
Message-ID: <20240607224746.903769-12-denkenz@gmail.com>
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
index 1688d5478d59..ff6d7553f851 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -850,7 +850,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 		ofono_call_barring_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->voice));
 		ofono_call_forwarding_create(modem, 0, "qmimodem",
-						data->device);
+						qmi_service_clone(data->voice));
 	}
 }
 
-- 
2.45.0

