Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC97FBA8
	for <ofono@lists.linux.dev>; Fri, 31 May 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183832; cv=none; b=LTSasN3QUfnhQxMRpK8O9SnymtaM0sJB51FExa67cNMKeEgnYThLYOSN2V+b+BYutXprvs0PXO+6u9ERdLABmAwlMkzKKWX7z+q+V5+8AhPYhtjLgcF+JUBDyHp6ICxjlvf1O2x46CDAPn740QvXQGNpylgMSwOSLcnLi8M84Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183832; c=relaxed/simple;
	bh=gS/jnotpA0pOX09B4+hTYWolfK4MVw1IYhgFvpehvBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oI2/UiuvwFEJdSvz/wCmablrGNRQBmZuNRWoV/JZeuunaFM++DdtZpwPoBBONUQAZ0FD9fISXhGUnng/T9TNHtu7at1FIWc8TUxYlKBAhv91yb2BNePRRMQQKr4dvcqaBct07yNEWw1WpZFfyLyvHDevwdztUSsXKe12bafyj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnjNKFV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnjNKFV0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31CDEC2BD10;
	Fri, 31 May 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717183832;
	bh=gS/jnotpA0pOX09B4+hTYWolfK4MVw1IYhgFvpehvBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tnjNKFV08ux1lRIMTEVyPaj1df0TQ2F0/f3GndDHPtDPFkXYSm4OgZBwJoGjzBnqw
	 5jrmXvOP2WPK9W97QqTO0WGmpFjCP2KZZpWsQ8LTcxTYaTw5BW3JN+7JJ5Ne6N7VN5
	 dpmarT8mJd9iAxwla39yFMtOAgP1ryUHI4CDXrpkpS7y/Eo5d1gmapkFISbRye44SQ
	 yw37kv70gr2WAgFOWNeG7hgmIHmOEXyHD3SmXf4BDMq5lQ1yzsUe+vkMiXf1ad/gwf
	 kYWggYdCWPWvPO9gWXhSpjIQbtVx5ooXawAjGoDblVG2dM4s5kDNEetGps+sURJWuF
	 i+NNaTTW8gbAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22104DEA710;
	Fri, 31 May 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmimodem: Remove the create exclusive service API
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171718383213.26653.16228151782935734610.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 19:30:32 +0000
References: <20240530144305.266664-1-denkenz@gmail.com>
In-Reply-To: <20240530144305.266664-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, steve.schrock@getcruise.com

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 30 May 2024 09:42:34 -0500 you wrote:
> From: Steve Schrock <steve.schrock@getcruise.com>
> 
> qmi_service_create and qmi_service_create_shared were doing the same
> thing--creating shared services. This change eliminates
> qmi_service_create to avoid misleading the reader. Exclusive
> services will be necessary, but they are going to be implemented
> differently.
> 
> [...]

Here is the summary with links:
  - qmimodem: Remove the create exclusive service API
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=73e37c80e8f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


