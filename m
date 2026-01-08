Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBA38BF69
	for <ofono@lists.linux.dev>; Thu,  8 Jan 2026 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863795; cv=none; b=ehPcD9MNpA7Mo4kodcj1jHLronys1JmkY8oaP6re56VnXNjPw6FdGNOgoty/ghKEdIs5l0ItipRL6wLgLqpvPdOhVRNOiROtGsgSFV+s+csOBzB6CxLP1aSzeS0Wvv8a+qAg787mw/sl1lrO0/nEQiy8XHWKhNUF2i3TAz7lLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863795; c=relaxed/simple;
	bh=SSdY54tXHre/GQL5iZz/9OlGRSnxwnraP2YK6DhXyAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aM2ObDO5fiUKxeevSF+OAuLG2DOrZD463Z7AQTDGxSFSO02v9QQsVL6GXNd373VUeLo0FW8883bBWhmthoyGnDIsS6OULNW5se/1ZGsgigoT140U+OTcv+RdfXUqABvcou4EJxbDxnkyCCXbyErRU2skvC9MgGAUrGUxg0W8n64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ85JqQG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ85JqQG"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fb6d38f7so14694331fa.3
        for <ofono@lists.linux.dev>; Thu, 08 Jan 2026 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863783; x=1768468583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jm4GooFtETQEluRqOsRlhTUYZtGeoNlQopJukF7Ilc=;
        b=UJ85JqQGj0eiCNkY6/2wAG6fO3LJHajYeHKeMYklm6uXAAQ4f+TGqKMz5lsLeW89LN
         RHBBx6sO3+zIgIvOLdp7j6bKnSE68utJedhknVapjahWC/HFcCHIKn5ohVCFsuKxwjMS
         02bNF3dXm3dV7ECtyUwv+cUzZGYAyJABsAD4Zc6UhUv5koSKVKZLYZBk0l+b7TZOITt5
         P9r+RBy7sUFkJtmgyzirisdNf3H6MwTzV56iO/LxWwh8RMrDyKfVilFq4p7WFNSMxqme
         VOWOGnYkmNVSPuY+MiQCisYcZ7dNqkloqnHYkXLp98nzucWAkCSZqUEAOX/cYOy1HMoi
         Pt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863783; x=1768468583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Jm4GooFtETQEluRqOsRlhTUYZtGeoNlQopJukF7Ilc=;
        b=S/SXtsl+GqYtjue0Dx7hZ5exZcWYaZU1GUNqjvkG2r5E/BwP0UWKFyhn1qQ6sqdMmE
         9hxSa7JSTM8FCECcTq17/SfR0THqJAlDZx1V7yipJIEVYLxJ/VcJprChLt3cuBLEv5mD
         Aimi+4V7ThjciH+hLifCPtOP2piklzO6PG20sPrOzCE3Gqx2buucqK1/kMFbzS5wkfLy
         byTfm3WXYxLuBMscs9nGaPl8L8NJYbNVUwUU9NnOecmtz2j1IRJgl8J2ohQ+ughZuia2
         cYHb6aAbAg8dD/Cez6k/ydfapiop5C7fQcHS6PzDP3lhNTsXtIagmN2H1u00CXpuIT9X
         9jNA==
X-Gm-Message-State: AOJu0YwK6EbwCzEWfWuCpsxCdaiiweNzoxgrP6QCrRcQeh4gZvphI2Ug
	/RsePE9PKLQukUoJX8H4+Lfyxcs+dVPcpDx5evR4+H2up3V/fDbnbCmQiBrI2Q==
X-Gm-Gg: AY/fxX4hOJRO4htbiitc4Gau00+5t02HBnmoGW7RVBtIjOTanq8afMDrLxBCcDnrSl1
	bEiev81nxdpAmfFx/duFiWJ7pPKv1W5S7J6XH7Zg4wLrJgInhhBgrpn6SmctCM8B8dYu4tAnZWX
	YFssQPL5GtANfy7Q4JxPMVLS5ANWRS9sDYT416j6U0j4gKa+cw91htQBIWhTaoD/weIt+Iqafg9
	Tsk9APRWqEw6NuAOzxcEP4Rt0L8Ie2fsRjm94/EWuwTbVQYgjmBg54YsWE7qY3gdXBU30qd5Q3X
	8FQYMLoamlWfAUSDsXN5H/4thbbEejC2H3XyhQtqQTf/PWEUfxqP232khm3JwbBrhnWZhqzuFpa
	dKFMVk6BJ8xQBnCdqGRbRts6sN4sGu5nH77jqG4c8V1qPc2D2TyihtkDpdC7zO1JTPIflcQdC5n
	xcG66xfodlQd9sxvrNMnp1sfvreCi7bB1zZ07IvnXwI03Uxoa37SbezqHIDXHF9qUQPtxgIcey2
	uX9VLZMJa/WgoWNND+0HurG63Xngy2TDHZj0s5PzSOJh53EevzLG4t++XzWIuFZ
X-Google-Smtp-Source: AGHT+IEPrXgTP3eCfSjjjXzWp+nV2ozH7PJfYzjR/QYQYx+RzvIh2WbBrSHYdttlzyCzBbo4w1lJ+Q==
X-Received: by 2002:a05:651c:41c8:b0:382:6067:a230 with SMTP id 38308e7fff4ca-382ff853a4bmr14863731fa.40.1767863783226;
        Thu, 08 Jan 2026 01:16:23 -0800 (PST)
Received: from nucken2.localdomain (h-98-128-204-19.A444.priv.bahnhof.se. [98.128.204.19])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-382eb923eb1sm14215361fa.48.2026.01.08.01.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:16:21 -0800 (PST)
From: "=?UTF-8?q?Richard=20R=C3=B6jfors?=" <richard.rojfors@gmail.com>
X-Google-Original-From: =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard@puffinpack.se>
To: ofono@lists.linux.dev,
	richard@puffinpack.se
Subject: [PATCH] gprs: Signal added for newly auto created contexts
Date: Thu,  8 Jan 2026 10:15:44 +0100
Message-ID: <20260108091556.3818780-1-richard@puffinpack.se>
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

