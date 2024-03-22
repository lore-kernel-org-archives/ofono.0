Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941764CE13
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122160; cv=none; b=GR8TYSU/41WDXCaAhCUlJplNiTpn2gxzi/CJ/0vy7F6TwIb96/ggoG/b0h/+NyNn1lriS1TgQbSvDCRK2vIwGGJe1wAnm54ZGHuPOilExJY/whhZ/jspyqUESEzb3EVUbw74A2tq+mhLtYEa1dOGI5BjqgByGfZL0+lQcEUiO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122160; c=relaxed/simple;
	bh=F2kBdDkO9/lifi4hnFgrDevAneXJ6Yj0qswNBRN9guo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhnPRSECz7XCriuuieoVBeo65ujnavmYKRe0LqAikvI7sHiBuJ5oNLLYl8g4SJNdkvdppoigPOhPgBRjEDJLeHGzxQOJ+R/6T1ZzXUE9NQvI49fWtuVXTL95XxWu2SLwBqnmPUUomxd8a3Iacp4cKqVYJbZdgOrXBnB+Ux+qRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1kCDUGz; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1kCDUGz"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e519d73850so1414619a34.2
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122157; x=1711726957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvG8VkNelblegkAJJcYsuUfUkmU7fhzLdvQgv2CLO2g=;
        b=V1kCDUGz2IQFlYOvpsg6Qy8scwUBo67wSDCz/uYv5Xgz55yGsrrTlLgrXlIoB7i7Wq
         Qgcc996kW5gUzUd5JhGJWB7s9LGp7eEov5cjFJiOZNNKasH6bWKdyWzXsTuqwszovfc/
         wiJ62lStTMzI+R35ySYf1rFdnKiNJ5al8tm3CcuwlI+KwDdgn0UAJT/NxbFxO+T3r/on
         0IkWKTNkji5JBNtNHMeva3Lvh5S2INacZa4Y0REwU6jDujrZc9JKYh1pFUxgn9NdiPk0
         XYUuHvZh53hOH/jxCpW6LT1qDQ6VuoUAOe7Njs0adUyQilyqZ3S8u1eMohuN7/FgVENe
         5KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122157; x=1711726957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvG8VkNelblegkAJJcYsuUfUkmU7fhzLdvQgv2CLO2g=;
        b=Q4Qq3C3NuctHKrkFn6S7wUYUURAjePCYynrO1DyKRMzFPQc9b0ffwir1kEKGFnQZcj
         1/021ofu+i0JdKhyxbdqpuaai8hBVHSXHQVvOn7oivWRo1HXudI2TRBbskbpiWoE9Gsg
         p63HYPYieC3HZMS2U+HAs6lCDkv4SDtz1K4QydiF9DEXTmPLESvpWfUwPFeNpP+xV5Y8
         5J2cEyIZgfxiw4yQ4gSQDOgYh11BYCmNg0xl/GJMuQQYcOsKGk+kji7J+o+958+mf+iZ
         xBxpOMc7MgFt9pCMnji7NLHkWa7fB3yojZZB2ob663TKHAUXG9XkdeqdjfwfuCOwFn6i
         elAg==
X-Gm-Message-State: AOJu0YzLKZbPxz3qRSYurUnPYbijfM04mSQ50ARNw2iCjFNowtPITq04
	awZ19ItylCo7gQivdW+0XEIlrATvhNx0VgIxqU0vi/rn9j7QJN6AVg0xF0Cy
X-Google-Smtp-Source: AGHT+IFgf/osuEfu1mjnkKeC91HoyEv4lf2LmixHmvbG/ADyvsUyGsnZMLY1wsvZIBBKtLrz7IQ8nw==
X-Received: by 2002:a05:6830:1d67:b0:6e6:7adc:e4ed with SMTP id l7-20020a0568301d6700b006e67adce4edmr2629008oti.29.1711122157455;
        Fri, 22 Mar 2024 08:42:37 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/11] modem: commonize feature string list generation
Date: Fri, 22 Mar 2024 10:42:15 -0500
Message-ID: <20240322154234.2720542-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
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
 src/modem.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 788e86fba0f6..37d9bd57fdd9 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -137,6 +137,18 @@ static const char *modem_type_to_string(enum ofono_modem_type type)
 	return "unknown";
 }
 
+static char **get_features(struct ofono_modem *modem)
+{
+	char **features = l_new(char *, g_slist_length(modem->feature_list) + 1);
+	unsigned int i;
+	GSList *l;
+
+	for (i = 0, l = modem->feature_list; l; l = l->next, i++)
+		features[i] = l->data;
+
+	return features;
+}
+
 unsigned int __ofono_modem_callid_next(struct ofono_modem *modem)
 {
 	unsigned int i;
@@ -878,12 +890,10 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 					&interfaces);
 	g_free(interfaces);
 
-	features = g_new0(char *, g_slist_length(modem->feature_list) + 1);
-	for (i = 0, l = modem->feature_list; l; l = l->next, i++)
-		features[i] = l->data;
+	features = get_features(modem);
 	ofono_dbus_dict_append_array(dict, "Features", DBUS_TYPE_STRING,
 					&features);
-	g_free(features);
+	l_free(features);
 
 	if (modem->name)
 		ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
@@ -1303,14 +1313,12 @@ static gboolean trigger_interface_update(void *data)
 						&interfaces);
 	g_free(interfaces);
 
-	features = g_new0(char *, g_slist_length(modem->feature_list) + 1);
-	for (i = 0, l = modem->feature_list; l; l = l->next, i++)
-		features[i] = l->data;
+	features = get_features(modem);
 	ofono_dbus_signal_array_property_changed(conn, modem->path,
 						OFONO_MODEM_INTERFACE,
 						"Features", DBUS_TYPE_STRING,
 						&features);
-	g_free(features);
+	l_free(features);
 
 	modem->interface_update = 0;
 
-- 
2.43.0

