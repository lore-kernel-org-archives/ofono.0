Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64774178CC3
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925832; cv=none; b=MLcbqlXJr8HDRo8xML58rDeaBNBj06B/dMGetcQrj7xm2aw0zRF1cluK4TPNVuBL6tGxIkkeyv4xI6Ztn1EmcMejTulpeZYfKfGlYywCHz39LaAD2RJCoa2Bzzi4ihgeUsXppGJszIop5p5vfX3LhFGvJdvbkRVf0ih/vRFzM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925832; c=relaxed/simple;
	bh=UC8fi8c/XnlTWv/hzBNrV3y/TwNhQnZ93y4aNzH9Q8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jftAza6AubmG5k4i02YR/uhlHhTPxGmIwAa0adqVqehJ9QJsIBD611Qap/wIP6be1bpGecNxynKDoQKncmvIz5LEJU60E+qJ4ePdmdXq4xcFGEJpjJoD3ivZ40OTwx8af9fQRHjcOiNR2cNzNDXap0W05ncRY9sUDiVXeWbh9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrHX9R69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrHX9R69"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD91C4AF08;
	Tue, 28 May 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716925832;
	bh=UC8fi8c/XnlTWv/hzBNrV3y/TwNhQnZ93y4aNzH9Q8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IrHX9R69iLl/JQofsRrsS9DAbaHqu0Y0foem3Gbh4Snwf0yCPQGvixdmlCQdmABTK
	 z40+F7NVtB/DikIVKQWU0GL6mV471NlMIuK8kjsqcKA5JwodOogjj/r0Kw3UU2xpXq
	 lo7KDH3qEif76WvuhTYJMIC8UTKKxcCgvZEUSViOu1xIRMuE6A6DtUmhuRMpc9NnCC
	 JjyL+RixHsYX7FjSzVZ205Mgs0+EJLAQPMl/kCqVOBxTxhGkGTOBoocR+AX1b6+KNy
	 iM1CC52ZFbmv2fGcwLwF5Xbb7y5TsqvbDIDwtyJqdr6eMimEbWPze86Teezlr73vkt
	 ODJ9iSE2Nbf4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09C87CF21F4;
	Tue, 28 May 2024 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] build: link dundee with ell
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171692583203.23106.5068953060005137221.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 19:50:32 +0000
References: <20240528185354.224680-1-denkenz@gmail.com>
In-Reply-To: <20240528185354.224680-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 28 May 2024 13:53:35 -0500 you wrote:
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] build: link dundee with ell
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=59322e4d77ff
  - [2/2] log: Use l_basename instead of basename
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=47165d458c32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


