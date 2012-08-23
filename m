Content-Type: multipart/mixed; boundary="===============3446365458752116038=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: sim status notification without polling
Date: Thu, 23 Aug 2012 12:37:08 -0500
Message-ID: <50366A44.3030202@gmail.com>
In-Reply-To: <503653AA.9030506@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3446365458752116038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

>> Also, one other thing I'm concerned about is the CFUN=3D4 usage when we
>> try to set the modem offline. Your comments indicate that the Telit
>> modem resets the SIM when we issue CFUN=3D4. Going from Online True ->
>> False we don't actually want to reset the SIM. Does CFUN take an extra
>> parameter to turn SIM reset off by any chance?
>
> Telit documentation says that +CFUN supports a second parameter which
> should turn reset off.
> AT+CFUN=3D? also returns +CFUN: (0,1,2,4,5),(0)
> AT reference manual: "reset flag 0 - do not reset the ME before setting
> it to <fun> functionality level"
>
> But the modem keeps returning +CME ERROR: 4 when I try it (no matter
> which CFUN level).

That is funny.  Maybe the modem does not support a true 'offline' or =

'airplane' mode.  In which case the driver might need to be modified =

somewhat.

This is something we will need to solve in the future.  If not fixed, =

I'm guessing that going Online then Offline will reset the SIM and cause =

all kinds of funny behavior.

>
> The modem behaves very strange sometimes. I kept getting timeouts when
> setting AT+CFUN=3D4. I once tried it manually and it took 26 seconds until
> I got an OK.
> Currently it works fine again.
>

Is there a newer firmware available by any chance?

Regards,
-Denis

--===============3446365458752116038==--

