Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D505156CF
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918661; cv=none; b=NKbvoRs+L7etkR7ctVdcDdAbtHbNcmu6GPRdDE4pgmZPHh9752LFWm64PJLPYwMvWbzJSc6ub8ucSAtD81AuXEkvZhbWuPohiR2U5IhoPjNVUlLjj5yJ77DEi3V6RScipsBmbL6s3dJKb/83OTEz6ew4SjIOr/UFCLjtIqdPMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918661; c=relaxed/simple;
	bh=n7xeE47HaCDAr09gryBE8G9J7FI4XWFCiqgYpPSzg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4okJKBL4Q8NElrJ7vSbCQkepM1No/4IA2rjYqlCoMxGSbkA3yGWRFSWaJ8lY4BJaH1v5lM/bW0sF9SSbfGhhCK/rw8o8QHP1sE4fU/KulR9i7Ig7NCwuNWItLaPJzoqSPNwjdXC7CJr2xcSYm3qpxno2qJcJEs8O9W5b8Yzyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9Sa6N3V; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9Sa6N3V"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbb4806f67so2079219b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918658; x=1709523458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV9GEjtnN5rEYNaT+uj9zxm84SvuBpr7nplYAoj6zKU=;
        b=U9Sa6N3VTtOUnQ2LhSdly2CGE4bHfrvGucmWRUhW5B+p5Wwspt1j26UyXzSCxtJG5w
         k1jcmNtB+QMskyNqwQywTfc7wdktuSFvAmodduQfas9J+o8DCc2V0t4SZjxZFZFOQlUa
         /sf9u9zZ/tP4WL2ghrJx+Pc/Zz1XQ+htUxndT309MfIEvGAH7XBNEM6iFt8wYjP7eQtx
         CO56K5NCJ3CdTuILeE0EZg7rrd47omLMjKStyA6fhwWyLQ0K0UJxDAhaChLe3iOYigS6
         iR1wke3IWPSQ452vYKXvV/4P/PfcQwo17JybUNbuUcAdmw0LRhmQqH54aSks2TkTovAL
         djWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918658; x=1709523458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV9GEjtnN5rEYNaT+uj9zxm84SvuBpr7nplYAoj6zKU=;
        b=Ud2Fm2ePgn6v6P+YwtIJ5iJeeESNCde+AU5Hfk9Qbfz5A0uYsKCPrk/sbF9tx3JYtK
         FOsRurmgd0YGMHjPNaFmOaFvHO0D8HN+V0QHjzLn5pTTPAEJZ53oFPjWO8xHdhUGQ64P
         e7x8yRlYgVjouBAqPfSPGsJyUj5p7mjzM00s5q5d1kZQNIsgBqGYRc5i3NlBgysxAdrU
         BoqfDYkvR5psS0PwNgOH+tEnLk319HlQKcnZGvxXALxe0GkwbVK3eTEEebhkYBoa1fQV
         glPwmd0qNJZE3uosb5iXhFpDvEpOhmhC2rWBA1IkOS1D54rs45xhysQ/cIDs3jQJ5tUW
         bTrw==
X-Gm-Message-State: AOJu0Yyng9BouK0PA8FtjQ+FgotVEIdLCPDF1xnKzSMRiTXwnUZyHHBL
	ccgdpbcaYSrxu4ClG1chNJvHjsa4+Z2al2acKPR32gG7Rz2swk8BM+o6IQ+V
X-Google-Smtp-Source: AGHT+IFjgl2JtabY2aMQtmfz4laLpcE3S/HPmkBP0K6q09U+1vsvdMirYjKZPsxLR+fEcvrNEkzqaw==
X-Received: by 2002:a05:6808:238b:b0:3c0:45ff:9614 with SMTP id bp11-20020a056808238b00b003c045ff9614mr7162632oib.7.1708918658457;
        Sun, 25 Feb 2024 19:37:38 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:38 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 19/22] gprs: Drop use of g_strdup
Date: Sun, 25 Feb 2024 21:37:02 -0600
Message-ID: <20240226033724.1460079-19-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strdup
---
 src/gprs.c | 74 +++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index ae0d5ae8a387..9b5b5b16464d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -325,19 +325,19 @@ static struct pri_context *gprs_context_by_path(struct ofono_gprs *gprs,
 static void context_settings_free(struct context_settings *settings)
 {
 	if (settings->ipv4) {
-		g_free(settings->ipv4->ip);
-		g_free(settings->ipv4->netmask);
-		g_free(settings->ipv4->gateway);
+		l_free(settings->ipv4->ip);
+		l_free(settings->ipv4->netmask);
+		l_free(settings->ipv4->gateway);
 		l_strfreev(settings->ipv4->dns);
-		g_free(settings->ipv4->proxy);
+		l_free(settings->ipv4->proxy);
 
 		g_free(settings->ipv4);
 		settings->ipv4 = NULL;
 	}
 
 	if (settings->ipv6) {
-		g_free(settings->ipv6->ip);
-		g_free(settings->ipv6->gateway);
+		l_free(settings->ipv6->ip);
+		l_free(settings->ipv6->gateway);
 		l_strfreev(settings->ipv6->dns);
 
 		g_free(settings->ipv6);
@@ -544,7 +544,7 @@ static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
 {
 	char *scheme, *host, *port, *path;
 
-	scheme = g_strdup(proxy);
+	scheme = l_strdup(proxy);
 	if (scheme == NULL)
 		return;
 
@@ -558,7 +558,7 @@ static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
 		else if (strcasecmp(scheme, "http") == 0)
 			ctx->proxy_port = 80;
 		else {
-			g_free(scheme);
+			l_free(scheme);
 			return;
 		}
 	} else {
@@ -581,10 +581,10 @@ static void pri_parse_proxy(struct pri_context *ctx, const char *proxy)
 		}
 	}
 
-	g_free(ctx->proxy_host);
-	ctx->proxy_host = g_strdup(host);
+	l_free(ctx->proxy_host);
+	ctx->proxy_host = l_strdup(host);
 
-	g_free(scheme);
+	l_free(scheme);
 }
 
 static void pri_ifupdown(const char *interface, ofono_bool_t active)
@@ -727,7 +727,7 @@ static void pri_reset_context_settings(struct pri_context *ctx)
 	if (ctx->type == OFONO_GPRS_CONTEXT_TYPE_MMS) {
 		pri_set_ipv4_addr(interface, NULL);
 
-		g_free(ctx->proxy_host);
+		l_free(ctx->proxy_host);
 		ctx->proxy_host = NULL;
 		ctx->proxy_port = 0;
 	}
@@ -740,7 +740,7 @@ static void pri_update_mms_context_settings(struct pri_context *ctx)
 	struct ofono_gprs_context *gc = ctx->context_driver;
 	struct context_settings *settings = gc->settings;
 
-	settings->ipv4->proxy = g_strdup(ctx->message_proxy);
+	settings->ipv4->proxy = l_strdup(ctx->message_proxy);
 	pri_parse_proxy(ctx, ctx->message_proxy);
 
 	DBG("proxy %s port %u", ctx->proxy_host, ctx->proxy_port);
@@ -1410,8 +1410,8 @@ static void pri_context_destroy(gpointer userdata)
 {
 	struct pri_context *ctx = userdata;
 
-	g_free(ctx->proxy_host);
-	g_free(ctx->path);
+	l_free(ctx->proxy_host);
+	l_free(ctx->path);
 	g_free(ctx);
 }
 
@@ -1436,7 +1436,7 @@ static gboolean context_dbus_register(struct pri_context *ctx)
 		return FALSE;
 	}
 
-	ctx->path = g_strdup(path);
+	ctx->path = l_strdup(path);
 	ctx->key = ctx->path + strlen(basepath) + 1;
 
 	return TRUE;
@@ -2193,7 +2193,7 @@ static void gprs_deactivate_for_remove(const struct ofono_error *error,
 	}
 
 	/* Make a backup copy of path for signal emission below */
-	path = g_strdup(ctx->path);
+	path = l_strdup(ctx->path);
 
 	context_dbus_unregister(ctx);
 	gprs->contexts = g_slist_remove(gprs->contexts, ctx);
@@ -2205,7 +2205,7 @@ static void gprs_deactivate_for_remove(const struct ofono_error *error,
 	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
 				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
-	g_free(path);
+	l_free(path);
 }
 
 static DBusMessage *gprs_remove_context(DBusConnection *conn,
@@ -2502,7 +2502,7 @@ static void remove_non_active_context(struct ofono_gprs *gprs,
 	}
 
 	/* Make a backup copy of path for signal emission below */
-	path = g_strdup(ctx->path);
+	path = l_strdup(ctx->path);
 
 	context_dbus_unregister(ctx);
 	gprs->contexts = g_slist_remove(gprs->contexts, ctx);
@@ -2511,7 +2511,7 @@ static void remove_non_active_context(struct ofono_gprs *gprs,
 	g_dbus_emit_signal(conn, atompath, OFONO_CONNECTION_MANAGER_INTERFACE,
 				"ContextRemoved", DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
-	g_free(path);
+	l_free(path);
 }
 
 static DBusMessage *gprs_reset_contexts(DBusConnection *conn,
@@ -2816,7 +2816,7 @@ static void gprs_context_remove(struct ofono_atom *atom)
 	if (gc->driver && gc->driver->remove)
 		gc->driver->remove(gc);
 
-	g_free(gc->interface);
+	l_free(gc->interface);
 	g_free(gc);
 }
 
@@ -2869,8 +2869,8 @@ const char *ofono_gprs_context_get_interface(struct ofono_gprs_context *gc)
 void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
 					const char *interface)
 {
-	g_free(gc->interface);
-	gc->interface = g_strdup(interface);
+	l_free(gc->interface);
+	gc->interface = l_strdup(interface);
 }
 
 void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
@@ -2882,8 +2882,8 @@ void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
 	if (settings->ipv4 == NULL)
 		return;
 
-	g_free(settings->ipv4->ip);
-	settings->ipv4->ip = g_strdup(address);
+	l_free(settings->ipv4->ip);
+	settings->ipv4->ip = l_strdup(address);
 	settings->ipv4->static_ip = static_ip;
 }
 
@@ -2895,8 +2895,8 @@ void ofono_gprs_context_set_ipv4_netmask(struct ofono_gprs_context *gc,
 	if (settings->ipv4 == NULL)
 		return;
 
-	g_free(settings->ipv4->netmask);
-	settings->ipv4->netmask = g_strdup(netmask);
+	l_free(settings->ipv4->netmask);
+	settings->ipv4->netmask = l_strdup(netmask);
 }
 
 void ofono_gprs_context_set_ipv4_prefix_length(struct ofono_gprs_context *gc,
@@ -2909,7 +2909,7 @@ void ofono_gprs_context_set_ipv4_prefix_length(struct ofono_gprs_context *gc,
 	if (settings->ipv4 == NULL)
 		return;
 
-	g_free(settings->ipv4->netmask);
+	l_free(settings->ipv4->netmask);
 
 	memset(&ipv4, 0, sizeof(ipv4));
 
@@ -2917,7 +2917,7 @@ void ofono_gprs_context_set_ipv4_prefix_length(struct ofono_gprs_context *gc,
 		ipv4.s_addr = htonl(~((1 << (32 - length)) - 1));
 
 	inet_ntop(AF_INET, &ipv4, buf, sizeof(buf));
-	settings->ipv4->netmask = g_strdup(buf);
+	settings->ipv4->netmask = l_strdup(buf);
 }
 
 void ofono_gprs_context_set_ipv4_gateway(struct ofono_gprs_context *gc,
@@ -2928,8 +2928,8 @@ void ofono_gprs_context_set_ipv4_gateway(struct ofono_gprs_context *gc,
 	if (settings->ipv4 == NULL)
 		return;
 
-	g_free(settings->ipv4->gateway);
-	settings->ipv4->gateway = g_strdup(gateway);
+	l_free(settings->ipv4->gateway);
+	settings->ipv4->gateway = l_strdup(gateway);
 }
 
 void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *gc,
@@ -2952,8 +2952,8 @@ void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
 	if (settings->ipv6 == NULL)
 		return;
 
-	g_free(settings->ipv6->ip);
-	settings->ipv6->ip = g_strdup(address);
+	l_free(settings->ipv6->ip);
+	settings->ipv6->ip = l_strdup(address);
 }
 
 void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context *gc,
@@ -2975,8 +2975,8 @@ void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
 	if (settings->ipv6 == NULL)
 		return;
 
-	g_free(settings->ipv6->gateway);
-	settings->ipv6->gateway = g_strdup(gateway);
+	l_free(settings->ipv6->gateway);
+	settings->ipv6->gateway = l_strdup(gateway);
 }
 
 void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
@@ -2999,7 +2999,7 @@ static void free_contexts(struct ofono_gprs *gprs)
 		storage_close(gprs->imsi, SETTINGS_STORE,
 				gprs->settings, TRUE);
 
-		g_free(gprs->imsi);
+		l_free(gprs->imsi);
 		gprs->imsi = NULL;
 		gprs->settings = NULL;
 	}
@@ -3266,7 +3266,7 @@ static void gprs_load_settings(struct ofono_gprs *gprs, const char *imsi)
 	if (gprs->settings == NULL)
 		return;
 
-	gprs->imsi = g_strdup(imsi);
+	gprs->imsi = l_strdup(imsi);
 
 	error = NULL;
 	gprs->powered = g_key_file_get_boolean(gprs->settings, SETTINGS_GROUP,
-- 
2.43.0

