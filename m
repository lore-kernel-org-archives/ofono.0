Content-Type: multipart/mixed; boundary="===============9028624322829267855=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Network preference gsm is only working when allowing roaming?
Date: Fri, 09 May 2014 13:48:40 -0500
Message-ID: <536D2308.9080900@gmail.com>
In-Reply-To: <1399617078.4638.172.camel@pflykt-mobl1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9028624322829267855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrik,

On 05/09/2014 01:31 AM, Patrik Flykt wrote:
> =

> 	Hi,
> =

> On Thu, 2014-05-08 at 16:51 +0200, Niclas Karlsson wrote:
> =

>>     [ org.ofono.NetworkRegistration ]
>>         Status =3D roaming

The modem tells us it is roaming.  Nothing can be done about that.

<snip>

> =

> ...this combined looks like your SIM says MobileNetworkCode 08 while the
> network attached to is 24. So ofono thinks your are roaming now. Is an
> update needed to some database? Is this in ofono or in some other sw?
> =

> Let's ask ofono ml for an answer.
> =


I'm not sure what the context of the question is, but RadioSettings API
is completely independent of the current registration status.

Regards,
-Denis

--===============9028624322829267855==--

