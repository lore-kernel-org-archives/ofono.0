Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58415572E
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800486; cv=none; b=ZYjysoV4wcmtNMtgPAhqAmdqUA0631tLpAcD0T9JBV/f5SepVQT4u48Se6fJjwyJ6FmOy9/tWN2Ym31l4jbTm0ts2kixYv4fEEsxGuChg8mG1I+avSLTZyzvgewYjVP3sRFfzviRawvDXa4rq7OcnlsdcPqEsf0k0oKxZ9X5esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800486; c=relaxed/simple;
	bh=vhWh+T6RlZXJBj5VGe3hZj4JBj+FYCcaUvSjzMZ9ENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJNYFXXZTwSQbalsexHDi6ZCib1EZnl+v6DphhSIIFRSEBa7wwqw7imKbkYeyGI4yT33Ihi/8vY010D8gSg7WcNQAEIas/5qUSj9efvhvsnxNbk19eMKPJ6pQM/7IqV4O4BBALbvWzwpXk5P0H3WI4yn8vyGuo347ZMDK+39Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml04CkJK; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml04CkJK"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b97a071c92so1366681eaf.1
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800484; x=1718405284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oesFof9ssiOR6KggjI1+dEYYKWLzRtMci6UvA+JL9CE=;
        b=Ml04CkJKEjCpeiZXLN0tEiEcZ/2PL7A/zcm99S4Wu/wuxna0eLeEKySoz+BGIrp32O
         3j9MSY/23prRyFq9lZuLUq829u6axO32wT9LPR3tCNBagghMzszzXwAqFWFM1ilkAvcV
         ZwProJLq6/D2+pUTqcKiRVT4H9Kh1w0uojaGtxJY/P4JnvjPQbJCE4nKPzNeFCFH/dH4
         jMuZZq3kqqaOxd/UAAWIaHPvVD0yH6v46m2QL7eSr952EqBhgCHqcpVSH+yVNRvoMxxQ
         dAiof2Xx1ug2bz//gcRfFqNLnsKZV1jgeqzZTs1N9+kfSgjJVYtt+ig6/sFDiY2WYN45
         GEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800484; x=1718405284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oesFof9ssiOR6KggjI1+dEYYKWLzRtMci6UvA+JL9CE=;
        b=jEPL4xIz97KV2ztNYRVFImLLFQXFQb4GsXgHfd6ZqKNzgjUWI7XCIZvK7xQwZyYUuP
         fpf+UHS6p+dO3dSz7eGNU5drqbAJh1+1gvp7AzEcl0Z36I2if2PVeC++Js5AJgTyG/FC
         7193VOJqkag2TfTixrkvNmpdmsoSHUgmYJVG/QdXtYT86zytvSxUAbdpcLADr00fwJ+e
         GWGck1rwpHcfk8pZnCJLtevLkkVo3GyFmzD/5IbcjjAv+r/cvS4ES926I/yVqC2+jy+E
         WfCRt+EmmL87KY/R4bpPuJnoFH2RnGQAnEoI7fpkC7gVx+CEGmropmFaMw9uZREzANtf
         VqMw==
X-Gm-Message-State: AOJu0YxBpVpq2KSn6rg1a0pai1SjDMp2R4YH7hVSfAP1G2vDT+ZmcjLp
	UjyCjnj3tG0yMiG1lcRS1EOMchNOHs2HMwUPXg/ybv7ivitqGHPEpbuBeQ==
X-Google-Smtp-Source: AGHT+IEJ2ffzS6TeClaBXxVx4vzZAl7zUtGu6Xx0jI53eoANRliFtAJHL+sxvDcOMl35VT4IroT6yw==
X-Received: by 2002:a05:6820:2283:b0:5b9:ff9c:b884 with SMTP id 006d021491bc7-5baae76788emr4020506eaf.4.1717800483962;
        Fri, 07 Jun 2024 15:48:03 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 19/23] qmi: lte: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:19 -0500
Message-ID: <20240607224746.903769-19-denkenz@gmail.com>
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
 drivers/qmimodem/lte.c | 47 ++++++++++--------------------------------
 plugins/gobi.c         |  4 +++-
 2 files changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 5466eac7c204..d2d1048b5515 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -162,10 +162,10 @@ error:
 	ofono_lte_remove(lte);
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static int qmimodem_lte_probe(struct ofono_lte *lte,
+					unsigned int vendor, void *data)
 {
-	struct ofono_lte *lte = user_data;
-	struct lte_data *ldd = ofono_lte_get_data(lte);
+	struct qmi_service *wds = data;
 	struct qmi_param *param;
 	struct {
 		uint8_t type;
@@ -174,49 +174,25 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
 	};
+	struct lte_data *ldd;
 
 	DBG("");
 
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		ofono_lte_remove(lte);
-		return;
-	}
-
-	ldd->wds = service;
-
-	/* Query the default profile */
 	param = qmi_param_new();
-
-	/* Profile type */
 	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
-	/* Get default profile */
-	if (qmi_service_send(ldd->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
-				param, get_default_profile_cb, lte, NULL) > 0)
-		return;
-
-	qmi_param_free(param);
-
-	ofono_error("Failed to query default profile");
-	ofono_lte_register(lte);
-}
-
-static int qmimodem_lte_probe(struct ofono_lte *lte,
-					unsigned int vendor, void *data)
-{
-	struct qmi_device *device = data;
-	struct lte_data *ldd;
-
-	DBG("qmimodem lte probe");
+	if (!qmi_service_send(wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_cb, lte, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(wds);
+		return -EIO;
+	}
 
 	ldd = l_new(struct lte_data, 1);
+	ldd->wds = wds;
 
 	ofono_lte_set_data(lte, ldd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_WDS,
-					create_wds_cb, lte, NULL);
-
 	return 0;
 }
 
@@ -229,7 +205,6 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 	ofono_lte_set_data(lte, NULL);
 
 	qmi_service_free(ldd->wds);
-
 	l_free(ldd);
 }
 
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7c3b352eb274..0e5e6badabd6 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -811,7 +811,9 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	DBG("%p", modem);
 
-	ofono_lte_create(modem, 0, "qmimodem", data->device);
+	if (data->features & GOBI_NAS)
+		ofono_lte_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wds));
 
 	if (data->features & GOBI_NAS)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
-- 
2.45.0

