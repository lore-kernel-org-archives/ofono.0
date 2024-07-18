Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399F29A1
	for <ofono@lists.linux.dev>; Thu, 18 Jul 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337634; cv=none; b=gUtQDfCF17yTTKV6Sgb7oB3lK5PpDtxxhaUi3+oDsvho/cCuLgsRGEM6GrqBRqpheIB5tDi1Ua9m8HrvtHaMR7FXLHaPjF+UlKvJNqykD1X7Qrp3MT4fQmleyeT3M+JF0NTb7kWJZpSSn6XGXu8/hAlsYQt80UUPAbhOmeTTARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337634; c=relaxed/simple;
	bh=m5RHqb3tEgqzM+dPOIR49kCe1Z3mHAwZksCk4kAmtnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iSm0kRwWDj55Hf5vX1CX5m+kKcrDOIbjoJwnhqnMHH9XGd0a8iCBTZflPjpyVDr6ItIRGNNo5b3uAQXdqI1RezjC8wLncG2sAjp7nWKFqifQqnDtdkDlorqxGo0gzDEoGvD+w5HfeQl3WJeP9cY+aDGKr8oowZY4dw8nSbu6JaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXco+dbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXco+dbi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81A5C4AF0B;
	Thu, 18 Jul 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337633;
	bh=m5RHqb3tEgqzM+dPOIR49kCe1Z3mHAwZksCk4kAmtnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iXco+dbi3auCJq3njmoe/WTRUCbe6OHRaxnPmQojYp5lNgtpYHg3A8XtD75OSPtX9
	 SNAoRtBzHKHjwCh8UgEHw+dyKWxv5LrLYpSMIdVcSiLQU8wNZFa1E76TaE61EwZN/B
	 PUB2v4BW6Yspsz5DH/g4cBTqxYEJUfyhrTNqCyrJta8QiIJahsVI+qBYIlTnrMR9tc
	 +By9ZBU1XJd5kBoxVwmEZTLJyfNCo0o2ITOgOhuEoKRCq9mKX/m0gYQ/s3rryDIxz+
	 y8QVfNNmBtl331VmKVdpF1gf+LSUys/R6807QBu2IGX6pWeA5nI845Z1u67ml/HQ4s
	 VDL+mRly5cE6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7FF3C43443;
	Thu, 18 Jul 2024 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Fix issues found with static analyzer
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172133763381.16613.17134476287823045894.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 21:20:33 +0000
References: <20240716101136.44583-1-m.rudik@omp.ru>
In-Reply-To: <20240716101136.44583-1-m.rudik@omp.ru>
To: Max Rudik <m.rudik@omp.ru>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 16 Jul 2024 13:11:32 +0300 you wrote:
> This patch series fixes several minor issues found with SVACE
> static analyzer.
> 
> Max Rudik (4):
>   stemodem: Fix possible NULL dereference
>   cbs: Fix possible NULL dereference
>   stk: Fix possible NULL dereference
>   call-settings: Fix typo
> 
> [...]

Here is the summary with links:
  - [1/4] stemodem: Fix possible NULL dereference
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8bd3d6573a85
  - [2/4] cbs: Fix possible NULL dereference
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5b528ee0fa69
  - [3/4] stk: Fix possible NULL dereference
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a4efa493a6aa
  - [4/4] call-settings: Fix typo
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=40eb7863661a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


