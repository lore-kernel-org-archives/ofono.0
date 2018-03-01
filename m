Content-Type: multipart/mixed; boundary="===============0801262776961848327=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Ofono LTE modems and connman services
Date: Thu, 01 Mar 2018 16:38:53 +0100
Message-ID: <a86022ac-0955-41ca-a4b9-0ccd4bf55721@southpole.se>
In-Reply-To: <20180301162733.298f3eef@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0801262776961848327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/01/2018 04:27 PM, Alexander Couzens wrote:
> Hi Jonas,
> =

> thanks for your patch.
> I'm actually having problem from time to time with ofono (quectel
> ec 20) when using LTE. Ofono has 2 contexts allocated, but it says
> it's detached to packet switched.

You should get just one context now...

> =

> I hope your patch is fixing this.
> =

> In the LTE atom, you're setting the profile 1.
> Does it really have to be profile 1. Is the profile 1 a special profile
> which should not be removed?! Or how is it ensured, this can not be
> removed?

Well, that's where I need some help from somebody with another modem. =

This works for the one I've got.

I'm not able to remove profile 1... not sure why, but the command fails =

consistently.  There's no reason it has to be profile 1, as far as I can =

tell... for the AT command set, context 0 seems to be special, but =

profile 0 does not exist on my modem.

Maybe the 'default' profile is the just the first dual-stack profile =

amongst all profiles???

Hopefully the patch is starting point for figuring this out...


> =

> I'm also asking, because ofono/qmi doesn't really support ipv4, ipv6 and
> dual contexts. For this we need to manage exactly those profiles and
> use them when starting the contexts. Atm requesting an ipv4
> context can result in requesting a Dual context depending if the
> network (SGSN/GGSN) supports it.

As far as I understand it, the default bearer context has to be dual stack.

/Jonas

> =

> Best,
> lynxis
> =



--===============0801262776961848327==--

