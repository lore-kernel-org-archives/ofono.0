Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC41EA6E
	for <ofono@lists.linux.dev>; Sat,  6 Apr 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435425; cv=none; b=W2iRznH8gSHQ0Hu+GxYZpx8TwNNSo1A909954jizUSjb5sJ4QnPyberKSVd0IBIhk8scn059rY9EXtSFcrsB964Jd5jvSWRkXiF7IwHLQ5Zmo0B3D5y2nqZ0A1XSJ12yNiH/QNR62D1oTlXK8zte7HhNy4dUCBHh2/JjXLFkegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435425; c=relaxed/simple;
	bh=SEF2CgEF2OcN3GL5eb4K0plQT2iJLdAdl/a2fc86cBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oKgZ79VmH/pnK+EmMXdrdEe9n6yTexrWrr75z0OkmMtG2BujbpXOpPDq+FteNu5douvUjEG4dbIIOjDV2gb1TJV6wWqXEVnTEEsXdN9nxggTKs0kZWdc6+Osd+MNQShEGHSghtCIFtNyKKWOnWPxl9EJFEdRiW3v8zoZAL0TLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evb45hfX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evb45hfX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C132C433F1;
	Sat,  6 Apr 2024 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712435425;
	bh=SEF2CgEF2OcN3GL5eb4K0plQT2iJLdAdl/a2fc86cBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=evb45hfXvVI3vUIMhf+aS+P99dPiKbC5Qk6b2q8OjGm7WMCk+UzWPQ+VaZYPlx6/B
	 e57E6nFHxE7fAAroBRN5XAkVGB6HNiq5gEStmRBd1ESJ26TzHFLk3sAjZq32kW5QIB
	 auJOxDM15Mpx8y+mb5yKN98M1GB1f1jnk5nceIt5i/ss43zo/o6uxBvQbP6/n0zBmj
	 EK6p9v24NW5X3FBCcPxy25b1TmvGwR0qceBKu25UySCUiLTr/oBUWe2+lG/TyITHMd
	 Ptugu1RkOTblMFsSjy1OgGhKO549rVarWX/WQsSjFrUc29VuNdVir2FiQykigiD8JA
	 tqp9tXrkYhCaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D070D8A103;
	Sat,  6 Apr 2024 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluez4: Remove support
From: patchwork-bot+ofono@kernel.org
Message-Id: 
 <171243542544.22154.6383468636929866789.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 20:30:25 +0000
References: <20240406195550.2950800-1-denkenz@gmail.com>
In-Reply-To: <20240406195550.2950800-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev

Hello:

This patch was applied to ofono.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat,  6 Apr 2024 14:55:35 -0500 you wrote:
> BlueZ 5 is now up to release 5.73, with the 5.0 release date being in
> late 2012.  There's very little chance that anyone is using BlueZ 4
> anymore.  Remove it.
> ---
>  Makefile.am             |   32 +-
>  btio/btio.c             | 1447 ---------------------------------------
>  btio/btio.h             |  110 ---
>  configure.ac            |    1 -
>  dundee/bluez4.c         |  296 --------
>  plugins/bluez4.c        |  988 --------------------------
>  plugins/bluez4.h        |   84 ---
>  plugins/dun_gw_bluez4.c |  172 -----
>  plugins/hfp_ag_bluez4.c |  218 ------
>  plugins/hfp_hf_bluez4.c |  554 ---------------
>  plugins/sap.c           |  363 ----------
>  11 files changed, 1 insertion(+), 4264 deletions(-)
>  delete mode 100644 btio/btio.c
>  delete mode 100644 btio/btio.h
>  delete mode 100644 dundee/bluez4.c
>  delete mode 100644 plugins/bluez4.c
>  delete mode 100644 plugins/bluez4.h
>  delete mode 100644 plugins/dun_gw_bluez4.c
>  delete mode 100644 plugins/hfp_ag_bluez4.c
>  delete mode 100644 plugins/hfp_hf_bluez4.c
>  delete mode 100644 plugins/sap.c

Here is the summary with links:
  - bluez4: Remove support
    https://git.kernel.org/pub/scm/network/ofono/ofono.git/?id=6bd9bd2c9efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


