Content-Type: multipart/mixed; boundary="===============5810406011315349106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT channel problem
Date: Thu, 05 May 2016 09:04:54 -0500
Message-ID: <572B5306.2000004@gmail.com>
In-Reply-To: <CAH4ZQwurmsdm9_Tw-hGz8zY=im62R=zu7da-0DUZ3dkQbY2_4Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5810406011315349106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 05/05/2016 03:42 AM, Enrico Sau wrote:
> Hi all,
>
> I'm running into a problem with AT command read process and I need some
> help because I don't fully understand the code in this case.
>
> Ofono freezes in one particular systematic case when I receive
> "\r\nOK\r\n" from the modem port (without quotes).
>
> As I understood the method gatchat/gatchat.c::new_bytes() is called when
> something was read from gatchat/gatio.c::received_data(), and the
> function p->syntax->feed returns a result based on the syntax structure.
>
> I made some debug and I found out that, in the failing case,
> syntax->state is 2, it means that it is trying to read a line, but the
> process fails because it doesn't find the ' " ' character.
>

What syntax is being used?

> I don't understand where the variable sysntax->state was set to 2. It
> doesn't make sense to me.
> I tried to search the code for all possible points where the variable is
> set but I couldn't find the correct one.
>

How does the rest of the log look like?

> Does anyone have a suggestion about where should I look?
>
> Thank you all.
>
> Enrico

Regards,
-Denis


--===============5810406011315349106==--

