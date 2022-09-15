Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33414403
	for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 20:51:26 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id bj12so44758597ejb.13
        for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=psW/7cl9SdNWwnnHZ0J9D2u6Ltsf4kax5gbxzCsw7Ns=;
        b=XNwIknale+FNoGyhFZhOw+h3HXo5BeQ+ZaJUd/tTskmy9SnxNWv9rdoKQ4EIPVfFh9
         G4sz0QIMavMhlfn4lm/FfPi1rYK+CFrttUPIuiAdQvSi9UYQEncVIuKsrg1vNRVabiJd
         rg8vOSlpnmsHYQgBxCPtDV9p+OX1KuNOXS45nsl3Zvxik7B+q1hLLm3JrbcD3umcyP25
         YmD1Fu4PpH66p4Dy+14BAi32qlp7kG7j0nq/8Zq5JXqPXyxtqwQY8Bo/mO68Ca6iIQ81
         ttXjplVaRsdfBw3Jom2KdguLP+4ZD9lIHbJC4eDEKAS7VJ6lUflTMNX+sy+gz59AuyEu
         eeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=psW/7cl9SdNWwnnHZ0J9D2u6Ltsf4kax5gbxzCsw7Ns=;
        b=Oc//bhR6xjkgQ3dpvOfXu6rjfpt6/FYs34TKtDiWLE9CraHIC5qihUmTAQmgMTNkrz
         Iz2JdRPQKLrjtEIeaP3akGNq2I/fm9aVIoX/q9jmQufHEIssoTu9Ro5CjTu5PvETxexq
         /IQLdnzenfPkcy4zJtXMXb3J61tYRjMkxqse2vhz4aK0wEAgkLN/BOAFDXYrDw82xBGS
         WGqq1c9t+IjH5Lsg+Ts2dRc9oD2Vpmg1SzUkqO102qslBsZYHnKuUzvov/CiAdqfzo3e
         5BOI060k9hTxkdMDy+OLbLpq6BTkcMdAYnWrjL7LN1cYPBI2wbohB7ec3UXD6/WGKqHM
         8Lcw==
X-Gm-Message-State: ACrzQf1+x8h5bAxib3k/fUeWNUTNeXoapSXL0S4741or3v5wfLwX/UIH
	XFmtScyfs3P1oxiaE7xNHFJWDt/cvh82qg==
X-Google-Smtp-Source: AMsMyM4LsuZmgprsHxA1u4zLgnT6blPcAqVNvjJxiQ2yO4K8Ox1KIdO8yUU9ujde+xWi+ywAPVAYeA==
X-Received: by 2002:a17:906:6a0f:b0:779:2fc:9a51 with SMTP id qw15-20020a1709066a0f00b0077902fc9a51mr1213539ejc.101.1663275085078;
        Thu, 15 Sep 2022 13:51:25 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709062ed300b0073c10031dc9sm9400015eji.80.2022.09.15.13.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:51:24 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] voicecall: Make sure SIM ecc numbers are always read
Date: Thu, 15 Sep 2022 23:51:05 +0300
Message-Id: <1663275065-19685-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

It might happen that by the time ofono_voicecall_register() is called, SIM
is already in OFONO_SIM_STATE_READY state so SIM emergency numbers are
never read.

Fix that by adding code that reads emergency numbers even in the above
case. Also, make sure ECC file watch is properly removed and sim_context is
free()-ed.
---
 src/voicecall.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3da258d..2cf035a 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -64,6 +64,7 @@ struct ofono_voicecall {
 	struct ofono_sim_context *sim_context;
 	unsigned int sim_watch;
 	unsigned int sim_state_watch;
+	unsigned int ecc_watch;
 	const struct ofono_voicecall_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -2866,6 +2867,16 @@ static void voicecall_close_settings(struct ofono_voicecall *vc)
 	}
 }
 
+static void unwatch_sim_ecc_numbers(struct ofono_voicecall *vc)
+{
+	if (!vc->sim_context)
+		return;
+
+	ofono_sim_remove_file_watch(vc->sim_context, vc->ecc_watch);
+	ofono_sim_context_free(vc->sim_context);
+	vc->sim_context = NULL;
+}
+
 static void voicecall_unregister(struct ofono_atom *atom)
 {
 	DBusConnection *conn = ofono_dbus_get_connection();
@@ -2890,6 +2901,7 @@ static void voicecall_unregister(struct ofono_atom *atom)
 
 	vc->sim = NULL;
 
+	unwatch_sim_ecc_numbers(vc);
 	free_sim_ecc_numbers(vc, FALSE);
 
 	if (vc->nw_en_list) {
@@ -2993,35 +3005,39 @@ static void read_sim_ecc_numbers(int id, void *userdata)
 			ecc_g3_read_cb, vc);
 }
 
+static void watch_sim_ecc_numbers(struct ofono_voicecall *vc)
+{
+	if (vc->sim_context)
+		return;
+
+	vc->sim_context = ofono_sim_context_create(vc->sim);
+	read_sim_ecc_numbers(SIM_EFECC_FILEID, vc);
+
+	vc->ecc_watch = ofono_sim_add_file_watch(vc->sim_context,
+					SIM_EFECC_FILEID, read_sim_ecc_numbers,
+					vc, NULL);
+}
+
 static void sim_state_watch(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_voicecall *vc = user;
 
 	switch (new_state) {
 	case OFONO_SIM_STATE_INSERTED:
-		if (vc->sim_context == NULL)
-			vc->sim_context = ofono_sim_context_create(vc->sim);
-
-		read_sim_ecc_numbers(SIM_EFECC_FILEID, vc);
-
-		ofono_sim_add_file_watch(vc->sim_context, SIM_EFECC_FILEID,
-						read_sim_ecc_numbers, vc, NULL);
+		watch_sim_ecc_numbers(vc);
 		break;
 	case OFONO_SIM_STATE_NOT_PRESENT:
 	case OFONO_SIM_STATE_RESETTING:
 		/* TODO: Must release all non-emergency calls */
 
-		if (vc->sim_context) {
-			ofono_sim_context_free(vc->sim_context);
-			vc->sim_context = NULL;
-		}
-
+		unwatch_sim_ecc_numbers(vc);
 		free_sim_ecc_numbers(vc, FALSE);
 		set_new_ecc(vc);
 
 		voicecall_close_settings(vc);
 		break;
 	case OFONO_SIM_STATE_READY:
+		watch_sim_ecc_numbers(vc);
 		voicecall_load_settings(vc);
 		break;
 	case OFONO_SIM_STATE_LOCKED_OUT:
-- 
1.9.1

