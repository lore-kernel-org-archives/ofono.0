Content-Type: multipart/mixed; boundary="===============2513483304154124589=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Tue, 30 Jun 2015 13:31:05 +0200
Message-ID: <55927DF9.6020006@hale.at>
In-Reply-To: <55922F27.1020802@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2513483304154124589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 2015-06-30 um 07:54 schrieb Marko Sulejic:
> Am 2015-06-26 um 04:20 schrieb Denis Kenzior:
>> Hi Marko,
>>
>> >
>>> _And the fail log _(on reconnect):
>>>
>>> Jun 29 15:19:34 mx31tt01 daemon.debug ofonod[657]:
>>> gprs-context.c(240):at_gprs_activate_primary() cid 1
>>> Jun 29 15:19:34 mx31tt01 daemon.info ofonod[657]: Modem: >
>>> AT+CGDCONT=3D1,"IP","web.one.at"\r
>>
>> Your modem is not responding to this AT command.  There's not much =

>> that can be done on the oFono side.  You need to figure out why the =

>> modem is acting this way.
>>
>
> Hi Denis,
>
> thank you for the answer. If I can figure out the error,
> and can solve the problem, I will let you know.
>

Hi Denis,

we figured out the problem:

At the end of a PPP connection, garbage was passed in to the AT command =

parser on the modem chat.
This garbage contained a doublequote, which switched the AT syntax =

parser into string mode.
However, because no second doublequote arrived, it stayed in this mode, =

and kept returning UNSURE result.

I think this is an major issue that should be fixed in oFono.
The syntax parser has to be extended to handle such cases.

Regards,
Marko


--===============2513483304154124589==--

