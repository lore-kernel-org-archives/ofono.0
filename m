Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C815572D
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800485; cv=none; b=tO6NXeL60CB98kycJPjTjyST+I/WC8V/INxPVsRQw2Y2HffeDS6PSlkJ/hnomcaUc6HmqdNeYGTfwjULYqsrZ878JqQiGRyXO+0rph4skKW/b25TBu2NRuiEeF9TOdmDNZl8m9aCuy0ua/Ta1B/QpPjB0rNeLonQQN2CJDcy5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800485; c=relaxed/simple;
	bh=SwULAulV4HnvpfTTr+6Nllpmj1Y2NI4+Th2yH0eiR1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpDM2VBawzM5lUxcXxDbSAy0BhBLkx0kpX/IDEWmDyXpj2vHUurDxEJUc0IF7BTftT6fKtw+ZAbdTu3RsSj4S8vhP6IFhZEe2tBa4FIFfHS2R4dcrq3YONv1EXQ/lCPTJ8cgxaaIkXrr8cyJuD0EqNoRf7qJvIauSpSAZzpshxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmd2XRca; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmd2XRca"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bacccdddd1so416075eaf.2
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800483; x=1718405283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ErA5jrZR07RoJqNMKsEwZqsgW0qBbd9MiVmTLNjRkc=;
        b=Fmd2XRcaA3lOo/Fbtdk2bD3R37GsN6EEcf8Z4tD/0riyB2ZalG+M9x+6DRFapy0jKq
         +iEDg/iLxG83T+2Jj7bC7IumesXPj9+wY2fj1NT8KVTI144rxACmsd0oDb4No1A5DSmF
         n919O1yhnP/IpSGOBX6LagovO8AfIVLUDc9/xmVwdj9PLpKBuqd81uLzhprjAaZgee+1
         gbt90btROUbz3/eZRFKpXeVeSfS8Nqs5sWCoS5dZKgIerJZpglfmFAeC6UDvPV2YU9m0
         ZvWL+7FEsDwVEM+fs7AOqduNuX51xH6blQ0xNWqSc9naOJ4wDqRwnOkbrnvKzp42doR/
         Q6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800483; x=1718405283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ErA5jrZR07RoJqNMKsEwZqsgW0qBbd9MiVmTLNjRkc=;
        b=N+zwu1pOSI42MMGG1e7OEB9E7BI+DHRMOAyF8RWXYN1QVIN0GDtgrCy1v4+YJJ7mhd
         zspTHyFv1+Y3dX3UBsUjqVELTWdeCnGOtGs4TeZs7C87WbKIuUs0vkdY8/Mo2FVIaDPX
         ocSUVSeoOZhvwLK+X5XffWe7plKicQl9Pes1T0i7rHXoCpIhmNcGeqSDRRRWfoAe9YJx
         gYtn/vEZlG7Q+djaNtr9kiYoSGZ+YQe7q9ct0xBA7DcXqYiwdaS//b+yn3lF6RQ9DOOt
         L6b+37GnBP+U6HAQZonzeA8TpNgFWVwpxTuz6nN2MGveUWuECtNH2AG4ba9fNWk1lA0N
         iHOA==
X-Gm-Message-State: AOJu0Yzd5kmMA5Xwzzcxv+wiF9cSWF+kpz60LKivmTtzAamXpaDUgqLg
	UTBcLNOrUoLjDCzne2hgKR1GDXgJq0alLNMx6dYIvbZ4LBHAhSBxedtHfg==
X-Google-Smtp-Source: AGHT+IFN2kTUcrUCCsAZtVyH4ZBZBwoCLeiVb00TZdP1al9ZTRVbKWQQEXUTrWw7CNOAyzRzVWsOjg==
X-Received: by 2002:a05:6820:626:b0:5ba:7350:9e5a with SMTP id 006d021491bc7-5baae8e19a6mr3570379eaf.9.1717800483296;
        Fri, 07 Jun 2024 15:48:03 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:48:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 18/23] qmi: netmon: Drop use of qmi_service_create_shared
Date: Fri,  7 Jun 2024 17:47:18 -0500
Message-ID: <20240607224746.903769-18-denkenz@gmail.com>
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
 drivers/qmimodem/netmon.c | 26 +++-----------------------
 plugins/gobi.c            |  3 ++-
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index f45a9efd6af8..82e0f2a4c737 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -195,39 +195,19 @@ static void qmi_netmon_request_update(struct ofono_netmon *netmon,
 	l_free(cbd);
 }
 
-static void create_nas_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_netmon *netmon = user_data;
-	struct netmon_data *nmd = ofono_netmon_get_data(netmon);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		ofono_netmon_remove(netmon);
-		return;
-	}
-
-	nmd->nas = service;
-
-	ofono_netmon_register(netmon);
-}
-
 static int qmi_netmon_probe(struct ofono_netmon *netmon,
 					unsigned int vendor, void *user_data)
 {
-	struct qmi_device *device = user_data;
+	struct qmi_service *nas = user_data;
 	struct netmon_data *nmd;
 
 	DBG("");
 
 	nmd = l_new(struct netmon_data, 1);
+	nmd->nas = nas;
 
 	ofono_netmon_set_data(netmon, nmd);
 
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-					create_nas_cb, netmon, NULL);
-
 	return 0;
 }
 
@@ -240,11 +220,11 @@ static void qmi_netmon_remove(struct ofono_netmon *netmon)
 	ofono_netmon_set_data(netmon, NULL);
 
 	qmi_service_free(nmd->nas);
-
 	l_free(nmd);
 }
 
 static const struct ofono_netmon_driver driver = {
+	.flags			= OFONO_ATOM_DRIVER_FLAG_REGISTER_ON_PROBE,
 	.probe			= qmi_netmon_probe,
 	.remove			= qmi_netmon_remove,
 	.request_update		= qmi_netmon_request_update,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 9c0ea4f6bbcc..7c3b352eb274 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -842,7 +842,8 @@ static void gobi_post_online(struct ofono_modem *modem)
 	if (data->features & GOBI_NAS) {
 		ofono_netreg_create(modem, 0, "qmimodem",
 						qmi_service_clone(data->nas));
-		ofono_netmon_create(modem, 0, "qmimodem", data->device);
+		ofono_netmon_create(modem, 0, "qmimodem",
+						qmi_service_clone(data->nas));
 	}
 
 	if (data->features & GOBI_VOICE) {
-- 
2.45.0

