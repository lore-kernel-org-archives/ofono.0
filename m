Content-Type: multipart/mixed; boundary="===============1572961822507895801=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] stkutil: convert img to xpm
Date: Thu, 22 Jul 2010 15:05:06 -0500
Message-ID: <4C48A472.7040605@gmail.com>
In-Reply-To: <20100722125319.73372158@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1572961822507895801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 07/22/2010 02:53 PM, Kristen Carlson Accardi wrote:
> On Thu, 22 Jul 2010 11:12:40 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
> =

>> Also, XPM is pretty flexible here, there's no need to use 0-9 digits
>> only.  For instance, you can do two look up tables, one for images with
>> LUTs up to 64 entries and another for LUTs with more.  E.g.
>>
>> A-Za-z0-9@$ and 'aa ab ac .. pp' or something like that.
> =

> I realize this - this was an implementation choice to keep the code
> less complex, thinking that it would be better to favor that vs.
> saving some bytes on the xpm.

The wording on my part was poor.  Of course you knew this.  My intent
was to encourage the optimization of the xpm format.  Remember these
images are up to 64k in size, so a difference between transferring /
using up 128k and 192k respectively is quite significant.  The added
(minor) code complexity is definitely worth it.

Regards,
-Denis

--===============1572961822507895801==--

