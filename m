Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC614A4E7
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456015; cv=none; b=hb6FBsAMv46og2PcY8l0lFTBQ+kC3ACjJA4+E07eeqQLuFdtwnghQ849KSCzyjDqXUCykdh8oPKS1SvEmmH/tv5RbNc3tXSteCRnERxKoZaYkjVH4Bua55rz3PS4pS9HdJb/cOW+PBNkQm7Aau1MVZUntSbj+04Ebb0ABpaN5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456015; c=relaxed/simple;
	bh=+wP3U1iC2H43hQrODEoYVeb+b1ybfPGuxKhE+VEnYes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSJV/kHkocEtX3PT1SdvggJxTlv59z91t1PTAyvlTx8lJcC91gtQm41KSHx+4Flnyz0XxSUGBoiaL65oXfmkU9lOoYMgd5INwIEQ3KtQRcR0CRlUsCyBef8/0pmb48LkeKZsItGBtFeqtfEqtqEAYBIyTlRcqjZwOYIJ87SEuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhNXjS1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhNXjS1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B427C4CED3;
	Tue, 17 Dec 2024 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456015;
	bh=+wP3U1iC2H43hQrODEoYVeb+b1ybfPGuxKhE+VEnYes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YhNXjS1FPJldjpDmAkljKcLMR9Y94M+C9SQhnQe1O5wlYiGIZiB/p2BWLSGbNqYGZ
	 ZHX72laJJSyK+IYjQXZRs22/EF5Ocewrc3Xku3KR4NZioLRyWQM8hswIBZuJ9DpaO0
	 POOWEVKu0BgNENYrSuYRauIgaVHtx6Vu0T9fUMIFhm0x1S3udhZOfu/Hy7bXYMT9sv
	 iSFoJuR81Xi2oxwDSPJCUsT9bKBgZJ7BjIWTvKHXnsLF/ZVHfFYOARJrfiGxV693Kv
	 STkXfybY4ev7xSTDlbynVobJrH0gJNdHST0T1vEnpXHrdMmHabCgtlkZuUjIhOupvV
	 3YyykwPUjLxwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AED6D3806656;
	Tue, 17 Dec 2024 17:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] util: ensure decode_hex_own_buf is passed a valid
 buffer
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173445603251.971982.3797684179170879951.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 17:20:32 +0000
References: <20241217093207.20636-1-absicsz@gmail.com>
In-Reply-To: <20241217093207.20636-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 17 Dec 2024 11:31:27 +0200 you wrote:
> ---
>  src/util.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v2,1/3] util: ensure decode_hex_own_buf is passed a valid buffer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1e2a768445ae
  - [v2,2/3] atmodem: sms: ensure buffer is initialized before use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=29ff6334b492
  - [v2,3/3] ussd: ensure ussd content fits in buffers
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=389e2344f863

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


