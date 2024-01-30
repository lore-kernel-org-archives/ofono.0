Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D40762CE
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649750; cv=none; b=sFgKv1xSsHIEgEomrMXQl38Brnv4U+I56GNUFB/6Hfmo2UXwlc+F6oIvd7LG8JLJXy+JCN3kPNtogFsvJcL7A9G9iQ29fI+nxQ1Aq1inWOINpK+oESh5Xdn1i0nhNDIHF4Yp6GS5dbZk/mGnX0a7JFcrvbTWjAz5q5CQKIOysCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649750; c=relaxed/simple;
	bh=ocOP2ENWgfeKcfkofb/GowR+z0pPyYIU9FELfhLwGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRjPI12I1k2OOSkzxxvKhjJNOX49bY36m1Fi/pBJIBH92AIKJYEk0xhRW9voaDrFcyf+9304oy89yhIBSDCpcG4aGBKMoYDMu4f6EEiBxZAlPhJtQU69n1qjyzCK07ICwog3glhUZ7MxuLXpnhD1+uxVFvkDijhmTTZ8OeknU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBbRiiK1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBbRiiK1"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb9d54575cso3287959b6e.2
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649747; x=1707254547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ/Hif7k39MhIpB+VGwN9tPfBsV5uUV3MaA8EewrxfE=;
        b=YBbRiiK11BTSgh9PGLAkIgaD7a1Yo0b0uIMEnhQ74Q9gpGFFufyYfhpB7vzTvqKMXJ
         4EIjtv2Q828hqQTdht9cTbTVib8Tzyg5AUAO54j4vBWAo4X4NMKHb92MeHe3YUOiIeoa
         uCMxyvhRf8shcu5FEJo5VwVawL9PZ3sM/I98AFTd4v9gzASKUyudGkIPxQQp+pIsjI9Z
         tC7ROOAWM5GYvNKMS0DeCe7cVVcoxvycGb50IYKm1KF0Ubw2tad7Rqmk3Dptv6rRpx9T
         uFm9ZkSAQAOeIAFyB467EIyy8drDv22dALChAHFMohYsYM2dX5Uq7biexQBZVoLIsZwv
         pKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649747; x=1707254547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJ/Hif7k39MhIpB+VGwN9tPfBsV5uUV3MaA8EewrxfE=;
        b=I32vIoZed00ZDDnNMVeubF17Oz63QnDMN21Dm73QBU3xPyMRFAH1FbNix4rRMn3EgD
         7WWEDa0BR5CIArcRasUtcD7wCUstqddFkuATNt8lyL297JqgT1K1Fiz9upFBw5eee8xk
         Gu3bewvIB6ob1UftM+USkwahdK/U6nPOWksQNjfIvZWJAlCqKlYBg0dDd3HDzWYyVl0o
         F2Uz3B1YgYOTsfXkQ8mGom5OQvbInaonB3Tgk2zX2Ap/TyF+mDl5j181IMfLH20sP02e
         1WsnPXEWqRQN700LVVACKD9z9IzN/4OO/5AnQT74McmlnMiA6TEw7Upz7DbJ8bGqocAc
         dZLA==
X-Gm-Message-State: AOJu0Yw0PVQUZDu0Oej4mV2FnTxO2SO1kqKUDrewyF8hpnnx3trqV04K
	GhakkYfEWPpOWZV3yF2CACLd1HVXpylcM9p//svzgB0s0L6Ho3BjpHGB3xH1
X-Google-Smtp-Source: AGHT+IHF4L6SCzzoU+BldagY80b0562wNKMrEetKveXbpdP/O1cw8ZBeomLxCFcodc50V5QHS3KFoQ==
X-Received: by 2002:a05:6871:4e48:b0:214:4761:d39f with SMTP id uj8-20020a0568714e4800b002144761d39fmr9165486oab.34.1706649747793;
        Tue, 30 Jan 2024 13:22:27 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:27 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/17] storage: Introduce storage_get_file_path()
Date: Tue, 30 Jan 2024 15:21:10 -0600
Message-ID: <20240130212137.814082-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple locations where the same steps are followed to
produce a file path for a given storage location.  Pull this logic into
a single function and expose it for potential use by other modules.
While here, convert use of GLib functions to ell.
---
 src/storage.c | 36 +++++++++++++++++-------------------
 src/storage.h |  1 +
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 05d9b88a0237..c7bbb1c6142a 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -171,45 +171,43 @@ error_create_dirs:
 	return r;
 }
 
-GKeyFile *storage_open(const char *imsi, const char *store)
+char *storage_get_file_path(const char *imsi, const char *store)
 {
-	GKeyFile *keyfile;
-	char *path;
-
 	if (store == NULL)
 		return NULL;
 
 	if (imsi)
-		path = g_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
+		return l_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
 	else
-		path = g_strdup_printf(STORAGEDIR "/%s", store);
+		return l_strdup_printf(STORAGEDIR "/%s", store);
+}
 
-	keyfile = g_key_file_new();
+GKeyFile *storage_open(const char *imsi, const char *store)
+{
+	GKeyFile *keyfile;
+	char *path = storage_get_file_path(imsi, store);
 
-	if (path) {
-		g_key_file_load_from_file(keyfile, path, 0, NULL);
-		g_free(path);
-	}
+	if (!path)
+		return NULL;
+
+	keyfile = g_key_file_new();
+	g_key_file_load_from_file(keyfile, path, 0, NULL);
+	l_free(path);
 
 	return keyfile;
 }
 
 void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
 {
-	char *path;
+	char *path = storage_get_file_path(imsi, store);
 	char *data;
 	gsize length = 0;
 
-	if (imsi)
-		path = g_strdup_printf(STORAGEDIR "/%s/%s", imsi, store);
-	else
-		path = g_strdup_printf(STORAGEDIR "/%s", store);
-
 	if (path == NULL)
 		return;
 
 	if (create_dirs(path, S_IRUSR | S_IWUSR | S_IXUSR) != 0) {
-		g_free(path);
+		l_free(path);
 		return;
 	}
 
@@ -218,7 +216,7 @@ void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile)
 	g_file_set_contents(path, data, length, NULL);
 
 	g_free(data);
-	g_free(path);
+	l_free(path);
 }
 
 void storage_close(const char *imsi, const char *store, GKeyFile *keyfile,
diff --git a/src/storage.h b/src/storage.h
index 4dc792ccf7f9..3a1e64493546 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -32,6 +32,7 @@ ssize_t write_file(const unsigned char *buffer, size_t len, mode_t mode,
 			const char *path_fmt, ...)
 	__attribute__((format(printf, 4, 5)));
 
+char *storage_get_file_path(const char *imsi, const char *store);
 GKeyFile *storage_open(const char *imsi, const char *store);
 void storage_sync(const char *imsi, const char *store, GKeyFile *keyfile);
 void storage_close(const char *imsi, const char *store, GKeyFile *keyfile,
-- 
2.43.0

