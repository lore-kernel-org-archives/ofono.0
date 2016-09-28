Content-Type: multipart/mixed; boundary="===============6032138904245788442=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: IPV6 question
Date: Wed, 28 Sep 2016 10:22:54 -0500
Message-ID: <57EBE04E.9080205@gmail.com>
In-Reply-To: <CAH4ZQwuSW=LhjY9zNKCJSyde+s_kivvdtJawE+-xJMG43joa1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6032138904245788442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,


On 09/27/2016 01:54 AM, Enrico Sau wrote:
> Hi all,
>
> As far as I understand, ofono doen't support IPV6 over ppp due to the
> fact that IPV6 compression protocol implementation is missing.
> Is that right?
>

GAtChat has support for IPV6 control protocol, so IPV6 over PPP should =

be possible.  I think it is simply not enabled in the driver since we =

have never found hardware that supports it.

We do not support IPV4 or IPV6 compression.  It is an optional feature =

and I doubt you'd want to use it anyway.  We're not operating on a =

constrained bandwidth link, so enabling it would only increase CPU =

utilization and decrease throughput.  Lose/lose situation.

Regards,
-Denis

--===============6032138904245788442==--

