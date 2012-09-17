Content-Type: multipart/mixed; boundary="===============4713612100893808228=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Mon, 17 Sep 2012 13:12:09 -0500
Message-ID: <505767F9.9060909@gmail.com>
In-Reply-To: <CABvLYuCY1KE5btF59ioXesRg3o=BYJBbaZyt1bodHMLDoMf+2A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4713612100893808228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 09/17/2012 12:49 PM, Cedric Jehasse wrote:
> Hi Denis,
>
>> To me it sounds like the output should be BASE followed by the inverted =
'!'
>> sign.  Unfortunately the modem is sending ISO-8859-1 characters instead =
of
>> GSM like it is being told to do by the driver.  That particular characte=
r is
>> not valid utf8, hence we go kaboom.
>>
>> Having said that, I'm not familiar with 'BASE', does the above sound
>> reasonable?
>
> The operator's name is just "BASE", so i wouldn't see why there would
> be an inverted '!' sign. In some AT logs i've also seen "BASE0" as a
> response to AT+COPS?, so i'm thinking this last character is just
> garbage.

What devices have you tried?  It may be the character is garbage, but it =

might also be it is not.  From the AT log the character you're getting =

is inverted exclamation point in Latin1 and it is a valid character in =

GSM character set...

Regards,
-Denis

--===============4713612100893808228==--

