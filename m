Content-Type: multipart/mixed; boundary="===============0533490657804545978=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Wed, 13 Mar 2013 17:11:12 +0100
Message-ID: <5140A520.7050603@syscom-instruments.com>
In-Reply-To: <513F703F.40001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0533490657804545978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12. 03. 13 19:13, Denis Kenzior wrote:
> Hi Anthony,
>
>>
>> Any comments ? :(
>
> Nope, the logs looked fine.
>

I found the issue !

On our embedded platform, there a CPLD which drive the reset, the power =

and the flight mode of the GSM chips.

And, guess what ? There has been an update of the CPLD sometime ago. And =

this update enables always the flight mode ... !!!

So that, depending of the board I used, the version for the CPLD was =

different (not all my boards were updated), sometimes I could send SMS, =

sometimes not, sometimes the GSM modem was blocked, ...

An update of CPLD code fix the problem !

Sorry for the noise :)

It's time to take a tea and be happy.

Regards,
Anthony Viallard.


--===============0533490657804545978==--

