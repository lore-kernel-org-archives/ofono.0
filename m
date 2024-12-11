Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF48133987
	for <ofono@lists.linux.dev>; Wed, 11 Dec 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931019; cv=none; b=p4mpSYVwGsyRc/UzX3LRAbZL1z4z4C4AXic8GOq7VaLQPYRsT+Ki7bebtfXEEFIxEiLSmCecrFPy76sI+q5ejF9C6qv2oU85hR+7fWghtJW3Ub/WCAjILzdkLKpxSWxZuhQK0Owo6RrR3te77LC+CcyE9Yij0SMcRgc5o/jl2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931019; c=relaxed/simple;
	bh=+L5spoPlFi7FNqNpbloYYNH0l6m7nv9r6oqT/Atf5LM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F1+5JDI2SB8jfD2Z15CYKM2LVz61aReH/aqTBShJVkBbDfx6Jcve4xDXYRnp+idXZkb3y0FI6c4RNdQg9/285yw9o42iWKOyCZ3GVRe5qf3XCYBMLbpRSAUhBagAzV7j9exh6or02ag6Ad+a57ITRuGk4c22eqfvdd90+Ah3RXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T27DFaOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T27DFaOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F3C4CED2;
	Wed, 11 Dec 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931018;
	bh=+L5spoPlFi7FNqNpbloYYNH0l6m7nv9r6oqT/Atf5LM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T27DFaOe/E9HoSlCVN78+gzezSpzTi2YwuXjf3A0ScFQEJPzwNYeLD0y5AfMbY/LD
	 ZSItGNfaYtAZnkEw0qNbLUW5EBqn3YxU1b3QVTKIPxCApTmQrTScSjFtlmZuGgScS3
	 VM5/HQ8kw9nIYuk55YKcm8FU6a4lhJyPFYD/6j1jnAST7aKlw/b1VJCh1G99yzhnHV
	 WgAyY2geWsZTs0T+8EYGOWVdgA/tpXVCC+4haxWLEonpEcsQlDCN6/VeZwRv9NkZ+Q
	 2vWKVSJKQ4pRORd8dYHmhEGq9h0T7K3VEsOmrrg53oMztUcoBCcsoHRKcGD2u3mG2+
	 INbN7abmoyq4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE936380A962;
	Wed, 11 Dec 2024 15:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qmi: radio-settings: Do not unconditionally try to enable
 unsupported modes
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173393103476.1613068.18382064663477019126.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 15:30:34 +0000
References: <20241211151633.495534-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20241211151633.495534-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 11 Dec 2024 17:16:33 +0200 you wrote:
> At least the modem in Motorola Droid 4 errors out if anything else but GSM
> and UMTS bits are set when selecting preferred mode. That happens if 'any'
> mode is set.
> 
> Fix that by querying supported modes and passing only those for 'any' mode.
> ---
>  drivers/qmimodem/radio-settings.c | 111 +++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 34 deletions(-)

Here is the summary with links:
  - [v2] qmi: radio-settings: Do not unconditionally try to enable unsupported modes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b1f810f218a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


