Content-Type: multipart/mixed; boundary="===============1756019805896036766=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Tue, 23 Nov 2010 15:45:07 -0600
Message-ID: <4CEC35E3.8010601@gmail.com>
In-Reply-To: <AANLkTimivA3nWN=ROdEFV4aMQVZ4+orwKQY1COO34Pea@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1756019805896036766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 11/23/2010 01:20 PM, Aki Niemi wrote:
> Hi,
> =

> 2010/11/23 Denis Kenzior <denkenz@gmail.com>:
>> In fact we were planning to report the current bearer on the
>> ConnectionManager interface once we figured out the vendor commands that
>> can actually report this information.
> =

> Do you mean HSDPA/HSUPA channel allocations, or the tech reported by
> CGREG? Because these can differ. For example, a Finnish operator's
> cells will not indicate HS*PA support, but HSDPA channel will
> nevertheless get allocated when data is moving. This is why for
> instance the N900 will show a 3G icon when idle, but switch to 3.5G
> when actively receiving data.
> =


I mean the actual bearer being used.  The 27.007 equivalent would be
+CPSB, not what is reported by +CGREG.

Regards,
-Denis

--===============1756019805896036766==--

