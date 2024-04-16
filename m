Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51A12F5BE
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280492; cv=none; b=ls4J+C/h5jUzAM7XBYPx77Xy1Qe/IHcjf/ZfmNo5cVCF6/5spbTYB7gIH4d4pAzipQ7ugl76LSDuPyxrWgjaTAvriRco8SYp0S1OrSYvDVgxOYMlnQvgoWk6Kw/uig3lfAdqCMkJq4nJ7PabksAKmjUFQMVuVYeEFg6IztCANiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280492; c=relaxed/simple;
	bh=5q7yV+X1T8NTe+5wWpca3gc2oT55I2Tbv4OY+c/Chgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5UmpnbttCvrhOerp7TsH2stUVajuHEMuincavnZdMCJ0dziv/qawAVduNVa4KUdPHlde/2VyM3e3EsC+Bum/pmU6Y9ttaCTuU3acOtyEpCiK5KnsRgn+rZk8+Lq7LYw4lmoL9fiOPCar4V0tBb8jUhaT+r64fP5AU+vf5pkVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7XptQq+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7XptQq+"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c718ddd87eso635000b6e.0
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280490; x=1713885290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKCZlW4vxj3Ag+1jA+Z1E+aZPmrrEatrCFGdz+9ZsNY=;
        b=H7XptQq+4oFJR2VOrQOn1VXEVzG+V3TopMmbn+naDjoIXKF7xCKsJHOYhE+SRj93to
         m4hzPXgfrw4VLC98RS9rM7bxQGkUMV9J6Dc1shLDAs9Tc4l3BQ4cgHJaTJR33RV7mz2+
         E0XvWX/HykGsYx5LbC1lIYD3HLfSYVzw0EwXt80vEDhM0WSQuuR40eUQMTzDJdCH8xbn
         u5S3r6mRjCYidFwu0PunZH1IywfNiCP7yW2mybxbAtxuAGLVKf3q2hjlx5YzdhWBZBit
         aCsF68kTseiYxa1w8ALhU0FABCpQdjfZPwL/dirlc/mnvRKbkEOxCEX3trT34BR0RMvW
         pvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280490; x=1713885290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKCZlW4vxj3Ag+1jA+Z1E+aZPmrrEatrCFGdz+9ZsNY=;
        b=EyFE9AcH6MMmPwWi+IcVSmpUvm0VMe0qQnQv9VdM61Upmq9fDh/jRAPzIy/60OnPzA
         Ujun0XDMhcT599iboSGj0FBpJ1h0zKerMqGVKPwN96zMIcstErJ5s1kyknwHTVd4bxaA
         tKrGSFFWhQzzulhqwirCKhFfcXwEQtsM7xbzsbeViQbWooiJB0OyZpQrx2C/9eHaopji
         G4fJGOR+ZxEJ+hIcm37v/ajFfI7oAfTQOAvVlmLDr7mE/zQS68Ctosf0XIHQMIG6UTyL
         laWTCd7/n1UEPzmIjvDOXf9T2iDO+bpGVdAd1pQwjvwXvirWllPH7RoxO033hqxE01qr
         5+xw==
X-Gm-Message-State: AOJu0YyylnL3OzJE+V62xp2NcUoOZ1wj+4M+T5Wy7dwXeJTNK7M1JjJm
	oJQB2UgtO01QHJpa+MRXKoD15cAYdlQ5Cx9Ejs6kFCkyE0mC2Ekumwvxyw==
X-Google-Smtp-Source: AGHT+IHW207hBGg+XBlcYEEeNy5ATEcsO2DckbNRM7adnIGECb8scJ1WjR6SdCm9201vbDySWw0pYQ==
X-Received: by 2002:aca:d05:0:b0:3c6:100a:86b2 with SMTP id 5-20020aca0d05000000b003c6100a86b2mr13924846oin.50.1713280490554;
        Tue, 16 Apr 2024 08:14:50 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/7] qmimodem: wds: Introduce qmi_wds_ip_family enum
Date: Tue, 16 Apr 2024 10:14:28 -0500
Message-ID: <20240416151448.3359644-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/qmimodem/gprs-context.c | 4 ++--
 drivers/qmimodem/wds.h          | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 33565252028c..cbe33861968b 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -247,10 +247,10 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 
 	switch (ctx->proto) {
 	case OFONO_GPRS_PROTO_IP:
-		ip_family = 4;
+		ip_family = QMI_WDS_IP_FAMILY_IPV4;
 		break;
 	case OFONO_GPRS_PROTO_IPV6:
-		ip_family = 6;
+		ip_family = QMI_WDS_IP_FAMILY_IPV6;
 		break;
 	default:
 		goto error;
diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index ffbebaffe32d..6213f75231db 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -63,6 +63,13 @@ struct qmi_wds_notify_conn_status {
 #define QMI_WDS_PDP_TYPE_IPV6			0x02
 #define QMI_WDS_PDP_TYPE_IPV4V6			0x03
 
+enum qmi_wds_ip_family {
+	QMI_WDS_IP_FAMILY_UNKNOWN = 0,
+	QMI_WDS_IP_FAMILY_IPV4 = 4,
+	QMI_WDS_IP_FAMILY_IPV6 = 6,
+	QMI_WDS_IP_FAMILY_UNSPECIFIED = 8,
+};
+
 enum qmi_wds_client_type {
 	QMI_WDS_CLIENT_TYPE_TETHERED = 0x01,
 };
-- 
2.44.0

