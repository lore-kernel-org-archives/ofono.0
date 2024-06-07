Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10181CAB5
	for <ofono@lists.linux.dev>; Fri,  7 Jun 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717800475; cv=none; b=BgbuDQ8hd3t6A0uW8q4hVAAC1WNeQwBkEjiC7ixnmSo2a2qJ0jyjlpoX09qERKOAjZoNR2SroMnWsNNx0iSywI1aXZT+/V9+aXUCYSfWwh1dm224kjcgE8cqGy6Iu+x6LhmDjKzkzkYMte3iHZvUbC9u8duS10znaUsZ2qeo+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717800475; c=relaxed/simple;
	bh=2dmAhmWZ/wPkyF9FB8Oet3/n6QpWt/Q86pnqLM+OQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJWe647cs0fflpUNW6fsPLoVFgpsxgdvrQYTRTvIFFFF8qW37lWbz/OrbXpk36409x/5XRBVqNGcBf4Io9jSXD2q0gijHAcbMlBCbuN9CIRO4sS5RdrEfXWqSMpM9YtCP0q8w95YQlge6O95EQI6osHuTpI3vKOLMnfwucEC+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFGJPbhb; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFGJPbhb"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba33b08550so1425438eaf.2
        for <ofono@lists.linux.dev>; Fri, 07 Jun 2024 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717800473; x=1718405273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nZjk+odFokyhaV+Ey+Q8l4FcCSD/HuMKdyicUc4rrA=;
        b=nFGJPbhb/XHw5sXlIDrYiS4A7KnTHdt7YPSDN1mk8h9CLY/4/7wjNuBIaM9CgiDEYX
         Q6gF6FR/64dmZ8KWWX0o7N/QxzrO4E/TWlYjN3LDukyLa11u5WT322iVR2qiYKUqV9us
         Xu7VJKYMTGJW63G3ZeMTYkWawiuCuwoeseoHghRPDhgTanwdM4MQOFGe+FT9jUAFehd2
         EpERtV90eFRMNJnJ6sVrjbKxvxiB0ra0ucjGelZqUfM0QlCqTWwFyy5o9kY1WX+N+vhn
         ZfOXaJ1YaistkIYd5lMhYezn00YDJdNr+pJwFPSZ8/ARWb+ifawKH43dwvNehlPA4vy9
         sLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717800473; x=1718405273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nZjk+odFokyhaV+Ey+Q8l4FcCSD/HuMKdyicUc4rrA=;
        b=LxbCtjYujoIEP4pdQgLG9WfpB0DpPAOPnBc6B8mvaTsZlHB8Xfnms/tjh8NgM73Zu7
         iKqdmJUEdMCFaGT0/0yAh39mU7YJUk0qKQWRz8+ALbwGqEh/aqyVUPLbb3EcbuNry693
         DADIeLNzOC5EyqDFWD+cVz4ITkANK3vKtIGrMBPK8lE1gugd6e9HZMYcBURE7LiEZbJa
         zonMfXPR1inkASAilMl+2at3qT+mb/+AyVhJUpI5ZUoSHmQl/9q/q8tbGEjI84TIYoUF
         RZinUU0pKk/p3PSqwY37Fq9nmD2rmmi1hvo0o7FzU6rJkXmnLbbeWMO8OoXrkeziYoOH
         L87g==
X-Gm-Message-State: AOJu0YxAdwOx3njZaop0hXr9nFmfgJF5iK+/KzH+uzJb8nPC44nEPqDp
	NvXqgu6ekGqNvKbVTNqJE1hUQzhzMOvXw8isHVAPby5/9wg8zr90s+8MjA==
X-Google-Smtp-Source: AGHT+IHDcgYueC9mhj66vNBRwghLtmFFiEYoNJDs6NjpuAxLjSoQu+oa2UBB2gduNzuEMH3HxxD/iQ==
X-Received: by 2002:a05:6820:1ad3:b0:5b7:3502:653c with SMTP id 006d021491bc7-5baae75722fmr4590059eaf.4.1717800472951;
        Fri, 07 Jun 2024 15:47:52 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba976b43c4sm838773eaf.14.2024.06.07.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:47:52 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/23] qmi: introduce qmi_service_clone
Date: Fri,  7 Jun 2024 17:47:06 -0500
Message-ID: <20240607224746.903769-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240607224746.903769-1-denkenz@gmail.com>
References: <20240607224746.903769-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows obtaining a new lightweight qmi_service handle from an existing
handle.  All outstanding requests (sent using qmi_service_send) and
registrations (qmi_service_register) will be automatically canceled when
the lightweight handle is freed.
---
 drivers/qmimodem/qmi.c | 8 ++++++++
 drivers/qmimodem/qmi.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 1b3fa34f685c..91469dc2e00c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2918,6 +2918,14 @@ static bool qmi_service_unregister_all(struct qmi_service *service)
 	return true;
 }
 
+struct qmi_service *qmi_service_clone(struct qmi_service *service)
+{
+	if (!service)
+		return NULL;
+
+	return service_create(service->family);
+}
+
 void qmi_service_free(struct qmi_service *service)
 {
 	if (!service)
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 227c498ab41d..821e54443658 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -139,6 +139,7 @@ typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_data);
 bool qmi_service_create_shared(struct qmi_device *device,
 				uint16_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
+struct qmi_service *qmi_service_clone(struct qmi_service *service);
 void qmi_service_free(struct qmi_service *service);
 
 const char *qmi_service_get_identifier(struct qmi_service *service);
-- 
2.45.0

