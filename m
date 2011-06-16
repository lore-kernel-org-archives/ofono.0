Content-Type: multipart/mixed; boundary="===============2925516143036181616=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Problems ofono 0.45 and Nokia 6760
Date: Thu, 16 Jun 2011 14:37:19 +0300
Message-ID: <1308224239.2565.562.camel@tucson>
In-Reply-To: <4DF9CC7B.60603@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2925516143036181616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-06-16 at 11:27 +0200, ext Claudio Degioanni wrote:
> > So my advice is to simply use DUN via USB ACM interface. So I think the
> > nokia driver might work better than the isiusb one in this case.
> I'm using embedded tegra2 system, in the past i have tested the
> connection on x86 machine and it
> works succefull.

Ah, I see.

This issue was actually fixed in commit
44ad041c2740064ec055bee7c4084953a10e799d about a week after the 0.45
release.

Cheers,
Aki


--===============2925516143036181616==--

