Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6141509AE
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075894; cv=none; b=CmDUrqu3BdgfxeeSgva9yBZBd4o1iqIBRbgLzF8h6BCqSOlLJTHH1XeWbL6+HZAX0ZMlnlSZwau7BH0QFEJFjw+qs7XBMi3A1I7iCX5AXYpjTlZAbasrmpEvfpA6O2NFxDekHjt8M/j4qq4KLJKr+GD+XoWcnYpD/kAPs7qZ6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075894; c=relaxed/simple;
	bh=Wf8/tx/IvvRnYFmGZdzdbSJCCh/NjGeGJMBU835sMnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnIdaR7tXERVVlts5qnRU9HGdAXLQe0OpA4EgibKguoP8FHIBK1xU3FqujzGqr2mjI6+xDCnuV+2Xlgeympkgp7AkPm/wSQmmU7TTk7zZexZGTK2n+BWIrLG1eZq9NWDW+r3AGLo2zKRs/kyK2knAslq1R11df2rE/AlAVmaqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co3vsi/Z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co3vsi/Z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa362cc2ccso877631eaf.3
        for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714075892; x=1714680692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZfgMmQDnfQj0u3MTMNut7a4YFzEI8BfyYI7/TCJUno=;
        b=co3vsi/ZVSuELM+t3HtTOdzU/U9lIEwxhbV3hLHOgGSppSwvcfZ8d9fiz2hfDb3XzO
         L9u1gTvjjAuXW8vGPds0+PVw0nT4HQzJ99AUltT1UjUpXKPe862XcMLDIHnr2tYUxtud
         3XiImZ6H2qKp0k6QlKpQuUfS/FIIJig1AILlW7JMeWd8NBJPh/wePKMThAg9IK8vzZvm
         6uxk9d+Klv5rkVVHj+lGC7+CeoPZ98DQLBrQD3oEDXP+KTDP/uxR3ZMyS42yZvLaYcid
         AXAeAGo69gD7jQWociYeFNrNNF6+ntYI8lOqafxytfh/oVPcxhQUmfo7a9FA6ZHARDj7
         T9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075892; x=1714680692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZfgMmQDnfQj0u3MTMNut7a4YFzEI8BfyYI7/TCJUno=;
        b=b6agJRa3rXcAehTjjGXxxL5VLrqmbN/G+gq01wseT5uMZi55X3Qhq86cP9EX0OyghE
         0lGk3BztJFzivmPktrBUMbdLjEiSygqjte/FTxm8u6v6jecjyG0PyqRnfeoUbzuUXq8o
         pda3ONeJCbbGp/1Y/GjfZWVtnr7I735kZGN17xZYa7/toTHh0ZWbfr1UvZ+29S1Y9UC4
         k50AzPnJe4Plu+r9GKdPV+NPlWdGXzli9hdJm1KKY0hfIIjdkoHbpB2UkkyjCtzjPm8K
         Cx3vn0QJEjLOMYFKNxmNq4C14NhOcbZNH66duTec2sAMxwGjqn0d564LiDl3pnK6/jWN
         qu6w==
X-Gm-Message-State: AOJu0YxPsm/ENwi4ZumNm9p+S+H58s4kiFU/e4NnPFVCPTYgFE1uL7Wa
	L4nHgvwNBMw6jGGDbCv159gX8Z2wQ7A21UjM2zv6UDjz/TCMl3nPd9520Q==
X-Google-Smtp-Source: AGHT+IGW3vzsOQ9ahc5npQdNAEKBvF0FPJOFn2Q0+uHPqdTPe1/XmAlW/jQkPsxDKnxvOuO6o+jSww==
X-Received: by 2002:a05:6820:70c:b0:5ac:9eff:440b with SMTP id q12-20020a056820070c00b005ac9eff440bmr1039553oow.1.1714075891909;
        Thu, 25 Apr 2024 13:11:31 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id w5-20020a4aa985000000b005a4bc907f0asm3432068oom.15.2024.04.25.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:11:31 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmi: gprs-context: Actually send param to qmi_service_send
Date: Thu, 25 Apr 2024 15:11:14 -0500
Message-ID: <20240425201129.538276-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parameter structure was built, but not included into the
qmi_service_send call resulting in a memory leak.

Fixes: b6ced6c5c4c9 ("qmi: gprs-context: Request certain TLVs to be included")
---
 drivers/qmimodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 055378dc102f..4004876bab87 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -194,7 +194,7 @@ static void start_net_cb(struct qmi_result *result, void *user_data)
 	param = qmi_param_new_uint32(PARAM_REQUESTED_SETTINGS,
 						requested_settings);
 
-	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, NULL,
+	if (qmi_service_send(data->wds, QMI_WDS_GET_CURRENT_SETTINGS, param,
 				get_settings_cb, cbd, cb_data_unref) > 0) {
 		cb_data_ref(cbd);
 		return;
-- 
2.44.0

