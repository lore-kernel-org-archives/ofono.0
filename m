Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E08145322
	for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048000; cv=none; b=hFjWNFNYobHaeadWERK5mJ844vqqVE/qxSfPNKI19bOqadtpVw4VA7Zm8yOMjubV4wKhuOzMMV9cSWke2eawjjUJxOqondcMiHOtfZuswf0MHbf8vZ8nP+MJIokwNc/kT9tNSmhqGrJdkq5hfAyx2WhHYRNRj8NrZwroI6b6TCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048000; c=relaxed/simple;
	bh=DRA7WCeACunwey7CTSjf/QqLa3Uiu85qeTkzynlBnN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNwO10xLi/mdgK76okSgy5mbbylei4FjcgrtBngtNuJeYdGYQJI3PliLLa5tiCJvqURe5am86xbs28EOivtNGfViHcO7PtBdvxRAUgh1Ihs3A0kXjKKyxPuGZ5Tw50W0m+Aytbt4y2+tZuBqqOG5NT87fpHo+KVo55ScITHsY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4JzsR36; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4JzsR36"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e45ef83c54so2753168a34.2
        for <ofono@lists.linux.dev>; Tue, 27 Feb 2024 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709047998; x=1709652798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNrf8JKJhvobJUbzR1kSVecV5eVWf0NyYhIAWjYX6a4=;
        b=Y4JzsR369jA09Zws6kA+s3y+FdjMZpNqfUAEDAPEd/YtuZ7zloX2mVM9AuGYLiUAY9
         062vQGYTU6EPf1CAvvfvZuqMUwHXrnygF6p6hne6kND43g6vsc+ihwG2grGe8QJt9bjN
         bOhG+tLP9fQNcJhoLgqWKfBCsNlm7vBkDUwHKRRyUD9cJnFGechYE0OCIPoOIXLOqykr
         F+dH4ttdeHcb9m68oyGKRpYPKBL/e4PbaBSptRv396JCSbbol4hJJTi/lyAvErDeRKVf
         ElqrxA3n8KGGaUKGCAOLViKr6hJl6YV/HupbGM/92msu9P9ApqUDLCWgz80Z4e9YOb5l
         Xggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047998; x=1709652798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNrf8JKJhvobJUbzR1kSVecV5eVWf0NyYhIAWjYX6a4=;
        b=BOSt56Y8qiXELv/Fyu/bvoUiI2fC3vZCVpdyn5juO6Pl7uEVTskfZpZ4WhF2tkFUdg
         /tznHSutIMwGc6F3iJd1uNie8YEbs8bM7z+FDCVPf0cYgsE38mkNeC6V7RirOiCVol2k
         smrhGlJrd/2yVxahU3ic/fsXQX7O9lxnY5C5FYgAjfVmWraWJ0kHaHLsc3kTPlzmHxjq
         fyJUTYEDN5X62tDKO5irTkiVAWO6opYPmKLZuJ15MKKIFzIBZcWoH3ykTEOFC6bo8npD
         UDRv5/coX+o5PgjI/9B3K8+y6Cx4G+DQXpT66m6PMc3Vy8W4zVtPgWB6B2YdtwjKfSnV
         8R7w==
X-Gm-Message-State: AOJu0Yyi2Cse3WLMpdv/ST8wmwqUQl6tuEgAmchVNzTHSjpSC63dgFd9
	8bgkxHc1qUzkCxwDDWEAbla/YMeWREU6Qr1fMxksfUMcusiZlzvB/AVShlsr
X-Google-Smtp-Source: AGHT+IGVJVL/I/MYXIz+SvdP/9JOUiswxdfWUojmrsT2xzPEaIcTF8YKY5QdYO5RX9+QUrFtakhO5A==
X-Received: by 2002:a9d:3e51:0:b0:6e4:aa2b:5475 with SMTP id h17-20020a9d3e51000000b006e4aa2b5475mr2675900otg.0.1709047998055;
        Tue, 27 Feb 2024 07:33:18 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l13-20020a9d6a8d000000b006e477a4207fsm1538589otq.54.2024.02.27.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:33:17 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/3] voicecall: Fix use after free
Date: Tue, 27 Feb 2024 09:33:03 -0600
Message-ID: <20240227153314.1469536-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227153314.1469536-1-denkenz@gmail.com>
References: <20240227153314.1469536-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If voicecall_dbus_register is not successful, it will invoke
voicecall_destroy, which frees the voicecall and associated data.  Make
sure to return early if this happens.

While here, convert g_memdup2 and g_try_new0 use to ell.
---
 src/voicecall.c | 70 +++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index f979c46fe132..4ce161b54600 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -671,11 +671,7 @@ static const GDBusSignalTable voicecall_signals[] = {
 static struct voicecall *voicecall_create(struct ofono_voicecall *vc,
 						struct ofono_call *call)
 {
-	struct voicecall *v;
-
-	v = g_try_new0(struct voicecall, 1);
-	if (v == NULL)
-		return NULL;
+	struct voicecall *v = l_new(struct voicecall, 1);
 
 	v->call = call;
 	v->vc = vc;
@@ -687,10 +683,10 @@ static void voicecall_destroy(gpointer userdata)
 {
 	struct voicecall *voicecall = (struct voicecall *)userdata;
 
-	g_free(voicecall->call);
+	l_free(voicecall->call);
 	l_free(voicecall->message);
 
-	g_free(voicecall);
+	l_free(voicecall);
 }
 
 static const char *voicecall_build_path(struct ofono_voicecall *vc,
@@ -1051,13 +1047,13 @@ static void voicecall_set_call_name(struct voicecall *v,
 						DBUS_TYPE_STRING, &name_str);
 }
 
-static gboolean voicecall_dbus_register(struct voicecall *v)
+static bool voicecall_dbus_register(struct voicecall *v)
 {
 	DBusConnection *conn = ofono_dbus_get_connection();
 	const char *path;
 
 	if (v == NULL)
-		return FALSE;
+		return false;
 
 	path = voicecall_build_path(v->vc, v->call);
 
@@ -1068,10 +1064,10 @@ static gboolean voicecall_dbus_register(struct voicecall *v)
 		ofono_error("Could not register VoiceCall %s", path);
 		voicecall_destroy(v);
 
-		return FALSE;
+		return false;
 	}
 
-	return TRUE;
+	return true;
 }
 
 static gboolean voicecall_dbus_unregister(struct ofono_voicecall *vc,
@@ -1357,20 +1353,16 @@ static struct voicecall *synthesize_outgoing_call(struct ofono_voicecall *vc,
 	struct ofono_modem *modem = __ofono_atom_get_modem(vc->atom);
 	struct ofono_call *call;
 	struct voicecall *v;
+	unsigned int id;
 
-	call = g_try_new0(struct ofono_call, 1);
-	if (call == NULL)
-		return NULL;
-
-	call->id = __ofono_modem_callid_next(modem);
-
-	if (call->id == 0) {
+	id = __ofono_modem_callid_next(modem);
+	if (!id) {
 		ofono_error("Failed to alloc callid, too many calls");
-		g_free(call);
 		return NULL;
 	}
 
-	__ofono_modem_callid_hold(modem, call->id);
+	call = l_new(struct ofono_call, 1);
+	call->id = id;
 
 	if (number)
 		string_to_phone_number(number, &call->phone_number);
@@ -1380,16 +1372,15 @@ static struct voicecall *synthesize_outgoing_call(struct ofono_voicecall *vc,
 	call->clip_validity = CLIP_VALIDITY_VALID;
 
 	v = voicecall_create(vc, call);
-	if (v == NULL) {
-		g_free(call);
-		return NULL;
-	}
-
 	v->detect_time = time(NULL);
 
 	DBG("Registering new call: %d", call->id);
-	voicecall_dbus_register(v);
+	if (!voicecall_dbus_register(v)) {
+		ofono_error("Unable to register synthetic voice call");
+		return NULL;
+	}
 
+	__ofono_modem_callid_hold(modem, call->id);
 	vc->call_list = g_slist_insert_sorted(vc->call_list, v, call_compare);
 
 	return v;
@@ -2384,7 +2375,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *vc,
 {
 	struct ofono_modem *modem = __ofono_atom_get_modem(vc->atom);
 	GSList *l;
-	struct voicecall *v = NULL;
+	struct voicecall *v;
 	struct ofono_call *newcall;
 
 	DBG("Got a voicecall event, status: %s (%d), id: %u, number: %s"
@@ -2410,19 +2401,8 @@ void ofono_voicecall_notify(struct ofono_voicecall *vc,
 
 	DBG("Did not find a call with id: %d", call->id);
 
-	__ofono_modem_callid_hold(modem, call->id);
-
-	newcall = g_memdup2(call, sizeof(struct ofono_call));
-	if (newcall == NULL) {
-		ofono_error("Unable to allocate call");
-		goto error;
-	}
-
+	newcall = l_memdup(call, sizeof(struct ofono_call));
 	v = voicecall_create(vc, newcall);
-	if (v == NULL) {
-		ofono_error("Unable to allocate voicecall_data");
-		goto error;
-	}
 
 	if (vc->flags & VOICECALL_FLAG_STK_MODEM_CALLSETUP) {
 		struct dial_request *req = vc->dial_req;
@@ -2460,21 +2440,13 @@ void ofono_voicecall_notify(struct ofono_voicecall *vc,
 
 	if (!voicecall_dbus_register(v)) {
 		ofono_error("Unable to register voice call");
-		goto error;
+		return;
 	}
 
+	__ofono_modem_callid_hold(modem, call->id);
 	vc->call_list = g_slist_insert_sorted(vc->call_list, v, call_compare);
 
 	voicecalls_emit_call_added(vc, v);
-
-	return;
-
-error:
-	if (newcall)
-		g_free(newcall);
-
-	if (v)
-		g_free(v);
 }
 
 void ofono_voicecall_mpty_hint(struct ofono_voicecall *vc, unsigned int ids)
-- 
2.43.0

