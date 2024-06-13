Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD081494BC
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314914; cv=none; b=LF7Eqj/fCjmjf+Ity1f3APAbVF7sZO642YtNw8NZgD8E8i0KaK34T6wJIm8q9fFzRkuKuUr9jv7Woi6icl7kc6cpMEjRJ5cbRYI2y46JFCBFWxEY1ZRYy7ulB1ajiiXtkvthN85GmjUiZn9WQFcNuQRXDgHSVQ0bqY11sJpPviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314914; c=relaxed/simple;
	bh=yshPWH0DKrmeyvPBMbOQC6teqXTeC4PeCGax6pr5yhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dULe2p2Cq/I9aSE0YDVaMGFxKNz0IX5MkGZ3iqmgV2rqdeL1d5Bf6xaAzTsnLqIPccL+04TyqIV+zXRMboD0tYEoqJ6zPWdsWcComGrhIColhUpV9K3muXwPtoK3WyXWsVn5PPeJL3eHiecKhYvx3L9ZwPUoVqq5Q4Pi6bXuhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjK5waYc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjK5waYc"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2548a00c19eso815054fac.3
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314912; x=1718919712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW/pce/bOqMWBRHsaDRAYAn1WCtKDItF8daMWFarSP0=;
        b=WjK5waYci5ThVnzlkXnRn0SLdCUU+NDJXUnM1vLt0EpTPo/ARUIZ5IwkzXW+sRYb6E
         JxZQDBCO+uaqBnGMK8XRnrJzbYSNro9bAqdAnYiJin+f+EozwEDP46sMb2uzyciMmw3Z
         YLm7Tewvmw5VVqBR7v6e+ZD1BUfTcTJdTMXPEeBiVagrrrC2Ah2PHmyV2D5kFcTvQbrw
         DyDaS2jF5fkaWH8Y3AjrMVGG/xZuX6o2eN6pQigbATdV8iQEDYdnNkSLmhpBpOOd8oJC
         OERTJL7pvwPh4AIphjZvuFtd+vbLZS6Pnk2zZc4Nb+7EN5by55tP7iaFdw0zc9bWT7Zv
         P1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314912; x=1718919712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW/pce/bOqMWBRHsaDRAYAn1WCtKDItF8daMWFarSP0=;
        b=MJZUIHjxlto19XQSa9VUlt8ifhbmWIJbgzzVYrQPn7T81QcyG2VjGv1iyn9WHivxd7
         8Js24yXMKdJu8uneMFqycZ84yK2acYuiTAgSxKAfwT5c/TrSKaJQPj4zqvyc8rgi3Tje
         NAk38zQmXVrRd5Nqu/W9Oe9CoH+v/gG8CyfUKkCcwDPgRc9fJbld6KI6BN9GzCAsjMoo
         +nJFi+aMqgrDBTYjI3GtjJRABcffg9erKf8IMtuxfR4H3Ql7y+wCpaPrqsJdbiMkIDE6
         5DGrVnMwpQMWmM/Koxsaayi+nlGqWH+h4zvhTf9DHvFi14HezuWwmvUkGuBLYbOIv5jT
         XMeQ==
X-Gm-Message-State: AOJu0Yw4AerpH7ISRE5qTL8k80VRtlsHIGYF4rWlmRw5SajzrW/sqG/A
	UkpYw1DuccJjJ/hjFLv/3Xlq4eALZji8VH9itQiy0zjbdL60ozEmc6FeGQ==
X-Google-Smtp-Source: AGHT+IGHwec1Tbpb9gAFtcfEamCJ3ufoyJaJzj+urIvPQuvmHLBpx+oCy6uYS90KgSBvE8JTA0UwDw==
X-Received: by 2002:a05:6870:ac0e:b0:254:88ed:c9ae with SMTP id 586e51a60fabf-25842998b78mr939238fac.34.1718314911662;
        Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 22/23] qmi: gprs: Drop use of qmi_service_create_shared
Date: Thu, 13 Jun 2024 16:41:31 -0500
Message-ID: <20240613214134.1056517-22-denkenz@gmail.com>
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
 drivers/qmimodem/gprs.c | 85 +++++++++--------------------------------
 plugins/gobi.c          |  4 +-
 2 files changed, 22 insertions(+), 67 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 03ee377e8916..da7ad63c49cb 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -21,7 +21,6 @@
 #include "util.h"
 
 struct gprs_data {
-	struct qmi_device *dev;
 	struct qmi_service *nas;
 	struct qmi_service *wds;
 	unsigned int default_profile;
@@ -405,9 +404,12 @@ error:
 	ofono_gprs_remove(gprs);
 }
 
-static int get_default_profile_number_request(struct ofono_gprs *gprs)
+static int qmi_gprs_probev(struct ofono_gprs *gprs,
+				unsigned int vendor, va_list args)
 {
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
+	struct qmi_service *wds = va_arg(args, struct qmi_service *);
+	struct qmi_service *nas = va_arg(args, struct qmi_service *);
+	struct gprs_data *data;
 	struct {
 		uint8_t type;
 		uint8_t family;
@@ -423,77 +425,29 @@ static int get_default_profile_number_request(struct ofono_gprs *gprs)
 	 */
 	qmi_param_append(param, QMI_WDS_PARAM_PROFILE_TYPE, sizeof(p), &p);
 
-	if (qmi_service_send(data->wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
+	if (!qmi_service_send(wds, QMI_WDS_GET_DEFAULT_PROFILE_NUMBER,
 				param, get_default_profile_number_cb,
-				gprs, NULL) > 0)
-		return 0;
-
-	qmi_param_free(param);
-	return -EIO;
-}
-
-static void create_wds_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_gprs *gprs = user_data;
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
+				gprs, NULL)) {
+		qmi_param_free(param);
+		qmi_service_free(nas);
+		qmi_service_free(wds);
 
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request WDS service");
-		goto error;
+		return -EIO;
 	}
 
-	data->wds = service;
-	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
-				event_report_notify, gprs, NULL);
-	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
-				profile_changed_notify, gprs, NULL);
-
-	if (get_default_profile_number_request(gprs) >= 0)
-		return;
-error:
-	ofono_gprs_remove(gprs);
-}
-
-static void create_nas_cb(struct qmi_service *service, void *user_data)
-{
-	struct ofono_gprs *gprs = user_data;
-	struct gprs_data *data = ofono_gprs_get_data(gprs);
-
-	DBG("");
-
-	if (!service) {
-		ofono_error("Failed to request NAS service");
-		ofono_gprs_remove(gprs);
-		return;
-	}
+	data = l_new(struct gprs_data, 1);
+	data->wds = wds;
+	data->nas = nas;
 
-	data->nas = service;
 	qmi_service_register(data->nas, QMI_NAS_SERVING_SYSTEM_INDICATION,
 					ss_info_notify, gprs, NULL);
-
-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
-						create_wds_cb, gprs, NULL);
-}
-
-static int qmi_gprs_probe(struct ofono_gprs *gprs,
-				unsigned int vendor, void *user_data)
-{
-	struct qmi_device *device = user_data;
-	struct gprs_data *data;
-
-	DBG("");
-
-	data = l_new(struct gprs_data, 1);
+	qmi_service_register(data->wds, QMI_WDS_EVENT_REPORT,
+					event_report_notify, gprs, NULL);
+	qmi_service_register(data->wds, QMI_WDS_PROFILE_CHANGED,
+					profile_changed_notify, gprs, NULL);
 
 	ofono_gprs_set_data(gprs, data);
 
-	data->dev = device;
-
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
-						create_nas_cb, gprs, NULL);
-
 	return 0;
 }
 
@@ -507,12 +461,11 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 
 	qmi_service_free(data->wds);
 	qmi_service_free(data->nas);
-
 	l_free(data);
 }
 
 static const struct ofono_gprs_driver driver = {
-	.probe			= qmi_gprs_probe,
+	.probev			= qmi_gprs_probev,
 	.remove			= qmi_gprs_remove,
 	.set_attached		= qmi_set_attached,
 	.attached_status	= qmi_attached_status,
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7ded86c52b96..1a866490d41c 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -742,7 +742,9 @@ static void gobi_setup_gprs(struct ofono_modem *modem)
 	char buf[256];
 	int i;
 
-	gprs = ofono_gprs_create(modem, 0, "qmimodem", data->device);
+	gprs = ofono_gprs_create(modem, 0, "qmimodem",
+					qmi_service_clone(data->wds),
+					qmi_service_clone(data->nas));
 	if (!gprs) {
 		ofono_warn("Unable to create gprs for: %s",
 					ofono_modem_get_path(modem));
-- 
2.45.0

