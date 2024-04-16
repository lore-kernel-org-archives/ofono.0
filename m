Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2B130A43
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280495; cv=none; b=FtipHzvkE9gkzjz/CaO6fZEBGB65c6+cAcf3LHwMkvd9DLz1AdLBZ9k1FYWgGKb3+ipTVjNdXstV89TjrHkF5QrK2LWfMAjpLe7Lp16Tm17fJFGDzmUgrmwBK38gCDjkfDBnDK7H3qXKTsi/crMt1QlHYX3m5p3UeqpNeLWchTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280495; c=relaxed/simple;
	bh=zHSIwGEmxSi+QiRXVF7x2cWl1zWn+ptTCyNgcy9ogzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwzitMqtHp3+ZI1UJ924k8wg38eWaAna8RHTcojy1WNHnq7dwUIAL8WWNvXvCqk/p9olkDyRc0Y8gbzuq9/AuYatcmwFdbUdL6XfqXL21WNBjhJBfOY5XIOSDmD1N9mGsbdVbzNS1fvKbM3AUhlP/RjAEtuFMjk3hd/FdQZxOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcQf0LVv; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcQf0LVv"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c70ef25e19so1140899b6e.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280492; x=1713885292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GtgPZ4dJTn593dqsX6XA77rx66P6gF3r46CjDj+akE=;
        b=OcQf0LVvsrHrMx1YdGcwF9S8SA5bfEPl3xxND3gWZYdVB368G5tgEeAUsY/O/leCCR
         J5hScU5CwfXVXA6eSgJkVWh4sr7mQc7Loggp15SMPhOUjhqjO3EIv3AVGplXQDifbyNW
         lcJvdYF/TkGeAEzmHl4ZTERuASvIq9pCELqzR8WzqJY28BsGqVfcsnLtOONndD8qyIoU
         sEbETCO/pa71iNFdDMJUaDY8EOFvbMpJpCTWX4znRWtMbq1A2oUMa6YT+681njdXxgzd
         V3dJfvdci2KKMMfErmMIUVuWNfEmgOj8oBMo1d/9SE55n6Qz2dwqYB2fM2119ylKe0s1
         8aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280492; x=1713885292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GtgPZ4dJTn593dqsX6XA77rx66P6gF3r46CjDj+akE=;
        b=Pf83APSkF9NwyhTVxuwi7QYhGNS2wN9BrDJ4JjoLGANe/taxXkg1mrUmFOU2V0JVs/
         fnnjXyCH0bKT7eaVY3XE7leMlAj0iF89rbYX2Aog9ktruvHakQgj28iBIrbgyNQEmEwm
         zoVjnmrX+ORBzKRpdzbRrTPqD9uYn9SPQ/cTUPbV7Mo7HEmJ7VV3fCo9INfnA35lcan8
         TrggOcOtm+VHVcxsEoraR+EU+CCcB7z3kLVMdX7++AiaNEST4vMbLJNCZFRaMKThd/+h
         YTv2qlLt2DUZ24wv4xunt3zeBK5wkPMWqPDTvLHNISD335o/1FmPEQdULsY6T4rDHIdK
         IUhg==
X-Gm-Message-State: AOJu0YxDa1rWvuPvSspgCQXR7MIi3RvYuji31zFbWo/IDjVgg99IAi+F
	yb89lbJfQm7lBr7VGIcKqGapfoI/ccjs7f+RyR6H4OOO3M5ohCb3Y4In8Q==
X-Google-Smtp-Source: AGHT+IEzOFUZWq2OLb4JW1rZ/6BJibT/NvkqiFrAcd2G1A2IhxPy2kyYFSO4eJ7RyM727bmYCYX0Hw==
X-Received: by 2002:a05:6808:aa8:b0:3c5:ef39:9fd7 with SMTP id r8-20020a0568080aa800b003c5ef399fd7mr13891771oij.34.1713280492703;
        Tue, 16 Apr 2024 08:14:52 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/7] qmi: gprs-context: Convert QMI_WDS_AUTHENTICATION to an enum
Date: Tue, 16 Apr 2024 10:14:31 -0500
Message-ID: <20240416151448.3359644-4-denkenz@gmail.com>
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

QMI uses authentication type as a bitmap, with both PAP and CHAP support
being selectable independently.  Convert QMI_WDS_AUTHENTICATION* defines
to an enumeration, removing QMI_WDS_AUTHENTICATION_NONE.
---
 drivers/qmimodem/gprs-context.c | 9 +++++----
 drivers/qmimodem/wds.h          | 8 +++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index ef49e1bcf421..e726382a223a 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -220,16 +220,17 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 
 static uint8_t auth_method_to_qmi_auth(enum ofono_gprs_auth_method method)
 {
+	/* QMI uses a bitmap */
 	switch (method) {
 	case OFONO_GPRS_AUTH_METHOD_CHAP:
 		return QMI_WDS_AUTHENTICATION_CHAP;
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return QMI_WDS_AUTHENTICATION_PAP;
 	case OFONO_GPRS_AUTH_METHOD_NONE:
-		return QMI_WDS_AUTHENTICATION_NONE;
+		return 0;
 	}
 
-	return QMI_WDS_AUTHENTICATION_NONE;
+	return 0;
 }
 
 static void qmi_activate_primary(struct ofono_gprs_context *gc,
@@ -271,11 +272,11 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 	qmi_param_append_uint8(param, QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE,
 					auth);
 
-	if (auth != QMI_WDS_AUTHENTICATION_NONE && ctx->username[0] != '\0')
+	if (auth && ctx->username[0] != '\0')
 		qmi_param_append(param, QMI_WDS_PARAM_USERNAME,
 					strlen(ctx->username), ctx->username);
 
-	if (auth != QMI_WDS_AUTHENTICATION_NONE &&  ctx->password[0] != '\0')
+	if (auth && ctx->password[0] != '\0')
 		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
 					strlen(ctx->password), ctx->password);
 
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 398f77c74672..0e30a0cca8c7 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -26,9 +26,11 @@
 #define QMI_WDS_PARAM_PASSWORD			0x18	/* string */
 #define QMI_WDS_PARAM_AUTHENTICATION_PREFERENCE	0x16	/* uint8 */
 
-#define QMI_WDS_AUTHENTICATION_NONE		0x0
-#define QMI_WDS_AUTHENTICATION_PAP		0x1
-#define QMI_WDS_AUTHENTICATION_CHAP		0x2
+
+enum qmi_wds_authentication {
+	QMI_WDS_AUTHENTICATION_PAP	= 0x1,
+	QMI_WDS_AUTHENTICATION_CHAP	= 0x2,
+};
 
 /* Packet data connection status indication */
 struct qmi_wds_notify_conn_status {
-- 
2.44.0

