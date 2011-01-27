Content-Type: multipart/mixed; boundary="===============9004902115106081470=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [gprs-provision PATCHv7 0/5] Plugin API for provisioning of GPRS
 context settings
Date: Thu, 27 Jan 2011 08:41:56 +0200
Message-ID: <1296110516.30517.8.camel@jsaunama-desktop>
In-Reply-To: <4D408A89.4070506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9004902115106081470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On Wed, 2011-01-26 at 14:56 -0600, ext Denis Kenzior wrote:
> > And again a patchset about automatic provisioning of GPRS context setti=
ngs.
> > =

> > Since the safe reading of EF-SPN turned out to be impossible until gene=
ral solution is implemented, I must temporary give up my insistence on it.
> > =

> > So the following provisioning driver API must be considered as provisio=
nal. =

> > When proper solution for SPN comes up, we should redesign the API. With=
out SPN, correct settings cannot be provisioned for all service providers, =
but at least for now most cases should work with just the MCC and MNC value=
s provided with this API.
> > =

> =

> I've applied all of your patches but have refactored them heavily
> afterward.  Let me know if I broke anything.

Excellent. Seems to work OK, thanks.

So, now while waiting for some solution to SIM reading issue, I can
start looking at proper provisioning plugin. And looking forward to
interesting discussions regarding merits of various XML-file formats for
settings database...

--Jukka



--===============9004902115106081470==--

