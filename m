Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B213BAFE
	for <ofono@lists.linux.dev>; Tue, 23 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886234; cv=none; b=D7MJaSF8CwuSBroWl0CEw4vtDaEkb9WEfx0DwF8O6zPLwo+puxre9h0rLHzbN+YwfnAs5WuDMvZXJ9+irRn5pm4pqzlsi9pFkjyzZgkaQbCKc+zpmRrK2n8wXVzC0rUxaQHUkYHZel3rNy6vXZZj+WMCYE7zo5uIzxGQbbU/5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886234; c=relaxed/simple;
	bh=U+Gc/UdNnlzbM4qcJCmK19+YbtVEIVV+uOOKuWTONNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V3jJXPhIS2bP3DSB+qbi6ji4qqVIWroODxiYoQbraNBKtfu1b5TTj2M1ke+7rve4krbuGbaVxhiqZqhTeedRFvrp9oSPp9cuY68lPD7U+KtpAYemtaeoAprMxvL4bvUZfJpZwdXyOVkuVq9gPbaGgifNUsqWXdxG05Vxx3pEr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX6QqYpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX6QqYpd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7F4DC2BD11;
	Tue, 23 Apr 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713886233;
	bh=U+Gc/UdNnlzbM4qcJCmK19+YbtVEIVV+uOOKuWTONNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jX6QqYpdDLJE+hYDtPIrVjTARDJXwV1Kf2bVfs1ko7YNVC6NRAF9dtQiIykKhODzg
	 PCTS4nIgNzBLtQL7Dqv26kStL0e5KDLHKsAH85wyrrRZ9PFIFl6qMlghnH67KHHNsl
	 9lSTbgSHeklIIjbOXgrsWkUr5VLhU50udIBHGP0MNfJ0XnyXJTszp5Y7eTkgh9+1QH
	 q7Ob1c+sbO8cX1rGqneUYblLr7+vuVIxihBac2+G36AF4Eu8+5E7iVX0UZ9SooOxq7
	 senVRUlOQcs+6nzExngJz02TaSq++ziDtIPqRT7VRUNUNSiEc71fnkatj5CS05vfk6
	 MfpSvkqtVDuXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D51A0C433E9;
	Tue, 23 Apr 2024 15:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qmimodem: Remove redundant unregister all calls
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171388623386.31372.888575782126890792.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 15:30:33 +0000
References: <20240423135711.272881-1-steve.schrock@getcruise.com>
In-Reply-To: <20240423135711.272881-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 23 Apr 2024 13:57:10 +0000 you wrote:
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
  - [1/2] qmimodem: Remove redundant unregister all calls
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b9d3413bc920
  - [2/2] qmimodem: Eliminate qmi_service reference counting
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4b0225684d56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


