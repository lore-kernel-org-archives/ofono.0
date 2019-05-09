Content-Type: multipart/mixed; boundary="===============3591971475730145080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 09 May 2019 09:31:25 -0500
Message-ID: <a2443d38-e50b-65fb-0df8-f70939529f19@gmail.com>
In-Reply-To: <CAPsFW+SBq=8aHiK-X8dGhFE2HuvrLibvJyY31ew5Oaq5TGVYcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3591971475730145080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

<snip>

> https://lists.ofono.org/pipermail/ofono/2018-September/018514.html
> https://lists.ofono.org/pipermail/ofono/2019-February/019134.html
> https://lists.ofono.org/pipermail/ofono/2019-February/019136.html

Yes, the thread from 2018 is a good summary.

> =

> I'd like to see it fixed, and I have been spending some time on things
> the last few days. but I have not understood yet where exactly this
> now needs to be added and how.

Essentially the netreg atom driver needs to query both CEREG and CREG, =

combine the results to give the final answer to the core.

Regards,
-Denis

--===============3591971475730145080==--

