Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B8194080
	for <ofono@lists.linux.dev>; Thu, 19 Dec 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629421; cv=none; b=YErorYpepElLerIgZp7iEiLLll01496fhd+GkQrydvJY7N+Cogl/dDE0Mrvlaj4ItQetVVlXvWAJUmIRNqoVaOd/jmfebGsal9kzEffvXXF1UuwK9juclL8v8zRj+W85bdzXRa3iiQ+ILeA4MTFNvqtF+bst7qMOWbAfdP1vAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629421; c=relaxed/simple;
	bh=Li/hfnQIPZDVwHC6eG19lFujAaFsPA8c1qAMSIl8GrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsiEWWUkCIfJs4cM+343KcbZw8dbCJs4rV+4q6hWUEbmim1QtmiDMd2e4u5wZRiLi8/DjVQmg7G7RlGnelRzJZu3pY7xm6SE5W5S7+UVD2T8OGQCTbvfay01kkDfKPWTNzwGJMqQ/c+RCKZHPOajTlbmC+v93Q/OLdININ3+BHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZGOa5fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZGOa5fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56325C4CECE;
	Thu, 19 Dec 2024 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629421;
	bh=Li/hfnQIPZDVwHC6eG19lFujAaFsPA8c1qAMSIl8GrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZGOa5fnK3flhK6BgiJ+e4nGuKwqJs9pxag8MC2oTZc/fvPye+idT+j3yqdmK1Md3
	 zfPcvLOVOBKp5R4TJaktICwtsMH5U+Zf+KubdIs0WDMZzq/AuS4NUM0T41FBc+Tyze
	 J96hHquBmeI4ckzK/Iz3wZM7ck2QAd0F61t7PtYugeoG5eZ+Z546ylQFyLCOIbj4jT
	 +t13B0YsYWfFgedYKbbB3Rrg/JPwhtqtszioDnqQiCnhYIjp1C4G3HYiov9Uek/G97
	 OmWzFhg/wX2QindRVfiQnLGh7UoCEXanxtdFHqFghURMPVpaApNtHIP4xLYxnOJFLE
	 jNqp77lgyw6qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2D3806656;
	Thu, 19 Dec 2024 17:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rmnet: Handle toolchains with old kernel headers
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173462943905.2328057.12511216025077176330.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 17:30:39 +0000
References: <e2b6a94dd9a3789e31dafadfc70c53b565d1db04.camel@linuxfoundation.org>
In-Reply-To: <e2b6a94dd9a3789e31dafadfc70c53b565d1db04.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 19 Dec 2024 13:47:15 +0000 you wrote:
> The RMNET_FLAGS_*GRESS_MAP_CKSUMV5 defines were added to the kernel in
> 5.14[1] and some toolchains use older headers, so add fallback defines
> in case they are needed.
> 
> [1] linux b6e5d27e32ef6089d316ce7e1ecaf595584d4b84
> ---
>  src/rmnet.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Here is the summary with links:
  - rmnet: Handle toolchains with old kernel headers
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3d6653f29686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


