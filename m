Content-Type: multipart/mixed; boundary="===============6296877391348526321=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Connecting with Huawei E226
Date: Fri, 27 Aug 2010 10:02:03 +0200
Message-ID: <1282896123.6841.76.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=MnhCwboYS29E8Ut8c0D6FeFxLusndOnO4C3Jv@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6296877391348526321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

> >> I forgot also to mention that I used list-context to see if the
> >> enable-modem was successful. The test B is the one that fails.
> >
> > From the logs it seems Test A is what fails since we never add any atoms
> > in that one.  Basically the problem is that your modem firmware never
> > tells us that the SIM has been initialized by sending us a ^SIMST
> > notification.
> >
> > Kalle's patch relies on SIMST being delivered eventually.  Since it
> > never does, oFono is under the impression that your SIM is invalid.  We
> > probably need to query SYSINFO a few more times in this case, but it
> > seems all Huawei firmwares act slightly differently here.
> =

> Is there something else I can do to help solve this issue? I tried
> another modem, a ZTE MF110, that is not working either. I installed
> wvdial on my MeeGo machine and was able to connect using both the
> Huawei and ZTE modems. I also tested the devices under Ubuntu Lucid
> and Fedora 13 (both with Networkmanager) and they worked out of the
> box.

the problem is that neither wvdial nor NM are proper telephony stacks.
They are both in the end just dialers. So that comparison is not helping
us since oFono has to do way more work before we can just "dial" an
Internet connection.

We get this fixed, but not as quick as you might like us too. The Huawei
and ZTE modems are showing race condition behavior. And that is mainly
because oFono is just too fast and they can't initialize the SIM fast
enough for us.

Regards

Marcel



--===============6296877391348526321==--

