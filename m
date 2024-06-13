Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316C71747
	for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314899; cv=none; b=PpRxFZumlf4+FdmVRmRi6mSNGkJuDq7g7BTdfyvOAkVqftFJVK0xrIBU+mtKTN+n5QQ4IkGj9ut/8HmPDFYcQZHU3gtaz5N4CTLvYqAQ40PAnc5YBkXDfPGit2k45Q+nvusrW6VZjeZxoxbS35i1KD97DK+CnlXjnx/cfzX4K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314899; c=relaxed/simple;
	bh=jiraYGs/O4eweLj36mjlG97UPK2OwCGH5AINnydTkrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgARmk+uodX+ZfhKF/tcFHXwTTttBSeXgk80sGv78sT8hpe5o+3+Or14BEnUSRc+/sGjuzfa8Ea+WrKvckcowmQrf/NUwJiodBgepxsl0etpmpN3G6yRK7ZXxCqZG+NKJsbkg9yQBEN9nL2gc+JDTg9RMbfooKryH13/OAuu+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKYKsRjd; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKYKsRjd"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9706c84e5so826333eaf.1
        for <ofono@lists.linux.dev>; Thu, 13 Jun 2024 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718314897; x=1718919697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXQOMqQZbkJLvo7lZ7g+/7mpUBAVXIRh6PGMOvNqgHU=;
        b=lKYKsRjdoGsXnwD34qY/NVnsLn58Sn565bQNbrEz/jIi38P5XhR8VAkBba5DlpP7N6
         goKvyWpUc1NgMKsQXlqtnHsS8tI0RJuy9MMNzAV4HQ8i3j7aL/uSBE2I7Gdv7g8nKD+Q
         e7FpDt9RO5gtZA4Nzj21rkjqWAHZ7hEvstyHXhZDc1MhQP/gekqHWCohTVaCKON2xdlA
         XSu52nimpOCNnreifTFjybqYiZrvZOwzhg+fz0s1hLg3HulyoO5Ncq2wafN9bY3ervSp
         y43oBF12lqiLSYQgGOnlYMPUQuNk/FTViHKxgk5U0RDRICH8tAeW5pQzjJVLsLMFE+zq
         S6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718314897; x=1718919697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXQOMqQZbkJLvo7lZ7g+/7mpUBAVXIRh6PGMOvNqgHU=;
        b=eXsTjSiDitNOeeIFzNvS249WeyNOhsgezkvjtl1gj6bmKqySzNMZ9ENYeQc1aFWYHA
         E9Sgn6KDvo/E2QJF6BNXscS4ZxFpq7nGyv8dOhq+or2W8OUBPk7x+a1mA1jh+RtAv9be
         IDLGPAtEMQRXG9IDQhDXfX9JFmZJnsNSLom+Nt2SEeCIe2DkyYXnHJ3IHOvdg2NLrOdK
         g16qFCcp8jgE7u5mshpfGQu9xybrSU1R+7Rc/slkQ6EHE3MBgwsnXiAiKMngeyDjfmfw
         p2jJLHI5W3nBtkUuFKiS/DSV8wfm1rGaApUCCxvQ1V8UnQMQgEyC99pTUXpgKPLhQ3yS
         kbnQ==
X-Gm-Message-State: AOJu0YzKz42XOzqJlsivlBgyYJHepunRW7G7VpawBk2gRHBg1BSDS69r
	tUsOFhbnIU4SDUAg7CsE7iedMugqRjt3xwsEsBSxOHPmAk3kw1oQgx2/nQ==
X-Google-Smtp-Source: AGHT+IENB7uIyVBWvX+sOzwVwjNpU8GTx8qKvGvr+jVppMXoFlwWDXZtpqte9aKu3zmD4p2fgHcjpg==
X-Received: by 2002:a05:6870:c6a9:b0:254:cdac:99a2 with SMTP id 586e51a60fabf-25842b804bdmr889740fac.55.1718314896712;
        Thu, 13 Jun 2024 14:41:36 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f768sm601589fac.41.2024.06.13.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:41:36 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/23] gobi: Remove phonebook and stk atom creation
Date: Thu, 13 Jun 2024 16:41:10 -0500
Message-ID: <20240613214134.1056517-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These atoms do not exist in the current qmimodem driver.  Remove them
until they're added back in.
---
 plugins/gobi.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 7c105eef992a..10ce2acc0cca 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -51,12 +51,9 @@
 #define GOBI_WMS	(1 << 2)
 #define GOBI_WDS	(1 << 3)
 #define GOBI_PDS	(1 << 4)
-#define GOBI_PBM	(1 << 5)
-#define GOBI_UIM	(1 << 6)
-#define GOBI_CAT	(1 << 7)
-#define GOBI_CAT_OLD	(1 << 8)
-#define GOBI_VOICE	(1 << 9)
-#define GOBI_WDA	(1 << 10)
+#define GOBI_UIM	(1 << 5)
+#define GOBI_VOICE	(1 << 6)
+#define GOBI_WDA	(1 << 7)
 
 enum qmi_protocol {
 	QMI_PROTOCOL_QMUX,
@@ -411,7 +408,6 @@ static void discover_cb(void *user_data)
 {
 	struct ofono_modem *modem = user_data;
 	struct gobi_data *data = ofono_modem_get_data(modem);
-	uint16_t major, minor;
 
 	DBG("");
 
@@ -427,16 +423,8 @@ static void discover_cb(void *user_data)
 		data->features |= GOBI_WDA;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_PDS))
 		data->features |= GOBI_PDS;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_PBM))
-		data->features |= GOBI_PBM;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_UIM))
 		data->features |= GOBI_UIM;
-	if (qmi_device_has_service(data->device, QMI_SERVICE_CAT))
-		data->features |= GOBI_CAT;
-	if (qmi_device_get_service_version(data->device,
-				QMI_SERVICE_CAT_OLD, &major, &minor))
-		if (major > 0)
-			data->features |= GOBI_CAT_OLD;
 	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |= GOBI_VOICE;
 
@@ -748,14 +736,6 @@ static void gobi_post_sim(struct ofono_modem *modem)
 
 	ofono_lte_create(modem, 0, "qmimodem", data->device);
 
-	if (data->features & GOBI_CAT)
-		ofono_stk_create(modem, 0, "qmimodem", data->device);
-	else if (data->features & GOBI_CAT_OLD)
-		ofono_stk_create(modem, 1, "qmimodem", data->device);
-
-	if (data->features & GOBI_PBM)
-		ofono_phonebook_create(modem, 0, "qmimodem", data->device);
-
 	if (data->features & GOBI_NAS)
 		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
 
-- 
2.45.0

