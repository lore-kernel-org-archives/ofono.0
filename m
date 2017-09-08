Content-Type: multipart/mixed; boundary="===============8163727021518449935=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] qmimodem: extract network time from serving system
Date: Fri, 08 Sep 2017 12:20:35 -0500
Message-ID: <e01f6baf-db46-4de3-d313-26be27c92ca9@gmail.com>
In-Reply-To: <158bbb77-3391-316c-98e6-ba22f9737c0e@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8163727021518449935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> +
>> +    time_3gpp =3D qmi_result_get(result, QMI_NAS_RESULT_3GPP_TIME, &len=
);
> And here:
> =

>      /* Universal Time and Local Time Zone 3GPP */
>      time_3gpp =3D qmi_result_get(result, 0x1c, &len);
> =

> (That might be the sound of Denis screaming in the background you hear! =

> :)  I'm not sure he'll agree with this... we'll see).
> =


So generally our preferred approach is not to spend lots of time =

defining data structures and #defines that end up being used only once. =

They belong directly in the driver code.  If you look at the RIL plugin, =

that is mostly how things are done, e.g. very much along the lines you =

propose.

In the case of QMI, we had plans to have a command line tool that could =

interact with QMI devices without running full-blown oFono.  So that is =

why we placed many of the protocol numbers and structure definitions =

into .h files.

For things that are unlikely to go into such a tool, I'm fine with =

directly implementing / decoding the data structures inside, but its =

hard to determine what might or might not be wanted in such a tool.  So =

it may be worthwhile to just put all structure definitions into =

nas/wds/etc .h for now and make sure that the naming stays sane and =

consistent.

Regards,
-Denis

--===============8163727021518449935==--

