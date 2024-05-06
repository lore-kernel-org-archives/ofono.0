Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303C155756
	for <ofono@lists.linux.dev>; Mon,  6 May 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037630; cv=none; b=Fhy2gj5oIzi60/cNRBfjMxsIg4/DoIkwwg42ypoFCRn1g09JoNNOXWViZQJYDrCwfX/LLHw/NgtGIN9GiHiJigNkh5dzIkafcu+nkMSApV6tpfY/qdwv/M9FLNMsBXtETOg+81is9RMp26CN8iDYGeqpcNe55r1PLir57jqr29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037630; c=relaxed/simple;
	bh=CIa1SzhPJm3SLgynYG1IKdegeaZX81NNSlxztTHyKjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5Unz0iKK5XEv9lQiclVvqGb8eiqRHcMn6hUHA+VVKiCyVWxaRcEMl6pV/b1G9vxewu5rZD7xI3gnrxn9grESOFpLmO7Jwv8HBz9eirvLtpowjH6K6E7HGvGu6grzdpm0lUBF3+FGFkw2SKs3vaS+N/OFKp3XlYQ155kZLn3+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvDeaI2T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvDeaI2T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F00AC4AF63;
	Mon,  6 May 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715037630;
	bh=CIa1SzhPJm3SLgynYG1IKdegeaZX81NNSlxztTHyKjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CvDeaI2TJ+BWFaBc82M//Bnkw+6wQ9RXJa5CCviIduqK8PaoLPPevUrNFiM051Q1z
	 bnZABsin6+5hT36Fj2AyUppMu5JrVwiieyVA5H+UZnmH5ew7Ux/1xeC+1/pR5DHy1z
	 cuIMojFqsNxUJvfrJYndrzBjF+9VtTvPUKLrOd01DQp2YcOVpdvVGEaVTqsQghX7In
	 OBA7bsmnXvzDWfqlmHsupTRnFyNgIGIzd604dtYnbdtB+W3Dti4x2uKkzGscVg6fUB
	 OgzWXzk02jpwaq+Ew3Q98dHvySyNINI+Nu5LF3ai9tOi7672WcB1cst+H7JabhOnhA
	 lUMg2ANDX3dRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AE9AC43333;
	Mon,  6 May 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/8] qmi: wds: Fix up enum naming
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171503763003.28995.8863061250338180394.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 23:20:30 +0000
References: <20240506215804.57124-1-denkenz@gmail.com>
In-Reply-To: <20240506215804.57124-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon,  6 May 2024 16:57:55 -0500 you wrote:
> Fixes: e075175baff2 ("qmi: wds: add utility to parse Data System Status tlv")
> ---
>  drivers/qmimodem/wds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2,1/8] qmi: wds: Fix up enum naming
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=96ae5482cedf
  - [v2,2/8] qmi: gprs: use Extended Data Bearer Technology
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=f4873f08bed9
  - [v2,3/8] qmi: netreg: Print network capability
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2c9fec539eba
  - [v2,4/8] qmi: gprs: Remove IP Support Type parsing
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=5d92ffde0dbe
  - [v2,5/8] qmi: gprs: Remove magic number use
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cbb0a7df113d
  - [v2,6/8] qmi: gprs-context: Split out IPv4 setting processing
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cfd311c6e584
  - [v2,7/8] qmi: gprs-context: Parse IPv6 context settings
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2d1e5e573ca8
  - [v2,8/8] qmi: gprs-context: Obtain initial bearer IP support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=10e045b86485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


