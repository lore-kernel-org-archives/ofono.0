Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090713E7CD
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239234; cv=none; b=DLtbl0jjylJWLj+dV1bY1m3txa8wH9um/m1vmFgTW2fofvhYDHIBleszHMi7B8Hok2BJa9dvIF3BgKy2DKQjw4EQ+cB6f6HQdD0hoGt8IgmrZd5cJQLIWCvfE67rutvBBDcgcJoXgFmDJjM7SXEm8KsR2Uy56pk54O3QVq9v2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239234; c=relaxed/simple;
	bh=OVEP758yXPmyFZ9YnavPfKfz7R5Rhdfn7ieRA6qdd0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qcvj8syyO/Fc7JRnyuXKRRNfuyAI1QozxzGORLVdn7XYkNtdg10XNWdDuxJuWS4zU4M2AkT0cIbPSKSFWPWN75L4gGJ7AD1+j9fqyg3y/m1cjunz/ET+fWdUKffoD1M7IbHC/QRT4obWcni0WMECpWTgJAtnZSOhM2Lm+qL+FTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh8eKmAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh8eKmAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFB8C43394;
	Thu, 29 Feb 2024 20:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239233;
	bh=OVEP758yXPmyFZ9YnavPfKfz7R5Rhdfn7ieRA6qdd0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jh8eKmAJHBGLkRlYl9kF3KizFhSS8DApNHqICSysCXkJHjF/0wDQhTfHfpUF1+UAU
	 4eAHZNH6UWjw8A91gQhV5OE2OxOiRbzAPfRw5NCCmtWFQHbEbjLplhw77/nB4IVerC
	 bbzrILaKrWLZGHQw9utKqfcSm+QGPeT5nwx1dyxoxTh9O9Rt5O2wd87lQlFXklVIvd
	 mBg3tPuF4IAU2gQAT9cdmAdaI6nsySp1d3xdSZ94neI9kVBneKfMZV/E1dkJ/bIX6p
	 tyabHJHKeW+QCzmjV5U/wuOGw073K3lY2zlAzRi/Lqwhvm4H06Rfb6Lkbpg3wSg1Kk
	 Pfm0n9bbiYwUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B91F3C595D1;
	Thu, 29 Feb 2024 20:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] voicecall: Drop unused GError variables
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170923923375.24686.15540341116437626583.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 20:40:33 +0000
References: <20240229180746.1671015-1-denkenz@gmail.com>
In-Reply-To: <20240229180746.1671015-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 29 Feb 2024 12:07:33 -0600 you wrote:
> GError return variables would possibly be allocated by g_key_file_get_*
> functions, but never used and never freed.  Fix that.
> ---
>  src/voicecall.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [1/4] voicecall: Drop unused GError variables
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8165dc6c175f
  - [2/4] smsutil: ensure the address length in bytes <= 10
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a90421d8e45d
  - [3/4] smsutil: Check cbs_dcs_decode return value
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7f2adfa22fba
  - [4/4] simutil: Make sure set_length on the parent succeeds
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=07f48b23e387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


