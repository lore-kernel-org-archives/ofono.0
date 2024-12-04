Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0FA2391B0
	for <ofono@lists.linux.dev>; Wed,  4 Dec 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336418; cv=none; b=jb+AKKXhH/zWbLWOth+fd4ImSI/D3bzi7553YsScvzrS+NIOgdH0l6QRUr/y1bGi13LC7ah0aYmDKFnEQfyukwbEugoAZfjBEm+Af2+jEq27kcdVU027DQ3/kgTqDh3aF0bDX4XgnnIFbEBXCyvFah/AD3qf9MAynOQc+MdN/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336418; c=relaxed/simple;
	bh=WX/5gv0z36IFywLW3Af/1i7igwsktb+LtYZuUX0A5EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WkwQqmDpbjTm4jqhtan1fUvkv6h+ODUNjgNPrsi/fFutb6zSk7JUKOn+8LtjblM5/d8ot4Sq0mDGeNYkmWFkbTxBboY1AAkCPsXiTpf1fZr3tjED8Xb9nk35j/r9jbnJeGzN3Q9u7DEc1UAFAtNQVlGhAVV+O55LN2JE+SyGdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuNhaR+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuNhaR+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F0C4CECD;
	Wed,  4 Dec 2024 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733336417;
	bh=WX/5gv0z36IFywLW3Af/1i7igwsktb+LtYZuUX0A5EI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DuNhaR+Q1SV5aChvaDiv7WghRZB1SagoOYH4zlDfpgkNOxFf4tOHaIqEK35PvFY4K
	 NcTUKbLmucqm4mkeExs5MAhLoBHBEMfoMr8vaU+LVSSiTS1KGkQdWU5stLEpR22iD4
	 P9dZLm1Rk4nco5AhlpQHaCbQPyN6wngaMNLkBFxh/rG7iWmF33zwgnOnJz5P+g83B/
	 WbO1/QHh1T9P5RoKXjFLkEezi63e1r3qaI//GrNzDgjqPWw34xbq6GGgRE+VssDBVM
	 yms2mzpeLa7qZdSoWUDs0RoGUJDO7Zab8+Z4HrXpsMNwMm44XrNmriRIfl9xkfYHF7
	 pQyfjXkqaRT0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3F73806673;
	Wed,  4 Dec 2024 18:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] smsutil: check deliver reports fit in buffer
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173333643152.1291489.12346039128484654720.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 18:20:31 +0000
References: <20241204082207.24692-1-absicsz@gmail.com>
In-Reply-To: <20241204082207.24692-1-absicsz@gmail.com>
To: Sicelo A. Mhlongo <absicsz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  4 Dec 2024 10:18:51 +0200 you wrote:
> Fixes CVE-2023-4235
> ---
>  src/smsutil.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [1/2] smsutil: check deliver reports fit in buffer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=02aa0f9bad3d
  - [2/2] smsutil: check status report fits in buffer
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2ff2da7ac374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


