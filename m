Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EC130A4A
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280495; cv=none; b=AVsh95xutZ51gI2gAS68Ix4Xs9W9VUxe9IP3qFGMPEeVOglt+Y8VC64aMx0MXwSwZK/D018moZrzSrVJBYJOvcxtk42pjy1BRTmdITRLajo7qN3ahGXMBmyP8/AZU0i2MV0f0rtVZvzlu/LDAFPnSCl4HbgHv5fyTxHLW0RRD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280495; c=relaxed/simple;
	bh=djyks+F3mGJvqLrXUlttGEmX8qYUItZB94KTWfCSLPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRZvZ8Pc3PJ3tk3Ii7QbNV0+GFiAQJQIRyQIkNfsQH/vjgb8Zcw/lIKD5bR756FuJsM2STHcszlm55WjjN2kV51u2eHDcNlbMwQrRlqZrUVXTC1MnLeyuFdDFFGbbrXOSUsx2jjnxwnoD9e6Pne6FoQeiOaOTtnHysuBqERYhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxSOhyMt; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxSOhyMt"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c7150cff81so480200b6e.2
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280493; x=1713885293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HxtktstjwcHtnRqcqYSUiT5ls1N6T033KZ+COMPkW0=;
        b=cxSOhyMtKdoSXG3CpIijyz9XbI/whv5BiRwXOGj0EYLNC/Load59wQxz83i8W9MKcD
         UrEw5P/1AZVFxUgTv0mvcTQB/Kr2emTiXz5+6xVXP7d8+UAxI7HKQKxQys371lTZtxG6
         5qrrW9plf+CzdIe7ZvCWppqvKN7ekAxwS7Nl5h+cYmpyTLxs/jW2XXYj6Ab6eD8lfnjj
         diwfVn7afijdT91DHIoH8JWxjjM0aHyx3kwSXaCJz78SJuw0ztfgdl4W5/q4Mh2bsryV
         3E5BZgywXUzlE6WtVxCgxvl0Q7YWmfu/4pI1zT8jYHFuXVwgav3HHZO57L6OnRSYDxyn
         ZIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280493; x=1713885293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HxtktstjwcHtnRqcqYSUiT5ls1N6T033KZ+COMPkW0=;
        b=gEPHQQB6WmACUtcAg7B7goWfWcFsTV4Ia0oPskFiYxRzD7Bvz8YHuVF23KzxzW0PUC
         ZiVC3OQlbD01Bd4UFE9U07yD8DFVzTycQTmL1wy35T/GMLK4GmdmuSc3BcKxj50uVXXW
         c5QMz7bopotEOmPLBTYaXfC4KkDus5M1Aeejd8dC7k4SUPz1fjixAD4YGMQU2VRoanL1
         W6k6UlAxOgKb4YoxTX2YK8NgS688JUkTCtla7tcWLhCg4Mc+c77QdJFC9EieA7QjgFgY
         QJNHWYsK+jAMIq3COnW59E45Oce7lz9Td7Kj1UoDnwGD59wCL8g2j9+sTdBew8Ysc3wx
         8Q4Q==
X-Gm-Message-State: AOJu0YzJrZr++x6WjXOHivR4Hw5/zWYyyutRxgG6zf7hSO2tbOLaO2l0
	NkqMUNn9IzDFfr+4MM8MvLtl4Yx+/aTFA81GCTYeJpVAQdQL5ocAaaF+LA==
X-Google-Smtp-Source: AGHT+IFBaXi5YsOj0F3SSaBY5UhTQJkigC9FOgWfnLycNzRxfrUKZiLIYZ5eVQ8NyQGqqyDIBTayYA==
X-Received: by 2002:a05:6808:2219:b0:3c6:124:9bd6 with SMTP id bd25-20020a056808221900b003c601249bd6mr15665636oib.25.1713280493394;
        Tue, 16 Apr 2024 08:14:53 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:53 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/7] qmi: wds: Convert defines to enums
Date: Tue, 16 Apr 2024 10:14:32 -0500
Message-ID: <20240416151448.3359644-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416151448.3359644-1-denkenz@gmail.com>
References: <20240416151448.3359644-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/gprs-context.c |  2 +-
 drivers/qmimodem/wds.h          | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index e726382a223a..14da16046f2a 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -64,7 +64,7 @@ static void pkt_status_notify(struct qmi_result *result, void *user_data)
 		DBG("ip family %d", ip_family);
 
 	switch (status->status) {
-	case QMI_WDS_CONN_STATUS_DISCONNECTED:
+	case QMI_WDS_CONNECTION_STATUS_DISCONNECTED:
 		if (data->pkt_handle) {
 			/* The context has been disconnected by the network */
 			ofono_gprs_context_deactivated(gc, data->active_context);
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 0e30a0cca8c7..0cfbd9802531 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -38,15 +38,19 @@ struct qmi_wds_notify_conn_status {
 	uint8_t reconf;
 } __attribute__((__packed__));
 
-#define QMI_WDS_CONN_STATUS_DISCONNECTED	0x01
-#define QMI_WDS_CONN_STATUS_CONNECTED		0x02
-#define QMI_WDS_CONN_STATUS_SUSPENDED		0x03
-#define QMI_WDS_CONN_STATUS_AUTHENTICATING	0x04
+enum qmi_wds_connection_status {
+	QMI_WDS_CONNECTION_STATUS_DISCONNECTED =	0x01,
+	QMI_WDS_CONNECTION_STATUS_CONNECTED =		0x02,
+	QMI_WDS_CONNECTION_STATUS_SUSPENDED =		0x03,
+	QMI_WDS_CONNECTION_STATUS_AUTHENTICATING =	0x04,
+};
 
-#define QMI_WDS_PDP_TYPE_IPV4			0x00
-#define QMI_WDS_PDP_TYPE_PPP			0x01
-#define QMI_WDS_PDP_TYPE_IPV6			0x02
-#define QMI_WDS_PDP_TYPE_IPV4V6			0x03
+enum qmi_wds_pdp_type {
+	QMI_WDS_PDP_TYPE_IPV4		= 0x00,
+	QMI_WDS_PDP_TYPE_PPP		= 0x01,
+	QMI_WDS_PDP_TYPE_IPV6		= 0x02,
+	QMI_WDS_PDP_TYPE_IPV4V6		= 0x03,
+};
 
 enum qmi_wds_ip_family {
 	QMI_WDS_IP_FAMILY_UNKNOWN = 0,
-- 
2.44.0

