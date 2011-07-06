Content-Type: multipart/mixed; boundary="===============0263286526775557648=="
MIME-Version: 1.0
From: Alex Kanavin <ak@sensi.org>
Subject: Re: [Meego-handset] ofono-qt - anything to add/improve?
Date: Wed, 06 Jul 2011 21:17:43 +0300
Message-ID: <CANNYZj9ZsDKjKjxt61zz_EOEhoqjhyg_evg8MmPQM7=sMLqicg@mail.gmail.com>
In-Reply-To: <20110706173237.GF9901@cyclone.jf.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0263286526775557648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/7/6 Shane Bryan <shane.bryan@linux.intel.com>:
> Two things come to mind:
>
> 1) A document that identifies which version of oFono the libofono-qt is
> =C2=A0 targeted for and some metric, like what percent of that version oF=
ono's
> =C2=A0 API is complete/covered by this library.

I haven't given much thought to the process of 'certifying' ofono-qt
for a specific version of ofono until now. Like I said, I plan to go
through the implemented APIs looking for things that are missing or
have changed and documenting them, and we can take it from there. We
can also change the versioning scheme to match ofono's.

> 2) A bit harder to do, espcially for the currently used CallHistory plugi=
n,
> =C2=A0 but we need an API for getting call history signals and methods fr=
om the
> =C2=A0 agent providing that data.

Yep, I haven't done d-bus adaptors in Qt yet, so will take some time
to get it right.

> On a matter related to 1) above, what is your plan for keeping pace with
> oFono upstream releases and (maybe more important to this list) keeping
> pace with oFono package updates in MeeGo OBS? =C2=A0No plan is a fine ans=
wer,
> which should (hopefully) spark offers for help, but if you *do* have a
> plan, I (and I assume others) would like to know what it is.

I suppose there should be a more formal way of tracking changes in
ofono/doc/*. Perhaps by making a diff between two version tags that
then would serve as a TODO :)

I will write up a wishlist and post it here.

-- =

Alexander

--===============0263286526775557648==--

