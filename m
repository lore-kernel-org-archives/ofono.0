Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE14156237
	for <ofono@lists.linux.dev>; Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720415; cv=none; b=jSGBIm2zNt2N4pnJaoctqCyc+gA7yeLh3V35dTa1R2TndEDUg7YtIYq9uux70FuZ/t2WHbscUU8CJL3qpgTzhgPSzRgXzBl//ici9AbcgjtXCnoiLgTvTk2NASseichxIxeuKF4GmOXOZQTSjlz8BXWtnpD3gZJyirg0K5ZzTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720415; c=relaxed/simple;
	bh=iPcwVUcrXn9NX1WcyXp4ojHeTnF1GIKGkKXAjV5/+ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WErewwvrgg8r8lvjITeu9I5Xt6xvHD58oX9c/eX0VCRF+XiVWMnh0ioJ+VzPiwXhj2Yk5ra1FMw/HCvCY5NaEyeetJmWoNC5d5YW3abAc9F70AJgxlrq432g+zHJ7xAgZLMOjoi1fB5guxCGLHRRdDQBCQbcUz+VPpvN/djs/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUu80qvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUu80qvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AF1CC4AF09;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720720415;
	bh=iPcwVUcrXn9NX1WcyXp4ojHeTnF1GIKGkKXAjV5/+ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bUu80qvQMawMS/bgSaVYrpwCGTknquKZO9WSGezEMeIh356vTfDzds13uj0ELI+u8
	 m57pboVlgfGIYtNjs9R8vuivPVvNGUnRfiHBDkRF3R0BrTfR9GPC6IwGEk8ZcdLMlk
	 jhwfqFcwux2qa5+ATGibq6UAvo7ndibk1EvsuO4E/3SEy+PJePK9Qp8lMFZx9ppySK
	 9eM0S9x9238PKK6x76pa0dOj6MtIUUS7kRNhmgsxROtKrnlNFrKeP1TFiNGVLie/32
	 PS2RqizUXtTneEh+v42wN+sw6HPgb8mYvgIxEwRaC4qYcIrsY+17+qdsXdoCTEEbW3
	 9LHI4Nm85mFKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 608CEC4332D;
	Thu, 11 Jul 2024 17:53:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/11] gobi: Limit number of premultiplexed contexts to 4
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <172072041539.1229.380635730249824780.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 17:53:35 +0000
References: <20240711164936.1688973-1-denkenz@gmail.com>
In-Reply-To: <20240711164936.1688973-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 11 Jul 2024 11:49:23 -0500 you wrote:
> 4 was chosen somewhat arbitrarily, but it is the maximum that the
> qmi_wwan_q driver can support out of the box.  The only limit is the
> number of clients under QMI.  Two WDS clients are typically required for
> each active context, one for IPv4 and one for IPv6.  The total number of
> clients cannot exceed 255 (uint8).
> ---
>  plugins/gobi.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [v2,01/11] gobi: Limit number of premultiplexed contexts to 4
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3076113d2867
  - [v2,02/11] gobi: Request dedicated WDS services for contexts
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a47296c79b10
  - [v2,03/11] qmi: Enable _auto_ use for some classes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b46004b53763
  - [v2,04/11] qmi: gprs-context: Declare qmi_service objects using _auto_
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=766aa0ac819d
  - [v2,05/11] qmi: Pass two dedicated WDS services to gprs-context
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=151823bdc330
  - [v2,06/11] qmi: gprs-context: Remove parsing of unused TLVs
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4921cfec9723
  - [v2,07/11] qmi: gprs-context: Treat IP family TLV as mandatory
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=90db5ebd6aef
  - [v2,08/11] qmi: gprs-context: Set up WDS service for IPv6
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c09e6bebe703
  - [v2,09/11] qmi: gprs-context: refactor detach_shutdown path
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d617baf9e089
  - [v2,10/11] qmi: gprs-context: refactor deactivate_primary
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f25f481d45e8
  - [v2,11/11] qmi: gprs-context: Dual-Stack context activation support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3ee784aa9d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


