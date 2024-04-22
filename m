Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2931DDE9
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803524; cv=none; b=WK0PzareSl95I2Au2jazvOCmi9iVF0QQtLXTPF0dfvrD1MWxRy8PdtMihxp6EHCzwAjRp+VYUocEZ2EoMKxZ31+azcpYYtWXFC9wBtUVrv++gQzIynYYI21Q22r/NewmU1D1wDIlDvwayIccB1D3sLICF3OUQkmWSIoCJUihVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803524; c=relaxed/simple;
	bh=LVJ+vJG6j+bwOYC2JrEWeR58Yt7px1vjkJNOId7H4JA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVrinSdIL6uXL7EJZJmGN/xS1z1GfjS6yasZq1OWzQuT3OfPkfTqfTA0jb3ZWQfKPxO8u8rCjp0Qe24MmGklsTEwHuxyq+wyXT22/ZljWVMNC4z272nI7oX9sq33028tdex7SdHMcNU7FZLy8/HZOWZQOBLwrFJpY6D8Tzk8660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3RktJEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3RktJEH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D180C32781;
	Mon, 22 Apr 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713803523;
	bh=LVJ+vJG6j+bwOYC2JrEWeR58Yt7px1vjkJNOId7H4JA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3RktJEH837EACYPz7V+QiV2ZTvodRXuzhRS7ULUyMOj/dsAjFoo0emHAp227NtVU
	 9Sv2GUfahiK6iVj0jVwgLq4zwIv/gz5jPFq3vmkODTbM2LgxzRTBQOM6Hp9RhZLZPl
	 T7rPxrYeckEIr3aDD1L6XyCneZQJv2KOvCyUjydvc4idfLn7gvuVxo+XrX+yaEwBeP
	 97mSR+S5ba+/5sTnHwJkEN5G3S1r7ZRNYplJOxmLiD1CYDIY4r2I1xaDMPJ9SFkY1F
	 qPU/en9udZ1P5BYsmWZd7K3kM1OqjjIhgGwOU1A9j9SkfYeZ9+GFnbAjyIoML0X43X
	 ngYo2ATiCxFZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73D32C433A2;
	Mon, 22 Apr 2024 16:32:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] qmi unit: Link to dl
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171380352347.32107.12758779421356187360.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 16:32:03 +0000
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 19 Apr 2024 16:44:51 +0000 you wrote:
> One of my VMs was getting a linker error when building
> test-qmimodem-qmi in maintainer mode:
> undefined reference to `dladdr'
> 
> Add -ldl to fix this.
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/8] qmi unit: Link to dl
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=279b04c15127
  - [2/8] qmi: Eliminate atomic ref counting
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=39b7437a0044
  - [3/8] qmi: Create a better client service abstraction
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6131bfc81468
  - [4/8] qmi: Eliminate unnecessary casting to unsigned int
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=28d60206ba2d
  - [5/8] qmi: Prevent clients from unregistering for others
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e13fb8f498cc
  - [6/8] qmi unit: Validate creation of services of the same type
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=af2718346a28
  - [7/8] qmi unit: Validate destroyed services do not notify
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2d4e571d1598
  - [8/8] qmi unit: Validate notifications are independent
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1c999cd5a0a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


