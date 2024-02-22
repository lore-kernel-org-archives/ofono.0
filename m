Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D47173E
	for <ofono@lists.linux.dev>; Thu, 22 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635030; cv=none; b=mTcy7PaxgiadWnacXNDXBS3brPAnp13Jl6+3ljxY2Ozd9zhwaq0bg41Twgu3KH+aRVzVURdIWp226bDU0Ujv6XV8eOgFZ5pJg5rqAsYOn7uaNUC54r7cYYTjjbYTJADrA0fy9Tag13yAXPO0iB+yj9VDMxGQDpOLYn4zZ9RKVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635030; c=relaxed/simple;
	bh=5WermFbCzCda9L/LudarXv5p7+cSJyetmJDIepU2RJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rUoWx5djWW71vbFP05XCNqfZZYOFL5WsuYj0OdvMSKoNvf0Izxaa5DBXYimb7oE0hZMdOeyPK5Z8HorvAYDABKeFzxIHMOUtloLzI49FbTHbuBGzarotHRZ6v4jAh2NmPBw6HtM3dG3WN9TJi6GRUfT2OFj3iHZ9yYd5HOMNOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmw37qVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmw37qVb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 895D2C43390;
	Thu, 22 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708635029;
	bh=5WermFbCzCda9L/LudarXv5p7+cSJyetmJDIepU2RJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pmw37qVbLyJNq8tbcuzPBlyUU1JMqozLP+C2azEl83ie4dLAT9vSQCeum39TBLh1E
	 W05x8PvAY8kMaW90eG0ewh1d9FjzyXGSctlcMbXoqd5/OaQgK+dQGF7RsZS6JUkJuh
	 7Qpuq6KaK9o8My2xukq9gFxA7Hx+x5p8GwkUyd3E/yQ5JsQX3zztckHdJPUP1rOtV/
	 qMj1u/YmZqwcan8VOP+youFTlEotXYbvXSDqSuyqHDlhf0dVva6GsQ+no72CbepJNB
	 kOp0TQn9v3EdkGHH06H9eR8lQsFGZ3dAQtFRdoF4ByR7IYl5PrWAFuQArSXOuFCovE
	 49UMYd0WrHbpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76DBBC395F1;
	Thu, 22 Feb 2024 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] qmi: Introduce discover() driver method
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170863502948.11350.17785563239272786860.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 20:50:29 +0000
References: <20240222201559.1293947-1-denkenz@gmail.com>
In-Reply-To: <20240222201559.1293947-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 22 Feb 2024 14:15:42 -0600 you wrote:
> On QMUX the discover operation queries all available services by sending
> a QMUX Control message and processing its reply.  The reply contains a
> list of services and the corresponding major / minor version number.
> 
> QRTR has a similar, but much more dynamic mechanism utilizing the QRTR
> nameserver.  Services on QRTR can appear and disappear freely compared
> to services on QMUX.
> 
> [...]

Here is the summary with links:
  - [1/4] qmi: Introduce discover() driver method
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=a11e3942354c
  - [2/4] gobi: heed the qmi_device_discover return
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=ff5215050019
  - [3/4] qmimodem: Fail early if discovery already complete
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=365293bf0451
  - [4/4] gobi: Fail early if re-tried discovery fails
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b95a03190891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


