Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE11F03FF
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335220; cv=none; b=DeObyai8esUAiSNuqjaA9UlXQo3o40OcuHEIA36CCXFlB/lQSMDcmrr47XFbhy+BjqsktgLhx7tE/C1uswMvDIy5WetQ5diCHTFIEVDXm9Z1Yn/GIKDF0KQHt7a0HuOPAK7yS8uVA5/c+fENBURox1BkW5HL048kPiegWuywSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335220; c=relaxed/simple;
	bh=GeTrqzXBHhSs6AM4pkiR4zYxCONhgPWgaBuNqCBh6XY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DlnL7xRb0G3AsQ+vXFQwGhucMJeZ+6OL5uy/tNYF9D6WVsaoWZIYfov8KJXprEQ7seiU6jilacxJ29ZRFcORai690pgp9uOwmg7VZulfCPl0jt9PuLRKVBF/x8roNcuVYWYiCSCLNUAT1hcKppd1EH0qzpft3zWauGHQd9IYOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwtJ+Ovk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwtJ+Ovk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B254FC4CECD;
	Wed,  4 Dec 2024 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733335219;
	bh=GeTrqzXBHhSs6AM4pkiR4zYxCONhgPWgaBuNqCBh6XY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fwtJ+OvkJwE4h+TWrYQ6j1YqcwxUkiMG7uMthweG1H3b4SjCDT/Vs14veuu88JBjI
	 4eNjXWxfXzhgCku3hBGCCwBUyEU2UtNhVBp/0Fg2Kll0RNoOXt8PIR0WsdaPZ45zbe
	 vQzO3Wtwth61dHp8PmcOcaqgGPlbRhULAc3TSGlO4SZ2avIgJeeK9/Jy+2Q4iTfFKl
	 VT97fU4nHk/Dt/frdNhg76IFvFi11KWEKxtrQVDS2vZXNdVDj50cZ3vHNZfpTMWi6s
	 heTAu5PpFSulHJAkwpNi+lDXGw+9XVvE07T4PJkk2HS6qXL+JD5wI6AbNRkadv1dSv
	 N2SORP+XvGBJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDA3806673;
	Wed,  4 Dec 2024 18:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] stkutil: ensure data fits in buffer
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173333523424.1285999.13862363002678866579.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 18:00:34 +0000
References: <20241204100758.4931-1-absicsz@gmail.com>
In-Reply-To: <20241204100758.4931-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev, ivo.g.dimitrov.75@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  4 Dec 2024 12:07:34 +0200 you wrote:
> Fixes CVE-2024-7545
> ---
>  src/stkutil.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - stkutil: ensure data fits in buffer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=556e14548c38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


