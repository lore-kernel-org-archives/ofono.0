Content-Type: multipart/mixed; boundary="===============8290523735416224601=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH 3/3] ifx: fix issue with closing of DLC_AUX tty channel
Date: Thu, 10 Mar 2011 08:38:56 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5F37@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1299707667.2497.18.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8290523735416224601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> Hi Guillaume,
> =

> > Using kernel mux, a recursive locking is detected. This issue is
> > due to the fact that the DLC_AUX is not closed by ofono. This is
> > not done because the shutdown_device() function in charge of it
> > is called in the context of an AT callback function and for an
> > AT sent in this same dlc. Calling the real shutdown_device()
> > function using a timer solved the issue.
> =

> I am not following here. Are you trying to fix a kernel locking with a
> userspace workaround? That is not really acceptable. It is the kernel's
> responsibility to cleanup after userspace. Not the other way around.
> =


No it's not what I've try to fix. I realize that my explanation is not very=
 clear :(
The real issue fixed here is the non-closing of the dlc when this one is di=
d in the callback context of an AT command.

The lock issue that we have seen with the kernel mux is directly linked to =
this non-closing and I agree with you that this kind of issue is not accept=
able. Kernel mux team is currently working on it.

About the non-closing issue itself. What I've seen is that if you do a g_at=
_chat_unref() for a dlc in the callback function of a g_at_chat_send() done=
 on the same dlc, the tty linked to the dlc is not closed. This is typicall=
y what we do in the ifx.c code for the modem release.
If you change the g_at_chat_send() call to remove the callback and do the g=
_at_chat_unref() just after it, the tty is correctly closed. Same if instea=
d to do the g_at_chat_unref() directly in the callback you do it in a timer=
 callback.
This last one method is what I've did in my patch.

Regards,
Guillaume
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============8290523735416224601==--

