Content-Type: multipart/mixed; boundary="===============4516062263200453111=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Tue, 01 Feb 2011 09:25:32 +0200
Message-ID: <1296545132.18320.12.camel@jsaunama-desktop>
In-Reply-To: <4D4719FF.3060107@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4516062263200453111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


On Mon, 2011-01-31 at 14:22 -0600, Denis Kenzior wrote:
> So my main problem here is that you require the SPN a handful of times
> in the phone's lifetime, more likely once.  Yet you pay the cost of
> reading and delaying the initialization every time.  In my view this is
> not really acceptable.
> =

> Perhaps a better approach would be to put the spn parser into simutil so
> it can be shared by netreg and gprs.  Then go back to your original
> proposal of delaying the gprs atom registration if provisioning is
> required and SPN is needed.

OK.

SPN parser is basically a line =

spn =3D sim_string_to_utf8(data + 1, length - 1);
so I do not think it really needs a separate simutil routine.

For reading SPN in gprs atom registration, it would make sense to make
it with the new sim_context api. Any estimates when that will be in?

--Jukka
 =




--===============4516062263200453111==--

