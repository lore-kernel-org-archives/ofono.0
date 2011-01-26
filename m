Content-Type: multipart/mixed; boundary="===============8624587641050777218=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [gprs-provision PATCHv7 0/5] Plugin API for provisioning of GPRS
 context settings
Date: Wed, 26 Jan 2011 14:56:41 -0600
Message-ID: <4D408A89.4070506@gmail.com>
In-Reply-To: <1296045255-29890-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8624587641050777218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 01/26/2011 06:34 AM, Jukka Saunamaki wrote:
> Hello
> =

> And again a patchset about automatic provisioning of GPRS context setting=
s.
> =

> Since the safe reading of EF-SPN turned out to be impossible until genera=
l solution is implemented, I must temporary give up my insistence on it.
> =

> So the following provisioning driver API must be considered as provisiona=
l. =

> When proper solution for SPN comes up, we should redesign the API. Withou=
t SPN, correct settings cannot be provisioned for all service providers, bu=
t at least for now most cases should work with just the MCC and MNC values =
provided with this API.
> =


I've applied all of your patches but have refactored them heavily
afterward.  Let me know if I broke anything.

Regards,
-Denis

--===============8624587641050777218==--

