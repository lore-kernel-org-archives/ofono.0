Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241E6E5E4
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633012; cv=none; b=N8LkG32qeCP2ZpqIRhFWAxoNWYiohEPqKsc+tT5EYDysm8CWS0Mg2fv3vXrSuVPgzIUX6uZ+ArsyslSn94eQ1/Zn0gYh+imuPs0VtTlwL6Eq4mNefI3vtRqEe8DW7E8wbKjKtonP+HBdf4Uzc9s6eYC/zOahSX6aOgfa25rh2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633012; c=relaxed/simple;
	bh=gZ457g/Jl4FgaSAU2muNe4zABSqTBeScqdwIcCf2QgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWy3P7acvTkDnk5ZM/tRoLCHgI/6duf9Uoemf72lumh6opO+t0eG8RnvxqSCdhgHtrfsahrm1d7LZveZsvCbir5h7jHbvKit2XRDJmLoRWfWtq/k2hxPNO9VZcYKdO9vh6Q4A6L9576iH5noRnPRm3Ap1QuuuDWYA+ELiRsLmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM4t/sr1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM4t/sr1"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ddca59e336so107916a34.0
        for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633009; x=1709237809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ+wgljsQYGCpixLwCvaa09CjLrMwUmYdVDp6sLZGzI=;
        b=bM4t/sr1SPu1GtZ5o7JUkItCEzGMwo9BiWhRc8hgOzBXoSkpUTwHSwXA9BOJ4jL2vZ
         l3J6JiUz6ueN7T7h94bqiOWiia8P8I4ZO7WVbh1vhH2dHd1aQBc44hNXsM7gwnxR3PMl
         tXZQebzgWuNdMy0mstb/o9X3ZYMmlyABo7yHFbkz3zA5PluuZKw5LWuZpBMF5bLseYQR
         11cZPO1CRE+WEDCHqmI2OafKxvFY5em0mUiRnVRFJHRkrBPPofrPW6v9Q4YPCyXAx5tb
         WUE7YCLBbFQEVIHlpJwnvN4L/ZrUDNE1Oi/UgTNoYSukyVE5xEkhSDQf3q9mq02sP4p6
         d2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633009; x=1709237809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ+wgljsQYGCpixLwCvaa09CjLrMwUmYdVDp6sLZGzI=;
        b=SeJVwN92OhPkd0M8D7Sf9Bb0+zL66+4yKShkv/EUI+mSOTEFyTCzTHBR81N0A5vJlT
         E7YYipil3xx1TFNeba2GaBMh5ASrys/VgYRIocyKXQOGGWh6y07LskhNZuV9T3o5knOp
         XQkE1ZehtRXtUXkdiMdpQhuToTw/dhbYR0kJKis2Am7T4O0fokg8Tz0uON1Q9+PHwmcx
         nCSX00IHpMz+ZCIXfj40YnQNDowobLiNzLI9h/V0O6pQyWvlKeyp/gzpoh9oAGIDCWEB
         pYRv4VW8Rxiq8rp7MXrIKFq2TeZjtMGMSbL1IZiHUes8UkY1rrk+FiguesYccBXbRygb
         iRkQ==
X-Gm-Message-State: AOJu0YzO0zrs+ua0i/hNL2TQycs8TZR9fLmKEz6u/eWKZGc3Gr45nTCT
	rrGFu5UgHnu8xuhFeDbGiTAbg/ZxF9pqKeRxDdpd7L8SNxtDqfGrwLQJfStq
X-Google-Smtp-Source: AGHT+IFtJjdx6CSNOn6Dki4B9HhLzK7ZuxkTd4TGC5gvD8T/ez1p/5+9E/+/aDWDg+P7TtKqIOMKKQ==
X-Received: by 2002:a05:6830:1d0:b0:6e4:53b0:5817 with SMTP id r16-20020a05683001d000b006e453b05817mr1695540ota.0.1708633009637;
        Thu, 22 Feb 2024 12:16:49 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id k1-20020a4a9101000000b0059a14309a29sm2472353oog.16.2024.02.22.12.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:16:49 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] gobi: Fail early if re-tried discovery fails
Date: Thu, 22 Feb 2024 14:15:45 -0600
Message-ID: <20240222201559.1293947-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222201559.1293947-1-denkenz@gmail.com>
References: <20240222201559.1293947-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index c4e63b7b464f..99a7d5564ed8 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -406,11 +406,10 @@ static void discover_cb(void *user_data)
 			data->features |= GOBI_VOICE;
 
 	if (!(data->features & GOBI_DMS)) {
-		if (++data->discover_attempts < 3) {
-			qmi_device_discover(data->device, discover_cb,
-								modem, NULL);
+		if (++data->discover_attempts < 3 &&
+				!qmi_device_discover(data->device, discover_cb,
+								modem, NULL))
 			return;
-		}
 
 		shutdown_device(modem);
 		return;
-- 
2.43.0

