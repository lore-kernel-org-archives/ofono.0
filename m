Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9E4C66
	for <ofono@lists.linux.dev>; Fri, 22 Nov 2024 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732243821; cv=none; b=YbptqUxg4ptv7461Q9dr7GHBoTmymVZ7cfI9+2JRApz9WRyNTfSep79cpSDt6s5Z5L40d65Z5XbOEJGaJcXtDJee3wd1QvMLObOP3G7kuvNMGqKlME9ET2LiblQ8J+IADa/KwplXeFGo09ySOaUsAQXS5dNo3T1tLiwGqD1M7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732243821; c=relaxed/simple;
	bh=LilX91oI9rJx3hslvEdcdj16EQNBDBhongDH++yq/PE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WnqCuBCC1ueaIQnV2PynqXuXtEUHqgVkHG/3APrf8MbjIIS/KoYCHZfKPGzzLDI89E/efwU9anPSoxd4MM2stsGytG4YQi/Fc08IZ16kA7JmXmZFINZkxDv3RyAXFqn+Hb/jPPGFhCopkpU8iwPrnLqN9hEaM668bpP35X4r6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZUo0Jfv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZUo0Jfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790DCC4CECC;
	Fri, 22 Nov 2024 02:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732243820;
	bh=LilX91oI9rJx3hslvEdcdj16EQNBDBhongDH++yq/PE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oZUo0JfvX/ai/VqthKNZ9ub33rde5LGOCTflf0b2+QIy+2bJ2OcPh44jQqdkTFetD
	 122/+1VcPMC4kCM/sHqSBDdx1TMnEhHEr/gh38bYYcoGeqjt+VzeGOzv3jIm0pMVEf
	 BuSPJPs0BGCfgXv9F70vJ4SqavNigiKIhl3pQmcYjB1srR4aCUQRqyzKyJnnDWK3rg
	 /DZNzjoWKLz05qVAcdulYZfzgkCUqYZoCeHUQ46UvL8T6K8rjx9q2xKsNVQgSFSVnT
	 KdKaJpC7VAvftO88OI1ghBcb6EZiawTpHsk6Fvg/Efl5nzkzvsNx6ADy7NQ0mj39pG
	 YB32vcSvnqgEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2313809A00;
	Fri, 22 Nov 2024 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] qmi: wda: Add qmi_wda_set_data_format utility
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <173224383251.2219051.12245041003569109490.git-patchwork-notify@kernel.org>
Date: Fri, 22 Nov 2024 02:50:32 +0000
References: <20241121152949.56962-1-denkenz@gmail.com>
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 21 Nov 2024 09:29:29 -0600 you wrote:
> This utility function builds a WDA Set Data Format message and sends it
> to the desired wda service handle.
> ---
>  Makefile.am                     |  1 +
>  drivers/qmimodem/common.h       |  5 ++++
>  drivers/qmimodem/gprs-context.c |  6 ++--
>  drivers/qmimodem/wda.c          | 51 +++++++++++++++++++++++++++++++++
>  drivers/qmimodem/wda.h          | 23 +++++++++++++++
>  5 files changed, 82 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/qmimodem/wda.c

Here is the summary with links:
  - [01/10] qmi: wda: Add qmi_wda_set_data_format utility
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6f38ad430a00
  - [02/10] qmi: wda: Add qmi_wda_parse_data_format utility
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=46c0a242a405
  - [03/10] gobi: Explicitly set 802.3 data format
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1b4d98578779
  - [04/10] gobi: Detect qmi_wwan pass_through support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=87aff5f3a23b
  - [05/10] gobi: ensure Set Data Format changes were applied
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=281b49763818
  - [06/10] gobi: Set MTU when initializing QMI_WWAN
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=b2c04c07f226
  - [07/10] gobi: Support RAW_IP configuration
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4411399f7114
  - [08/10] gobi: Add support for multiple active contexts
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=7df5d3660e1d
  - [09/10] qmimodem: wds: Add qmi_wds_ip_support_from_ofono
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=1e88453c17cf
  - [10/10] qmimodem: gprs-context: Fix non-default bearer activation
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=3dce963d9bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


