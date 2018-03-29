Content-Type: multipart/mixed; boundary="===============0600853071707942057=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 00/30] QMI rework
Date: Thu, 29 Mar 2018 13:08:26 -0500
Message-ID: <40721f1e-bc35-afe4-adc2-17bad2bfb11f@gmail.com>
In-Reply-To: <481f4b9b-f771-4ab2-80b6-191b4c7c8097@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0600853071707942057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>>> This is effectively the same as what you proposed with a little twist =

>>> (improvement :) ):
>>> i)=C2=A0 you wanted to add a list of groups to qmi_service so that grou=
ps =

>>> of notifations/requests could be cancelled independently of other =

>>> groups: that what ServiceHandle is above, effectively
>> Note that MBIM doesn't really have a concept of a service that is =

>> 'opened'.=C2=A0 It is just a UUID, so having everything sit on the devic=
e =

>> object and using groups was more convenient.
> =

> I don't know enough about MBIM... the UUID could just live in the =

> "shared" object and the service reference like it I've described above, =

> right?

You could, but it didn't seem worthwhile.  Conceptually it looks quite =

similar to D-Bus where the service UUID is somewhat equivalent to =

interface name.  QMI is a bit more involved with client ids, major/minor =

versions, etc.

Regards,
-Denis

--===============0600853071707942057==--

