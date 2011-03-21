Content-Type: multipart/mixed; boundary="===============8043075572478636867=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH v2 1/9] bluetooth: add functions for sco connection
Date: Mon, 21 Mar 2011 18:08:39 +0100
Message-ID: <4D878617.6000703@linux.intel.com>
In-Reply-To: <20110319110621.GA5863@jh-x301>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8043075572478636867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,
> AFAIK the plan is still to have only one interface towards PulseAudio as
> far as Bluetooth audio is concerned, and that's the Media interface in
> BlueZ. So oFono shouldn't need any SCO support as such.

Thanks for feedback,

My understanding was that profiles had to be prototyped using btio, then =

moving to use bluez over dbus similar to hfp handsfree implementation. I =

have no real idea when this transition could occur...

Fr=C3=A9d=C3=A9ric


--===============8043075572478636867==--

