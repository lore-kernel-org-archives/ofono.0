Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665413211E
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565452; cv=none; b=bneJrMVrVW0vqo3Iwu1AkXoUgdOFmg/cgCeoGHcg5I4xdCZyjxFhp9rqVaNzn/0rMeBysPV/TcchDx2FcFwLM+pWxEpVthZPmOnex+CbHfgolT64z9KJNMdALTQVzYawGD0g6X9Eg12p9Cpj//j2tkNnNqIU2KXk1RdztJI0WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565452; c=relaxed/simple;
	bh=vZemnAQx6lt/5RW9tkn97Ir7UgxKrTvGJK9H4hhc7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0P8aC0zY203T7zluTTlZOKs0UXkQhqAJX3KPAHJw9BefHMaNhjXjOv3gigaxu+dyBbn+xGktH/E3TjcZI4bOqQ3PI6m1hBRI8c96CXMUKOmW+VbR5P6yi61sqtj2OVL7MvZm9ppMS00aEO9zjEUguuSyqOkkfRyhkNih26P/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjp1UGqU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjp1UGqU"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-376069031c7so22011395ab.0
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565450; x=1721170250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=Bjp1UGqUYgn9Jg5elfFx2oxXmXv4geBEVZ147NJHbfcfQ1CuzO8AvlpppLheLy0DXP
         802KlpJFIsM3KJfNy9IBTZmXmTfQe3bgizYIdKxqMz7TMrNss1kBHNc+u03PqoxgEAx7
         jHppdZ4rHgUs4CEAT1wZjh0JdmPVcUX1xoEc04uk8sINKppyyuG5Qrs8g/h+iSt1YRzl
         FS8J2pccguVMFNVg1nqU5+6mQbNciVr89lqx6qSxTl4MtZi/ER/h7Yvhk8XOWBF4guc7
         pb5p6Z4l83CNLX69vl+cfqsAoXiVwAnNk9VY9jathccTQPlpHMFgMLqlv8oU3Ol3HYUo
         5uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565450; x=1721170250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2iBWS2+3c3Faezm++4qy17LkbyRGNJqin8EvtAlyAE=;
        b=MA568qRyP94SLrCT1jOASPSYcG6KzeXhQXDAZKcB+M/n/yhii5qmztodkqO+vOvXvu
         KFgKPjy8/vllVavhDbQyMaNSaRumL/2pbfkOLVE/gwLNb06LhHZDeeNdjT+v+wILCHDD
         BIdVkbIUw1A1r9iQiF4DzrYOhVFiuP9KRvoIiDNPa0rFJlxvchNE0QZAUyshwvKrb12y
         KkdveL86NAGRguV2HTGoDILnD+GvDc8UC2Jvj6ahFgtar4Wm1lC4lytFqCVsSQ3ehQpw
         /5FsoYFjy0N871Yv7y7UuZrxKfUB2q9MOeMY3YTICYeznALiMp2q6HDdQI/QVwwCymMx
         Ajdg==
X-Gm-Message-State: AOJu0Yy9YyTs9lxZVxhORlwSfBmreV0xxI/SszAwk4z94j0DSkFSsEnT
	tp4j8LA6t9OkuoDKEtU/f0fzsvPEvaIy4Yc9qfExRHxGNMPFymoY8Caj9A==
X-Google-Smtp-Source: AGHT+IHsIBNANi4jLX1xRKnPuARhauLuxbPo4aNhFO6tpdQJiGFENtZxxg3CmAYE9ngKoOjr+tL3CA==
X-Received: by 2002:a05:6e02:18cd:b0:379:4564:1228 with SMTP id e9e14a558f8ab-38a598b3998mr41022825ab.30.1720565449960;
        Tue, 09 Jul 2024 15:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/11] qmi: Enable _auto_ use for some classes
Date: Tue,  9 Jul 2024 17:50:22 -0500
Message-ID: <20240709225047.1427626-3-denkenz@gmail.com>
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

This enables ell _auto_ keyword use with qmi_service_free and
qmi_param_free.
---
 drivers/qmimodem/qmi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0e48313ebb64..69698ee049c6 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -5,6 +5,8 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+#include <ell/cleanup.h>
+
 #include <stdbool.h>
 #include <stdint.h>
 
@@ -110,6 +112,8 @@ struct qmi_param;
 struct qmi_param *qmi_param_new(void);
 void qmi_param_free(struct qmi_param *param);
 
+DEFINE_CLEANUP_FUNC(qmi_param_free)
+
 bool qmi_param_append(struct qmi_param *param, uint8_t type,
 					uint16_t length, const void *data);
 bool qmi_param_append_uint8(struct qmi_param *param, uint8_t type,
@@ -146,6 +150,8 @@ int qmi_error_to_ofono_cme(int qmi_error);
 struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
+DEFINE_CLEANUP_FUNC(qmi_service_free)
+
 const char *qmi_service_get_identifier(struct qmi_service *service);
 bool qmi_service_get_version(struct qmi_service *service, uint8_t *out_version);
 
-- 
2.45.2

