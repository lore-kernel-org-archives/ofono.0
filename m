Content-Type: multipart/mixed; boundary="===============2660962758777582684=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] ifx: fix issue with closing of DLC_AUX tty channel
Date: Wed, 09 Mar 2011 13:54:27 -0800
Message-ID: <1299707667.2497.18.camel@aeonflux>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813A9C5DBB@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2660962758777582684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> Using kernel mux, a recursive locking is detected. This issue is
> due to the fact that the DLC_AUX is not closed by ofono. This is
> not done because the shutdown_device() function in charge of it
> is called in the context of an AT callback function and for an
> AT sent in this same dlc. Calling the real shutdown_device()
> function using a timer solved the issue.

I am not following here. Are you trying to fix a kernel locking with a
userspace workaround? That is not really acceptable. It is the kernel's
responsibility to cleanup after userspace. Not the other way around.

Regards

Marcel



--===============2660962758777582684==--

