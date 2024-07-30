Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA31AA3F1
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367232; cv=none; b=RVf5Ni6WJ6K53j3JW53rb11T7oTWG5zznvkQaXshypDisCz0yg6YLsGFhnU3UaN3wC7ohOdm0UCj4PLB32KTdywWzHbI9+2RqbdxUozNRrJBsPPpBxObHeE+DZjbEfEPUZdoGzYD+B61Eb7rRJeWTnoOYE9cgYDeGa2Lz/QI+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367232; c=relaxed/simple;
	bh=WGF6A6WJnFp9xT5a1pJ6DYGVLhNQINRek4QfjHaIYHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jztvk/OmzVHIkrK9CHuYYMNIQ8qwZ3ZBLKVBe7to5DFP3mz9b+7lxLF4S2+DKcZiJpTPG4OUwGAqQyLAc3ltl27Db2cggNBk+kZovIglW8G8KOHUKDMXWEqRHPYIDs/jKUxXFUS0xNEwEGwafqs81xdAtKE403TdrBMDodhydxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSjGX2iV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSjGX2iV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACC88C4AF0A;
	Tue, 30 Jul 2024 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722367231;
	bh=WGF6A6WJnFp9xT5a1pJ6DYGVLhNQINRek4QfjHaIYHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSjGX2iVHCiT8dF/Pck8JfcmvEq/GeYEcLMLJiijADbCeQ7zjs44Vb8abbpQ7Sr2T
	 beo3REkyz/l4epv6IVF7gdA0AY/EczhfyoFeMCipdCiA1sKHfcYXobG1e8lYI9I7Ca
	 4Xi+aeHLnO2yO1zBda0EnIliHS7FoMPTyjF+fnmU87R9jvFtdDxdVABjwyoG+WkBZG
	 75X9SsQXtuU5B08YA/mcWvtm2d+qM4viNvhJedxzafTTfJtV7RTMH7RO0Pmu+khPE1
	 7BFrefSIhu9JHG2PnUPEnIugz7k0dejC/h0JGEfl2sHooeqohiTkYQv8Wdf8qP7Nq3
	 MoGz3Y6e/ULmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98C67C43140;
	Tue, 30 Jul 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Fix use-after-free
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172236723162.17027.3698220805508786713.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 19:20:31 +0000
References: <20240730091332.20031-1-d.grigorev@omp.ru>
In-Reply-To: <20240730091332.20031-1-d.grigorev@omp.ru>
To: Denis Grigorev <d.grigorev@omp.ru>
Cc: ofono@lists.linux.dev, denkenz@gmail.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 30 Jul 2024 12:13:31 +0300 you wrote:
> Hi Denis,
> 
> It looks like the static analyzer is reporting a false alarm and the recent
> change is causing a regression, so I suggest reverting one commit.
> 
> 
> Denis Grigorev (1):
>   Revert "cbs: Fix possible NULL dereference"
> 
> [...]

Here is the summary with links:
  - [1/1] Revert "cbs: Fix possible NULL dereference"
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=91e7548b52b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


