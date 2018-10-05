Content-Type: multipart/mixed; boundary="===============7337871957587401980=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 21:47:24 -0500
Message-ID: <582370e9-6ac2-987f-a458-6d3aa31e5bca@gmail.com>
In-Reply-To: <CAKSBH7GpyFOrgOYyKyq1bJf7nNQoNRdci1iymNcyOSdxAdPbjQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7337871957587401980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>>
>> I prefer we set a good example :)
> =

> Then the cleanest way is to set a default in the switch, without any func=
tion.
> Ok?
> =


That is not really great either.  We want to make sure that the compiler =

warns us if we add a new enumeration and don't take care of it in the =

code.  In fact we have a coding-style.txt entry for this as well, see =

item M12.  If there's code that uses default labels for enums, it is =

likely not compliant and should probably be fixed.

Regards,
-Denis

--===============7337871957587401980==--

