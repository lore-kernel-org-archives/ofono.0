Content-Type: multipart/mixed; boundary="===============6066358381081244507=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: vendor models and options
Date: Fri, 07 Sep 2018 10:09:32 -0500
Message-ID: <da763150-e3c8-dfe4-da96-0c4e679f1aa2@gmail.com>
In-Reply-To: <CAKSBH7GEje3Gc71h1qDDnKineXL8MHtNBwZmyK+VbeJNh+JZaQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6066358381081244507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/07/2018 03:09 AM, Giacinto Cifelli wrote:
> Dear Denis, all,
> =

> while preparing the Gemalto driver, I see that there is a potential =

> shortcoming with the vendor structure in the atmodem. I can set =

> OFONO_VENDOR_GEMALTO_model, but this could be a very long list for all =

> options to maintain. I see the tendency also for other manufacturers.
> Would it be ok if I convert the vendor integer in a structure with model =

> and flags?
> This would make the current code more compact and clearer.

Feel free to suggest something more concrete illustrating how your =

proposal would result in more compact code.  It seems to me that it =

would be quite disruptive, but I always try to have an open mind :)

But of course there are other 'creative' ways we can utilize to handle =

this as well.

> =

> The alternative of cloning the atmodem is less tempting, because then it =

> needs constant monitoring of the atmodem to porting the features in it, =

> or conversely missing features in this general driver. One example is =

> for the indicators=C2=A0+CGREG/+CEREG/+C5GREG that we are adding in atmod=
em =

> (gprs.c), instead of the unique=C2=A0+CGREG that doesn't work anymore for=
 LTE =

> (in the 27.007). If I add it in Gemalto driver, it will be missing in =

> the atmodem.

Aren't these commands now standardized?  Why do you need sub-model =

information to handle this?

Either way, it is quite hard to give you any suggestions without seeing =

concretely what you're trying to do.  Perhaps you want to submit what =

you have (or some subset that illustrates the issues you're having) to =

the mailing list (even if it isn't completely ready, just tag it as =

'RFC') and then I can give you more concrete feedback.

Regards,
-Denis

--===============6066358381081244507==--

