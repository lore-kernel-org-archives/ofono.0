Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D871B48
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649747; cv=none; b=jTME+Tw46xmvtb8T/c/dyfVRIFOtw975iyo7PEBCOQDTo/zS8Ze2WNbjhlo//ZKIg9H8SaBOPfceOQXcad7fhE0NxkVYQqxa7jj0Fvm4C3v91dgQ4BiU68dtjbSDYZrooRbchzeDUnKX9xKrKpLUruwbdS/qe2MwwWpnNnT3Ikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649747; c=relaxed/simple;
	bh=b2/Q+G77z9qtdxIyClU4hIsTCIq5g9yuq0eg3wyEvrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goXzJhllyI8GvJimW1pTeuDHocSiBIIlmAPU1RWbOwntsYkXdfqrUZacevqptkcitBlba8iuYWmDpKuVEZs3obP+TI1hNrdxFwkesXg6CEyeM0xgg6fLdGE92t/iP35lBp/dFW9bOndYELYWXw0r0DJPPBiGMzrBqVLjR7e3ANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEexMeQ2; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEexMeQ2"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-218642337c9so2278439fac.3
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649745; x=1707254545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2/69l/hPQNUE7M6NPnzmVVlli3t5FRfvoixHWe4mY=;
        b=aEexMeQ2fVY8zC1xXpYhHfRhQIz9Trgdlti7YNPDKd+DFae80LX09ZZYWVTWYqtlPa
         ZKKTME3dnp8ls7XCccHendJ2ukBCUB9ZHE+l5dhwi7Wwfa1uL594dlt04WL6phtrfs16
         pWUIXjIcDN5HFaMhsx+/Zu4w7VHUz0u0DqnGX8w5TsUxSxBVocjp9zbDovwSw2wjzPiV
         50bogzk9slZepvp5GYjL3w4abaHvbdlMsUISccIHIn03Qb1qwOPIMfPv993QNdbCOgtB
         BNJL606vDHSRaNTvnGpE8+WZROr0LJEoNcEWWY6KcGZlyeqKLuvFE8JsbzEQ8DXtLyhV
         QYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649745; x=1707254545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL2/69l/hPQNUE7M6NPnzmVVlli3t5FRfvoixHWe4mY=;
        b=AS6JLr6qVYFLf+7oOqUswdACzKsnAYqPBkCIG3gtgmJtTuul7I7L2U48Dx37Ok23ro
         7l2IhA+Uzq+62wpDGK5UApgJcE2VyCa78y+9hDtPwm5poYVe6oylGPN5IDwsynKsWVMV
         38AdIj5NLumxqSOBln7Evi3ceFjasAgZ966aEZqeGxfwzIhVIr6Q1TYnxv1E2j3XwFl1
         KqhUbvrlxYsGNd/sr6stkMcJ+PkHHn+fwAEvUsb1ijbvOE18M49kpEzpR4vGwo/t+Loz
         yda4FCRONlUcLVJHAsKrdFI7uTtrj/ZBA8EvgxA5bE5DF7w8hhG2tEbZ90xoAn2dcdwW
         8bmQ==
X-Gm-Message-State: AOJu0YyeDXDysqPWhbgn1dyTtLPRqx9BFcozuu8alLfJRwR+NGi9Y/65
	wa/XV7zpDRepY1WT7rG3sM0wDJDcUEHy9HHlKvTlJqrqeRiH/n5/cAM5tDP3
X-Google-Smtp-Source: AGHT+IGMQ42y6SXkXomvfxwGKURuN9PrcP2hhbMiGOCXuYR1taTqsrgeWuhP2vt/Qn88B5ZC/uxbIA==
X-Received: by 2002:a05:6870:2c8c:b0:206:4d0e:c190 with SMTP id oh12-20020a0568702c8c00b002064d0ec190mr12605552oab.52.1706649745262;
        Tue, 30 Jan 2024 13:22:25 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:24 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/17] umlrunner: Also mount /var/lib as tmpfs
Date: Tue, 30 Jan 2024 15:21:06 -0600
Message-ID: <20240130212137.814082-1-denkenz@gmail.com>
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

