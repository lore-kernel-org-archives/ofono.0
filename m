Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885633EB17
	for <ofono@lists.linux.dev>; Wed,  7 Jan 2026 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814518; cv=none; b=kr8z8Y/NRKBFsdoV+EWVJLMX8kyYoUc/FNWLYJ9No5zuYLwn3K78ubAMH3ktktAlQA/Pp7yLPSW02N0M63LQxuRNd8v7NW1CxcPTnxN7CDxfwanpJ9f9hkJN9M1H+2qgybqzvG2kl5h4rNfExsGNq5zM5Az7GGx3G2uuFJX3yt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814518; c=relaxed/simple;
	bh=SSdY54tXHre/GQL5iZz/9OlGRSnxwnraP2YK6DhXyAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gs9VEpK0xpKlOk68N0yHAScTaRZCjWsLEkYrCkmjOCDxb5HU8LmCzi/9BjJN/Cnxf28ahMey42MLAsvIbh5DbGCcHuJXz/K2+/U1qhb5ll6KxZUp4A3DT/kiP+uxahRAUmKqeXjsFH9NaAJbnaZCAGtCybMzCEzm3aL3ucsvQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr9FXn3U; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr9FXn3U"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594285c6509so2568918e87.0
        for <ofono@lists.linux.dev>; Wed, 07 Jan 2026 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767814514; x=1768419314; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm4GooFtETQEluRqOsRlhTUYZtGeoNlQopJukF7Ilc=;
        b=Xr9FXn3UCnIhok5hprVCeKebYxjOdQ5I8Wvp/BqV60nVuF50qOTCYSjTi7py+Gm/7W
         sRftihUf139y5Qf1R4UFBgVqE4AtOeKiLuIN60lZ788x+NRFx5ohtvCOWGa97csiob6E
         Ni2+QOi51EmUuIoQ1s5UcwiqLNShbWKrZFNdjRM1Ph1WF/JqW7aF4TZMf1n6Yynjook6
         W2+DCznOkJ8xPhQjVWhqnOAcpmB1hdXS2LDb+AyNUusVXFdoK1P+UHbJ61PW1MEQIhWL
         m+0AzRoCLfWtyDhhNuBfjK6BivCbU+pNibm9aAoRIP8Aa6rVz8nlRtgONa+uO92/bK8C
         fE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767814514; x=1768419314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jm4GooFtETQEluRqOsRlhTUYZtGeoNlQopJukF7Ilc=;
        b=nAW0/3A65K/DhESUi6fqsp/ez42l+2yd+1OX15kdNTrqe7ZJfDbcCEfv8W3wbYthK6
         sqlik/bSQ3Om82n12jgiTQUFTIHcxoD0oVYtkdjZUXKpLwcdnTLh0QNkeR9woiQN2Dlc
         hoLhLtJaYMNvUShwF4jWeOUzmjEqccu6lmMbSPDz+WUWBgloW1PN3WcKZQ39M0NJGw1e
         NJVFpRorag+M/YvONL73ANBl+faHsJ3wJdNEKbxHG4vN+XI9yu7NlJ2uG4GYNxA67qtf
         1/YK5qTT2yjNOjTBQd7CyjaX5LFuTk8OGiy0buqm2AqOqZf3EmwgOPQvopF1/mtF7/+C
         G8Gg==
X-Gm-Message-State: AOJu0YzZHqblNOgn5qLpsfwySSF9GaS370Q6rzftOfoEJ1w3OHSch6Eg
	ka8nywL+TlGDpYy0unZJ5kOyhToGRTzUVeY3xkBo3zCsNhsvw2f1zCy6RCC5Iw==
X-Gm-Gg: AY/fxX4vfifB9/9jPggVNxwUL311w7fPo0VkboZWBqWCbM4SxJi6D9GElc5q1Aur+n7
	oOF/1E6ExqKx5LFa9R8F5PRqkoJYBn/rrxa2+5ba3ejTSpPHEuYw90PHJ4j/ozeUWvltcRx107X
	3LFd9WPGNeY7aQK+LQ8upL0A8jNE+/U1xvQCRUMl8fmaVqmzql5Sz8ScnLst/r2etr7BPXL5VXF
	eQHgJ0FvtFBqU8JukrWlwGt+DXxt7CU8R2cufZ/9YIkNCcK0xJy88VgBuNH7HnxGXNXCya9suNq
	Q89T6aqUpyIdVw2hVJPkHnvpy3dUEL5mi7AdNjxF9QV/ywq3BhDA8Zc37Z/GZqSOmTvDaPXsD+D
	YcTkvaiy4/dRsBBqf7TxJ4bLvwOl2lEb2avA5sF0JbwCQzxAaJ4MClKtbk5SpKPETfcMyGR8oIm
	5SBSZtOMS+iAu0gT6SpzMDa2sfzGw+gqF5klbW8m+srb8Rq1/rgdsee1/zWdFC/pT3NPuesApZB
	uGUoDEjIpSnvpnillkYswp+m2vMroImQ8jPF1EF/6M087kv3cuIHluZSBQnF4ox
X-Google-Smtp-Source: AGHT+IEbDh7a7XoSlQiZZffeXUF1OY92XN/bZtOQ1I0i6t3TaKaLoiiyTgVyHB74FUBoMhz6ZRqotA==
X-Received: by 2002:a05:6512:a88:b0:595:7854:af77 with SMTP id 2adb3069b0e04-59b6f02b59amr1261275e87.22.1767814513719;
        Wed, 07 Jan 2026 11:35:13 -0800 (PST)
Received: from nucken2.localdomain (h-98-128-204-19.A444.priv.bahnhof.se. [98.128.204.19])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59b65b89842sm1484999e87.0.2026.01.07.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 11:35:12 -0800 (PST)
From: "=?UTF-8?q?Richard=20R=C3=B6jfors?=" <richard.rojfors@gmail.com>
X-Google-Original-From: =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard@puffinpack.se>
To: ofono@lists.linux.dev,
	richard@puffinpack.se
Subject: [PATCH] gprs: Signal added for newly auto created contexts
Date: Wed,  7 Jan 2026 20:34:53 +0100
Message-ID: <20260107193459.3791108-1-richard@puffinpack.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where a cid gets auto activated and a
new context is created, we need to send the added signal,
just sending a change is not enough. Connection managers
(such as connman) assumes it gets notified with an added
signal when the context is created, otherwise it wont
accept any changed signals.
---
 src/gprs.c | 65 ++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index c5287661..fce7f1e5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2017,6 +2017,36 @@ static struct pri_context *add_context(struct ofono_gprs *gprs,
 	return context;
 }
 
+static void send_context_added_signal(struct ofono_gprs *gprs,
+					struct pri_context *context,
+					DBusConnection *conn)
+{
+	const char *path;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	path = __ofono_atom_get_path(gprs->atom);
+	signal = dbus_message_new_signal(path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"ContextAdded");
+	if (!signal)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	path = context->path;
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	append_context_properties(context, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(conn, signal);
+}
+
 void ofono_gprs_cid_activated(struct ofono_gprs  *gprs, unsigned int cid,
 				const char *apn)
 {
@@ -2076,45 +2106,12 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gprs, unsigned int cid,
 
 		strcpy(pri_ctx->context.apn, apn);
 
-		ofono_dbus_signal_property_changed(conn, pri_ctx->path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
-					"AccessPointName",
-					DBUS_TYPE_STRING, &apn);
+		send_context_added_signal(gprs, pri_ctx, conn);
 	}
 
 	gc->driver->read_settings(gc, cid, pri_read_settings_callback, pri_ctx);
 }
 
-static void send_context_added_signal(struct ofono_gprs *gprs,
-					struct pri_context *context,
-					DBusConnection *conn)
-{
-	const char *path;
-	DBusMessage *signal;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-
-	path = __ofono_atom_get_path(gprs->atom);
-	signal = dbus_message_new_signal(path,
-					OFONO_CONNECTION_MANAGER_INTERFACE,
-					"ContextAdded");
-	if (!signal)
-		return;
-
-	dbus_message_iter_init_append(signal, &iter);
-
-	path = context->path;
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					OFONO_PROPERTIES_ARRAY_SIGNATURE,
-					&dict);
-	append_context_properties(context, &dict);
-	dbus_message_iter_close_container(&iter, &dict);
-
-	g_dbus_send_message(conn, signal);
-}
-
 static DBusMessage *gprs_add_context(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-- 
2.48.1

