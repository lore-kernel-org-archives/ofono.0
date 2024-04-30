Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90F1F5FA
	for <ofono@lists.linux.dev>; Tue, 30 Apr 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494033; cv=none; b=PRozDCyqVoofFWNd4a1CtMeFV5MHfmLUnhgKUPJDvOK/T8GW4mW+gIbwALbMpNYe/jbjP9tNuOKb0qkVJ+QHbPLdQ5gVLpost4+CkE2D/0AIFu68eooNdDoTTqBwReFEEQejNtBHIcOqGymSJvkCdDhoB0Rpr6GHJGwLglyGms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494033; c=relaxed/simple;
	bh=ztOI5QolSeFg3H16C4IepB4Ca3dc7Sej7ImTBaPv/Sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aVJIOEYSIyn9EVy8yDZzOjNBIqIAiIxVSte1MGhpNOO0QZk2QN+RzXA3G4Qd/Bp/NnnLpYOL9oUprrD5DzQ22Y5q0zXEBEsg0ULwmUDvyE+bzTZA01uv9+6WWS0d/8ft3AsWL81AK2rGcNiBDFfJcj/2gPkmP8TD2sXFha0jl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn3gHGu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn3gHGu8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D34BCC4AF18;
	Tue, 30 Apr 2024 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714494032;
	bh=ztOI5QolSeFg3H16C4IepB4Ca3dc7Sej7ImTBaPv/Sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gn3gHGu8HpiS5DAr9CN7XBbFxXv8P4GVFUkgw4OtJeQzLAxynojin1vIZdL38Zf9r
	 5nOUWRI2icE8kWz6BFYYVATvKzPhRxBotFBsMVZrjAS3z6yTeWRfIEEZzrrTmScNhy
	 87qlWTh6wCs1cNX+fcm4nSHh7xJTSeDDcRdjD7NLX6RQK9N+kfrZlWK9/AG+OwgKsA
	 uwGCFbdnQx6QzNRysUHdFe+89HJnOi07OMOQ75iH2n323M6qItswP6D00v9ACDkUiG
	 Proz9wSDnc80TmgnrZJICPzxpklB8BFDzt0znZlE+4/zDN570WPIz1pe03aZF0Z6BA
	 DiiZA27EZB3+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C06FAC43616;
	Tue, 30 Apr 2024 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmi: voicecall: Reflow the logic to avoid nesting
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171449403277.567.5586601630790943853.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 16:20:32 +0000
References: <20240429212640.11474-1-denkenz@gmail.com>
In-Reply-To: <20240429212640.11474-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, adam@piggz.co.uk

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 29 Apr 2024 16:26:15 -0500 you wrote:
> ---
>  drivers/qmimodem/voicecall.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [1/2] qmi: voicecall: Reflow the logic to avoid nesting
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c5afab6e824c
  - [2/2] qmi: voicecall: Add free on the error path
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3365880efc45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


