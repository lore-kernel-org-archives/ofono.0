Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852581DBB0C
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202997; cv=none; b=hlJSxOWIwXbOTizUdRS6tFmBCBgoDVs+CSJHn2V+/cd4XWn8RzLx0AYrrebG/5oxW3VxBHbSLHvzOZ48VhV33VVxhiMB6/lvYheSAwFhgtZE25ONyIeuO95J0PALt5WijIc0Ao3OsLaCbVFNNdyiskSezYJz+xg17s/vBQ3JPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202997; c=relaxed/simple;
	bh=K/mO8DXP5l66w9IrVuOZrcyki+7Ahgg27q3qLOsqCfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhRm5DkjPcJsonKPfS9/jps1wyTDVaDE9vvgF8bQUBqhlStyKmEdsTh0pJqMXKclpdbY37UV/iTUodrNlmaI5BdyMpUvJ9YvUXp2Pgd7Xhjzao2/tCuP7+TZWYEgTSGYEzyuNfPfIEUwfOk975rqJn3TF+vGWC2U4yXOHIGKGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBNHAQHy; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBNHAQHy"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2969dc28d9eso685887fac.0
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202995; x=1732807795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pBvuTpliBIseJXNzlVg2WXf6PYRSRuFYxUuc4uQx1Q=;
        b=YBNHAQHy9crDuRJqNcdK9Buychn2IjQrH5uTg+gpEHAkGkQ61XtpQxx/RIk/fosJ26
         D3vaJ4chtIeSbzH9BEdtBvL/PEMeO4M8CcBcyKTOZrBqko9Hl9MUGVlLeEPj3smbrME5
         qyx7sSFnUNwOWXiT/maE9zhJpDeEXMzCxNdKltwEgAK3p9dS2dTkU64iNdY6/zz420Ap
         xwGatO6fxEKcKym/XxdANYmj60aV8hRODk82jB60JwOQ5A0StY2JBnC008m9yxdYYo50
         9DsS1JlFYOKdl0aSFPwn35yCSpT09JayRGLY2gkdVeCmASBCkZAkEybATyg9fhiEAP+R
         n6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202995; x=1732807795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pBvuTpliBIseJXNzlVg2WXf6PYRSRuFYxUuc4uQx1Q=;
        b=TUfucRYDlejO+kzDL2SIjZANyxLA0Fo/dY1K5X6FBy+gbL1svvUV6itSubu5NY1jCq
         JXw9J4u938+lJqq0vQp61kKxON1phqm0mtOJLTPv4psYd5ietfQLYdPxdqw7oxJgrbhb
         kMhwMy93nDMRovzuRfcKQJGCv47Qm84HrOwtjLf6nxn7KulijwTrvGH4nlwcaLkgOmad
         b2BrYHdlwnJx7SGkRAlaQVWwM2rtW0x7O9Dmsd6GYQWlBmLiWA0gEOKVFBFov6TlsNsW
         JS/UVlzf8TtOmjek/wBp62wd1s/1RM8W64Krhoe5TPO6wXMaLjozTCmr+x/493DQriNN
         uIfQ==
X-Gm-Message-State: AOJu0Yyt5Bmnvibgj/u8lJyEqLGXt09f4o73sFfc/ceGsMVwDl9uPeOF
	sfgFh0QOAV6yD5olCKZiYU5TgGLeCXuW6r1e3URxvXP4a1LhAtQwqRnwgQ==
X-Gm-Gg: ASbGncsJm6WLucsvhAjhA3rhJSCteNzUTPLQAG658h0WIUfCkBNVgndzHdQO0nsY4EG
	+V2r2w3JD0T0+8DavLO7TAa7tRZrp55ym5RoGHLzSK1t0jXkf4D6XdfcrDVzcZjStvSlF+wne30
	vOPsyVLZ1raOtbE3NEXT+CCNc4vQLcL4RW08oSmBsOWMkHa2qeWaMRU1YprZ/dSvWlqhD83oRtJ
	JYEVTBwHvoeX3j3vlWo4GfQJdQKr/ie9KkoriWkRFl5f0V8Hw8h9k6gL3/ypFU5N/3L9xEh7osK
	zrDQahI29cTBcixm2jCtu/UK
X-Google-Smtp-Source: AGHT+IEynh2Ov6JLBeAfScZOpBE60flhTfs6mN9FcJ8Z6Ny87D5x0ly5mJN/OWsRv+h70h3hH0I6FA==
X-Received: by 2002:a05:6870:b4a3:b0:287:32f7:ef42 with SMTP id 586e51a60fabf-296d9ae3365mr7611883fac.16.1732202995310;
        Thu, 21 Nov 2024 07:29:55 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:54 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/10] gobi: ensure Set Data Format changes were applied
Date: Thu, 21 Nov 2024 09:29:33 -0600
Message-ID: <20241121152949.56962-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
References: <20241121152949.56962-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some firmware accept Set Data Format command, but do not actually honor
it.  For example Quectel RM502Q happily accepts being set to 802.3
link-layer protocol, but doesn't actually change it.  Try to detect this
case and handle it appropriately.
---
 plugins/gobi.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 87b54ae05f17..321a2ae0bca7 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -461,6 +461,33 @@ error:
 	shutdown_device(modem);
 }
 
+/*
+ * Some firmware accepts the Set Data Format command successfully, but doesn't
+ * change anything.  Try to detect and warn if that happens
+ */
+static int compare_data_format(struct gobi_data *data, struct qmi_result *result)
+{
+	struct qmi_wda_data_format expected;
+	struct qmi_wda_data_format actual;
+	int r;
+
+	if (!wda_get_data_format(data, &expected))
+		return -EPROTO;
+
+	r = qmi_wda_parse_data_format(result, &actual);
+	if (r < 0)
+		return -EBADMSG;
+
+	if (expected.ll_protocol != actual.ll_protocol ||
+			expected.ul_aggregation_protocol !=
+			actual.ul_aggregation_protocol ||
+			expected.dl_aggregation_protocol !=
+			actual.dl_aggregation_protocol)
+		return -EBADE;
+
+	return 0;
+}
+
 static void set_data_format_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -473,8 +500,12 @@ static void set_data_format_cb(struct qmi_result *result, void *user_data)
 
 	DBG("");
 
-	if (!qmi_result_set_error(result, NULL))
-		goto done;
+	if (!qmi_result_set_error(result, NULL)) {
+		if (!compare_data_format(data, result))
+			goto done;
+
+		ofono_error("Setting Data Format had no effect");
+	}
 
 	if (data->data_format == WDA_DATA_FORMAT_802_3)
 		goto error;
-- 
2.47.0

