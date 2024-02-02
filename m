Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B912C7E4
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916632; cv=none; b=SRthwncRS6NaiQj3KkVmDwGPRQEYDjBxns8X6f5CyuO/42RYOmjrJRBXc3Sx4BwNKf1xHKW8+IhfIRWscviwfNRV8GaZniFmeksjVhmfuRkOFlShTKzrvqzeHrEN8vRnsljH5rQZux9A+mSv0yHSA07hF0kPsMGy0H03OMpCEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916632; c=relaxed/simple;
	bh=7OvWtzvaY6ExYzTPw7CDYxENypNzeD6Tw0O9ibb1ulM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mGejDW4UYY3WofLw3iOhuj/7s5p4gItkFFFp9jtHD9iw7tchAPUyRUa2mHsfv3/J4A6dTbtCCleHTtrsVYlIK2aIHBN3r/mFCE4dGAWS4Lx9VraRp//DdF5mQFVYfTzUEqOzCqrJVGeekoYUD/7IO3DY2wGJBmFRHG/G/wUWLks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAwqqueS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAwqqueS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0278C433C7;
	Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706916630;
	bh=7OvWtzvaY6ExYzTPw7CDYxENypNzeD6Tw0O9ibb1ulM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JAwqqueS4CjhHq4X+atsN2d914YIpRuBUr/o4Ktx8c6Ko795UpjtS28BV1w1Ecaaz
	 OMPayTfRqA4Arm3uxoAzCGO790IzmzfRxouZa1bqlRIxzY7EDUD6k4VjF1VefyzVEA
	 orm4taMvH75G1Ew85HMFjeo+OFU127Y3Di8EBV3zC0aTJS+EYT69S2yyhwYDywDdSF
	 wbP0kMERwQb+FuhwqLhNpS7YuSCllWc2MLPHfI2Ro01zHqekJOsN8DpjV/pH+ywYDJ
	 YMpuLxsu1pR6TxpzwCH8z+3Hdk2uSRcmmj5BPFiPo8Xk/3gYLJFgFSJd9kOAyUlPHo
	 3aFD/lKtJP/+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 930D5C04E27;
	Fri,  2 Feb 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/18] umlrunner: Also mount /var/lib as tmpfs
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <170691663059.19326.2493056169205569636.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 23:30:30 +0000
References: <20240202225405.993792-1-denkenz@gmail.com>
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This series was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  2 Feb 2024 16:53:33 -0600 you wrote:
> /var/lib is used by oFono to store various long term settings.  Make
> sure the settings from the system are not used by mistake.  Also, since
> the host filesystem is mounted read-only, updating of /var/lib locations
> by oFono wouldn't work anyway, which might be confusing.
> ---
>  tools/umlrunner | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [v2,01/18] umlrunner: Also mount /var/lib as tmpfs
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=aba0f71b784a
  - [v2,02/18] build: Only enable backtrace(3) in maintainer mode
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=05eabee2524d
  - [v2,03/18] build: Bring in more ell classes
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2a9ccea64b54
  - [v2,04/18] build: Enable _auto_ syntax
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2da2e9cc26e7
  - [v2,05/18] provisiondb: Remove some duplicate MCCMNC entries
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=19a0d53ba5d5
  - [v2,06/18] storage: Introduce storage_get_file_path()
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=cebe22caedd1
  - [v2,07/18] storage: Convert g_strdup_* use to l_strdup_*
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=d650fe8936cf
  - [v2,08/18] common: Drop GLib use from gprs_auth_proto_to_string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6f63dbbbb5c9
  - [v2,09/18] common: Drop GLib use from gprs_proto_to_string
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=c934b708742c
  - [v2,10/18] storage: Remove mode parameter
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=405039ff9601
  - [v2,11/18] storage: Use l_malloc
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=4619f19d3ac7
  - [v2,12/18] storage: Remove mode argument
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=e4fdf579649f
  - [v2,13/18] storage: Use void * instead of unsigned char *
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=75998e0898bc
  - [v2,14/18] storage: use l_file_set_contents
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=eaa03eee6c1d
  - [v2,15/18] lte: Refactor lte settings management
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=2ce572d56759
  - [v2,16/18] lte: Add provisioning support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=69adffb51633
  - [v2,17/18] phonesim: Add lte atom
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=783b036d7bc8
  - [v2,18/18] lte: Write provisioned info to disk
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=53c13ead095c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


