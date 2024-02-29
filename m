Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964344374
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251025; cv=none; b=d1DZruavshBK9FK/1dJpEEG4U5izj5oHbl2anU6aXu/G9eZZ4QQnxNqrb2j1kk5fboqLkEY2Bw001wX43bpBiIPXwIKSpBjQY1RN9habLQKMOWL5FSpCkzBFQD7XtM9orhg80/OyBrWGSKC0TxgrRv/7QZi0oYlbut6RZwX3y6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251025; c=relaxed/simple;
	bh=Cs5i13xlEPgjfcS6MG9zmuhLJNqoGzoAt0gnvYM2dpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5X5hcEDzi4LsY+5AidTJ4uqMtT110zhsF+PLvASyYDOe2hnQJrP8pKKmYdy7mRb0O+t0GyM03GroaGtr8cIHM+TSbda+q1ZI6QVdOOOFao+VksiRYllIh/9F+1uAZdGO+w7SvvYzuedRYlJgRCLi/EmYrlb2dzq3KzQ2YFJnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtRnXdcw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtRnXdcw"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e4c1d243b4so534996a34.2
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709251023; x=1709855823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRqoGTPmQJ86eYXoX36fi9ACS5FMscO/yGW5TsJMK8o=;
        b=JtRnXdcw0v480Ur05W85JZ4ylxDZhVLUHOPouXHgnP3w3bre7jvpWSOgR77IAu6WD8
         dz0GmRBVak6/d2lCARyNDsKZldAWvejTp1oeXGjH7thWC1pr/eJ8NODqN4+OPQQlkwGZ
         ftbT5Y3z3XEJIAYOm3YOQoiB5qPWeGzcUiHWpOmPJFO2Nj0MzocyQHr8QggejuTzajUV
         7AzuI+PY3JrOMiJ6JMNE1EE9lnO05igFiHFuzKaVnDy7VqxrOBLhw2eyWgy7AOytfDuU
         QVc3/ppK0WV0Cfk+9D7sEm383PNYk2uoTCkbOPCzu5xwi8eoBjts7tfqHkn2gcjo8a4K
         ISZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709251023; x=1709855823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRqoGTPmQJ86eYXoX36fi9ACS5FMscO/yGW5TsJMK8o=;
        b=KX3rmbAeeKlSnrRdmuIrYA1g7C5tyL1VBaUayyJk/+ogvfaMsGqOypattGj+6OhntD
         K7fcNHx0nIaRy6xH98lf1udcR3CXoy165YLdsR7JrnbbpmzjoedjhO08mqY7LDxz7k1j
         NFlmjBYPAYtFCGm0D9rIXXaiQjzfVRXnjMIZPYdvF2AP3MIDCfHU2NUoJw53m5vkiSmJ
         25E0QT3c00+SeLjtbcH83SZCUjLfoQplotDOgUmQ1nuXUTytSUn9yPbOLPbXtZzk2wYC
         bYatdGR1RveiSlgf/TMr3z8pDAT9qoWtLWNnS6B1e18xrYLHckeoX3Ayk/5CijoWOeD6
         nDEg==
X-Gm-Message-State: AOJu0YwF1i3aY4G9lr48I/7VDBDpDWxgezPxpUo0RzhkCAY9kqs4vsj3
	WS3M/8lIZIXHGjryKS0V670Rf8SyZS00+RHPpmuOx84ghMGHzYVxJJ2j6qZ9
X-Google-Smtp-Source: AGHT+IHTo3AvDdGhLImvvA/pasEUG1wSyaYHO+JiTpDvk2CvCUKL6o3CLqGNu8SFg8+lZpHbQ3Y9Qg==
X-Received: by 2002:a9d:62cf:0:b0:6e4:ac86:634a with SMTP id z15-20020a9d62cf000000b006e4ac86634amr175788otk.33.1709251022623;
        Thu, 29 Feb 2024 15:57:02 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830060300b006e4b3c42595sm473924oti.32.2024.02.29.15.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:57:02 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] voicecall: Refactor string_to_phone_number
Date: Thu, 29 Feb 2024 17:56:42 -0600
Message-ID: <20240229235658.1703008-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229235658.1703008-1-denkenz@gmail.com>
References: <20240229235658.1703008-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

string_to_phone_number is used to convert a sanitized phone number
string to struct ofono_phone_number.  An unsafe strcpy is used for the
conversion.  Change string_to_phone_number in two ways:
  - Add a '__' prefix to make it clear that this API is private and care
    must be taken when using it.  In this case, by sanitizing the input
    first
  - Use a safer strcpy version, namely l_strlcpy

While here, add a sanitizing version of string_to_phone_number that can
be used to sanitize and convert the input string in one operation.

Also take the opportunity to convert some of the functions involved from
GLib gboolean type to stdbool.
---
 plugins/smart-messaging.c |  4 ++--
 src/call-forwarding.c     |  4 ++--
 src/common.c              | 41 ++++++++++++++++++++++++++-------------
 src/common.h              | 10 ++++++----
 src/message-waiting.c     |  4 ++--
 src/sim.c                 |  2 +-
 src/sms.c                 |  4 +---
 src/voicecall.c           | 10 +++-------
 8 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index 0c9700d23b48..e7dffbb0508c 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -201,7 +201,7 @@ static DBusMessage *smart_messaging_send_vcard(DBusConnection *conn,
 					&bytes, &len, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 
-	if (valid_phone_number_format(to) == FALSE)
+	if (!valid_phone_number_format(to))
 		return __ofono_error_invalid_format(msg);
 
 	ref = __ofono_sms_get_next_ref(sm->sms);
@@ -243,7 +243,7 @@ static DBusMessage *smart_messaging_send_vcal(DBusConnection *conn,
 					&bytes, &len, DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 
-	if (valid_phone_number_format(to) == FALSE)
+	if (!valid_phone_number_format(to))
 		return __ofono_error_invalid_format(msg);
 
 	ref = __ofono_sms_get_next_ref(sm->sms);
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index d5bf70691b9e..69b587044332 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -794,7 +794,7 @@ static DBusMessage *cf_set_property(DBusConnection *conn, DBusMessage *msg,
 			return __ofono_error_not_available(msg);
 
 		if (number[0] != '\0')
-			string_to_phone_number(number, &ph);
+			__string_to_phone_number(number, &ph);
 
 		timeout = cf_cond_find_timeout(cf->cf_conditions[type], cls);
 
@@ -1206,7 +1206,7 @@ static gboolean cf_ss_control(int type, const char *sc,
 
 	switch (cf->ss_req->ss_type) {
 	case SS_CONTROL_TYPE_REGISTRATION:
-		string_to_phone_number(sia, &ph);
+		__string_to_phone_number(sia, &ph);
 		cf->driver->registration(cf, cf_type, cls, &ph, timeout,
 					cf_ss_control_callback, cf);
 		break;
diff --git a/src/common.c b/src/common.c
index aff356da3330..57b04424b9f2 100644
--- a/src/common.c
+++ b/src/common.c
@@ -236,23 +236,27 @@ struct error_entry ceer_errors[] = {
 	{ 127,	"Interworking, unspecified" },
 };
 
-gboolean valid_number_format(const char *number, int length)
+bool valid_number_format(const char *number, size_t length)
 {
-	int len = strlen(number);
-	int begin = 0;
-	int i;
+	size_t len;
+	size_t begin = 0;
+	size_t i;
+
+	if (!number)
+		return false;
 
+	len = strlen(number);
 	if (!len)
-		return FALSE;
+		return false;
 
 	if (number[0] == '+')
 		begin = 1;
 
 	if (begin == len)
-		return FALSE;
+		return false;
 
 	if ((len - begin) > length)
-		return FALSE;
+		return false;
 
 	for (i = begin; i < len; i++) {
 		if (number[i] >= '0' && number[i] <= '9')
@@ -261,10 +265,10 @@ gboolean valid_number_format(const char *number, int length)
 		if (number[i] == '*' || number[i] == '#')
 			continue;
 
-		return FALSE;
+		return false;
 	}
 
-	return TRUE;
+	return true;
 }
 
 /*
@@ -273,12 +277,12 @@ gboolean valid_number_format(const char *number, int length)
  * Destination address, or EFADN (Abbreviated dialling numbers),
  * are up 20 digits.
  */
-gboolean valid_phone_number_format(const char *number)
+bool valid_phone_number_format(const char *number)
 {
 	return valid_number_format(number, 20);
 }
 
-gboolean valid_long_phone_number_format(const char *number)
+bool valid_long_phone_number_format(const char *number)
 {
 	return valid_number_format(number, OFONO_MAX_PHONE_NUMBER_LENGTH);
 }
@@ -415,17 +419,26 @@ const char *phone_number_to_string(const struct ofono_phone_number *ph)
 	return buffer;
 }
 
-void string_to_phone_number(const char *str, struct ofono_phone_number *ph)
+void __string_to_phone_number(const char *str, struct ofono_phone_number *ph)
 {
 	if (str[0] == '+') {
-		strcpy(ph->number, str+1);
+		l_strlcpy(ph->number, str + 1, sizeof(ph->number));
 		ph->type = 145;	/* International */
 	} else {
-		strcpy(ph->number, str);
+		l_strlcpy(ph->number, str, sizeof(ph->number));
 		ph->type = 129;	/* Local */
 	}
 }
 
+int string_to_phone_number(const char *str, struct ofono_phone_number *ph)
+{
+	if (!valid_phone_number_format(str))
+		return -EINVAL;
+
+	__string_to_phone_number(str, ph);
+	return 0;
+}
+
 gboolean valid_ussd_string(const char *str, gboolean call_in_progress)
 {
 	int len = strlen(str);
diff --git a/src/common.h b/src/common.h
index bfbf2cff0437..cede20d1de32 100644
--- a/src/common.h
+++ b/src/common.h
@@ -159,11 +159,13 @@ enum context_status {
 
 const char *telephony_error_to_str(const struct ofono_error *error);
 
-gboolean valid_number_format(const char *number, int length);
-gboolean valid_phone_number_format(const char *number);
-gboolean valid_long_phone_number_format(const char *number);
+bool valid_number_format(const char *number, size_t length);
+bool valid_phone_number_format(const char *number);
+bool valid_long_phone_number_format(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
-void string_to_phone_number(const char *str, struct ofono_phone_number *ph);
+
+void __string_to_phone_number(const char *str, struct ofono_phone_number *ph);
+int string_to_phone_number(const char *str, struct ofono_phone_number *ph);
 
 int mmi_service_code_to_bearer_class(int code);
 
diff --git a/src/message-waiting.c b/src/message-waiting.c
index 6115d495f5dd..7a3b2d8932d2 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -199,7 +199,7 @@ static DBusMessage *set_cphs_mbdn(struct ofono_message_waiting *mw,
 
 	req->mw = mw;
 	req->mailbox = mailbox;
-	string_to_phone_number(number, &req->number);
+	__string_to_phone_number(number, &req->number);
 	req->cphs = TRUE;
 
 	sim_adn_build(efmbdn, req->mw->ef_cphs_mbdn_length,
@@ -298,7 +298,7 @@ static DBusMessage *set_mbdn(struct ofono_message_waiting *mw, int mailbox,
 
 	req->mw = mw;
 	req->mailbox = mailbox;
-	string_to_phone_number(number, &req->number);
+	__string_to_phone_number(number, &req->number);
 	req->cphs = FALSE;
 
 	sim_adn_build(efmbdn, req->mw->efmbdn_length, &req->number, NULL);
diff --git a/src/sim.c b/src/sim.c
index 137441d2a127..8a97e87612d9 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -748,7 +748,7 @@ static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *msg,
 				goto error;
 
 			own = g_new0(struct ofono_phone_number, 1);
-			string_to_phone_number(value, own);
+			__string_to_phone_number(value, own);
 
 			own_numbers = g_slist_prepend(own_numbers, own);
 
diff --git a/src/sms.c b/src/sms.c
index 2fc91f9e2162..2b440c59fec0 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -552,15 +552,13 @@ static DBusMessage *sms_set_property(DBusConnection *conn, DBusMessage *msg,
 
 		dbus_message_iter_get_basic(&var, &value);
 
-		if (strlen(value) == 0 || !valid_phone_number_format(value))
+		if (string_to_phone_number(value, &sca) < 0)
 			return __ofono_error_invalid_format(msg);
 
 		if (sms->driver->sca_set == NULL ||
 				sms->driver->sca_query == NULL)
 			return __ofono_error_not_implemented(msg);
 
-		string_to_phone_number(value, &sca);
-
 		sms->pending = dbus_message_ref(msg);
 
 		sms->driver->sca_set(sms, &sca, sca_set_callback, sms);
diff --git a/src/voicecall.c b/src/voicecall.c
index 1bf96ee179b4..d9f3dd82f0e6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -499,7 +499,6 @@ static DBusMessage *voicecall_deflect(DBusConnection *conn,
 	struct voicecall *v = data;
 	struct ofono_voicecall *vc = v->vc;
 	struct ofono_call *call = v->call;
-
 	struct ofono_phone_number ph;
 	const char *number;
 
@@ -517,13 +516,10 @@ static DBusMessage *voicecall_deflect(DBusConnection *conn,
 					DBUS_TYPE_INVALID) == FALSE)
 		return __ofono_error_invalid_args(msg);
 
-	if (!valid_phone_number_format(number))
+	if (string_to_phone_number(number, &ph) < 0)
 		return __ofono_error_invalid_format(msg);
 
 	vc->pending = dbus_message_ref(msg);
-
-	string_to_phone_number(number, &ph);
-
 	vc->driver->deflect(vc, &ph, generic_callback, vc);
 
 	return NULL;
@@ -1368,7 +1364,7 @@ static struct voicecall *synthesize_outgoing_call(struct ofono_voicecall *vc,
 	call->id = id;
 
 	if (number)
-		string_to_phone_number(number, &call->phone_number);
+		__string_to_phone_number(number, &call->phone_number);
 
 	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
 	call->status = CALL_STATUS_DIALING;
@@ -1511,7 +1507,7 @@ static int voicecall_dial(struct ofono_voicecall *vc, const char *number,
 	if (is_emergency_number(vc, number) == TRUE)
 		__ofono_modem_inc_emergency_mode(modem);
 
-	string_to_phone_number(number, &ph);
+	__string_to_phone_number(number, &ph);
 
 	if (vc->settings) {
 		g_key_file_set_string(vc->settings, SETTINGS_GROUP,
-- 
2.43.0

