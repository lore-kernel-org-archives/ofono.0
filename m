Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704604643A
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116588; cv=none; b=W1VBN7YjAhXTZgVs2XKINpKJi4R+HhOQvEASAtwSxlK9l/gMNH61Ds86cy4iS7F/4pjxLgaWy0AS6fMxpVyeL70jJ+ew2aaqGXEs3meubbCBX9UWe1XTrEp7XyM8zvmOMNWq8hz8T7LiVYzBOLLmRCXiotJC9AimzsIDz74Jtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116588; c=relaxed/simple;
	bh=F2kBdDkO9/lifi4hnFgrDevAneXJ6Yj0qswNBRN9guo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezVvwHCwZy9DzOB73RTDGWe+FIrL9ceH2dPREYGxwONp+93kTolIsg6HHL58jlcG/sFMbpblyfc28LTEGTz6bZxL6fpm7xX1XdEWk20DQqv85X47FzBXhcIVNbqneWRbW8Pyf6jhQtgHrdoDRFGoD1itNekIlMn1Yu0G4PhgqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhi8SRDq; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhi8SRDq"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4859178f1so1147013eaf.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116586; x=1711721386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvG8VkNelblegkAJJcYsuUfUkmU7fhzLdvQgv2CLO2g=;
        b=bhi8SRDqnPtPwNxyU/XIw8tHuq0pkPAePgvCvlXPYEplyOCxGFzrCkGpFsw0wBLQw/
         z+hCdTGT5tv+dt7o2ws2vLAQVtnPEYdAlNO8/Md7B8wLWKXRqoMQtEZ73UlawWsLYQZT
         17k6QvBJ79zvR96VwwLBXaWxjOod/AE7Cily5Zx/n2QvXrZTV3HJIBMadfaB6XFnaAOk
         Bb5VtAVr4QkNVNCjwtALIPNJz7/aDQZjIXLO3SQhaIhf8kmAPfKUCbTCQVLkXAruiES9
         F5r4B0p805RWknH3Zew/OQEk0E2hzHML8mjEHaUAXuf82Mgb06qryuDIZjXY8RkzE0Ca
         3pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116586; x=1711721386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvG8VkNelblegkAJJcYsuUfUkmU7fhzLdvQgv2CLO2g=;
        b=UTXL8kAGJ95ZPEY3A76SebQII7pnEtFjC3dolIptjlX1pwdq9yNnEfwBE0PuKZEtBc
         itwm0pVKtAv09JgIwp1KHhyUjXwL7TeOq4XElNUPzIL5qeApck/Aepde4OwO3Amo+j2X
         ke2eXy4Fm+EAaGi3CeHGBiW9LatXntO5tGbA1AVQwL7mnZEyIieBfNuD9zMl2eoZAQy6
         URnWb6YTCbbIykVCwqhdzg3ckOwaTna2mTiMb+fIOkBWkS/FmjOs63wgS+Q/HnSMiFwx
         Z4iQXsAHbpf0or27Fm9g4eIoQIQII5LiNNkUda+1QAIlMSikBbHgeyrJHdFlSCmHFOtp
         Renw==
X-Gm-Message-State: AOJu0YzWivxjw/9NYHsEmziBE9lRwiLfGdhtFgEIt1zSSEG/XpO0EhQk
	aFECbxSofwwyu/Pmc7DjgkPm6eTesTZFVBDXFqbLx81wvhXzCtSmIqXxpzul
X-Google-Smtp-Source: AGHT+IGvFft12ybqyxdX+d3CWD0jDsXj18qD1gBTkScixNCfZzZptaL35LRTmMX3Hg3gEdt0DLqn2Q==
X-Received: by 2002:a05:6820:1e16:b0:5a4:9977:446b with SMTP id dh22-20020a0568201e1600b005a49977446bmr2832662oob.6.1711116586422;
        Fri, 22 Mar 2024 07:09:46 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/11] modem: commonize feature string list generation
Date: Fri, 22 Mar 2024 09:09:03 -0500
Message-ID: <20240322140942.2703042-2-denkenz@gmail.com>
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

