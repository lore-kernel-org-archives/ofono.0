Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAAA35
	for <ofono@lists.linux.dev>; Wed, 21 Feb 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556429; cv=none; b=c9Q5rG7gjo7wefKe1U4F5azv9FwRlwRzPgvIB1lNt1TUBFmvn32f7/n/sZqDty1phxlYH1hAjxFM+UHJczk8Wvs6QP5nEGLoI9NhBImsC6i2k6TFyS/7hqzy3EnxVerCAFhnT1uIfRxbn3jZyF/tKoDkwoW6UlZQsg6rmdQimBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556429; c=relaxed/simple;
	bh=P1+NnxO1s9odOSks/M/u9yw96OnvzTgsrw0FwTO6Qd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbKyozJLqWnjdRhS8Gm/bU1vck4DjPUvLlsizx73POQuEjRhv3D6X9QmLBC78egCIbUu6hatEFp1nq90fvFs//2qnnf2RGdutFnRasMY3p3fI3bAMeqhQESp4EPu/UBXFrOhTD74o+6GiQgqV1M71Pn55RKDbr+sGBUS85iQIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeJmNeK9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeJmNeK9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0498C43390;
	Wed, 21 Feb 2024 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708556428;
	bh=P1+NnxO1s9odOSks/M/u9yw96OnvzTgsrw0FwTO6Qd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WeJmNeK9B8OEQwV7th7g1DKgc12ocekHqv7r273bhMxUO/Es8vc8d18ou6I2mZ2jm
	 49XnDpgK5gB45no3pbF4C+gCa/Y6GgfbtpX3/ZXrXH3kOv/BjHdcKV7f4+J7f5HV4E
	 nSHosCPb84q/D0wxqi1lpxh4gdczW1fzOlZ8M6d8lD9JLlsmlO00XuBrRJml03lcwB
	 qnNO3J4sHRabUhA5jpX8+m/9CqGepaUdGegEzOmscStfO3gVh8VhS7FaYnfbw5Hs7z
	 V/16sGPAwIIl8ZOIroOHkcapchYWYAsIArCN/RXFFokP6b2zmibq4D73sI/0/rwTtl
	 j2hLnSoPGNtlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99782D84BB9;
	Wed, 21 Feb 2024 23:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/6] qmimodem: Use l_queue_remove_if to eliminate double
 lookup
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170855642862.11758.13526244904604383397.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 23:00:28 +0000
References: <20240221221725.185480-1-steve.schrock@getcruise.com>
In-Reply-To: <20240221221725.185480-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 21 Feb 2024 22:17:20 +0000 you wrote:
> ---
>  drivers/qmimodem/qmi.c | 50 ++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [v2,1/6] qmimodem: Use l_queue_remove_if to eliminate double lookup
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1efef179f088
  - [v2,2/6] qmimodem: Use l_timeout and l_idle for discovery
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ae0392353d8f
  - [v2,3/6] qmimodem: Use l_idle for shutdown instead of g_timeout
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4947c7980add
  - [v2,4/6] qmimodem: Use l_idle and l_timeout for service creation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a42c37eee09e
  - [v2,5/6] qmimodem: Eliminate glib macros
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d0386f3af377
  - [v2,6/6] qmimodem: Use l_free in qmi_free for consistency
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ae353c641101

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


