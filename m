Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4C1401C
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825030; cv=none; b=X1C2GxeaMgFDWiDgGBaUBkndrkmCulSEqhMXtzO35rMvE2LYj0YPXx971QO/YUDufPszJdZImhvGh9SPfAU0ENKArirtIsoZyUNs2RuKeZhaShKJpovD9L+Ax9KrTlmgYS0Ugxrpuv/umi0ajAe6Bm4JuHFfgMFkESOnm2IpwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825030; c=relaxed/simple;
	bh=j43M5DGEjDARdQWL2mILwGJClC25OZvEul0flja2/FY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CT4qrzx9tzSGmYO+76owbdudcJ587wV7PDgccetfEZB0cRK9SO7GHxSqwE2ZDg5bhFQX+cxSJfYCLzASGfPMT9C9yDwKoxbf3On6dt3x0IjOJVz2MncZYTwltAx/1miy+IZnv4edvSxDMCa/u6setwwRUguhV8e7sqQnHJzcibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecQ9ryWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecQ9ryWN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D22C3277B;
	Mon, 22 Apr 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713825029;
	bh=j43M5DGEjDARdQWL2mILwGJClC25OZvEul0flja2/FY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ecQ9ryWNCy0+U7GM/qFkdnCbVn/AweaFBs4wbjcyZ6dG/KyWBdau0OTcr9dd5UuGl
	 cbTjYp9PJ2XtHU1qbcf6dUwQJkHXl+hmbNNBUDszM6LBLVIfrATCsHE6j68oz8+8vP
	 QlBq2g9bzO3XTUXSSoFXkfHQHVY1O9/96i1MIT8hrKKku7t6y8VInXH1VVgbToPsF4
	 6g9l7svJVWPt9x5+pI68Zh8hS9xzHOvxiKfDQSaaNcDu3nIfNE9p7lTW0KN+gGG8Yn
	 OHA7yPqlNSaB+z/GSttts2pbC5JJjF7pQtpp1s+B06mA4pWNpTO+nk1aUrnizuo7GM
	 p+sPPBoCdgmpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 749CEC433A2;
	Mon, 22 Apr 2024 22:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] qmi: Remove redundant NULL check in qmi_param_new
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171382502947.30544.9303442669792419668.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 22:30:29 +0000
References: <20240422214058.3411417-1-denkenz@gmail.com>
In-Reply-To: <20240422214058.3411417-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 22 Apr 2024 16:40:43 -0500 you wrote:
> l_new cannot fail, and thus cannot return NULL.  Remove the check and
> simplify the code.
> ---
>  drivers/qmimodem/qmi.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Here is the summary with links:
  - [1/4] qmi: Remove redundant NULL check in qmi_param_new
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e16edbd2bb51
  - [2/4] qmi: voicecall: Fix up code style violations
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3c5ed8ec1e57
  - [3/4] qmi: voicecall: Remove ternary conditional use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=231cde4f12a4
  - [4/4] qmi: voicecall: Remove redundant initialization to NULL
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=789f68a5fba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


