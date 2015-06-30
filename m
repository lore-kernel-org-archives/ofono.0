Content-Type: multipart/mixed; boundary="===============0436720740511240125=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Tue, 30 Jun 2015 07:54:47 +0200
Message-ID: <55922F27.1020802@hale.at>
In-Reply-To: <558CB6F4.2070808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0436720740511240125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 2015-06-26 um 04:20 schrieb Denis Kenzior:
> Hi Marko,
>
> >
>> _And the fail log _(on reconnect):
>>
>> Jun 29 15:19:34 mx31tt01 daemon.debug ofonod[657]:
>> gprs-context.c(240):at_gprs_activate_primary() cid 1
>> Jun 29 15:19:34 mx31tt01 daemon.info ofonod[657]: Modem: >
>> AT+CGDCONT=3D1,"IP","web.one.at"\r
>
> Your modem is not responding to this AT command.  There's not much =

> that can be done on the oFono side.  You need to figure out why the =

> modem is acting this way.
>

Hi Denis,

thank you for the answer. If I can figure out the error,
and can solve the problem, I will let you know.

>>
>>
>> Jun 29 15:20:14 mx31tt01 daemon.err connmand[561]: Failed to change
>> property: /he910_0/context15 org.ofono.ConnectionContext.Active:
>> org.freedesktop.DBus.Error.NoReply Did not receive a reply. Possible
>
> Regards,
> -Denis

Regards,
Marko


--===============0436720740511240125==--

