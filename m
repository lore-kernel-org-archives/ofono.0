Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF221304A8
	for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280493; cv=none; b=a+XQwPAehd11NKqz3noUIWQY4fp3wio6sv6k1PsilUtmqsQYI+DrhkX4JZgtmnvHFknOLNPdIpLutFLFB590n9qtJ6VB/TYLMfe3BB8srlBEhSUO8mW5KenNOHwqEbngLWZALE/0gFMqL0GIeB0xSkUq6BJ60JaFd3asX8GOtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280493; c=relaxed/simple;
	bh=rkZvzfx43fr3pOeWb6v/v4ctuIQPgB14D/mn4735eU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJhGFTPpj+rWKdP5ulMaJbEvWoK+BzkvXj7VyMHhYaarq/q/G65Qh4yX1dPbalgY2Ik0yUiC0ZSO4Hx1xWBl4JdFFzmJk6+YM2810uTpnta5eXQiGnMA/Eb5oc5iDVuZaBSf+nedS73djLN4Y+uTKt1+pTz5EQ1b/8ouiaxqiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeZ3bygu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeZ3bygu"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c71c7e2d40so689845b6e.3
        for <ofono@lists.linux.dev>; Tue, 16 Apr 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713280491; x=1713885291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdJofdHMxVD8ZF0MmsCklun785N5ALoodngrqixhwWM=;
        b=aeZ3byguYIvFSgTKdpB03BbWR+YwR4H/zap8CIAMx0tslXPY0w879AY21DHEd/iBWf
         wtQyU/+4HQJGconbylJkZcVJnOr+CGSTHYtwYi4jmokcsnfsmnvZMbiPqJ/7J60v81iG
         j1GV9+rryQX8+SOO89C1LBuCTrAy5zCJ8x3tlCZRzHZ53KRNH9sLhndxpcSjDVzDgavl
         kI0ZpZ/bhwFsmBazam+ldeKC+EUZXDBoPHrJVKLd2eW1JLFM+/jUD86VsEgKcdpvhzaN
         AGf6z3a5PP4N/KqjJLOkd+WkezSASpWBPO0EBEuVZgosbq2I2Lp4NvyRTgnQ9R0KFLd/
         q4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280491; x=1713885291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdJofdHMxVD8ZF0MmsCklun785N5ALoodngrqixhwWM=;
        b=FE6dr49fAhBjOtrXICrImXRnNSogweihzR1jgsI6k14tG8d0KQAPbPwg3za0TP4shk
         Iw9agZlNKYM4ki3bLLibSS6lkqB+vwYNPP7f+sxRo9AsiJFWriJZ9/AUcAjn3EXwdg7J
         ipjulg62XlS+tdr+QX26pCkoSjcal6I0thHipe6m+PjBUFzf6pxcgkC28qAYt3RW9y3C
         MsodiUqHMAPCuO0xUswyXH0VB2Klh26BICrOVPbkwOH73JSXJeX/IiatQI0+1p53NLR+
         mgX2aaZiPNIV3UU7+9fFIgZQAU1DlkwkSkqoQ7wpWZ8Rdm3JTJdVQtmQooBqDYGWhKdV
         UYPg==
X-Gm-Message-State: AOJu0YxTPmVb3T29f2LSotCNomID21n5U6zKH0bjR01tDvVSAkTsFHTW
	cNY+1z8CYVVtVbExToS2WSJRZe5F2i/dzZk3LpLE523HM/3nU3njEZryYQ==
X-Google-Smtp-Source: AGHT+IGFxvi3474ROTPB9sXdycHy0mGdU6IFU/N8/lV11DdLITN1an8bfCcO9tkQhMGr29XNrX2C8g==
X-Received: by 2002:a05:6808:1911:b0:3c4:e00a:6c2b with SMTP id bf17-20020a056808191100b003c4e00a6c2bmr16219924oib.53.1713280491287;
        Tue, 16 Apr 2024 08:14:51 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id b17-20020aca2211000000b003c708fc7267sm1085797oic.27.2024.04.16.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:14:50 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/7] qmi: gprs-context: Do not free/alloc unnecessarily
Date: Tue, 16 Apr 2024 10:14:29 -0500
Message-ID: <20240416151448.3359644-2-denkenz@gmail.com>
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

In start_net_cb, a new cb_data object is allocated which contains the
exact same information as the cb_data object being passed in as
userdata.  Use cb_data_ref/unref instead.

While here, also fix an erroneous invocation of CALLBACK_WITH_SUCCESS if
the GET_CURRENT_SETTINGS request was not queued successfully.  An error
should be generated instead.
---
 drivers/qmimodem/gprs-context.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index cbe33861968b..1d7449e68ccc 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -166,17 +166,12 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 
 	data->pkt_handle = handle;
 
-	/* Duplicate cbd, the old one will be freed when this method returns */
-	cbd = cb_data_new(cb, cbd->data);
-	cbd->user = gc;
 
 	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, NULL,
-					get_settings_cb, cbd, l_free) > 0)
+				get_settings_cb, cbd, cb_data_unref) > 0) {
+		cb_data_ref(cbd);
 		return;
-
-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-
-	return;
+	}
 
 error:
 	data->active_context = 0;
@@ -205,7 +200,7 @@ static void qmi_gprs_read_settings(struct ofono_gprs_context* gc,
 	cbd->user = gc;
 
 	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, NULL,
-					start_net_cb, cbd, l_free) > 0)
+					start_net_cb, cbd, cb_data_unref) > 0)
 		return;
 
 	data->active_context = 0;
@@ -277,7 +272,7 @@ static void qmi_activate_primary(struct ofono_gprs_context *gc,
 					strlen(ctx->password), ctx->password);
 
 	if (qmi_service_send(data->wds, QMI_WDS_START_NETWORK, param,
-					start_net_cb, cbd, l_free) > 0)
+					start_net_cb, cbd, cb_data_unref) > 0)
 		return;
 
 	qmi_param_free(param);
-- 
2.44.0

