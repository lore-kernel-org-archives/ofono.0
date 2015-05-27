Content-Type: multipart/mixed; boundary="===============4462046418127800391=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 19:02:51 +0200
Message-ID: <5565F8BB.4030106@dynamicdevices.co.uk>
In-Reply-To: <CANPyyuOxb-vV6cVNA-oeHt1atNPGHPg_SPBGW3o8CUOvrVaJcw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4462046418127800391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 27/05/2015 18:58, Mike Williams wrote:
> Alex,
>
> On Tue, May 26, 2015 at 12:20 PM, Alex J Lennon
> <ajlennon@dynamicdevices.co.uk> wrote:
>> Would you mind sharing the auto connection patch for cellular as we have
>> been wondering here why configuring autoconnection didn't seem to make
>> any difference?
>
> It's actually a patch for connman, which needs cellular services set
> with favorite=3Dtrue as well as autoconnect=3Dtrue before it will
> automatically connect them. connman correctly parses 'cellular' out of
> DefaultAutoConnectTechnologies and sets the autocorrect property for
> cellular services, so this patch just sets those services' favorite
> property to the autoconnect property when they are created.
>
> I'm a complete beginner to the connman/ofono source code though, so
> use this patch at your own risk :).
>
> Mike

Thanks Mike - that sounds very much like what we need.

I had resorted to a script which forced a connection of all cellular_foo
services to cause connman to connect the service and thus set the
"favourite" property

re: beginner - me too (although I have spent more time than I care to
recall fighting with PPP and modem AT command-sets over the years! :)

Thanks again,

Alex

--===============4462046418127800391==--

