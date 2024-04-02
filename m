Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D215AAA7
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095679; cv=none; b=bC1CEpn7bekQzYuXYB5CtZcorryQRVLcdVlvooXKWmpiKYzjYlc2Ofn61x1QkOjQSjA7EPZdd2SaOP6Z37wQLLy3ga7b8EbBQ+vmAe4soa/QwkguWmprcvzcaevsEiHqF/oyq/uWQsz001/QySawGkIa0NnUDG+n7csG/cQIcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095679; c=relaxed/simple;
	bh=kPNwvKdSmG/PW2rQ8oyCW1eFlFAkA5sNGNqcOa5Z0CM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EmsDVj9RjJMRMVXEC59njDagFRxHxbYTKklyDAk1fV7eYBF65qeGmM9s9/FlqdqcvabOfonNa0PPucwsoDcLPJ9UUSqXWagrefe42u5ieIR/Sul6Awr9Azs25VonhQqGmDCbmgrKn+ozkfPhdKmrv8q44JTIU7YMBitDxLMXwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc7ea.dip0.t-ipconnect.de [79.239.199.234])
	by mail.holtmann.org (Postfix) with ESMTPSA id 18FDBCECD4;
	Tue,  2 Apr 2024 23:59:49 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] udevng: Detect embedded qmi qrtr modems
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240402212013.39038-1-steve.schrock@getcruise.com>
Date: Tue, 2 Apr 2024 23:59:38 +0200
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C7DEA43-2E90-488B-91A2-9868638F4301@holtmann.org>
References: <20240402212013.39038-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Steve,

> Embedded qmi qrtr modems are identified by the existence of
> rmnet_ipaX and rmnet_dataX devices. Add a new "embedded" modem type
> so that these devices can be collected during enumeration and then
> configured for use by the gobi plugin. Modems of this type will be
> exposed as /gobiqrtr_X.
>=20
> Retrieving the endpoint ID is the main complication. It requires
> using an interface IOCTL and extended structure that is declared
> in msm_rmnet.h. This header is available many different places on
> the internet including in Android sources, but it is not available
> in popular Linux distributions. The minimum set of declarations is
> provided here so that the IOCTL may be used.

can=E2=80=99t this be integrated into the WWAN subsystem? And then we =
just
add support for WWAN subsystem to oFono.

Regards

Marcel

