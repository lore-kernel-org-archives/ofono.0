Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224920897F
	for <ofono@lists.linux.dev>; Mon,  7 Apr 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062812; cv=none; b=TtN5OtR+DoFc0f9zKGF03RIkTfprUHCu4nggmrkxfcPiW4WPEIJs5gatIhrebV8Q7sMowOc9QzP4r3qYpyJUTw0IibhdJEPctbXIFTuwf1rna52/cEAX63mp73w7FDAACFQyr9i2mgPQn/abg7tZc43/YjvkHWGpL4O79Kyt3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062812; c=relaxed/simple;
	bh=NkIMv++L1mEqQOA5LRYcZTVBj8qjzENzYiUj0qsqzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QldrRGl4/5p++33rnlAlq2tPTlzpoehYfgBLbyogkuE5xOF/T3XHr6D7d9n4JV3pP8F43yL0djOc4rqugtTN5zr1jodLQQUhGT+2HB5P+fOyhWHFfqGWL/ejTmxDhNfefh7hHpwVvrV8dz8rh7fxiJugY3Moxo4+2azQKYa/AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR/UikHk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR/UikHk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edb40f357so24240325e9.0
        for <ofono@lists.linux.dev>; Mon, 07 Apr 2025 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744062809; x=1744667609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SrHZ2ynBzknH3v7AxX1/4h77h3w5HlDpUP0GRnWKCc=;
        b=CR/UikHkZJQIR78aazjlrKP80FrvM1CjwuqZ4BBe0j4T6vjcHC15ybQRZRzXqejSZw
         H4H9259u/R8q2Q814JyyYnD1O/iFUbYetDhtptZAot75Y69seth2zP3o2EVh3bvtRUJj
         zLYmpmF9prVCJ7waB9mNP0qZQ9qcZ8IUV9RMy1g2vOCQ4qqnLyC5Yhevzgp3hRBtGIZX
         +hFrsA00vW0io59CPICmqIzbdGz2y1jCucCu37nZYsOm7HvvqjEJbF5twj1KV9F6gI3f
         fq9iHgSGazCOni+z2PG32EUr3OzSiKCeXqQ+X6bqQ19MFC+N2lPu3cPdzPXWPnMm/UZ5
         l8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744062809; x=1744667609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SrHZ2ynBzknH3v7AxX1/4h77h3w5HlDpUP0GRnWKCc=;
        b=PL+ijIBrbtH2pfCy+vp6yGv3hl7DY/MgWwhpwxAeJcaBIrt/BwBSIsjFDlnU+a3W/p
         wn6mCgIYEjHWqAW2yaFu5wQWuMkvJo9PQCynNgyFM1VKKZXGj992k91tPs8QZLYifibm
         UYIHUTVfbLWpEhd1ro88u4mH7fFhJvp3mNV9p0NJ6l9//qYXwKPPwgGcTieRVC9DItwH
         A7H41VR9ZrEGnnW3dHbxmkXtaALPSBB+vAo6DOJGZMdlZFeW6o9xymsJWLfm4/24Sxlu
         TtqbiyCyDLcZbYcbvceHT5Tap+0oQ9T8Mod3bBj2G/2EtGlURspsOEKqVxd+DzT08aa/
         pP6w==
X-Gm-Message-State: AOJu0YxF7k46/XFeVemr7BmImc0Z3ZDbOITIcz+CFTvlwAZcNc1WokfW
	mHiEFXx5JgvMEHjkrZXCyc+8yid+CX8sji6+OwVkaoSn7wOc7vklTSgPGoZK
X-Gm-Gg: ASbGncupNiCMAIEZoMfnBuYLHc7C4VTUz3PuhbOkLPZpr/I7053UmehO5UUNnYZnGu6
	eJSThkO8Cf6PF3EFr8D4ZwNK39W+L2D7/n32AhEass9/0XXTvdCQQTx78zqOS5Myj4gq8DuvZzs
	eToVmcvUYPYqSlhmsubq3FNKWJgHL183FgkHUUhx0CtHyTiBEA5x6w53xI4kCn3eK34KJd24GCv
	+OyGpSmjFqAMb8/529GVHhYwXNgf/SBtKUWgqHB226QdAIItzR+an6Q0UQuAWrSeyFrT+lDzdnb
	vdx7922n9w9UFTaix4LJqAUlrCcqpKGDT664Nw==
X-Google-Smtp-Source: AGHT+IECmuPcEneX6CIjs82cNVFXGWDuAwFLUc7KfQkqavAEnA2lTc7A0OK+HknuMMxUvWqRuV69JA==
X-Received: by 2002:a05:600c:5785:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-43ee0783d96mr94687735e9.30.1744062808953;
        Mon, 07 Apr 2025 14:53:28 -0700 (PDT)
Received: from tpt440p.. ([41.84.241.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2f4sm140343625e9.19.2025.04.07.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:53:28 -0700 (PDT)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: ofono@lists.linux.dev
Cc: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] smsutil: fix possible buffer overflow
Date: Mon,  7 Apr 2025 23:52:50 +0200
Message-ID: <20250407215308.9674-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding the null terminator is not necessary since encode_hex_own_address()
already provides it. The bug was discovered via ASAN:

==2244==ERROR: AddressSanitizer: stack-buffer-overflow on address 0xffffa141b839 at pc 0x0000008d2ac0 bp 0xfffffea95f00 sp 0xfffffea95f18
WRITE of size 1 at 0xffffa141b839 thread T0
    #0 0x8d2abc in sms_address_to_hex_string src/smsutil.c:2418
    #1 0x8d3ac0 in sms_assembly_store src/smsutil.c:2509
    #2 0x8d5fdc in sms_assembly_add_fragment_backup src/smsutil.c:2696
    #3 0x8d4bb8 in sms_assembly_add_fragment src/smsutil.c:2603
    #4 0x88c10c in handle_deliver src/sms.c:1442
    #5 0x88cff4 in ofono_sms_deliver_notify src/sms.c:1638
    #6 0x58b7ac in raw_read_cb drivers/qmimodem/sms.c:403
    #7 0x55e6cc in service_send_callback drivers/qmimodem/qmi.c:2476
    #8 0x549fc4 in __rx_message drivers/qmimodem/qmi.c:801
    #9 0x54cfdc in received_qmux_data drivers/qmimodem/qmi.c:1043
    #10 0xaad880 in io_callback ell/io.c:105
    #11 0xaa7e1c in l_main_iterate ell/main.c:461
    #12 0x807958 in event_check src/main.c:182
    #13 0xffffa3fdf964  (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x5f964) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
    #14 0xffffa3fe03b4  (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x603b4) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
    #15 0xffffa3fe10e0 in g_main_loop_run (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x610e0) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
    #16 0x808478 in main src/main.c:300
    #17 0xffffa36f2298  (/lib/aarch64-linux-gnu/libc.so.6+0x22298) (BuildId: 8e356c2fd2ec1ebf5535228f366e2af8bd837770)
    #18 0xffffa36f2378 in __libc_start_main (/lib/aarch64-linux-gnu/libc.so.6+0x22378) (BuildId: 8e356c2fd2ec1ebf5535228f366e2af8bd837770)
    #19 0x41096c in _start (/home/mobian/ofono/src/ofonod+0x41096c) (BuildId: e672292c782b5f428bf5870e0142347fe81107b2)

Address 0xffffa141b839 is located in stack of thread T0 at offset 57 in frame
    #0 0x8d3970 in sms_assembly_store src/smsutil.c:2501

  This frame has 2 object(s):
    [32, 57) 'straddr' (line 2504) <== Memory access at offset 57 overflows this variable
    [96, 273) 'buf' (line 2502)
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow src/smsutil.c:2418 in sms_address_to_hex_string
Shadow bytes around the buggy address:
  0xffffa141b580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0xffffa141b600: f1 f1 f1 f1 04 f2 f8 f8 f2 f2 00 00 00 00 00 00
  0xffffa141b680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0xffffa141b700: 00 00 00 00 00 00 00 00 00 00 00 04 f3 f3 f3 f3
  0xffffa141b780: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
=>0xffffa141b800: f1 f1 f1 f1 00 00 00[01]f2 f2 f2 f2 00 00 00 00
  0xffffa141b880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0xffffa141b900: 00 00 01 f3 f3 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
  0xffffa141b980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0xffffa141ba00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0xffffa141ba80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==2244==ABORTING
---
 src/smsutil.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 5c9826d3..84895c4f 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2415,8 +2415,6 @@ gboolean sms_address_to_hex_string(const struct sms_address *in, char *straddr)
 	if (encode_hex_own_buf(pdu, offset, 0, straddr) == NULL)
 		return FALSE;
 
-	straddr[offset * 2 + 1] = '\0';
-
 	return TRUE;
 }
 
-- 
2.49.0

