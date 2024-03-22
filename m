Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293B46525
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116589; cv=none; b=pmIyVt7AirQQnSi6IT9TxNOJRwGssBI0qhEliD8g67kKwLY9qTsB9ACs3skjh5wGfqfQIMPIw7eLhmg6bbKngRVWbpDS/+BqkmckJ26kfjzblEaSiWZaNO+Hv1bBKD8sB/nX9NuZS201FKC4yO54DN5u8cuf6565T8gW5zPhZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116589; c=relaxed/simple;
	bh=yoTX1JwcbFoPDrkJVhYp7Dl090+lkhKN4m4+xU7wKJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIQKgIbYJXA1NGPFT9N7tVgijGzaemvIQRfKRtC6S3TbRORoFEBrrPM5kE1kFMut9dni1YG9vcnJSaIhmpMyCuY+613z9PDzLyDGh2yGO0KZd5ydp3ne/XeGNpTZ6PdqjUzMGMCsTTnhb9q1p1iOIgRnO6nl+uPYEP2G+Vkr6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP6DrZrq; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP6DrZrq"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a477c48fdeso1105607eaf.2
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116587; x=1711721387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFC3u/HMQvFQPmxOHhjwulDYQ/1ikrg3DDpuFYppu3c=;
        b=BP6DrZrqPT1CU1IbO7r/l8Ti1O79W9m/p+4vWXgQu9p1OeNbqiik99lhYNxNnEE8Zb
         1lxtPswGGFlK1/Wo3lCICGcW7e9wtnp+wKBFyekeTBZqOrQnCtirMYgOiM8SenQYICuY
         TEPy56wl6y2esnhv31RCNWk4/Dqcwi6N2/HWs+/9xI+mwbYRF/hhvhX8j7GYSwYFRyUt
         UyPiAHR7lRgDjYh1dMteb/KzZVMa5u7c1M/Ws0yTr7cKwGspaN0VYhVSrWQmTNPSTUm3
         /N810/wxoCjzgN9rZMf/+oLnD1X7wJb8va9tJJBP/n9dAIuz29ydvwiyuFe3zdF8NBGH
         t+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116587; x=1711721387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFC3u/HMQvFQPmxOHhjwulDYQ/1ikrg3DDpuFYppu3c=;
        b=i2g7WZIXKPbJxKlt0oWI7I2qZGwZBfHuhl5J7r4hNlIL32uXMrr7KpsmVtRjWCZ5rM
         YgGTcqL13xnemK/lWVsAV/nK3EVwi7+qbv1zFe2MKmp6XK7xBKnoxeJYHu4MzrmVcBwO
         /aKGbs+e4smhMSuHe+p3Ge667pUYHPDmJW5F+Oj5jYqTIy21BRfWzM/wkO2++szz4P2w
         AOL0/Vaj+EwBTDAS1XvcBI73VO2S3AeNksvQ7rTc+hXlkjy3Ns5krNDou06TPUXHjKjU
         wiA3BjubxOf3msU2pp9Tx7KJUyITsdLbp+VUEFfuzSBAG+36LQbSEX0CxERGelHlfSln
         pz4w==
X-Gm-Message-State: AOJu0YxWqFUS8ukrhIICVCxsN0m7GwQknYZZQMnbrFTDArTXHd9Mk6Eg
	/rfvyGJ7SQUyTz9xpzbdCa1WYD5qgwibmXMe8+U/rkpwYoOm53QRK5Ma+B/Z
X-Google-Smtp-Source: AGHT+IFCqMtCbdUoo/d92hbCmzB13qT0AMzAWuFhryqhlMKkrDVYE1H6TvjazzlxkMFWw+zAsOl6OA==
X-Received: by 2002:a05:6820:1f06:b0:5a5:dc:1875 with SMTP id dl6-20020a0568201f0600b005a500dc1875mr3049524oob.2.1711116586961;
        Fri, 22 Mar 2024 07:09:46 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/11] modem: commonize interface string list generation
Date: Fri, 22 Mar 2024 09:09:04 -0500
Message-ID: <20240322140942.2703042-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322140942.2703042-1-denkenz@gmail.com>
References: <20240322140942.2703042-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code was repeated in multiple places, factor it out into a common
function.
---
 src/modem.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 37d9bd57fdd9..7486a56aa183 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -149,6 +149,19 @@ static char **get_features(struct ofono_modem *modem)
 	return features;
 }
 
+static char **get_interfaces(struct ofono_modem *modem)
+{
+	char **interfaces = l_new(char *,
+				g_slist_length(modem->interface_list) + 1);
+	unsigned int i;
+	GSList *l;
+
+	for (i = 0, l = modem->interface_list; l; l = l->next, i++)
+		interfaces[i] = l->data;
+
+	return interfaces;
+}
+
 unsigned int __ofono_modem_callid_next(struct ofono_modem *modem)
 {
 	unsigned int i;
@@ -832,8 +845,6 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 {
 	char **interfaces;
 	char **features;
-	int i;
-	GSList *l;
 	struct ofono_devinfo *info;
 	dbus_bool_t emergency = ofono_modem_get_emergency_mode(modem);
 	const char *strtype;
@@ -883,9 +894,7 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 		ofono_dbus_dict_append(dict, "SystemPath", DBUS_TYPE_STRING,
 					&system_path);
 
-	interfaces = g_new0(char *, g_slist_length(modem->interface_list) + 1);
-	for (i = 0, l = modem->interface_list; l; l = l->next, i++)
-		interfaces[i] = l->data;
+	interfaces = get_interfaces(modem);
 	ofono_dbus_dict_append_array(dict, "Interfaces", DBUS_TYPE_STRING,
 					&interfaces);
 	g_free(interfaces);
@@ -1301,12 +1310,8 @@ static gboolean trigger_interface_update(void *data)
 	DBusConnection *conn = ofono_dbus_get_connection();
 	char **interfaces;
 	char **features;
-	GSList *l;
-	int i;
 
-	interfaces = g_new0(char *, g_slist_length(modem->interface_list) + 1);
-	for (i = 0, l = modem->interface_list; l; l = l->next, i++)
-		interfaces[i] = l->data;
+	interfaces = get_interfaces(modem);
 	ofono_dbus_signal_array_property_changed(conn, modem->path,
 						OFONO_MODEM_INTERFACE,
 						"Interfaces", DBUS_TYPE_STRING,
-- 
2.43.0

