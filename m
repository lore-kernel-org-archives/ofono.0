Content-Type: multipart/mixed; boundary="===============7102854425821699869=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH 2/2] Add: n900modem driver
Date: Mon, 30 Aug 2010 23:28:13 +0200
Message-ID: <6741e76801885a065863f2d50dee4c50@chewa.net>
In-Reply-To: <4C6AE0D3.5090903@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7102854425821699869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 17 Aug 2010 14:19:47 -0500, Denis Kenzior <denkenz@gmail.com>
wrote:
>> -	/* Expect phonet interface name usbpn<idx> */
>> -	if (strncmp(ifname, "usbpn", 5) ||
>> -		ifname[5 + strspn(ifname + 5, "0123456789")])
>> +	if (match_ifname("usbpn", ifname)) {
>> +		driver =3D "isimodem";
>> +		address =3D PN_DEV_PC;
>> +	} else if (strcmp("phonet0", ifname) =3D=3D 0) {
>> +#if HAVE_N900MODEM
>> +		driver =3D "n900modem";
>> +#else
>> +		driver =3D "isimodem";
>> +#endif

I don't understand what this code is supposed to do in the first place.
Autoconfiguration of the Phonet stack is the kernel's job (or phonet-utils'
on older kernels). This really really does not belong in oFono. That is a
complete denial of the reasons why Phonet is a socket API, i.e. that more
than one user-space process can use it at a time. If you want oFono to take
care of everything, you really should just steal the USB interface via
libusb and/or use the raw SSI character device. Not that I'd advise doing
so.

In any case, if you need to know whether you're on SSI or USB, you should
check the link-layer address, not the name of the interface. I do hope
that, if and when the SSI driver goes upstream, the interface will be
called ssi0 or mcsaab0 rather than phonet0 by the way.

Then there's the GPIO lines. Ideally, the hardware specifics should be
taken care of by the kernel.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============7102854425821699869==--

