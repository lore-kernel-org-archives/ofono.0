Content-Type: multipart/mixed; boundary="===============5218808796232256530=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Vendor product extension thoughts
Date: Thu, 04 Jan 2018 10:27:19 -0600
Message-ID: <fea86f8c-9f44-cbbe-74e1-5bee3b4a9633@gmail.com>
In-Reply-To: <CAH4ZQwuKXyE1wi47d1eO-Jcqcht47OkoV_WO3KUOuCymhQ31Yg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5218808796232256530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 01/04/2018 07:01 AM, Enrico Sau wrote:
> =E2=80=8BHello everyone,
> =

> I'm facing what seems to be a limit in ofono implementation.
> I'm working with some Telit modems and some of them have reserved =

> contexts which can't be used for data connection.
> =


Define 'reserved contexts'?  Is it just the context id that is reserved =

or the USB port?

> Currently, from telit plugin, I can only send the "vendor" parameter to =

> the interface create function and there is no way to specify the product.
> =

> What you think?
> Did anyone ever have to set different behaviors for different products =

> of the same vendor?
> =

> I'm thinking about different solutions:
> - extend the vendors enum in order to be a vendor/product enum.

This can certainly be done, but not preferable.

> - add a product parameter to the function prototype

This would be too invasive.  Are you using the telit gprs-context =

driver?  If so, you'd be better off changing that one to accept a custom =

data structure instead of a GAtChat.  See drivers/hfpmodem for an =

example.  Or write a custom driver for your needs...

> - change the vendor parameter with a structure of two variables

See above

Regards,
-Denis

--===============5218808796232256530==--

