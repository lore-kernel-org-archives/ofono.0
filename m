Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A57690A
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443028; cv=none; b=FjO4BELduEuiPJGJ0ECK855GUFOHDEY76GJ7DdOO3hunBf/d7zJESx5Q/UGipn1HLaBBKIrz2UPlL7TbU2kpr+B4xQgyQSQxxFf/u96Iz1Iw32ZCyu6b2KiGbFrZ95nkkRuCzLitBrGvEB4VFqRzQh0pPwolNOGZP9+a6qpKjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443028; c=relaxed/simple;
	bh=Szy/0mGd8LArqw9Arvz/C5D0iwOda2m5ITXmuyY+C4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m/Pfz+p3LZVTzYa1LXPYBPNGQs7wq1n5yPHEbRwpDHybhA/V3KO6IK8EWs3Qtb9gk14vbRqGaoeu0ubh575u5FelcmjGfczwvO/FAyERYw8WHc7rgLPM+0e/Hxk7cI6Lil9lGA6ZeVU6EDt60G0Ms4k4Yn0VqTQsQLWtn+BMKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DefW907q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DefW907q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 401F4C43394;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443028;
	bh=Szy/0mGd8LArqw9Arvz/C5D0iwOda2m5ITXmuyY+C4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DefW907qqoZioKWszEPi2C/NxS5p6GKV6QMdeQqx05xo286lFNLRzOUJRzIAayFL8
	 5gSV33TeG6fCC3EtvxGTsE+7GO9VXDavq/dx+SLJl5QHSOFNUQdOSPZYw6gP8D3Z2/
	 ih8VyAwkzfN+auELzJiKbqBVn6fOcC56NT/c44w4nzdnjqSUc2VaczjshgsDO6Jht1
	 n9Xs0xnpBLHeoVFhCmSUMMlICkYLsL4PVC8hGwGNHrqcdVnWInDZj2FzJS2RqzJ1zr
	 VjQnN0oqR3VyvQ0HzDR59IY8NS71wZyvZJyrzMA14Uq4XeRtHkH5TULSI5HU4aTOSP
	 TWI6idzjtPzWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 249FBD990CD;
	Tue, 20 Feb 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: call-forwarding: Fix possible buffer overflow
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170844302814.30347.10531500671432895439.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 15:30:28 +0000
References: <1708177632-11449-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <1708177632-11449-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat, 17 Feb 2024 15:47:12 +0200 you wrote:
> ---
>  drivers/qmimodem/call-forwarding.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - qmimodem: call-forwarding: Fix possible buffer overflow
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=befa5fc9629b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


