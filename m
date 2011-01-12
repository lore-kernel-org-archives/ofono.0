Content-Type: multipart/mixed; boundary="===============6214733856097086737=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Wed, 12 Jan 2011 18:42:25 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802D59EA2@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1294849744.3873.89.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6214733856097086737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

ofono-bounces(a)ofono.org wrote:
>> Main reason for separate notification function is to avoid going
>> through all the cases handled inside voicecall_notify. TTY field in
>> ofono_call is basically for the GetProperties.
> =

> I see. So here is the main question that comes from this now.
> This seems to be a bit IFX specific driven API. I still have
> no idea why they can not just indicate this via +CRING and
> have to use CTM CALL for it.
> =

> Are we expecting that all modems will just establish a normal
> voice call and only later on signal that it is a TTY call?
> Any input from different vendors other than IFX. What about STE, ISI?

This notification is to inform the ME that the call is accepted as a TTY
call
on the remote side.

Regards,
Jeevaka





--===============6214733856097086737==--

