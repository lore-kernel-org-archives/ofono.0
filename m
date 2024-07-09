Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CB156F43
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565451; cv=none; b=kT+Mm91zDbrfuUugrAQbDj6WYPQWvrgVlAi5699vfiH9sW3ghBgJaNomcO6L3gdVEFitMJO8lCX51I2pdVmRsIXj+qodFDuNFYlqFEPzxcJnmpFqF9pDTSw39i/sF+QrLx2XktbrgPylF2hqyXhh0Jwhmm2gqu6KSslW05kHhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565451; c=relaxed/simple;
	bh=VBJdnq/Br6eI4igqVnMW/sTXg0Gzz2fZ4MEiET6TZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeHJHD+G7traFByiiauIOc6YN8+hWo5SQM8c+PYsEWxLJxcIFJEJZxEiHvsMasl570pC0288iJoLbI9YqkqD61mmd8x5Bys41oVFrBiWjhUAvdfm9UzxnP9MoTw8LEMDHhZNbM3nlwQIA4nwai2NBpfOFvO+Z14ZSB3p/kJPfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ysg/Bb75; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysg/Bb75"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-38713b03039so13881305ab.0
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565449; x=1721170249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=Ysg/Bb75i7gHbbDYZeOZGxRjgBBn192/Zst6i6S+BC0MRfwWNF0kjiMVve76q/Kn3n
         Hrix+AkZS03omLc/71DYd5sECo4M03adlqi5JGHXJdlDI7omyFneInA5e8AA/CMKpBdr
         gZP2OBGhoflgf74uMNfwNGfAuXLhvnMW9UWSoOMPFw82paQ8eEa1MGH8R+TFtK3zFdRf
         qdCYifOZ2DEFfzziatN378GfADXg8/NQruflILfrqoKQFnyIKeSJoyHICvlwu3e6GT+3
         Pr+fwTYiVvtEvVy7s0VS+B2T2eun44tBcIs6f7wTz+uuZqSD4UCzVU31ZZrjbZyN4WKQ
         7eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565449; x=1721170249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hFYFd2wxJVjFo1RYvq8oVkHVsdRhr45mMwFvFgqeFg=;
        b=IqNO3OsGa7VsBHRZaRQOIDfm0lXqRN0Tc2eZj3SWBn6PWS/HzKpK4/r3F8g9lbQR5v
         kxrCAqK02F1X4lEFIDZfMx6VUzy5qkRKhIlYfSUuRgZ+Z1OPJr0gC/qQVn/52zYtquPD
         Qey1qhzJ+9qViu9AwlpYJrkmMUvLICMNZp1aapaqLQ6EEdgQt6bQfu5Ff7Y0oYq6yEmu
         MToBqTVQ4cOzRpjmUgsygILQmNL5CodiM9X4cqzf121ok+3pRDbpTxv1AGZMyRVe2GnE
         HoV7cFWHBcqg3FM6tEzXL4Wi9HxV36Efo2hZhj7IeAA458AXFT+7PAjQUccxLo3pKsOZ
         EgYw==
X-Gm-Message-State: AOJu0YzBMyhkdJcCv2BYSN+Oxwbv0e1DtPNhvy6F/qw94L49lreK4xtd
	n6uaw0SSqZjUmhd+E38sVG+hWsowa3YVcvlT/9/NmZn2gwxdqDb8GT70YA==
X-Google-Smtp-Source: AGHT+IGVgrUF4Gpwac8QFHSYWjq4FMg9T3G0oyFazk8xM4KXuP4b3HdxCN8c2nys3llQ8xylW24eqg==
X-Received: by 2002:a05:6e02:180a:b0:374:ac3a:e32c with SMTP id e9e14a558f8ab-38a57bce18cmr43555215ab.16.1720565449350;
        Tue, 09 Jul 2024 15:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/11] gobi: Request dedicated WDS services for contexts
Date: Tue,  9 Jul 2024 17:50:21 -0500
Message-ID: <20240709225047.1427626-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
References: <20240709225047.1427626-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each context the modem supports (up to MAX_CONTEXTS) will require two
dedicated WDS services.  One will manage the IPv4 configuration, the
other will manage IPv6 configuration.
---
 plugins/gobi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index b6df849de47e..76e1e133860d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -72,7 +72,11 @@ struct gobi_data {
 	struct qmi_service *voice;
 	struct qmi_service *pds;
 	struct qmi_service *uim;
-	struct service_request service_requests[16];
+	struct {
+		struct qmi_service *wds_ipv4;
+		struct qmi_service *wds_ipv6;
+	} context_services[MAX_CONTEXTS];
+	struct service_request service_requests[8 + MAX_CONTEXTS * 2];
 	int cur_service_request;
 	int num_service_requests;
 	unsigned long features;
@@ -170,6 +174,8 @@ static int gobi_probe(struct ofono_modem *modem)
 
 static void cleanup_services(struct gobi_data *data)
 {
+	int i;
+
 	qmi_service_free(data->dms);
 	data->dms = NULL;
 
@@ -193,6 +199,13 @@ static void cleanup_services(struct gobi_data *data)
 
 	qmi_service_free(data->uim);
 	data->uim = NULL;
+
+	for (i = 0; i < MAX_CONTEXTS; i++) {
+		qmi_service_free(data->context_services[i].wds_ipv4);
+		qmi_service_free(data->context_services[i].wds_ipv6);
+	}
+
+	memset(&data->context_services, 0, sizeof(data->context_services));
 }
 
 static void gobi_remove(struct ofono_modem *modem)
@@ -489,6 +502,7 @@ static void discover_cb(void *user_data)
 	struct gobi_data *data = ofono_modem_get_data(modem);
 	uint16_t major;
 	uint16_t minor;
+	int i;
 
 	DBG("");
 
@@ -538,6 +552,13 @@ static void discover_cb(void *user_data)
 	if (data->features & GOBI_UIM)
 		add_service_request(data, &data->uim, QMI_SERVICE_UIM);
 
+	for (i = 0; i < (data->n_premux ? data->n_premux : 1); i++) {
+		add_service_request(data, &data->context_services[i].wds_ipv4,
+							QMI_SERVICE_WDS);
+		add_service_request(data, &data->context_services[i].wds_ipv6,
+							QMI_SERVICE_WDS);
+	}
+
 	if (qmi_qmux_device_create_client(data->device, QMI_SERVICE_DMS,
 					request_service_cb, modem, NULL) > 0)
 		return;
-- 
2.45.2

