Content-Type: multipart/mixed; boundary="===============8294903745374064035=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Connecting with Huawei E226
Date: Fri, 27 Aug 2010 20:14:50 +0200
Message-ID: <1282932890.6841.79.camel@localhost.localdomain>
In-Reply-To: <AANLkTimPTy-bXSCJNXFiAo8U8+SLe0KzQ18AxdzGZvJy@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8294903745374064035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

> >> >> I forgot also to mention that I used list-context to see if the
> >> >> enable-modem was successful. The test B is the one that fails.
> >> >
> >> > From the logs it seems Test A is what fails since we never add any a=
toms
> >> > in that one.  Basically the problem is that your modem firmware never
> >> > tells us that the SIM has been initialized by sending us a ^SIMST
> >> > notification.
> >> >
> >> > Kalle's patch relies on SIMST being delivered eventually.  Since it
> >> > never does, oFono is under the impression that your SIM is invalid. =
 We
> >> > probably need to query SYSINFO a few more times in this case, but it
> >> > seems all Huawei firmwares act slightly differently here.
> >>
> >> Is there something else I can do to help solve this issue? I tried
> >> another modem, a ZTE MF110, that is not working either. I installed
> >> wvdial on my MeeGo machine and was able to connect using both the
> >> Huawei and ZTE modems. I also tested the devices under Ubuntu Lucid
> >> and Fedora 13 (both with Networkmanager) and they worked out of the
> >> box.
> >
> > the problem is that neither wvdial nor NM are proper telephony stacks.
> > They are both in the end just dialers. So that comparison is not helping
> > us since oFono has to do way more work before we can just "dial" an
> > Internet connection.
> >
> > We get this fixed, but not as quick as you might like us too. The Huawei
> > and ZTE modems are showing race condition behavior. And that is mainly
> > because oFono is just too fast and they can't initialize the SIM fast
> > enough for us.
> =

> I understand. I mixed up two problems and that got confusing. The ZTE
> modem is not showing the race condition issue. It didn't showed up
> when I called list-modems. That is why I tested it with other
> software, just to be sure it works with linux (MeeGo in this case). I
> will test again with the ZTE modem and send the logs to the list.

my ZTE modem works, but you need the latest oFono and its udev rules to
make it detect.

Regards

Marcel



--===============8294903745374064035==--

