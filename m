Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0B7580C
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230071; cv=none; b=tMEnjMCH5rIFGXdU/kZkhud4w5zhO4qBGRLpKF09VTQyHXTaYy3fUqUTZdag8jF3QKYWHfnpEk+l31C6cwd637LhBbK8h3MgzBl2Bqwth95/NdY15J9SAQkph163C3IkLoxtjB25H1swRo8viUsl3FXrTU0pMmhq+o6Di5Os7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230071; c=relaxed/simple;
	bh=cuh2FD7jR5o1QO9n3R0TDeyXDKZ0BvaAyQiICNebl0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKiwlbqpXXseYmTTvtgFTFI/ssgL1aIoMMTAsNJ1QJ+52GripAKNH4/pZac6qogE8a8LYK/vU/sLDYDewSbIWBd2WmD6GfXL5AiJom2hoE15BQcmWKd3bbumwlYuKhmvieka6YpNbXrc3JyDlNrrjV30UwmV9LPeg+s7ax7cxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg/kHPO4; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg/kHPO4"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21edca2a89dso614116fac.3
        for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230069; x=1709834869; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlQmreyy0+/j5q9Q3CZ2kYkYnYjjBFT+tCwzXSkKtcA=;
        b=Gg/kHPO4ttAtCY/GafSpu5K9mb3HPfugkjTSwMUqwQFHTxUE7ARP+cumS8GvaH0Hyw
         g5cOmIPANBd29XBSpQ2E2+DNmSQD2VHa7mpoRa+1pd7RVbpR52lF//hU72IiZ191HfXI
         ++4hr2DY+JqvkobnAaIIFHkTGcUI8lWBk3tr9Kuox8e9FyNOdhA8drHkbaZZxxVSuLc1
         Cg/nEp/y7e5yiOZIqECMKGOBoFSG5UEAubyuGsQ/bg784utcPXhvUdD10uUzMkz5qxxV
         MKj/eArQk4QmoR4UPGk18EWZaJdeFQW+q8zI4ZIgXgfhPHUsIL/kQhTRrIUNCjX/PRdQ
         JLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230069; x=1709834869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlQmreyy0+/j5q9Q3CZ2kYkYnYjjBFT+tCwzXSkKtcA=;
        b=oLHUBa1eH7OVC1uX/9mjyAb/5fXaRZi+xhyWREhl99dauD4sDqZzIyTqQa05eoPuB6
         ht6h0pBW6lbygfHSRhLTgas8WkYX16OO8lHWb7EknNn3bS7qb+exuTo3wFOKyXQrCHyT
         DVkpN+fpY5Vsq5ePLySSecY8qcYJVER6R6NNWKtpU2/2SveCqWf48qFWn+TYfspWmu5/
         RlwaGpZ7fDsWAIV7PUdq8GBxPAwC0WT/q+ZR70zQgy1usO28AHhatL1YzihepDWAjjzB
         DwdTPacbXqD7JIaJJ62qfgqXwFBhy9EET2TvM+eJmSPVJX+54mXfbJt+NkK7H86fxxrt
         7RNw==
X-Gm-Message-State: AOJu0YzL9LKVL7fPa492uZuJpAPL8AbyUWuRHm22ex9nRW8EbaQs9B3B
	YbcAu+gZOazZNc0zIDtvygwPYempnYE0oY8kDZW0gE8hbsmPMj7kkRcjYUEJ
X-Google-Smtp-Source: AGHT+IEkA8nUyAtp9qeUuaDikVaph5yknk4sS5Q+PTr2sGTXwfzASktW5UqDy4PVf05lTM5pi/CWFQ==
X-Received: by 2002:a05:6870:e2d2:b0:21f:1705:d5b0 with SMTP id w18-20020a056870e2d200b0021f1705d5b0mr2782343oad.52.1709230069279;
        Thu, 29 Feb 2024 10:07:49 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gz14-20020a056870280e00b0022008c33ee0sm549899oab.36.2024.02.29.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:07:49 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/4] voicecall: Drop unused GError variables
Date: Thu, 29 Feb 2024 12:07:33 -0600
Message-ID: <20240229180746.1671015-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GError return variables would possibly be allocated by g_key_file_get_*
functions, but never used and never freed.  Fix that.
---
 src/voicecall.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 725a166b0376..1bf96ee179b4 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -3438,10 +3438,9 @@ static void emulator_dial_callback(const struct ofono_error *error, void *data)
 	gboolean need_to_emit;
 	struct voicecall *v;
 	char *number;
-	GError *err = NULL;
 
 	number = g_key_file_get_string(vc->settings, SETTINGS_GROUP,
-					"Number", &err);
+					"Number", NULL);
 
 	v = dial_handle_result(vc, error, number, &need_to_emit);
 
@@ -3564,7 +3563,6 @@ static void emulator_bldn_cb(struct ofono_emulator *em,
 	struct ofono_voicecall *vc = userdata;
 	char *number = NULL;
 	struct ofono_error result;
-	GError *error = NULL;
 
 	switch (ofono_emulator_request_get_type(req)) {
 	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
@@ -3572,7 +3570,7 @@ static void emulator_bldn_cb(struct ofono_emulator *em,
 			goto fail;
 
 		number = g_key_file_get_string(vc->settings, SETTINGS_GROUP,
-						"Number", &error);
+						"Number", NULL);
 		if (number == NULL || number[0] == '\0')
 			goto fail;
 
-- 
2.43.0

