Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192ED172BCE
	for <ofono@lists.linux.dev>; Fri,  5 Apr 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347837; cv=none; b=hqID2LjNc2buswqMXA/9nmlmaIOzSn9+OdT3A6sYH5lsFiU6d+iJa5lJYLya3iVsEzYBDVogQYQG05qVIpB+X0542Oj2X/d2OjtpuSzZkgyc6V+a+nnVmp1DEXWVk0S5xQNL30lur86DbS+kEF1sJohzDncMsGVJ7O1y37YD2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347837; c=relaxed/simple;
	bh=X5TyDs+9R5L0EGOLuh6I2WLuLPcA8HstIZ7JIBDJwkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fd0exGUxCZZtwPuMS5/rlKSHd/5+YKXKnkVw7qonoS+rN2uLMZNzkUlAEV8AVAmbf8YVE1hdv5cUuw0PAwwwCuLVbJX0pjVQnIKVz3ACprTejUujsQORUiX5biK/pK5cD23ZihdNsVVX+CDNyeDznTyhXrUuWGanci3ELQkMjfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjHBSpq3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjHBSpq3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEDA3C433C7;
	Fri,  5 Apr 2024 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712347837;
	bh=X5TyDs+9R5L0EGOLuh6I2WLuLPcA8HstIZ7JIBDJwkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjHBSpq3FeHnBY3RB+08EE/FTiVmVHwEuH0wlyLkyeEWKn6E1JWaUcVVK9TnHypuz
	 oZp+StGrCGcrzOFIDRGm+5u32H0VSOcwYkde7ZyGXNwC1358TIPdU43LNQskqym1jl
	 hggsJ/hJDBi7zyxUmqe8mZui+ec5IZ1Z5RUSXNbiJ2c3v9kbk01Rc/imbmuKstcCWZ
	 19Hz3O/wdE3MruTu2DzUSeVnPzzqrYD3CFz02yuykDOCXYvKaWkFhc0B7ZC3KgQn49
	 Oq83J5IxS/v/viBOFlMyJG2iGXXTBZNXpjSM8eAdggoNXDOTv0iGN4R9VTswMmIADZ
	 WVzhYK28gDzDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D96A0D8A102;
	Fri,  5 Apr 2024 20:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] qmi: Create QRTR unit testing framework
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171234783688.2796.13623339458968288660.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 20:10:36 +0000
References: <20240405194250.39561-1-steve.schrock@getcruise.com>
In-Reply-To: <20240405194250.39561-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  5 Apr 2024 19:42:49 +0000 you wrote:
> Use actual AF_QIPCRTR sockets to create test QRTR services that may be
> utilized to validate the functionality of the QRTR implementation of
> qmi_device.
> 
> These initial tests validate that the qmi code is performing service
> lookup and instantiation properly.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] qmi: Create QRTR unit testing framework
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=58c8e856dff9
  - [v3,2/2] qmi: Add unit test for QRTR qmi_service_send
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=728db12daa68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


