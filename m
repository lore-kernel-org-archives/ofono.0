Content-Type: multipart/mixed; boundary="===============4028378098344648051=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v0 2/3] huawei: Add modem type detection
Date: Mon, 09 Jan 2012 02:31:35 -0800
Message-ID: <1326105095.6454.145.camel@aeonflux>
In-Reply-To: <4F0AB677.8070508@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4028378098344648051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> >> +static gboolean parse_ati_result(GAtResult *result)
> >> +{
> >> +	GAtResultIter iter;
> >> +	const char *line;
> >> +	int num =3D g_at_result_num_response_lines(result);
> >> +	int i;
> >> +
> >> +	g_at_result_iter_init(&iter, result);
> >> +
> >> +	for (i =3D 0; i<  num; i++) {
> >> +		g_at_result_iter_next(&iter, NULL);
> >> +		line =3D g_at_result_iter_raw_line(&iter);
> >> +		if (g_str_has_prefix(line, "+GCAP"))
> >> +			return (g_strrstr(line, "+CGSM") !=3D NULL);
> > This parsing is more complex than it needs to be. It also parses the
> > string too many times. Especially since GAtChat does that all for you
> > already anyway.
> >
> > Instead of posting an example here, I just pushed a patch so you can see
> > how easily this can be done.
> =

> Right, I see this is easier do to how I you submitted it :)
> However, I have a dongle EC1261 that is bugged because:
>          - when I send ATI, the capabilities line is returned with =

> "+GCAP +GCAP:" prefix
>          - when I send AT+GCAP, the prefix is "+GCAP:"
> =

> Unless the manufacturer fixes this issue, we won't be able to support =

> this dongle...

that is because that modem firmware is like super buggy. I bet they also
prefixed the other ATI responses with their counterparts. Whoever owns
that modem should upgrade the firmware to a proper version.

And precisely because of this, I want this to fail if the modem firmware
is acting up again.

Regards

Marcel



--===============4028378098344648051==--

