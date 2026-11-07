Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068381;
	b=V66jm0EQ3dt7TL9lNq/y8yObHg3BSMWnmrdg5Pu0sBSNPwSaYVDrKBtEZ3En0A5YzFkS
	 3BfFI/eXgbd/S0fbi6lKLdwtp7tjQ+hcSkYmslcDtmXcTuAOnJmd/40ilWmTGYoTmMCSS
	 zIxSUZRIkYTF9rgu0s/8xJvHWpuovUqCwQZN0HNeOsaMFMQaZNz76LBMEZaWEeOBSpB7A
	 +b70VfcLDO4z/QVz/WjGa/tExKEKSedExtm8/PRpwl62ul3LME+PQYl3Y5Lr8oH+2KQN7
	 6r+WuzJwk194bawDd7v4UUjYtFIfqzYJWrc0I8ovylR77i+jcwR7NaYMim2U/uuzE8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6rFtDL+4M0QJuXDJ/u9fzL3dy/dGvGVkv79Kcm6X45A=;
	b=DoUaW1AWxsmLEcrw9QxBRJP7ZoorhM35ks/B/AxW6hmmNsgwfxVPPeqCiiyTjV/Mn3BN
	 vjtBe+16ikmB6SpuqlGQkByPeqB4XaKvTDk8bTKgrcLrlnnrZV3zijaGz8I2hD6oCJRSp
	 PY7tQDupTOUhxwNhVlXK2Mo3Ij8TVQgYi8n+LKy0OwFkP2vegFqqQWrRJdCircwyQC+wl
	 t8fRTQoKxV1LqsqTyO5cunmmS2bZ7IJaEuopOShkvJtvbDGQ7StZOUGNtXHKDuPmJ7D+b
	 cYJv1bYJ79zdt6I/OdSRYYJ2XAsPw3t8UoLbxSKRQSeQw6E2gJM5xNCAd0EQsbd+MBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCorYqv9;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF0606A326
	for <ofono@lists.linux.dev>; Sat,  7 Nov 2026 16:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86BF0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCorYqv9
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so4564145e9.0
        for <ofono@lists.linux.dev>; Sat, 07 Nov 2026 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794068380; x=1794673180; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rFtDL+4M0QJuXDJ/u9fzL3dy/dGvGVkv79Kcm6X45A=;
        b=tCorYqv9O009maDlMmKNZN/AqFerI/ZvKc4CkHhNszlAY1V0gIf0J2LgECaQPliv5i
         NL9GHwR8WVLSlEdMHqSksCIJq/6kcpikR0td56fccJd2pJOoQY4Nf4IoKus4rDaG4c4w
         wQbaHVLHq1uuu/RlyCN9bh68I1BZFuWB7T+CFlmXT+zUl4rqgtS6Z/Au3HiOWXReZTuc
         jRo57n6FfypRRaAJki0jtmEZ+fpSX01xEGU/2KfCqTGZzOm132v15HFCJehx2jk6n3/f
         8WKkFj00/iXK2D2XxNy5DTedCYZXzRKsOC2SLMZ6l++MbRfqt53z9O0zspIMZ+ZB8YAS
         3+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068380; x=1794673180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rFtDL+4M0QJuXDJ/u9fzL3dy/dGvGVkv79Kcm6X45A=;
        b=W5KvGW1UJtubTcMi9Tsb/wiRq6Os7sBh1bcKc6uJR8iRyGGu/xxjzVGZnBttNJUWuv
         gSG2l/H/Ja68gJ2D7nCD7i0vEi14IYva5G5bAS7h/eNYZgZf5yo88Zfi/QFNEF8l3LYW
         Anpq/omUcO0t2AmT0mz9Qh2jT49wfVfko+U4sHFRqZxPf1GVRfiYPUk820ua5cXWJ3kH
         KhMLGzSaVDH9pmOsL3SYafLWSBZn5IrllHaqYYqA0aGepgeFFqnxGgmgsR8Q0i8aQLf7
         Mpy/2Wn7s1VBKT7K4GliTDU22pKhCE3d0nf3QYxnWqvFla3dWBsvOuVspZxVDwnhZdvZ
         iVWw==
X-Gm-Message-State: APuU4Z9OuAopBngDFnT77z1zFHpJ+dK4lFm4XxGmGQazoyUTkUfYlxwZ
	xJFj377lhELqkxOKfFlqVMG+F6vMk68kDZ/izMdWy2PbqNNCP8QkQ3ghdp2lLQ==
X-Gm-Gg: AYBFou3BBn9Qncmxorxer0B6I+87r8iqKwJVJksbCWOaletW5Yi+syS/X9Cqg7XMPs7
	4wLL9z80dMAzF5cxjYveYjE0sdU0zb+d2Pe+W4czUyYoiNOGkBfp2eAtyaoSYuVUwDyqfBnqfx0
	tsJFCFY0mBDEs5M8IuFbw0pN7zWaDfFh+ht0oo0qmAv/1tSf6ykjmxAAjCra9eqX3Wk0T/opRBI
	j52naZxWp77plzWE0t9ya8tYFb+YY/jo/SydkxRReEJXhfo1KuV6yT52kOW8Nsc3JrWAYHpDBHk
	oxzDiau3ctE5UWYfmsQs5iDJ2xRZhwAM6ENE75LFijPvAodSGzJE/2/rIadZIeEj4bN8DMiISLA
	xMk2K+b/dGdNoOrjxNvF3x+zdd7bEK8rFqv8HQ6lcWsM7uo4UxExY3nFvYvU2MI0o9idU3UMbK1
	mFmfPCcfwemXMco8cf5qCLIUa+h0mqGRJxJwHLDJz+Oh9KoCCx0j60urS/o7fQ1vfzDdWsp3kCo
	QQpcX2LwDysS/9cBApJ2pB/NQi2wxPJqU0c/wtkS5mLJts0nQyf2ZIizwY8X+wFfNdnAC00VPe7
	2cFFo8g/Y+zUAqaXWSIHaEwUdKY+8bzGr38ptZw2hgU8VSEGhg==
X-Received: by 2002:a05:600c:4e0e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4b810df8c0fmr43761105e9.0.1794068379856;
        Sat, 07 Nov 2026 08:19:39 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb75913sm68334085e9.0.2026.11.07.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:19:39 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	sunweaver@debian.org,
	absicsz@gmail.com,
	merlijn@wizzup.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] gatchat: Fix possible stack-based buffer overflow
Date: Sat,  7 Nov 2026 18:18:27 +0200
Message-Id: <20261107161827.472030-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Post: <mailto:ofono@lists.linux.dev>
List-Help: <mailto:ofono+help@lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ofono+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSM 07.10 test-command echo on DLC 0 copies the command payload
into a frame buffer sized for the negotiated frame size, without
validating the payload length against it.  A malicious modem can send
an oversized test command and overflow the stack frame.  Ignore test
commands whose payload does not fit into a single frame, mirroring the
existing length clamp in the status-change handler.

Fixes: ZDI-CAN-31014
Reported-by: Trend Micro's Zero Day Initiative
---
 gatchat/gatmux.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 95ffeb8d..b86d4754 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -984,10 +984,23 @@ static gboolean gsm0710_packet(GAtMux *mux, int dlc, guint8 control,
 							data + 2, len - 2,
 							write_frame);
 			} else if (len >= 2 && data[0] == 0x43) {
-				/* Test command from other side - send the same bytes back */
-				unsigned char *resp = alloca(len);
+				struct gsm0710_data *gd =
+					g_at_mux_get_data(mux);
+				unsigned char *resp;
+
+				/*
+				 * Test command from other side - send the
+				 * same bytes back, provided they fit into
+				 * a single frame.
+				 */
+				if (len > gd->frame_size)
+					return TRUE;
+
+				resp = alloca(len);
 				memcpy(resp, data, len);
-				resp[0] = 0x41;	/* Clear the C/R bit in the response */
+
+				/* Clear the C/R bit in the response */
+				resp[0] = 0x41;
 				write_frame(mux, 0, GSM0710_DATA, resp, len);
 			}
 		}
-- 
2.25.1

