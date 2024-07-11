Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E82BD0D
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716423; cv=none; b=rUn/+oVyAh+iCimTV1cwCNGmGYXEq++H0xVXj7q/s6I0KL7TDsVAsOqvkIfc5hp0KsNBZ6PJySVg2nWtz89BDYmkG1GIAqrb/ji5uM46FVkJ30KQkB6+dGYmRcWNFY6VUc2KsVL6MUMvdarHLxSW17GttEKCNF60oqAmP4PbylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716423; c=relaxed/simple;
	bh=dffnGkI17qSPW3b25IONLAlEAPrFwVApJ4+yj4idVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdot+AVAFLXSVwhrLihzmbj/pdxS8F1M3BW1qmbN2zA+/qjgb6xz5EoINdyzPKPEA5OgfLqiGXZm/9m73Anp1o2VpOgMJWLkLh5hYl9bvSMhS8yg5rbewo3x32MjtFcbgZIhHoxGII5w8fI944JbuPYuAxYbxXSZMNcIqziYqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+i7RO0X; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+i7RO0X"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eee7728b00so39153539f.3
        for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716421; x=1721321221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=Z+i7RO0XSj7ST8jo4RoxAsAVbAeFaTPltxOA+J8z259QzS9hhNr+FDnnNdNcA5BGmJ
         nIKYD7zq/K+hiZ01ty3HxTx+y2R8qMlQmLYC77lc6Nf4I5eE+eGfzRtxPwoTX6wRPxjb
         +fbgvwPkOEHaiqOqW/IXKqSEAGMb2S0ebw/hPajr4SJwh5I9vhV0UpBHoWJwrs2Zuo0y
         5c0meS3rmkoSLBwnn6GXI/lkR2KcylLyB2wWVqWOv7DBgxA7PorFUAs/ES4t88zbEkTU
         b8T/3zScqCdgo54SIFo86Sv+pmY6bXnP9IWDUZpCJqxdkVNb7iuTwhuayczyNZAEVYB3
         HtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716421; x=1721321221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c2JHjrV2CQ00glYH/m2D0yKTwf7Wgj38pYLIWfkVyo=;
        b=SQ/4qB9EXbCq2xrew3hS6NDGY23aNRS1Y00eXsHCS4oGgZIBUMTbut4JZA1CYhpmiP
         nStHzjsb6CsEBldKuzMDA8sNoyWgFRJL3TICNDNNsWwFRJYT0oHTzYrbog62ZshMh4WW
         eEa0Zh9nHBmeat+US1ajUEEitLrkB47NXS1/t5/8obCqDY9+mD/3uoS5qX1ktmlzMn8v
         PZK022h1McGPPLZsGudiWRUxoE51XXa8TQIFpApXssTqgN7Oc3LymEaw592fprIPlprj
         KSzPkwtrfLYA8XGNSWrl1MJ7IF8fpTQesgOyJh72zoJug9aHjL1iOHS/wH7W7veQexYR
         mOgw==
X-Gm-Message-State: AOJu0YzzB+xFHJX5xSscBjweBCmEDo6d8pdzMWlQgGTXvzIw44PkfFoF
	1T9bQ4Y+JTNdsAt1TjZseuYrwJ5TPwEPWo/wa0/mbFpKEtTy+pf42RLbMw==
X-Google-Smtp-Source: AGHT+IG9cdibtzO0IgSiAQOXcI/OTbJx3bpC5FJ5/P6GyQ9VCPKUJrSTul7+pm80jbAT2nhUOtzeeA==
X-Received: by 2002:a05:6602:6d1a:b0:7f9:c953:c754 with SMTP id ca18e2360f4ac-7fffe62c3d3mr1302452239f.3.1720716420697;
        Thu, 11 Jul 2024 09:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffed680fa4sm194096039f.46.2024.07.11.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:46:59 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/11] qmi: gprs-context: Declare qmi_service objects using _auto_
Date: Thu, 11 Jul 2024 11:46:24 -0500
Message-ID: <20240711164654.1688558-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711164654.1688558-1-denkenz@gmail.com>
References: <20240711164654.1688558-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the error paths slightly.
---
 drivers/qmimodem/gprs-context.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 3c18476142ea..7d13889bf603 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -554,7 +554,8 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 					unsigned int vendor, va_list args)
 {
 	int mux_id = va_arg(args, int);
-	struct qmi_service *wds = va_arg(args, struct qmi_service *);
+	_auto_(qmi_service_free) struct qmi_service *wds =
+					va_arg(args, struct qmi_service *);
 	struct gprs_context_data *data;
 
 	DBG("");
@@ -562,14 +563,12 @@ static int qmi_gprs_context_probev(struct ofono_gprs_context *gc,
 	if (mux_id != -1) {
 		int r = qmi_gprs_context_bind_mux(gc, wds, mux_id);
 
-		if (r < 0) {
-			qmi_service_free(wds);
+		if (r < 0)
 			return r;
-		}
 	}
 
 	data = l_new(struct gprs_context_data, 1);
-	data->wds = wds;
+	data->wds = l_steal_ptr(wds);
 	data->mux_id = mux_id;
 
 	qmi_service_register(data->wds, QMI_WDS_PACKET_SERVICE_STATUS,
-- 
2.45.2

