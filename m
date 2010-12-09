Content-Type: multipart/mixed; boundary="===============1882481430577930998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] TODO: Add task for NITZ name support in netreg
Date: Thu, 09 Dec 2010 01:47:57 -0600
Message-ID: <4D0089AD.2010409@gmail.com>
In-Reply-To: <AANLkTimpfM88KdOg-kGL6ZTnGur7x6ULU5u0pgbSxYx2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1882481430577930998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 12/09/2010 12:52 AM, Aki Niemi wrote:
> Hi Denis,
> =

> 2010/12/3 Denis Kenzior <denkenz@gmail.com>:
>> Out of curiosity, how do you plan to support this on AT modems?  I have
>> yet to see any AT modem report the NITZ network name via a proprietary
>> command.
> =

> Are you sure? In my experience, the NITZ name may be received moments
> after registration, so it would make sense to have an unsolicited
> notification of it.

The NITZ notification does indeed arrive unsolicited.  However, no AT
modem that I know of reports the received NITZ name.  This is only
reported via COPS.  The best you can do is call COPS again after the
driver reports ofono_netreg_time_notify.

> =

>> Besides, all AT modems report the NITZ name via COPS.  So in effect
>> oFono already fulfills this task...
> =

> Well, not with ISI modems it doesn't. Also, if we move PLMN name
> handling over to oFono, how can you determine if the name reported by
> COPS is indeed the NITZ name and as such should take precedence over
> the core's PLMN name?

Hence the reason for my pointed questions.  I'm a big proponent of
moving the PLMN database to the core, however this needs to work for
both ISI and AT modems.

Regards,
-Denis

--===============1882481430577930998==--

