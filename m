Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27953AC
	for <ofono@lists.linux.dev>; Mon,  1 Jul 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847698; cv=none; b=RV9nvwCqqLWTqk22XJAiwUvIzrWxq3j5oHx+f8tbokdwxvoN61wv6iqCE13FJLw+82DOs94MXqC5veO+KjGy3cl/PgQn1zYdEG4faFlNWQZJvjVppe1Z7q+nmEXGHqkrR0dTTISf0TQeIXuibnlGykhAldu6ZyQbNfISWcN/BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847698; c=relaxed/simple;
	bh=hgTnWPOTcmTw0EfDR1xN3ufxpHEWmSS+VcrNGlCG+Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRMyrgcLCMg3LYxOYnm4+YqoFVO7y0cIx2JzVDxbvIsDRhH3fpXB32MMbk7bUyTuzmBAc3XuTB8SHZ1hTIUkqAmxGjJgQhG4O4F1IBH+BpnaxZd3OrEyKOE4cQnXKP5JUDkqDTYOWaWtIJz5gu336kU0aCvjqRLFOSY0VdjVjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=EDbY5vcf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="EDbY5vcf"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c0b73b109so216429285a.1
        for <ofono@lists.linux.dev>; Mon, 01 Jul 2024 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1719847695; x=1720452495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQCkjpUdLRHvnCnzzgA4OJR1c+kA7ECQAgr2kzXfGIk=;
        b=EDbY5vcf1pXtGtal7U+xEclF7NAMiyR3aX4rnW6ew6gMQonUBrPd0UjlA5DcD+ojB+
         /xGJKM63BiFK9d0vHMYda5861hMaXT74MK0onBmhItR/vUtE3flEUW2nXoBzv1QTl6T1
         Mog8XkSrOOJyGoHStyFPBnDieQ0MTk+dQ1jhdXadTaLLvylWnAucxpfj/wyhOqy9TyVV
         0Kx18bpZrPBkw8ARiWWjBWf2V5jXssJxZfcGZ+kUc3IENOPi5mMVUAVoMUvalrWCW7Wg
         cw9rM4vw/qk8wbhQfPjMfb4Qjdeq1IsxpJcw0vXE+9utw4gQgWiz7w18sSDBH3Mh5FiG
         h3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847695; x=1720452495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQCkjpUdLRHvnCnzzgA4OJR1c+kA7ECQAgr2kzXfGIk=;
        b=A3q1A07gnrTTOawmwqS5WUWb7/LbbY+qZzrxsdo/ZnUpI8HC1WGWEdkzJhV2PkfaWS
         CalPcGmmxiNZD87FC7rgBcwp1Smhdu5YYfgH/iqv9/dVHckeBHvrrq+C9f5qkqQwcA0O
         cvKk/rX94t+MZgkjro6dCd8rwXIV3X0njdr8rE2TFALShRECABsKZw+XfbNMpK4MZgi4
         RqMCI46kfl54npiC0TkGPX3h60WHAWeLxSrSzIkjP2TNCwypiMBEY65AkNyI0JIS1O8e
         AR8pTZt4guCJh2YLogHNXNcKlTNV+3DuqX/qvsn/QkDLr8ME+DYjrBLyngv1tXl+5Tdr
         bmBQ==
X-Gm-Message-State: AOJu0YwJSzH/fR9p2DOYJRcT3HnIf8lmv8sDuuY9XgIuBSXOZ7r9/3Hy
	2N9Lpc3qcXi3LZj6686b/mdPGou9uqBR1KdtuNV080u2AUYoXtdlRr5gbepzUtZWUE4/k7/869h
	u0W42aZRrAWbUICK2u6KLg+SZgJODOr1WqiDQmC33WXzav1i9Vtdi7keVWDjqlcV06IE9CwIE+c
	MUj6vGqSwkpl4Y9t1nnZZLPsaPI/OM83Sy4DRCLXNDQ0WAwg==
X-Google-Smtp-Source: AGHT+IGeQL9hWxllu89fu3LlOJSHIyBLQdk45JBf0bYaBVmt3IPqFtkl1X66PSKIe43O5IBZ/TZS0A==
X-Received: by 2002:a05:620a:112d:b0:79d:79cb:2a5f with SMTP id af79cd13be357-79d7babe241mr782912985a.63.1719847695427;
        Mon, 01 Jul 2024 08:28:15 -0700 (PDT)
Received: from localhost.localdomain ([140.177.136.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69262ab7sm356212085a.26.2024.07.01.08.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:28:15 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 2/3] udevng: Remove Diag setting from setup_gobi
Date: Mon,  1 Jul 2024 15:25:50 +0000
Message-ID: <20240701152553.23072-2-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701152553.23072-1-steve.schrock@getcruise.com>
References: <20240701152553.23072-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gobi does not use the Diag setting.
---
 plugins/udevng.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 271d43b16336..8e116c6605ea 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -356,7 +356,6 @@ static gboolean setup_gobi(struct modem_info *modem)
 	const struct device_info *qmi = NULL;
 	const struct device_info *net = NULL;
 	const char *gps = NULL;
-	const char *diag = NULL;
 	GSList *list;
 
 	DBG("%s", modem->syspath);
@@ -376,11 +375,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 			net = info;
 		else if (g_strcmp0(subsystem, "tty") == 0) {
 			if (g_strcmp0(info->interface, "255/255/255") == 0) {
-				if (g_strcmp0(info->number, "00") == 0)
-					diag = info->devnode; /* ec20 */
-				else if (g_strcmp0(info->number, "01") == 0)
-					diag = info->devnode; /* gobi */
-				else if (g_strcmp0(info->number, "03") == 0)
+				if (g_strcmp0(info->number, "03") == 0)
 					gps = info->devnode; /* gobi */
 			} else if (g_strcmp0(info->interface, "255/0/0") == 0) {
 				if (g_strcmp0(info->number, "01") == 0)
@@ -393,14 +388,12 @@ static gboolean setup_gobi(struct modem_info *modem)
 	if (qmi == NULL || net == NULL)
 		return FALSE;
 
-	DBG("qmi=%s net=%s gps=%s diag=%s",
-			qmi->devnode, get_ifname(net), gps, diag);
+	DBG("qmi=%s net=%s gps=%s",
+			qmi->devnode, get_ifname(net), gps);
 
 	if (setup_qmi_qmux(modem, qmi, net) < 0)
 		return FALSE;
 
-	ofono_modem_set_string(modem->modem, "Diag", diag);
-
 	return TRUE;
 }
 
-- 
2.43.0

