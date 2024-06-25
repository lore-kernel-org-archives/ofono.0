Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D984174EC7
	for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333734; cv=none; b=leebh736dqbXourjQWMxH2HMBtsKDJMYMyKTAbZ7U/hzLBIhF0KXPMXx36ArhgFnQmoxwut91r1V7bCW3YCwbQILTV7rOPGGSF/+m5ub8GYPR4plBVgCREus7xHu+mDuHPv13OusK8CajnraVrTk6xTBgFK30A2QUbDs5v1Q1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333734; c=relaxed/simple;
	bh=93oYdyo4JFmMCEn08uVMKUDs6mcIc+WMr9jtGBbghxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsBgDNaKwmgts2BH3oVW47/0eKy46y0n0DPvYRmUKkbiOclz5zJHkWavVEF5iA39a/KD0LJfggv0eWEf7srbvZH/nVYqa7tVyZURKdGrfm1FdVRzGcd73f8I4ZGFWWGqKWQqacHyYTyq+kRAP8guDLmUF3NVrjAW9kDTAOkF/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI1J4Z4L; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI1J4Z4L"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c1adbcaad3so2548086eaf.1
        for <ofono@lists.linux.dev>; Tue, 25 Jun 2024 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333732; x=1719938532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRe5GLPV3MGyiCXYMpc6TBo/8Mio8zmDcg+zyGSPYqk=;
        b=SI1J4Z4LNQBYFWjxDsoVbH21mnyk60RniFsn4HyjzzbFDQ3AzV3QvL5frmOVv5QVyj
         x2a9Ct1DRfJjmAVTiDyW3zH2DCpwPsdKQKVYErMMHQGlZhPxS42P5vAEKwE11L91V4rb
         aIw8kKlW+bSMPyNS1fLWxlJq1GbiFh8dcNMqz2xyfmdeaDuQHw6UvSvaCylflXyDCD4L
         rxe5+tFyKAclXEIQnqtOclA1hmA+FQ/BLdODfKMHnK+EtJLJfYHC8pt2SK6R2CMU7rWM
         g1x9/tnvIiAahHS6P7Z28nzVRQZheknRFeEcvm9kXsfsuIhqFqWsqYvmCixJGLcC5bIX
         qJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333732; x=1719938532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRe5GLPV3MGyiCXYMpc6TBo/8Mio8zmDcg+zyGSPYqk=;
        b=ltinMrrjYYqKbmGIAVuPHXQm9JP21g7gnwczRuWK9yyDDYdLIPnffn/zd74HexJO1m
         LnHpyZT5l+U/GjHLH+22YQqP8NoqXC5Dron6Zq5sHMuyP2D7ZaG3FeEHZJot1kWG2Dx+
         n/utu3jhpQi7MwMKruVO7SlD6S7IT0foE5qTW5Vu9cLlkQVRQgFoONOQxwaF2OyiUbZA
         kqYGpVeTtx7x3ahqq9IkIkFh2SD9fPm9ikST/UJQ2xLuKOdMOimWxVuXZEHKkFGJ0doD
         VRr+WoPhJtsKcewPhjmY1QTGjf7DLja1uGZzbi6qKuWwl+YH2x/c2O77Azla5KnCJGv3
         cVjw==
X-Gm-Message-State: AOJu0YziGHtjpr4n9MhKtTUf3+NrPbSlPDA996zOmVwjMF0WNq1Qb3Cn
	i364Z0YhKSXKyIuVxPkJ6n/f2MYBu+rjvzz4icqc+OuujqTiCT2PidgXVw==
X-Google-Smtp-Source: AGHT+IHI+m8Ld3A0chJVYd+PXvUJIFxIOa4VESk/Ryn9Dp6COQvibvM3Q/4dCVU78lsjb6nKUqouxw==
X-Received: by 2002:a4a:8804:0:b0:5c1:9e5a:ad9e with SMTP id 006d021491bc7-5c20ea000eamr1891006eaf.0.1719333732103;
        Tue, 25 Jun 2024 09:42:12 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d55dc2dcsm1884844eaf.27.2024.06.25.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:11 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/14] unit: Use _auto_ to automatically tear-down test setup
Date: Tue, 25 Jun 2024 11:41:49 -0500
Message-ID: <20240625164158.1170937-13-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240625164158.1170937-1-denkenz@gmail.com>
References: <20240625164158.1170937-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-qmimodem-qmi.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/unit/test-qmimodem-qmi.c b/unit/test-qmimodem-qmi.c
index 2ff981391849..e68f5a7bdd8f 100644
--- a/unit/test-qmimodem-qmi.c
+++ b/unit/test-qmimodem-qmi.c
@@ -181,11 +181,11 @@ static void test_cleanup(struct test_info *info)
 	l_main_exit();
 }
 
+static void _l_test_cleanup_cleanup(void *p) { test_cleanup(*(void **) p); }
+
 static void test_create_qrtr_node(const void *data)
 {
-	struct test_info *info = test_setup();
-
-	test_cleanup(info);
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 }
 
 static void lookup_complete_cb(void *user_data)
@@ -205,11 +205,9 @@ static void perform_lookup(struct test_info *info)
 
 static void test_lookup(const void *data)
 {
-	struct test_info *info = test_setup();
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 
 	perform_lookup(info);
-
-	test_cleanup(info);
 }
 
 /* Callbacks could queue other callbacks so continue until there are no more. */
@@ -223,7 +221,7 @@ static void perform_all_pending_work(void)
 
 static void test_create_services(const void *data)
 {
-	struct test_info *info = test_setup();
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 	struct qmi_service *services[3];
 	uint32_t service_type;
 	size_t i;
@@ -262,8 +260,6 @@ static void test_create_services(const void *data)
 
 	for (i = 0; i < L_ARRAY_SIZE(services); i++)
 		qmi_service_free(services[i]);
-
-	test_cleanup(info);
 }
 
 static bool received_data(struct l_io *io, void *user_data)
@@ -423,7 +419,7 @@ static void send_response_to_client(struct test_info *info, struct l_io *io)
  */
 static void test_send_data(const void *data)
 {
-	struct test_info *info = test_setup();
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 	struct l_io *io;
 	uint32_t service_type;
 	struct qmi_service *service;
@@ -443,8 +439,6 @@ static void test_send_data(const void *data)
 
 	l_io_destroy(io);
 	qmi_service_free(service);
-
-	test_cleanup(info);
 }
 
 
@@ -469,7 +463,7 @@ static void internal_timeout_cb(struct l_timeout *timeout, void *user_data)
 
 static void test_notifications(const void *data)
 {
-	struct test_info *info = test_setup();
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 	struct l_io *io;
 	uint32_t service_type;
 	struct qmi_service *service;
@@ -517,12 +511,11 @@ static void test_notifications(const void *data)
 	l_timeout_remove(receive_timeout);
 
 	l_io_destroy(io);
-	test_cleanup(info);
 }
 
 static void test_service_notification_independence(const void *data)
 {
-	struct test_info *info = test_setup();
+	_auto_(test_cleanup) struct test_info *info = test_setup();
 	struct l_io *io;
 	uint32_t service_type;
 	struct qmi_service *services[2];
@@ -563,7 +556,6 @@ static void test_service_notification_independence(const void *data)
 		qmi_service_free(services[i]);
 
 	l_io_destroy(io);
-	test_cleanup(info);
 }
 
 static void exit_if_qrtr_not_supported(void)
-- 
2.45.0

