Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1545B697
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914496; cv=none; b=lxIB52CuRPD0bj22X+ml8Ogl15/hGnpw22w5ya59DA6+zIlwQJqDhpz3yi4/ATrfZ61ypunl8YPm6e3wADaJ4NlJMDnaF8RmlJG3/Y3M+Up8jUZYqebg879LBfyplfRZhZhW1XZzWUF8xSazhbcu+15OdCt5UGS6jg0uUwrH4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914496; c=relaxed/simple;
	bh=b2/Q+G77z9qtdxIyClU4hIsTCIq5g9yuq0eg3wyEvrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RScqMJCB327eIdiuAnHX4wKYqSsFFjorEWNKn2iGrPrnSKKg472meGAyO5YXcG9FZuGf9ANsN0zVnu2WZZbRcWbFlij8KgV8b/elsMefbdr7W6EFeQNl/q1lwfG9LXVEcmd+6Vcd7/2IrYslMMNXkTY4roUNQICZNRDeQznm8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM75nZ+A; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM75nZ+A"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e11faeb125so1252110a34.2
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914493; x=1707519293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2/69l/hPQNUE7M6NPnzmVVlli3t5FRfvoixHWe4mY=;
        b=mM75nZ+AyrRyutjetWrGKQmK0pxNMAUDFYvvgQ1Ac4cCu6J25OOUk/ZCYsqJVH1hNZ
         0FLD2J/kyM0mmbYHz/a5JF0oZVx0D9iDUoC/WG3MClKngAJXQ8Q/IiLyDqYmWDnpvCWn
         CZZrv0xym/0ezXfKqspq6MaELz6OmfFOrmiKi/cMZDNlcSFRl407fz6gBF/Mqje/RhMs
         TsKjMkdpiRtPgEcdR3ypbL7NJn2XD/82iIRXBuh1peqwbK/jnVpCrhrGc9oVTnIheI4D
         lVBzMIg6Waa96UqJNVv8SifvEYPIcY1Ulemn0mix8EuyFp8fQGJTJMo1rPtQb8mRkZJa
         6hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914493; x=1707519293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL2/69l/hPQNUE7M6NPnzmVVlli3t5FRfvoixHWe4mY=;
        b=ERJuYuLLFyaSvYuE3Iko2cySqjELRFLfcfhj/lUQV55XYcmJ2c9Ltvgi36GnO39lR2
         eru4pB84mFXIHZLtzoqGsRms5MVh64JvAYoqkg9yf7QdjRTILBI7OpV/yVSRZOqVeyRM
         VID6+DbZ21A5O5VzXpXaqAk9KJOqu70VrJ9rgktRVWTAxeogKoTKCTKopjPm3N5Gx3u9
         GR65KkFEVCtsUlPz+nHtPF3Ki5n1F5UmoaamOV07XGrLRzYiBRN/u4wwhI0hrcO/Bzxz
         V/9F7RpWYoA2V99tEMqHHThgN6y7Z13w06IiUz/BsaBobbknzRvndTy9u77nz9pX257/
         9GAw==
X-Gm-Message-State: AOJu0YxIIIMrhV8vs+ATsxzmxKRgBNHNCqJ7wVMuuYlFWm4SaGoNZmQ1
	IQ8zWgf5IE1/Tb/qIjlC7wSIpdknSGF83w7frXzpDZhbVVzOGj0PpYBEMDMk
X-Google-Smtp-Source: AGHT+IEc8w0qVCSJlARml9W/GPGUZzb/KGHc0zm9ti2cBumvmnUYgNZ+ktPYg0Dp1/dymxfBkwFX7A==
X-Received: by 2002:a9d:750f:0:b0:6e1:37b:5678 with SMTP id r15-20020a9d750f000000b006e1037b5678mr6712147otk.34.1706914493450;
        Fri, 02 Feb 2024 14:54:53 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:52 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/18] umlrunner: Also mount /var/lib as tmpfs
Date: Fri,  2 Feb 2024 16:53:33 -0600
Message-ID: <20240202225405.993792-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/var/lib is used by oFono to store various long term settings.  Make
sure the settings from the system are not used by mistake.  Also, since
the host filesystem is mounted read-only, updating of /var/lib locations
by oFono wouldn't work anyway, which might be confusing.
---
 tools/umlrunner | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/umlrunner b/tools/umlrunner
index c1d4c9864487..bb2f24a6dbb9 100755
--- a/tools/umlrunner
+++ b/tools/umlrunner
@@ -45,6 +45,8 @@ mounts_common = [
     MountInfo('tmpfs', 'tmpfs', '/etc', '', 0),
     MountInfo('tmpfs', 'tmpfs', '/usr/share/dbus-1', 'mode=0755',
               MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME),
+    MountInfo('tmpfs', 'tmpfs', '/var/lib', 'mode=0755',
+              MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_STRICTATIME),
 ]
 
 dev_table = [
-- 
2.43.0

