Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B622198851
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924817; cv=none; b=ts9fWQlBKu/unzTwp/14P5qZ8PrzlOEXN90ufz/Z8qH7z7b48xJdst5UN0b2X9JnEcT3Wvwu3j7RjlmJDe8UVeFpTO+0l2x6Dhh47ltcYLkZEuKdN5oLiQuSs8jzNC8ZVcGFySCafh1AsNldqr5Sx6/+3iiaNyKkCg6/rxn9KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924817; c=relaxed/simple;
	bh=0+4LaVhTcYm2hKMZBKpHlLVXXNoJ9CkxYGw8M+ts+Nw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jl/IgMswOruzib1B6OZCSgUYyR3VsZu/KaZSntFnaS0OISDkH8rl9nPoUrzbJJUILBhT74GErUYGj15ZVHfy55TLRijefDUmwDmIsuEwsELvr6qQbuMAXNdboMZoLkbQxGC1+kS8828ios4LxH/+xQ1wfI5YFZJWxuBQdjxZrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc9b7.dip0.t-ipconnect.de [79.239.201.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id D47F4CECC5;
	Mon, 18 Nov 2024 11:13:26 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] qmi: sim: implement lock(LockPin method)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Date: Mon, 18 Nov 2024 11:13:16 +0100
Cc: ofono@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>,
 absicsz@gmail.com,
 merlijn@wizzup.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1D53BBD-CC41-4924-BA84-1BB0040F3517@holtmann.org>
References: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

Hi Ivaylo,

<please insert commit description here>


> On Nov 17, 2024, at 13:03, Ivaylo Dimitrov =
<ivo.g.dimitrov.75@gmail.com> wrote:
>=20
> ---
> drivers/qmimodem/sim.c | 70 =
++++++++++++++++++++++++++++++++++++++++++++++++++
> drivers/qmimodem/uim.h |  1 +
> 2 files changed, 71 insertions(+)
>=20
> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
> index b1d8f22..65c0fa6 100644
> --- a/drivers/qmimodem/sim.c
> +++ b/drivers/qmimodem/sim.c
> @@ -844,6 +844,75 @@ static void qmi_query_locked(struct ofono_sim =
*sim,
> l_free(cbd);
> }
>=20
> +static void qmi_lock(struct ofono_sim *sim,
> + enum ofono_sim_password_type passwd_type,
> + int enable, const char *passwd,
> + ofono_sim_lock_unlock_cb_t cb, void *user_data)
> +{
> + struct sim_data *data =3D ofono_sim_get_data(sim);
> + struct cb_data *cbd =3D cb_data_new(cb, user_data);
> + int passwd_len;
> + uint16_t info_len;
> + uint8_t pin_id;
> + struct qmi_param *param;
> + uint8_t session[2];
> + struct {
> + uint8_t id;
> + uint8_t enabled;
> + uint8_t length;
> + uint8_t pin[0];
> + } __attribute__((__packed__)) *info;

Is this a good idea to define this inline with the function and not =
better as some QMI generic define?

Regards

Marcel

