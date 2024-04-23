Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026B13B7BD
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886234; cv=none; b=Lk93YdrPZow/duCl4adJW5UW6xeu73hJjxuIkeeA/PPuAlG6XD0oPXb/fl6tg1tutTLmjVZNsTeLaOkx6jEZ2AdheHXt7IiYfJ4afesKXU31sI/Gzeh9Oh8QRetIs/iVyh30MMdREbdk1iHOk5UJyI9iVyHfJQzkGfiei1z2aOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886234; c=relaxed/simple;
	bh=XAcclC8ut32hD+Ml/EL3hwsjlv2Pq1UgaxlOaygJlhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foJSJGusLfVsuyHOhEyQFGqnS6u0kl3HmYtCbn8RRw+T4eXuF/XpmK29FHaJL+G49100g2kP4+PT3amgSF8Xc+aR5BhvCtL57Z//irsifBqhfvUF0yuCpusYF8FpSerqAjuRyRWUDf63vTtloOahOjwC0WFSdoUVS1Iae93rGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMs0PwJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMs0PwJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00C31C32781;
	Tue, 23 Apr 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713886234;
	bh=XAcclC8ut32hD+Ml/EL3hwsjlv2Pq1UgaxlOaygJlhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZMs0PwJ77VLspp4W2W9INC1N/8X21QIk05EHtT3byR+0NqELDLaaiDadTzEi+BYvY
	 8T21/8230XZQbRbFPUyuiJ6dY8RxW3bNoVd/7AIeAMxw4jvOoPX9kGg5v0uPkOGeL1
	 TeQJs4wF08M6OSY7DhwZz1Km6WEPsSNU7nHHtCoP0wXEg5vD1KdcXz6cRo9Pb6Q366
	 +NtAgxFQm46RNWtQfh7qk4S1AGdelw/Gt1DRPISwBmKkx7spDYkrAFJo2nJWKJsqGo
	 02jKDmQPgR1dJeeKsSiq9kJkYPoj3yTkTNtL03+eKU7AnzqnYEACL/AUfIFN80o5lX
	 MM1aLn+lrFnNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC38EDEC7E0;
	Tue, 23 Apr 2024 15:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] qmimodem: Remove redundant unregister all calls
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171388623389.31372.14310453549810495760.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 15:30:33 +0000
References: <20240423145936.276945-1-steve.schrock@getcruise.com>
In-Reply-To: <20240423145936.276945-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 23 Apr 2024 14:59:34 +0000 you wrote:
> Some of the qmimodem drivers were calling qmi_service_unregister_all
> before decrementing the reference count to 0. This is unnecessary
> because the service will unregister all as it is being destroyed.
> ---
>  drivers/qmimodem/gprs-context.c       | 4 +---
>  drivers/qmimodem/location-reporting.c | 2 --
>  drivers/qmimodem/sms.c                | 2 --
>  drivers/qmimodem/voicecall.c          | 2 --
>  4 files changed, 1 insertion(+), 9 deletions(-)

Here is the summary with links:
  - [v2,1/3] qmimodem: Remove redundant unregister all calls
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b9d3413bc920
  - [v2,2/3] qmimodem: Eliminate qmi_service reference counting
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4b0225684d56
  - [v2,3/3] qmimodem: Remove unregister/cancel_all functions
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a2ca0a16788a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


