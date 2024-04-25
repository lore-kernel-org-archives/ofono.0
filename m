Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EC14F10D
	for <ofono@lists.linux.dev>; Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076429; cv=none; b=oUsaCkKKLOq4yaEy02+nNHOjvhWcLn37g6e2oEoeN3ZnDcLmMGgMQ3SToHQjXr7XW+ZP/EGkIY0GEgdOFywSJtElLHjitVTWYT7izh/H0cOQTkmCWqa6nanRYVgJLVIq5P0wVmLS2+13Xy0RFyhW1HeR9w9VL3/sXysCHS/5ypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076429; c=relaxed/simple;
	bh=EabNKXOA7TlcdXvEmdR18CQUSdkNaLzLzV8qGS7HzpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UxmyesOq4yBc5S6fs+1Pkt0tUDUH9Ssyr0JJZTwVvmHMQiu2t7igs0zaq/rflQ8JXXEGEZtvalUwkINsxBw/G4ub0h2J5/IvTZc7zXpoX5lEVjnIp2c5mWUYmEaQSmc7mWUvtEbNxqJzNeV0gKmeiTh+kylZ68JXAXWE8dKZmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UamB7HWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UamB7HWx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B42FC113CE;
	Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714076429;
	bh=EabNKXOA7TlcdXvEmdR18CQUSdkNaLzLzV8qGS7HzpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UamB7HWxNhGBR7P8OfMLOYtdyQL4LEF/Zhw20bm4vGW/fa3vBoQY1gsdBV78JB+0j
	 NxNNgBvquT5/u0Chk7SiQgMJKRIWz7RiLOjWkDw+GxGWViMSeXMYVgdJ+/bN0AwK41
	 Kv12W69a+dXmdOzzVDal8GDEs+xJfJKQaKRiD4zOufp70ZD0qt4z4rJOrF6CprMmdk
	 dU+J5iFm0pIdsviEDVe6NC2PLu1F/sYI/8VYNrYpDA00NKC+TSttXTSAhm0ZtZTYyG
	 cRcf/aOgZcNPs72SSMLetzBugZwc3Cn+JSTOtwbSrgcjrqS51PspCnxju498zu1Obo
	 elAWce1vrmzOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 163BBC43140;
	Thu, 25 Apr 2024 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qmi: gprs-context: Actually send param to qmi_service_send
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171407642908.12759.406654380269682641.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 20:20:29 +0000
References: <20240425201129.538276-1-denkenz@gmail.com>
In-Reply-To: <20240425201129.538276-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 25 Apr 2024 15:11:14 -0500 you wrote:
> The parameter structure was built, but not included into the
> qmi_service_send call resulting in a memory leak.
> 
> Fixes: b6ced6c5c4c9 ("qmi: gprs-context: Request certain TLVs to be included")
> ---
>  drivers/qmimodem/gprs-context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - qmi: gprs-context: Actually send param to qmi_service_send
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=06978a863b4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


