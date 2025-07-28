Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212222B8C2
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714189; cv=none; b=RG3whlM8xmE8abD89dIkhY/EQ719R7favxjBaaJAOPoFlqMXIthjgn6anGkpxywYDE5gpB7bh6mRF9unh6bB1n7TG1jJyfO8UBH7Jq4gNILlJhEA0izHCyCZVuVft9D1EFfYpqktcNGPP9AHJFo5on9MfbSy2hA9Mkl6bm+x45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714189; c=relaxed/simple;
	bh=2+XZ1qrU8yimalrWC/L7wKuaGb0n62sAUbsU3XFoepI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pq3zBwZJnOdHggfvlKf6TejY0kPl3MeaWVQBACSQ0yvS4hmF4NpK4mFLYRYHFX5y31I7pvIO7dObuNcZpPjFFc6L0qWpbGYBccUh238AtFfqQT0jATDOWZsokXg8u9LibbMmm+hLr2ogYAMaAaW2GAEoo/x/bc2FH6sdsWx0GNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slvI9ZLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slvI9ZLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AE6C4CEE7;
	Mon, 28 Jul 2025 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714189;
	bh=2+XZ1qrU8yimalrWC/L7wKuaGb0n62sAUbsU3XFoepI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=slvI9ZLWadH6eRATX2cDO0IsgWWpQaa66bP7XauMyDtHHF/OgDIpX3wnmGc8PtrNt
	 W+q9V5Jgzg/S7B+ix0ROxxyGMq38UjCTljOHaftwXCyF1rtTjapbOAyVUz4dO+Kms0
	 t9hQ3tzXp73m3Gp6HK9poEBbzoOVe06TE/3FwQ0Es1CgFe2SK7Crj+I9Q1dC/s26AJ
	 hSF6fDafCBG6ZtUdHo3JB8StBKdPqAnaEHWY/U8toNBGX+ujuU+knuE3I4ko4xZFHS
	 HSVtw+KZd/fhxvS1YTeC7go6/44BzuFRSHLK73B8v23T1T7e5WQcaRZZj6kjj1EGS7
	 Wwrr+k7P2Te1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD38383BF5F;
	Mon, 28 Jul 2025 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [0/6] droid: migrate to gobi QMI driver
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <175371420575.733265.3516017452180532925.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 14:50:05 +0000
References: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
In-Reply-To: <20250725121954.650668-1-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: ofono@lists.linux.dev, denkenz@gmail.com, absicsz@gmail.com,
 merlijn@wizzup.org

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 25 Jul 2025 15:19:48 +0300 you wrote:
> [PATCH 1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when
> [PATCH 2/6] gobi: fix start_service_requests() return type
> [PATCH 3/6] gobi: request PDS service if supported
> [PATCH 4/6] gobi: Do not try to create WDA service if modem does not
> [PATCH 5/6] gobi: Introduce "LTE" modem property
> [PATCH 6/6] plugins: drop droid and use gobi for droid4 modem instead

Here is the summary with links:
  - [1/6] gobi: PERSIST_LOW_POWER instead of LOW_POWER when disabling modem
    (no matching commit)
  - [2/6] gobi: fix start_service_requests() return type
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=9e82a797ac93
  - [3/6] gobi: request PDS service if supported
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4eeededadedb
  - [4/6] gobi: Do not try to create WDA service if modem does not support it
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cd28a73c6373
  - [5/6] gobi: Introduce "LTE" modem property
    (no matching commit)
  - [6/6] plugins: drop droid and use gobi for droid4 modem instead
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


