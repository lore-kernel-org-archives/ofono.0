Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939991A2C05
	for <ofono@lists.linux.dev>; Wed,  8 May 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183431; cv=none; b=q9nPiPWlqDl2u9K2pv82Difc/1PEU0qWIZzovWLC8rovTNWMOBCDxtW1EBWDgohSfU9IdHxBFW7xieniJEmFnoaM+P2CfSov2pAsIFR9oWvTj6y4on9ztKSmAVDM8zVtn22LOeEuITyndRh9U3a0dFpH8Jgrzh39BCGq+VrtHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183431; c=relaxed/simple;
	bh=PlqLFkWPUVot++cBG3/lJOurBwbeiYbc5zj2yeHskKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qcmkj1BhxcE2ebpqAlW/1Fcp47W/93pEL1px8aoQIZc1BqSLqMYZ3OoWcDZB7AkfR4i5idGIUmKgs+Sy+5gX+gGs9CRhRn3o1X1IS7/vjNspqMOb+6CB+5nZIbZRGhuK2TZ0TDFjusW7jUitCVLWScUWcAr8ubXpER3lsZGpFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWCVrK6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWCVrK6i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41A9FC2BD10;
	Wed,  8 May 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183430;
	bh=PlqLFkWPUVot++cBG3/lJOurBwbeiYbc5zj2yeHskKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWCVrK6i9npwRgNjceTK03coKnEU/gh/0/wciBx5+NBCtD8M4bhZtKDQXAa+KcHxn
	 5Han/BFmZVzm3XLZ/7Ta737opIsq4fC2CpWb7eWu/WI6m6f2ogVjaBAesIZu6eLzm8
	 zo2KqUy899ZpcpRv7IYcwUPC4qigJufsonnfC8BnaIegIH4LzsYhM7xkUFfk5yxFOV
	 cp7cl3RsIIYqh7aqyk14kekTyNZdSpCxH+zbFnTfVi1xgFot8uyY6+dwGvgMHLKDmE
	 XTDx/G2TKT4NAB2TttzH9qVZhr4wDVN1h6DRtG0QjjPj6EqjiloJMO19pyfCysLTPk
	 VbasTsLtOJdaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F4D7C43330;
	Wed,  8 May 2024 15:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] log: Handle dladdr failure
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171518343019.10761.948465647028566910.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 15:50:30 +0000
References: <20240508143844.42060-1-steve.schrock@getcruise.com>
In-Reply-To: <20240508143844.42060-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed,  8 May 2024 14:38:44 +0000 you wrote:
> If unit/test-qmimodem-qmi times out while running under valgrind,
> valgrind complains about an uninitialized value being printed during
> abort signal logging. dladdr fails on the valgrind address
> (0x580BCE37 in the example below) but print_backtrace still tries to
> access the Dl_info structure which is not initialized. The fix is to
> handle the dladdr failure gracefully.
> 
> [...]

Here is the summary with links:
  - log: Handle dladdr failure
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cef344ccf05e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


