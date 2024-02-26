Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAC14A85
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918659; cv=none; b=PTJNCEkJV4W1Mxc4frq/Q87FJUiE/A7/P+TrLJKouzDyb0V87Rbl8+qlDZrMW+h4G8cveEADpb7L36NCigA/PBHSkMu/uG5Pv++r4sq9yGVHdZZLvCwRWnQmHbBz2fzyW6Xuil3X8pNOOfRnWNJbwvirboR/eCO0WTwYKPUpTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918659; c=relaxed/simple;
	bh=2yn8lHT0yCW6AzzK8uZmtOpxGhAlY6jY1KJ657clvOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCaqYl3hYGBtRWTNn/2hqALtBnubQvPM+Wpo0G0HfGsjnlQ2Wpv8q3QZ3ptS+1bCA5BPUu74yfyc3u7ihve9jb9nY7fjF9uOHdEpur2ChVNWUcUi0t5WQRh5BteSVruCJuiH4Ux6Vql6KXNzQww0Rmj+L/Zm7G+w282vQVk07pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtKpBnb; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtKpBnb"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c0485fc8b8so1972012b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918657; x=1709523457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leh0DaqTdtkPfQXhaVyfFOJS6w0uROAGx+5ANr8wiN8=;
        b=RCtKpBnb4Luzk5mDQuQrGjdpXOCiXO1XIGn3T8JlcWE9QJozbPexi2wFrUCr7v/ku8
         CvYbm9qa2QNLDGHouOy5MZ08/OQSeHl2dXt0oR9kOSQH/edh/npkF7MEQ6sJMTSNKvNJ
         R09Bk4ANI2YK0GsjblNf1efmaAQVFTfs5FCv4mdamN0+u6z2hw+O8K1IrZa5l7cudb5C
         VNBGzzte4hKQENC/rXK8IzBk5Nulp+1pMFzBGjOOY2dD135G2/E8lFYWwpIH4d7WWfRw
         XMQW4yVfgBvoBTMpe/QiP0NamBWyWq23t6lMFJYN6beIF4mPSr/fybSVVBWl0pk2qmB4
         32sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918657; x=1709523457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leh0DaqTdtkPfQXhaVyfFOJS6w0uROAGx+5ANr8wiN8=;
        b=vtKtPdBtQSSWMQBO3+g7U3T/JYi4+xoyGqvcfVlIhpLeNs6PA+JhNqYvrBa7ef5Aru
         m03zDf3iA2IDIF2w+g47FHeJxmSoSUTfSCQxFg0+9kJWuPj9HaR78z+xrkOT1mICEOdI
         uZvxbdSSAd34Xsb5PtRjXoaXn/rv+zNjShh5XxUq1Hh6AUlErF2uoFQODE/xH6iof3OT
         nP+3YPR7bkJF2PWk9zhDmQSMAzOenbRvPsWVhwWTJgXdT1zEvJIL3XNAlZOzNAsTb06u
         BMqgpUQHMd5sTRqUkE0q+TsjRlFnLNSQQytwoTcYixRyNaJQ/AkCSswJklm9PLsob3rX
         C6BQ==
X-Gm-Message-State: AOJu0YwY7SxjmZAL3wHuUgssAbNNGJ6sX7S768OdXIugLl3gNh6ZK0qb
	DUkvnMQLz6LQb2nEpfiEPhSJlRXF/AaXCWpEAjc7NFgLbrSrSYzURGt5XmrV
X-Google-Smtp-Source: AGHT+IH/qCknzdZ4O82u6CWh0pR/z9i66ffmhgR5rabZrlbUlOLHNrEI7jSPkUAVI9j4Kpaf4wArGA==
X-Received: by 2002:a05:6808:482:b0:3c0:2bf5:7c11 with SMTP id z2-20020a056808048200b003c02bf57c11mr5997157oid.17.1708918657257;
        Sun, 25 Feb 2024 19:37:37 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 17/22] sim: Remove g_strdup use
Date: Sun, 25 Feb 2024 21:37:00 -0600
Message-ID: <20240226033724.1460079-17-denkenz@gmail.com>
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

Replace by l_strdup
---
 src/sim.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d941415a4879..50c6a46eebf7 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -515,15 +515,15 @@ static void pin_cache_update(const char *iccid, const char *pin)
 	struct cached_pin *cpins;
 
 	if (pin_cached != NULL) {
-		g_free(pin_cached->pin);
-		pin_cached->pin = g_strdup(pin);
+		l_free(pin_cached->pin);
+		pin_cached->pin = l_strdup(pin);
 		return;
 	}
 
 	cpins = g_new0(struct cached_pin, 1);
 
-	cpins->id = g_strdup(iccid);
-	cpins->pin = g_strdup(pin);
+	cpins->id = l_strdup(iccid);
+	cpins->pin = l_strdup(pin);
 	cached_pins = g_slist_prepend(cached_pins, cpins);
 }
 
@@ -536,8 +536,8 @@ static void pin_cache_remove(const char *iccid)
 
 	cached_pins = g_slist_remove(cached_pins, pin_cached);
 
-	g_free(pin_cached->pin);
-	g_free(pin_cached->id);
+	l_free(pin_cached->pin);
+	l_free(pin_cached->id);
 	g_free(pin_cached);
 }
 
@@ -1713,7 +1713,7 @@ static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
 	DBusConnection *conn = ofono_dbus_get_connection();
 	const char *path = __ofono_atom_get_path(sim->atom);
 
-	sim->imsi = g_strdup(imsi);
+	sim->imsi = l_strdup(imsi);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
@@ -2291,7 +2291,7 @@ static void sim_iccid_read_cb(int ok, int length, int record,
 
 	extract_bcd_number(data, length, iccid);
 	iccid[20] = '\0';
-	sim->iccid = g_strdup(iccid);
+	sim->iccid = l_strdup(iccid);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
@@ -2305,7 +2305,7 @@ static void sim_iccid_changed(int id, void *userdata)
 	struct ofono_sim *sim = userdata;
 
 	if (sim->iccid) {
-		g_free(sim->iccid);
+		l_free(sim->iccid);
 		sim->iccid = NULL;
 	}
 
@@ -2590,7 +2590,7 @@ static void sim_inserted_update(struct ofono_sim *sim)
 static void sim_free_early_state(struct ofono_sim *sim)
 {
 	if (sim->iccid) {
-		g_free(sim->iccid);
+		l_free(sim->iccid);
 		sim->iccid = NULL;
 	}
 
@@ -2654,7 +2654,7 @@ static void aid_session_free(gpointer data)
 static void sim_free_main_state(struct ofono_sim *sim)
 {
 	if (sim->imsi) {
-		g_free(sim->imsi);
+		l_free(sim->imsi);
 		sim->imsi = NULL;
 	}
 
-- 
2.43.0

