Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792217597
	for <ofono@lists.linux.dev>; Sat,  7 Dec 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733592074; cv=none; b=lIM3wyvikpDpuwI8vEnPYwKc9hoRpPkZ4BzyfwlVEUKTI/9KW5AVR5jEaeB7ZC0mV6WksimbkBcT4pis8x+elTOdJkkJTHDfvuhFt3aOZRbsf+LyYHhaMmDNiuKIf6v/P1hdUl17FzMBatISE9nzP4JPCecONcUIubDzkbOIUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733592074; c=relaxed/simple;
	bh=FweBpL1GGAK9OZYhje3Y47aKfZQPrDkY8EiScw9CNLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxtz8dUMOE3zoZiBlGDu7+Dm9oLGmujkJNA/aP0cjfdIBQoArbpMMTK3SLa5sPG5tjDDG2WfXG2B88rIqmfXgu2OuDVgsn1TEZOmeoYeFs9SMtM8qKAFnBSjxi+n0UJS9rbduttYY4AcyXJV5JsSZcyOm+5OKIEw4P39fMZK9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUaPs5+L; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUaPs5+L"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so240467266b.3
        for <ofono@lists.linux.dev>; Sat, 07 Dec 2024 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733592071; x=1734196871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMcpUZ77Ql/ZEyeg23/+vZz71jG9jPDXKyEiDcfNqwM=;
        b=GUaPs5+LgiVXl2NyM1moAIF1rl/wHdnvB5h4T4pP0L8f7sdK56AeKLjrUR5BQxqA5g
         jnarNYbENEosnbBjS3lnyF/QJV2Z1dZRJcHYeZIxXj7N8BaWG84PyBXjbiCauoNFx1a9
         GM1agVhTKmnZY/bYPWxEcmJaL+8WLxS1sW592x6pJFB9CL6/dEAvvRgv4M5oqwv6g0Ng
         XHra7de3aIRiVHJ8AmmOg3sISWBYeymqtArBNjT2hBGvxwRqpCOq3I1TdKIl03wNGRKb
         wquzTjejN/0YpSzjrohFJllA2qIORHPZVUNAR+T/J6R9VS22c0dWanet1DSZbgpqBSAK
         Tbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733592071; x=1734196871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMcpUZ77Ql/ZEyeg23/+vZz71jG9jPDXKyEiDcfNqwM=;
        b=sac5v7g/IeqU+GjkAiPcMdXFyyAewIPhWXsgGKRCXC1GFHe5s5Ckrk6rw0HvN9Q+f5
         /q9vCbU50hjmnZ7z+26EILJQSJgC2gxS8lwRl08dG8eggvAugQiOLgyKCXfIIzDEOUYo
         nhEVQkHAqUnpM21NFrincMlGCi6B316KjKZ08DV1Zsf7/wFZu/JH995JvcHYbibs9R9v
         CnjjqBD+Rpdktgxjsmbq4I9hciVDDbpEmwKrYydANfow0HhcqyMC3i9osr0YNvOi/FEP
         ARQJBI4quaZ0pKceu/ERSj8Kdm8aVOg5uTUK83ZOEhuQrZpifmXNYISGDjS84QKIEm9C
         t5LA==
X-Gm-Message-State: AOJu0YyxphNgxLieKua7HlcAnocRh7IXhoG95Og+q2oklIsCJaLi4jhJ
	5o8mloTh1aUr4/P6ZCIvVmtkqWPQgo0IviHbD8/ZmhboiVqQjEl9w6XeKQ==
X-Gm-Gg: ASbGnctTTWQac5BEigh2v3J06Xea9CIa7Oq2rhJGP0u3Hi8YcTFaDHJZrq7zLfH0BZI
	OkAiWRknSpml1Oy8ICOJWjFspvc0TMqEmITNkvSYwUGucafWVyLUl9nXBzlEWIzAVgE6G0xarCL
	XicAxP/vUoKe05ymzLC3jstE+wWxuoguALzA1o4PvEV2lYXc5czSRrDyoh+vF8UM/cAY5NqLg/k
	YeezGmsCr7EcE3dhvW54zugkCF3qKoOS27THbfj8kHkxQU8WSp2MZ8SsvU8eoUEO+UdjgNz
X-Google-Smtp-Source: AGHT+IFv+5fPZd5HguXUuj2QDBHbbSk9v21juHNE0yW4BufVLKr/lYSxDjzt7k5CLK6WqH9pX4SFYw==
X-Received: by 2002:a17:906:18a9:b0:aa6:1917:42e7 with SMTP id a640c23a62f3a-aa639feeeecmr621332866b.22.1733592070429;
        Sat, 07 Dec 2024 09:21:10 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa651ea3160sm108664566b.174.2024.12.07.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:21:10 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] qmi: radio-settings: Do not unconditionally try to enable unsupported modes
Date: Sat,  7 Dec 2024 19:20:50 +0200
Message-Id: <20241207172050.191314-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least the modem in Motorola Droid 4 errors out if anything else but GSM
and UMTS bits are set when selecting preferred mode. That happens if 'any'
mode is set.

Fix that by querying supported modes and passing only those for 'any' mode.
---
 drivers/qmimodem/radio-settings.c | 97 +++++++++++++++++++++++++++++--
 drivers/qmimodem/util.h           | 19 +++---
 2 files changed, 104 insertions(+), 12 deletions(-)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-settings.c
index cf0b747e..b62a87d0 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -21,6 +21,12 @@
 struct settings_data {
 	struct qmi_service *nas;
 	struct qmi_service *dms;
+	unsigned int rat_mode_any;
+};
+
+struct rat_mode_any_data {
+	struct cb_data cbd;
+	unsigned int mode;
 };
 
 static void get_system_selection_pref_cb(struct qmi_result *result,
@@ -92,20 +98,20 @@ static void set_system_selection_pref_cb(struct qmi_result *result,
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 
-static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
+static void _set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
 			ofono_radio_settings_rat_mode_set_cb_t cb,
 			void *user_data)
 {
 	struct settings_data *data = ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd = cb_data_new(cb, user_data);
-	uint16_t pref = QMI_NAS_RAT_MODE_PREF_ANY;
+	uint16_t pref = 0;
 	struct qmi_param *param;
 
 	DBG("");
 
 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
-		pref = QMI_NAS_RAT_MODE_PREF_ANY;
+		pref = data->rat_mode_any;
 		break;
 	case OFONO_RADIO_ACCESS_MODE_GSM:
 		pref = QMI_NAS_RAT_MODE_PREF_GSM;
@@ -136,14 +142,91 @@ static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
 	l_free(cbd);
 }
 
+static void get_rat_mode_any_cb(struct qmi_result *result, void *user_data)
+{
+	struct rat_mode_any_data *data = user_data;
+	struct cb_data *cbd = &data->cbd;
+	struct ofono_radio_settings *rs = cbd->user;
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
+	const struct qmi_dms_device_caps *caps;
+	uint16_t len;
+	uint8_t i;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	caps = qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
+	if (!caps)
+		goto error;
+
+	for (i = 0; i < caps->radio_if_count; i++) {
+		switch (caps->radio_if[i]) {
+		case QMI_DMS_RADIO_IF_GSM:
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
+			break;
+		case QMI_DMS_RADIO_IF_UMTS:
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
+			break;
+		case QMI_DMS_RADIO_IF_LTE:
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
+			break;
+		}
+	}
+
+error:
+	/* last resort */
+	if (rsd->rat_mode_any == 0)
+		rsd->rat_mode_any = QMI_NAS_RAT_MODE_PREF_ANY;
+
+	_set_rat_mode(rs, data->mode, cbd->cb, cbd->data);
+}
+
+static bool get_rat_mode_any(struct ofono_radio_settings *rs, unsigned int mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *user_data)
+{
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
+	struct rat_mode_any_data *data = l_new(struct rat_mode_any_data, 1);
+	struct cb_data *cbd = cb_data_init(&data->cbd, cb, user_data);
+
+	if (!rsd->dms)
+		goto error;
+
+	cbd->user = rs;
+	data->mode = mode;
+
+	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
+					get_rat_mode_any_cb, data, l_free) > 0)
+		return true;
+
+error:
+	l_free(data);
+	rsd->rat_mode_any = QMI_NAS_RAT_MODE_PREF_ANY;
+	return false;
+}
+
+static void qmi_set_rat_mode(struct ofono_radio_settings *rs, unsigned int mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *user_data)
+{
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
+
+	if (rsd->rat_mode_any || !get_rat_mode_any(rs, mode, cb, user_data))
+		_set_rat_mode(rs, mode, cb, user_data);
+}
+
 static void get_caps_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd = user_data;
+	struct ofono_radio_settings *rs = cbd->user;
+	struct settings_data *rsd = ofono_radio_settings_get_data(rs);
 	ofono_radio_settings_available_rats_query_cb_t cb = cbd->cb;
 	const struct qmi_dms_device_caps *caps;
-	unsigned int available_rats;
 	uint16_t len;
 	uint8_t i;
+	unsigned int available_rats;
 
 	DBG("");
 
@@ -155,16 +238,20 @@ static void get_caps_cb(struct qmi_result *result, void *user_data)
 		goto error;
 
 	available_rats = 0;
+
 	for (i = 0; i < caps->radio_if_count; i++) {
 		switch (caps->radio_if[i]) {
 		case QMI_DMS_RADIO_IF_GSM:
 			available_rats |= OFONO_RADIO_ACCESS_MODE_GSM;
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_GSM;
 			break;
 		case QMI_DMS_RADIO_IF_UMTS:
 			available_rats |= OFONO_RADIO_ACCESS_MODE_UMTS;
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_UMTS;
 			break;
 		case QMI_DMS_RADIO_IF_LTE:
 			available_rats |= OFONO_RADIO_ACCESS_MODE_LTE;
+			rsd->rat_mode_any |= QMI_NAS_RAT_MODE_PREF_LTE;
 			break;
 		}
 	}
@@ -187,6 +274,8 @@ static void qmi_query_available_rats(struct ofono_radio_settings *rs,
 	if (!rsd->dms)
 		goto error;
 
+	cbd->user = rs;
+
 	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
 					get_caps_cb, cbd, l_free) > 0)
 		return;
diff --git a/drivers/qmimodem/util.h b/drivers/qmimodem/util.h
index 58bf4f98..14d4d865 100644
--- a/drivers/qmimodem/util.h
+++ b/drivers/qmimodem/util.h
@@ -14,17 +14,20 @@ struct cb_data {
 	int ref;
 };
 
-static inline struct cb_data *cb_data_new(void *cb, void *data)
+static inline struct cb_data *cb_data_init(struct cb_data *cbd, void *cb,
+						void *data)
 {
-	struct cb_data *ret;
+	cbd->cb = cb;
+	cbd->data = data;
+	cbd->user = NULL;
+	cbd->ref = 1;
 
-	ret = l_new(struct cb_data, 1);
-	ret->cb = cb;
-	ret->data = data;
-	ret->user = NULL;
-	ret->ref = 1;
+	return cbd;
+}
 
-	return ret;
+static inline struct cb_data *cb_data_new(void *cb, void *data)
+{
+	return cb_data_init(l_new(struct cb_data, 1), cb, data);
 }
 
 static inline struct cb_data *cb_data_ref(struct cb_data *cbd)
-- 
2.25.1

