Content-Type: multipart/mixed; boundary="===============2152670887382066606=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 23 Oct 2013 12:20:57 +0200
Message-ID: <CACM4vuAb9G-SgSuRo-xf_DjuQ6bse5vxGYTQmXNZyAX+L+GbqQ@mail.gmail.com>
In-Reply-To: <52604017.9030003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2152670887382066606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

<snip>

> So again, you can try to guess, but you need to do this outside of the co=
re.
> If you want to run heuristics against IMSI based on some database, then j=
ust
> extend the provisioning API to do so.

<snip>

> Patches are always welcome, but please keep in mind the core policies I
> outlined.  Plugins have much less restrictions and you can get a bit more
> creative there.  If you want to maintain a MCC -> MNC length database bas=
ed
> on ITU E.212, then I definitely encourage you to do so.
>
> Regards,
> -Denis

After thinking about different options, my proposition is:

* Write a new plugin called mnclenght that will find the length of the
MNC code based on the IMSI. It will use a DB of MCC/MNC
correspondences and check some special cases for some operators (this
is the approach taken in Android, btw).

* This plugin will be called by the sim core after reading the IMSI in
case the MNC length has not been set before. If a valid MNC length is
found, the MNC will be read from the IMSI and MobileNetworkCode
property will be updated in dBus.

Would this approach be okay for going upstream?

Regards,
Alfonso

--===============2152670887382066606==--

