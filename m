Content-Type: multipart/mixed; boundary="===============0214540839141341321=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [fix-isi-udev PATCH 0/3] Improve udev with isi
Date: Fri, 08 Oct 2010 10:41:26 +0200
Message-ID: <1286527286.6145.184.camel@aeonflux>
In-Reply-To: <1286480461.9665.558.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0214540839141341321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > [fix-isi-udev PATCH 1/3] udev: do not use post-143 libudev features
> > [fix-isi-udev PATCH 2/3] udev: refactor add_isi
> =

> These two were applied. Thanks!
> =

> > [fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB ids
> =

> This one was left dangling; let's see if we can come up with a better
> way to match the modems driven by cdc_phonet. (Although, admittedly this
> same approach is already used with some AT modems.)

that is a leftover from the time where we only looking for TTY devices.
In that case that was fine. Now this needs to be fixed as well.

Regards

Marcel



--===============0214540839141341321==--

