Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F56FB2
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099430; cv=none; b=qDWxRsMuzYAkJoyz6qDrLf1goUnJycCPX7qkrC3VbP2HZTE9ISkGcpyn2NQkhIrQa9OWFX5HypPevBpmO72YNUc06ibFnTIQdMF3XAvwZRQWD6dW6rHLl56T0n3zzN+qvDPQXdbroywHaWXB8gGBqPipSjZj543e9+hwYQKjLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099430; c=relaxed/simple;
	bh=eBg5Di5LEp37zjCACJqjlgRPRaT8WGVoTo+mz3ji6cI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H95N3yXpeRV7NAU+Jgxh+TZ2duJVkOuj1VgSSsi3T22g50c2i3nC5itHkKBgmgoL70zDcRI9Q2V/p3OeA6rkWMKlQqkE+ti7MRG+Ue89uyx69H9VWpk64WiYKQBwCvVCtr6XvmMjucZccVAgZUEwSJfTVz/D1hNXXBc4qJjnLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A13r03fc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A13r03fc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18E4BC4AF63;
	Tue,  7 May 2024 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099430;
	bh=eBg5Di5LEp37zjCACJqjlgRPRaT8WGVoTo+mz3ji6cI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A13r03fcA4JI95sMzRU6GFYckvkUaDEwQ2JIXYCOggUsLa/5DHWzF8ZD6CWQx5OU4
	 o4q6H/BUAOWqUs4AvZKftzf9+3ssVemmfbd3QLjoC9DQoITT566sNtHYuLbEMWlIXc
	 bm+NZDUqiQLNf/eqwfD3v8DvYS+7EtP/ayuXeRmtMOClaCbOTH3qzGPjiNVnL13b+U
	 LZfdypstCMs246KwfMCK1FwBQenUk49HV45NVW9qdLNnPNUvi4U59OHz3T7d0LvcuZ
	 qnqcV4uWG8QcDMsK0TlekmkCRLeBXVg+jBSRbaHFil09Nh7dG6txV0sYtfPbJ7pC4H
	 5LAB8LloUAPMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05C39C43330;
	Tue,  7 May 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: Fix error path memory leak in gobi
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171509943001.26156.16901924428295697285.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 16:30:30 +0000
References: <20240507153408.681340-1-steve.schrock@getcruise.com>
In-Reply-To: <20240507153408.681340-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  7 May 2024 10:33:58 -0500 you wrote:
> I noticed this leak when I terminated ofonod while gobi was retrying
> discovery on an unresponsive QMUX device.
> 
> ==8257== 20 (16 direct, 4 indirect) bytes in 1 blocks are definitely lost in loss record 31 of 154
> ==8257==    at 0x4885118: malloc (in /usr/libexec/valgrind/vgpreload_memcheck-arm64-linux.so)
> ==8257==    by 0x5A4737: l_malloc (util.c:49)
> ==8257==    by 0x4669E3: qmi_param_new (qmi.c:2374)
> ==8257==    by 0x466D73: qmi_param_new_uint8 (qmi.c:2449)
> ==8257==    by 0x47D717: gobi_disable (gobi.c:482)
> ==8257==    by 0x51BAD7: set_powered (modem.c:986)
> ==8257==    by 0x51E8FB: __ofono_modem_shutdown (modem.c:2279)
> ==8257==    by 0x518233: signal_handler (main.c:85)
> ==8257==    by 0x496D14F: ??? (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
> ==8257==    by 0x49CDE47: ??? (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
> ==8257==    by 0x496DBFF: g_main_loop_run (in /usr/lib/aarch64-linux-gnu/libglib-2.0.so.0.7800.0)
> ==8257==    by 0x518A23: main (main.c:314)
> 
> [...]

Here is the summary with links:
  - qmimodem: Fix error path memory leak in gobi
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d5d99ff50355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


