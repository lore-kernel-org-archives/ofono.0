Content-Type: multipart/mixed; boundary="===============2154396904758277799=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] atmodem: Signal quality on quectel serial modems
Date: Wed, 19 Aug 2020 10:19:13 -0500
Message-ID: <eb5b1cee-c0a1-e20d-1fb8-5d24311291b8@gmail.com>
In-Reply-To: <20200819124356.881471-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2154396904758277799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 8/19/20 7:43 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> As the default way of getting the signal quality with +CIND is also
> unstable on quectel serial modems (the same as on quectel EC21). In fact
> the signal quality is only updated on cell changes. Those trigger a
> manual AT+CSQ in ofono and get an update this way, but the URCs do not
> work.
> So we implement a quectelish way here as well.
> =

> --- >8 ---
> =

> I send this patch as a RFC because the quectel_csqn_notify function
> very much duplicates the ifx_xcsq_notify function despite the "+CSQN"
> string. I did not see a good way to reuse the already existing
> function because the callback interface only has one user defined
> pointer and this is used by the struct ofono_netreg pointer already.
> Does anyone have a better idea ?

You could take advantage of the fact that at_netreg_data carries the vendor=
 id =

in nd->vendor.  So if you wanted to make ifx_xcsq_notify you could do somet=
hing =

like:

struct ofono_netreg *netreg =3D user_data;
struct at_netreg_data *nd =3D
			ofono_netreg_get_data(netreg);

switch (nd->vendor) {
case ...
	prefix =3D "+XCSQ:";
	break;
case ...
	prefix =3D "+CSQN:";
	break;
}

....

Or just put the meat of ifx_xcsq_notify into a separate function that takes=
 the =

prefix as a parameter...

Then ifx_xcsq_notify might look something like:

netreg_generic_strength_report("+XCSQ:");

> =

> Thanks,
> Lars
> ---
>   drivers/atmodem/network-registration.c | 34 ++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> =


Regards,
-Denis
--===============2154396904758277799==--

