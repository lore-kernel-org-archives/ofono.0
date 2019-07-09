Content-Type: multipart/mixed; boundary="===============4234688429135189305=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/10] quectel: add basic support for serial connected
 modems
Date: Tue, 09 Jul 2019 10:25:38 -0500
Message-ID: <567371b6-c940-9928-d955-93b94fad7d39@gmail.com>
In-Reply-To: <1eb425dc-cdda-a723-176f-cef89370ab67@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4234688429135189305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 07/09/2019 01:50 AM, Martin Hundeb=C3=B8ll wrote:
> Hi Denis,
> =

> On 08/07/2019 18.12, Denis Kenzior wrote:
>> However, there is still the fundamental issue of not being able to =

>> correlate the created ttys to the original one...=C2=A0 If we can fix th=
at =

>> in the kernel, then a strong argument can be made to drop GAtMux =

>> entirely. Which is actually what I would prefer as it would make =

>> conversion to ell much easier.
> =

> Let's see how it goes:
> https://lore.kernel.org/patchwork/patch/1098922/

That looks quite reasonable, so hopefully it gets picked up soon.

> =

> It won't make it in until v5.4, so either we support both n_gsm and =

> gatmux, or we fall back to /dev/gsmtty1 as base if GSMIOC_GETBASE isn't =

> defined.

Nah, I don't think there is a need to support both if everyone is happy =

to use the kernel multiplexer.  Can we come up with some common place =

where to put the kernel multiplexer setup?  This is something that will =

be relevant to more than quectel driver...

Something like atutil? .. Or maybe even ell?  E.g. we need an equivalent =

of g_at_mux_setup_gsm0710() and perhaps something that would open all =

the DLCs requested?

E.g. something like:

mux_setup(GAtChat *master, n_dlcs, callback, userdata, destroy);

callback(size_t n_dlcs, GAtChat *dlcs, userdata)

Regards,
-Denis

--===============4234688429135189305==--

