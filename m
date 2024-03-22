Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80D50A88
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122160; cv=none; b=H0cBUC2HNpmc47GCmmOV1o2sPtHsyIZLNgRiR7BOEuBTstsSBUfvmgbgHOdRSxENfOVdSgzIDrEHGGwIYyobLI9kL6znb6Xkaz5GPaMa+oAyQL4I+acCpPHKCSw0ibPzj+2ni2qzbsi6/F9r0TP6YrBIm3a4vceI/vrHgYzy05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122160; c=relaxed/simple;
	bh=leNypGPphppVvT22hna5vh0O5jb2CwfyLqdlocK+p08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmG4hlzz7ZlVfo08ydOvUquRajBnW3wUFOlvtpED00r1BrRmRaU8wplIzKX7SvhurcmGspKzlBrcNzRxUKKO+MnyFrsYSB5S8xgivi/DlGC3m+j4VLMmcWmU0TUiOUopX2yxi8yiDNa/1AYRB9XQcZawnJWaJ5Mou9uS4+J/U7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN1UBuAh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN1UBuAh"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6b582d266so747228a34.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122158; x=1711726958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abiA7JPT86Q2mYUz0MSoC4cJmAibaQeXB6pHarWLsfg=;
        b=GN1UBuAhyQZIG+yndvY/o+b3TjE9jg+mwFpnxMyNJLym3t0+qvYQ+nhzsumDo0rigf
         erbJHfY9f3J9UTMhU3Msxd45g1Cam6cITRDHY12Gn3OTucB7wqE8gvJUMztaklXFSUtd
         G2dCRl6sLh8oVuKZgGT3gwS4HsLnN7sEqGHTquvKvFUTt/pxWKWE7z1EmoqdrVFTZt5N
         7qxcSFHn6czTGzq11/m7mMtPOEWDJRXK8fOSyQNvH9rnBz65WKbzVj+j52EChnBuPgTm
         pHwAio0azsxZjMOLp+ynTUQokAaeU53zUS59O2XsxQ0uEPXvb84bWIss9oW4pcInjyLh
         u1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122158; x=1711726958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abiA7JPT86Q2mYUz0MSoC4cJmAibaQeXB6pHarWLsfg=;
        b=Eqc6gnz6FlxbunWdpndNj3afhQkBxpz/5uxax3yTe389Nph80JVft97VcENuQknFWQ
         K5Il/z52WpKHZxF6DterlW46eb6sjNypO1igsgKWZ6HSPI9TOQaSy3gALFGeE6ahh17d
         DtAs+o4wr0ClVaJQ+cousxLbL+7QWv6k831m7x+FdoZlPbVbKkOWBj11AHMGj2QxyF4r
         xFAfnPtVSurdlMEXp7PbZNKGBhGiulmN7jzCv34oIQuAxYR2QmQ6bA3F3gQjs/4HIp+0
         D1qw0EavfjxwIc+zZ5vgmwjc0okjdsP2bEwWbCdBn/gsK6HI5L/oVMQK2+AR3SWz5DCE
         4VUQ==
X-Gm-Message-State: AOJu0YyJjnsLhWawg1QqUVGe/omES+iLURhQtv+RTPBbGzz4/paw/FWw
	d3awx0f55hgzwCyUcmjywTQXD9sEhXCD21bB7CPP568DXJ7xjppUSmsNyrgB
X-Google-Smtp-Source: AGHT+IENcvVHf2EKks133VESTzITvGrk1jNDdS3GN3aYaAaTNpcpGHCRALxcJVEhbESwDuVk7pmzow==
X-Received: by 2002:a05:6830:22d9:b0:6e6:9a77:62b5 with SMTP id q25-20020a05683022d900b006e69a7762b5mr17621otc.9.1711122158326;
        Fri, 22 Mar 2024 08:42:38 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/11] modem: commonize interface string list generation
Date: Fri, 22 Mar 2024 10:42:16 -0500
Message-ID: <20240322154234.2720542-3-denkenz@gmail.com>
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
 src/modem.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 37d9bd57fdd9..24ab61761325 100644
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
@@ -883,12 +894,10 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 		ofono_dbus_dict_append(dict, "SystemPath", DBUS_TYPE_STRING,
 					&system_path);
 
-	interfaces = g_new0(char *, g_slist_length(modem->interface_list) + 1);
-	for (i = 0, l = modem->interface_list; l; l = l->next, i++)
-		interfaces[i] = l->data;
+	interfaces = get_interfaces(modem);
 	ofono_dbus_dict_append_array(dict, "Interfaces", DBUS_TYPE_STRING,
 					&interfaces);
-	g_free(interfaces);
+	l_free(interfaces);
 
 	features = get_features(modem);
 	ofono_dbus_dict_append_array(dict, "Features", DBUS_TYPE_STRING,
@@ -1301,17 +1310,13 @@ static gboolean trigger_interface_update(void *data)
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
 						&interfaces);
-	g_free(interfaces);
+	l_free(interfaces);
 
 	features = get_features(modem);
 	ofono_dbus_signal_array_property_changed(conn, modem->path,
-- 
2.43.0

