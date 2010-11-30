Content-Type: multipart/mixed; boundary="===============5328136291738994898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Need clarification in querying the pin status
Date: Tue, 30 Nov 2010 07:34:33 -0600
Message-ID: <4CF4FD69.1020405@gmail.com>
In-Reply-To: <AANLkTi=Vdw-LKPpYTSf6dcB7WOm_H5q2chiv13hhfq6N@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5328136291738994898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

>     This is actually a bug in oFono, somehow we missed the fact that
>     ChangePin with the wrong PIN will decrease the retry counts.  The core
>     needs to be fixed to query the current PIN state and reset the state =
to
>     pre-sim if the retry limit is reached.
> =

> =

> Can you please let us know if this is already addressed or this will be
> addressed in future.
> =


This task is still pending, see the last task in the SIM / SIM File
System section of the TODO list.

Regards,
-Denis

--===============5328136291738994898==--

