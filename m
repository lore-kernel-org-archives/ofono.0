Content-Type: multipart/mixed; boundary="===============3395793559314598928=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] sim: Check SIM pin status after changing pin.
Date: Fri, 05 Nov 2010 21:19:03 +0100
Message-ID: <1288988343.9615.140.camel@aeonflux>
In-Reply-To: <AANLkTimcZCHkLiyiwKOOxnT_kC1cAwS7J=A8-SaeozRg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3395793559314598928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

as Denis mentioned and I stated many times, please don't top post on
this mailing list. It is against our mailing list etiquette.

> OK, I can see that this approach was rather too simplistic... Maybe check=
ing
> the returned CME error would be a better idea?
> I=E2=80=99m a bit unsure how (or if) to proceed with this. As this is in =
the core,
> and not our driver, it might be more on your table? If you think it is
> important.

So if I follow this logic, then it does mean we should not be fixing
issues with the STE driver anymore? And not allowing you to use the
generic AT modem and generic MBM modem drivers? Since these are strictly
speaking not STE driver either.

This is not how this works. Everybody works for the greater good to
improve oFono. This is the way how it makes progress. The core is not a
fixed piece of software. It evolves with the modems we support. If it
needs to be changed or improved, then that is a task you should take up.

And as explained by Denis, if you have found such a problem area inside
the core, the generic drivers or anywhere else, write it down as part of
the TODO list. So patches are highly encouraged.

Regards

Marcel



--===============3395793559314598928==--

