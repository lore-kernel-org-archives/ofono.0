Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C43146D7D
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596708; cv=none; b=ZTeFyuFUkdeeG+iPU8cq60r0K14DoRxT3E3yYlI8sIXkgNnrWl7rGjwgkXG/MXW2/DxiqtGZuKWkRuNvgU2qHztA171PswvTjPF8Q42P2O3TdTGOgHRg8wB5tEX9++ERReVxcKqI1zJ31rIVGWZnPOjX7Fz/hjw5YQ8yo7k0O5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596708; c=relaxed/simple;
	bh=81RpkgqfyJKWDHVsOKvCKjD5cKl36YPVLUTQrimX/Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShNLfdGJLYm4Rc++LriLV72YzwM5ytzG/7FlLrYbzRFHiaMZWBqsH8elGoLhxvymCIClgz78BOkjZ7TmV7JmKnNvabCJZtyS1uuE2miG5QLsV9TaIsBB8RRyUYEycpkqYCR3ouUvwMkQDUhW58Po+/aXB9/DNROGz6a951x6X1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8IOlCaA; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8IOlCaA"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b1bbff09f8so90476eaf.1
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596706; x=1715201506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6UHh7+nWzKG7FiETnzVDRmr5ppMz3HFtEGMnF6T2gk=;
        b=E8IOlCaAehpsfTZNGyJvEvWqhZh5Eeqjg/iOwad79QA/j52z37XXndCb3sXsBJXaCn
         yfa7NAMnndHHc0BmS+O9SaWejFR+qaQafJaLIaltJtGPmqO6xCTfIRSg+2dANov5lZMa
         6XJ/OpUqKdfEuFOKj2r8RCUYp1LCuYDMT1Ul6pq1gjMED5D2YJnaqrrT4wa550JFZacF
         RhE4khJescOur6qRQm2rVXfG0JbPa4ff20GzStgTDa6h9OulSgAmeQFPGhN4DI424/EM
         PCIy4xLcac8lyHyMdfa3oVHYLqiDjgdRA2ZMBkc1k477f/9sFkjM9WxhGVvMV/NAjInG
         BlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596706; x=1715201506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6UHh7+nWzKG7FiETnzVDRmr5ppMz3HFtEGMnF6T2gk=;
        b=BZ7+AioUvwt4Mcwl//gVeK/3/VnfULmLYhp/IW3V89X5PBu0ZDXSsNgTkio3Foe1k4
         qiAzvd2AjavIzVVGFDFtAB80+NPq9W0voIs9Mka/Uo2G+VO2ewhCwe4RdweGJy36/I60
         ueQe7CDWmWr0ePJeXtEn2JKlw0vsRWUouTM7/AXKDHtVpP+/ROJZfPZIbxCGg7z5LZvd
         uvVuiDonOOY9/aQu8pzUzChAq50H7SbJ1xpshoGNCfMaDVGUtnlN7Oi2YUJRJyXntsWF
         Wodi3EolqeyUuzU/9vBUtUjfXv/o7TanRt1jf3+odHAGGFgHrf55UmilLd/iua2zFQUJ
         WvhA==
X-Gm-Message-State: AOJu0YxU+wzlDc7ppjt0zH2YSxBbmUmvlwkBQBEpsJIEVEr6pdkkTygV
	EEZJSJ+H5NvU67I1Ea4GxmDSO2KbSFpDGbPKsv2Keaa5PWcpM7u0TSCNtw==
X-Google-Smtp-Source: AGHT+IGPg7Dl/hPdo3oNbRduiW3CryWszbIeZ/887YHSjash6EoraoiWaeEoI+LKdHA1NR4KK8NWNA==
X-Received: by 2002:a05:6871:826:b0:23a:f308:b25d with SMTP id q38-20020a056871082600b0023af308b25dmr384047oap.25.1714596706000;
        Wed, 01 May 2024 13:51:46 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id or3-20020a0568715c0300b00234bc052521sm5883658oac.10.2024.05.01.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:51:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] qmi: gprs: Split out GET_DEFAULT_PROFILE_NUMBER request
Date: Wed,  1 May 2024 15:51:23 -0500
Message-ID: <20240501205142.12777-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501205142.12777-1-denkenz@gmail.com>
References: <20240501205142.12777-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow request to be re-arranged into a new sequence
easier in the future.
---
 drivers/qmimodem/gprs.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index bca1897ea02f..0122998a090e 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -275,7 +275,8 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	l_free(cbd);
 }
 
-static void get_default_profile_cb(struct qmi_result *result, void *user_data)
+static void get_default_profile_number_cb(struct qmi_result *result,
+								void *user_data)
 {
 	static const uint8_t RESULT_DEFAULT_PROFILE_NUMBER = 0x1;
 	struct ofono_gprs *gprs = user_data;
@@ -312,9 +313,8 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
-static void create_wds_cb(struct qmi_service *service, void *user_data)
+static int get_default_profile_number_request(struct ofono_gprs *gprs)
 {
-	struct ofono_gprs *gprs = user_data;
 	struct gprs_data *data = ofono_gprs_get_data(gprs);
 	struct {
 		uint8_t type;
@@ -323,7 +323,27 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 		.type = QMI_WDS_PROFILE_TYPE_3GPP,
 		.family = QMI_WDS_PROFILE_FAMILY_EMBEDDED,
 	};
-	struct qmi_param *param;
+	struct qmi_param *param = qmi_param_new();
+
+	/*
+	 * Query the default profile.  We never change the default profile
+	 * number, so querying it once should be sufficient
+	 */
+	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
+
+	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+				param, get_default_profile_number_cb,
+				gprs, NULL) > 0)
+		return 0;
+
+	qmi_param_free(param);
+	return -EIO;
+}
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs *gprs = user_data;
+	struct gprs_data *data = ofono_gprs_get_data(gprs);
 
 	DBG("");
 
@@ -334,18 +354,8 @@ static void create_wds_cb(struct qmi_service *service, void *user_data)
 
 	data->wds = service;
 
-	/*
-	 * Query the default profile.  We never change the default profile
-	 * number, so querying it once should be sufficient
-	 */
-	param = qmi_param_new();
-	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
-
-	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
-				param, get_default_profile_cb, gprs, NULL) > 0)
+	if (get_default_profile_number_request(gprs) >= 0)
 		return;
-
-	qmi_param_free(param);
 error:
 	ofono_gprs_remove(gprs);
 }
-- 
2.44.0

