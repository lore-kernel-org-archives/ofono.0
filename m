Content-Type: multipart/mixed; boundary="===============8719647640227492627=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 12:00:44 +0200
Message-ID: <87fwt9ng37.fsf@potku.valot.fi>
In-Reply-To: <1294129852.5852.76.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8719647640227492627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

>> For me the best would be to have all plugins in ofono tree and
>> enable/disable them with configure switches.
>
> I wanna use priorities and smart detection to use them. Nothing for the
> user to configure. Just installing some extra packages should active its
> usage. And yes, I want to make it possible to build all plugins at all
> time.

Even better, maybe just a bit trickier to implement. But at least
mobile-broadband-provider-info already supports pkgconfig so the
location of the xml should be easy to detect automatically during
configure.

-- =

Kalle Valo

--===============8719647640227492627==--

