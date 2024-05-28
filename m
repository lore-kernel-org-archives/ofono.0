Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5D13DBB1
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934012; cv=none; b=OARfhTjMYMV4XbkAfuQJtOLRiLf+IYwEZt9EF9eYwXt7q/zPxmZFYRLpZyVAwLvW3BxEQ83TC+zUBUNgiX2la50tYCEyxa3t3MG043GM+GK8hd9V203kIuPjmnwKtYFIZDDNApWiXNnTRzdtVUMEOCJXtR/d1KMVPqoO2oLgZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934012; c=relaxed/simple;
	bh=VNhR98Q4q8+2t0k+Z0nI9QKA0/qj53dCPKZ4HYx5x/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDFf10a/OkEUQf0PZ+dQniY5RQOrNqWv9KAq1zBTIq9vJmnK37gdRG4Nlcq5Hk6b/ED7AAJd/VnIN6ayed7X+w31Otp8F6LmmET0cgnjyqgExf/0W6jdR2EWZfrVp0VvFuBRIIdh0Xsrf8nQ/AxxGofg62EQeOXedLhZFrSbsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYT5tCmu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYT5tCmu"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8d2ec8652so792631a34.3
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716934009; x=1717538809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMWY/C1su4b09AePBJC0PUdPoBdRSJrP1VKaE7rIByY=;
        b=lYT5tCmuobwRF6AxUF8E6mBvOPbCoRP73tW75muBLC7zKUMo3sLQHn/KrdoKgMDssO
         pLYhlF5jEMSec0eZoaB+PMtFHywRzs52QOPxSLrnAt75J1kLmJpKFjNRk5W6qi7oGTf2
         CLVAxj3rBpptt5Eq4Wf2V5Xh8eM2/iiCGDzY7PcwYmpD3X9dd1hKjeaJXIfGQlfrkyva
         8dFwFYjzPBwcGGhYvF6g4wdcHPQTCzDIF1DlXPERb/iQGP4Nf4wffLIXybC5nN+AhGxR
         9rlbrn9MX4bg0FTciPq0W5EfTKUZN4KbloBIXX5Fw5mgkOD39XR3O9uUfs5jPYYEVOUd
         B0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716934009; x=1717538809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMWY/C1su4b09AePBJC0PUdPoBdRSJrP1VKaE7rIByY=;
        b=CDTSQrO61EZN+R/62UtIIuQQVHsfGVabHDrgu41A+ZGzKkEyW7w83P6+O6iw6u+hMB
         Cl3DaIW2JRfnGkSz6UI5G4p2YBGkmUQvq1jNjR8zqnVfWkVupcxr5Cwj4hOlHEf16jeg
         lw7h5bQLqcNdozzbUjnioy1ajg9SJeRbPD5UCr3Py3aIi2DrZ2+KZpBKEj+Fl+L65alr
         JAs5HYoYLrDqkgcCkamQTpbZnRWo23FDtf6wm0pooteGhJxz2bjdHRb26gq7NLMIFlIG
         JDq8T15b/xYyTCkopb96oZ3fP1T8ZseomXDgyMyZtQXet8yvxPdWFNe1pfA91zSbg62+
         O0mg==
X-Gm-Message-State: AOJu0YwOwevdTAtxJR2g7xuut0lLefZ76rNlVQc2NvX2wA2M8Gxy/Qxz
	86RynDhODzTWFITIW/oJUusf+bXsKoOSlvWmLXHr0TS/7ggtrQ7fziKOCw==
X-Google-Smtp-Source: AGHT+IFenszKs215OsCMb7GeqVG+dOBku8SL2wwXhpyOlh9pQiG3JdLKav7fPvupBBhBvvAlvCy4/w==
X-Received: by 2002:a05:6830:1c1:b0:6f1:2f2e:216f with SMTP id 46e09a7af769-6f8d0b23325mr15347936a34.24.1716934009468;
        Tue, 28 May 2024 15:06:49 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0e79f84sm2054474a34.69.2024.05.28.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:06:49 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] voicecall: Fix use after free
Date: Tue, 28 May 2024 17:06:29 -0500
Message-ID: <20240528220642.251435-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On shutdown, if the sim atom is removed before the voicecall atom, the
sim context is removed automatically.  However, voicecall atom does set
sim_context to NULL in that case, resulting in the following valgrind
report:

==251105== Invalid read of size 8
==251105==    at 0x59B4F3: sim_fs_file_watch_remove (src/simfs.c:243)
==251105==    by 0x560E2A: ofono_sim_remove_file_watch (src/sim.c:2621)
==251105==    by 0x5412E3: unwatch_sim_ecc_numbers (src/voicecall.c:2820)
==251105==    by 0x53B8C8: voicecall_unregister (src/voicecall.c:2849)
==251105==    by 0x52B16B: __ofono_atom_unregister (src/modem.c:336)
==251105==    by 0x52E6E4: flush_atoms (src/modem.c:492)
==251105==    by 0x52C1BE: modem_change_state (src/modem.c:586)
==251105==    by 0x52E155: set_powered (src/modem.c:974)
==251105==    by 0x52E307: __ofono_modem_shutdown (src/modem.c:2279)
==251105==    by 0x5296B6: signal_handler (src/main.c:85)
==251105==    by 0x48FF198: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
==251105==    by 0x495E3BE: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
==251105==  Address 0x5baa6f8 is 8 bytes inside a block of size 16 free'd
==251105==    at 0x48458CF: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==251105==    by 0x59B2A1: sim_fs_context_free (src/simfs.c:213)
==251105==    by 0x59B133: sim_fs_free (src/simfs.c:123)
==251105==    by 0x5620EF: sim_remove (src/sim.c:3239)
==251105==    by 0x52E701: flush_atoms (src/modem.c:495)
==251105==    by 0x52C1BE: modem_change_state (src/modem.c:586)
==251105==    by 0x52E155: set_powered (src/modem.c:974)
==251105==    by 0x52E307: __ofono_modem_shutdown (src/modem.c:2279)
==251105==    by 0x5296B6: signal_handler (src/main.c:85)
==251105==    by 0x48FF198: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
==251105==    by 0x495E3BE: ??? (in /usr/lib/libglib-2.0.so.0.8000.0)
==251105==    by 0x48FFDC6: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.8000.0)
---
 src/voicecall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/voicecall.c b/src/voicecall.c
index d9f3dd82f0e6..398a576a3cc2 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2966,6 +2966,7 @@ static void sim_watch(struct ofono_atom *atom,
 
 	if (cond == OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
 		voicecall_close_settings(vc);
+		vc->sim_context = NULL;
 		vc->sim_state_watch = 0;
 		vc->sim = NULL;
 		return;
-- 
2.45.0

