Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E538F80
	for <ofono@lists.linux.dev>; Thu, 10 Apr 2025 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255797; cv=none; b=ShaUChDq3pKYhQ7WYqDbjtGdD+zGix7i6Av2fBsNyKoKwKTYnu8UeIGnyLPrGFHdo7hJXrodgkDaBV0t0m5e89QhN0JF0J5Meu+tuHo5JJorVu7DwkXbhHn33sg+3A9OKBlKOxbQEAL5hjAYfSHjGmnBrqIKXT1CGE3s6f7wP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255797; c=relaxed/simple;
	bh=TvKfXgP2qWsGofUfN491JbJqu5lL/WvCvpu3qdsg8qw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ou6SQMTV4MhttO1eD36h0Vrn3MxxcUx9JY8vbfuVRnG4kwO+Umch6won/otuqCEx/Ewmasz6hzbTXKHL1eCBz2q7iaxo43vLAYWj9eBRERTqqOs+pB8y5FUsVuK7amicjSaK5DviMHjOI9COYzr/uIqqKB1ixAqp/hALMRAHjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYqclywm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYqclywm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E17C4CEDD;
	Thu, 10 Apr 2025 03:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744255794;
	bh=TvKfXgP2qWsGofUfN491JbJqu5lL/WvCvpu3qdsg8qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OYqclywmePwYLSnoR+4aB3YrX8iw0PstYBchb15KlaMwTaooLOuGrdIw5qgusojky
	 RcucY52NyOzlbKit6zatvNGVYQ0IHvQ5DDQ+Y/eJjQP30yxBuj38fkq3/sN4b1XYn+
	 vVd4ofkxSIHznkD6Qr6pSOKzplnIE7+B+DVDa6RxJSci1nPFz4wUShjlPrJPLxF0dw
	 cM4qkPKJleE0YMhNXvH2pQ3eZiIQbT6xD8lQrBIMLsNHnuDcAzOmJ3OELppIiC4rbW
	 1oRouRIRSAGXcYq+pAyq4hInnQnqmk3ECo5JYlwYer/S3PMwZQ6/WJ9f9aoyhktDYo
	 Yo/NlCSuKM3qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3439D380CEF9;
	Thu, 10 Apr 2025 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] smsutil: fix possible buffer overflow
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <174425583201.3136865.16589582099784143392.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:30:32 +0000
References: <20250407215308.9674-1-absicsz@gmail.com>
In-Reply-To: <20250407215308.9674-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  7 Apr 2025 23:52:50 +0200 you wrote:
> Adding the null terminator is not necessary since encode_hex_own_address()
> already provides it. The bug was discovered via ASAN:
> 
> ==2244==ERROR: AddressSanitizer: stack-buffer-overflow on address 0xffffa141b839 at pc 0x0000008d2ac0 bp 0xfffffea95f00 sp 0xfffffea95f18
> WRITE of size 1 at 0xffffa141b839 thread T0
>     #0 0x8d2abc in sms_address_to_hex_string src/smsutil.c:2418
>     #1 0x8d3ac0 in sms_assembly_store src/smsutil.c:2509
>     #2 0x8d5fdc in sms_assembly_add_fragment_backup src/smsutil.c:2696
>     #3 0x8d4bb8 in sms_assembly_add_fragment src/smsutil.c:2603
>     #4 0x88c10c in handle_deliver src/sms.c:1442
>     #5 0x88cff4 in ofono_sms_deliver_notify src/sms.c:1638
>     #6 0x58b7ac in raw_read_cb drivers/qmimodem/sms.c:403
>     #7 0x55e6cc in service_send_callback drivers/qmimodem/qmi.c:2476
>     #8 0x549fc4 in __rx_message drivers/qmimodem/qmi.c:801
>     #9 0x54cfdc in received_qmux_data drivers/qmimodem/qmi.c:1043
>     #10 0xaad880 in io_callback ell/io.c:105
>     #11 0xaa7e1c in l_main_iterate ell/main.c:461
>     #12 0x807958 in event_check src/main.c:182
>     #13 0xffffa3fdf964  (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x5f964) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
>     #14 0xffffa3fe03b4  (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x603b4) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
>     #15 0xffffa3fe10e0 in g_main_loop_run (/lib/aarch64-linux-gnu/libglib-2.0.so.0+0x610e0) (BuildId: 3901bdcbc847d04fc971a1923bed26ef7d9b81e4)
>     #16 0x808478 in main src/main.c:300
>     #17 0xffffa36f2298  (/lib/aarch64-linux-gnu/libc.so.6+0x22298) (BuildId: 8e356c2fd2ec1ebf5535228f366e2af8bd837770)
>     #18 0xffffa36f2378 in __libc_start_main (/lib/aarch64-linux-gnu/libc.so.6+0x22378) (BuildId: 8e356c2fd2ec1ebf5535228f366e2af8bd837770)
>     #19 0x41096c in _start (/home/mobian/ofono/src/ofonod+0x41096c) (BuildId: e672292c782b5f428bf5870e0142347fe81107b2)
> 
> [...]

Here is the summary with links:
  - smsutil: fix possible buffer overflow
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9e9c1cb58334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


