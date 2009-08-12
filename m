Content-Type: multipart/mixed; boundary="===============5064095210327877342=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 12 Aug 2009 11:13:51 -0500
Message-ID: <200908121113.51953.denkenz@gmail.com>
In-Reply-To: <a32762a20908120648q7d07800evb542b5ec253ae622@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5064095210327877342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> 2009/8/10 Denis Kenzior <denkenz@gmail.com>:
> >> It would make sense for the providers to resend the MWI information
> >> everytime subscriber connects the network and then it would be less
> >> problematic in case the information couldn't be written to SIM, but I
> >> don't know if they ever do this.
> >
> > Probably they don't, there are also weird roaming cases to consider,
> > where you receive MWI, turn phone off, step on a plane and turn phone on
> > with some other network entirely.
>
> There is another case to consider when the SIM is moved to a
> completely different phone. In fact, I think this is the original
> reason to store the MWI flag to the SIM.

This is why we always attempt to write to the SIM for EFmwis.  If the SIM =

doesn't support this file,  then there's nothing we can do to preserve the =
MWIS =

information in the case you describe above.

There are other cases as well:
	- EFmbdn & perhaps EFmbi
	- EFmsisdn
	- EFcbmid
	- EFcbmir
	- EFcfis

>
> > Can we make the MWI interface smarter somehow?  Perhaps by not enabling
> > it unless at least the EFmwis file is available, or by always storing t=
he
> > EFmwis contents on the filesystem?
>
> I think this makes sense. There is another, related issue with some
> Nokia modems, though. They might not support low-level, EF access
> directly, but have some higher level API for accessing things like the
> MWI flag, HPLMN list and SPN. We might need to think about adding such
> high-level API support to the driver API as (optional) ops --
> especially if other modems behave similarly -- otherwise the ISI modem
> driver may need some kluge to handing EF writes.

There is vast amount of information stored on the SIM that we need to expos=
e.  =

Today oFono processes:
	- EFspn
	- EFpnn
	- EFopl
	- EFmbi
	- EFmbdn
	- EFmwis
	- EFspdi
	- EFmsisdn

We also eventually need to support:
	- EFecc
	- EFsdn
	- EFad
	- EFcbmid
	- EFcbmir
	- EFehplmn
	- EFehplmnpi
	- EFici
	- EFict
	- EFoci
	- EFoct
	- EFcfis

 So there are two issues here:
	- There is absolutely no standard data format for such vendor commands.  S=
o =

coming up with a higher level API that supports all modems might be tricky.=
  =

The advantage of using low-level SIM access is that the command syntax & da=
ta =

format is standard and should be supported by any modem out there.  Of cour=
se, =

as you point out, many don't.
	- This presents the issue of having many more code paths to debug inside t=
he =

core and potentially many more plugin functions to implement.

I'd like to keep the core as clean and small as possible.  What is your =

feeling for the level of bloat such higher level APIs will introduce in =

comparison to a giant if-else statement inside the driver itself?

Regards,
-Denis

--===============5064095210327877342==--

