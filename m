Content-Type: multipart/mixed; boundary="===============6983266395983953096=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: Re: Voice calls over qmi was Re: Incoming sms problem on Motorola
 Droid 4
Date: Fri, 11 May 2018 20:09:53 -0700
Message-ID: <40c47311-04c7-20ab-7bf9-0228e2ce85fe@joeyhewitt.com>
In-Reply-To: <5a49a4a1-4f9e-2538-e52f-83cce765a70e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6983266395983953096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Pavel,

 > It looks like the QMI voicecall driver is just a stub with no =

operations actually implemented.

I hope I'm not stealing their thunder, but Alexander Couzens at sysmocom =

seems to be working on implementing it [0]. Last fall, I had =

incoming/outgoing calls in oFono working on my MSM8930-based Android =

phone with these patches. You will probably want to revert the =

"NOT_FOR_MERGE" commit(s).

I have some rough (outdated?) patches on top of theirs, for DTMF[1], and =

improving the implementation of release_specific()[2]. (I don't know =

some of the technical details of GSM and QMI, but those changes made =

declining incoming calls work the way I expected.)

-Joey

[0] https://git.sysmocom.de/ofono/log/?h=3Dlynxis/master
[1] =

https://github.com/scintill/android_external_ofono/commit/306a3a6f19546b7b9=
b6b8df973d75710ce21bc3c
[2] =

https://github.com/scintill/android_external_ofono/commit/979fce83a1985b8a4=
3f1b8f49ed746710792375f

--===============6983266395983953096==--

