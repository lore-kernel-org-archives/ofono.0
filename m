Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1860B9F
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965630; cv=none; b=qmL6JVMETFBjDVys13BDl5O5dKkftcfA6imw7TQUPt9BjZLY2lua6W36vTfRTAcRq4SCMEJSeEZVEe7ugyaZHCcoMH/LwWmZeKLtahUXdg3L4MHX5zfDZf0D0fnMPNBbnKjgaS+BHP0vzA0B4UUB0k5j+vQHKGiS40y/ED2TUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965630; c=relaxed/simple;
	bh=/BFO45cwv5jJSivK2AkW3ST7Qqyms5HHLfyoGvcmohE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nHpg+l1euzg+0tW0758OxtxpXLoL+HuZPEjVqW27eKdBtLHWou99ZRJx+aIXcGM6ITKAwQ3Q4EelWIkFC4ON1VTSQ5MtZpl1vaOKXRCh/RwbzOMBTWjggqQjpePSnJvxlBA8kFHq9VcupXFalKFlOZK1PTkeE3LezdYXjKiWnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx8aZExO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx8aZExO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E5A6C43390;
	Mon, 26 Feb 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708965630;
	bh=/BFO45cwv5jJSivK2AkW3ST7Qqyms5HHLfyoGvcmohE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lx8aZExOtj9BMc2Jocn0GwiogSc3JMfDrS/2APjSP4jkUjbKUqC5zu9Y+HzmFDsx8
	 KnNxOQQGkt+2rYPxaJNHWZAf6b6zymqmhaV7IdU6f3jVd9VXS9TISpW3a1sRpblfjy
	 ZlELVQKUPHdezR8Smq56chLx992kT8TCwcqS9fA6XmkVbqdB5o4ZS9g3JJPGT5dBIx
	 x9X4wWPEI7jdBuyp5WQ313s45K44lvkAyXgwVHwf5V6N3I9XhZB3oYUev0LOTmrX/s
	 mccI9fXvNEGljywGkTokFpgopaXlE5CxHs1RzZ75mUjFl3nng5/4S5x0OeJO/ZUb8c
	 WeGCSXFld3m4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55F4AD88FB0;
	Mon, 26 Feb 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] qmi: Use FAM instead of allocating a member
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170896563034.8639.9760938846172392951.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 16:40:30 +0000
References: <20240226153459.1463304-1-denkenz@gmail.com>
In-Reply-To: <20240226153459.1463304-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 26 Feb 2024 09:34:20 -0600 you wrote:
> Instead of allocating a separate buffer inside the request object, use a
> flexible array member (FAM).  This allows the request metadata and data
> to be allocated within the same memory region.  The only downside is
> that the data buffer is not released once the request has been sent over
> the socket.  Since most requests are quite small, this shouldn't affect
> performance.
> 
> [...]

Here is the summary with links:
  - [1/8] qmi: Use FAM instead of allocating a member
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e2a311461036
  - [2/8] qmi: Ensure tid is initialized
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1a801dfb93db
  - [3/8] qmi: Move and rename QMUX sync logic
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=051150db7f67
  - [4/8] qmi: Introduce __ctl_request_submit
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=84f9d568a394
  - [5/8] qmi: Split RX path into QMUX and generic parts
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=8a09d514f60d
  - [6/8] qmi: Introduce write driver method
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a9ebacb42317
  - [7/8] qmi: Move control_queue member to qmux subclass
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d3f4c6cb3959
  - [8/8] qmi: Make sure to set transaction id as LE16
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=df0c32bda186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


